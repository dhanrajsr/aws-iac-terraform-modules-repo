resource "aws_launch_template" "eks-node" {
  name_prefix = var.name

  image_id               = var.ami_id # Replace with your desired AMI ID
  instance_type          = var.instance_type
  user_data              = var.user_data
  vpc_security_group_ids = var.security_group
  iam_instance_profile {
    arn = var.instance_profile_arn
  }

  dynamic "block_device_mappings" {
    for_each = var.ebs_volumes
    content {
      device_name = block_device_mappings.value.device_name
      ebs {
        volume_size           = block_device_mappings.value.volume_size
        volume_type           = block_device_mappings.value.volume_type
        delete_on_termination = block_device_mappings.value.delete_on_termination
        encrypted             = block_device_mappings.value.ebs_encryption
        kms_key_id            = block_device_mappings.value.kms_key_arn
      }
    }
  }

  placement {
    tenancy = var.tenancy
  }
  tags = merge(
    {
      "Name" = var.name,
    },
    var.tags
  )
}

output "launch_template_id" {
  value = aws_launch_template.eks-node.id
}
