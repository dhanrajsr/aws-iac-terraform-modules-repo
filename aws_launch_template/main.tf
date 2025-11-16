resource "aws_launch_template" "eks-node" {
  name_prefix = var.name

  image_id = var.ami_id # Replace with your desired AMI ID
  instance_type = var.instance_type
  user_data = var.user_data
  vpc_security_group_ids = var.security_group
  iam_instance_profile {
    arn = var.instance_profile_arn
  }
  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
      delete_on_termination = var.delete_on_termination
      encrypted = var.ebs_encryption
      kms_key_id = var.kms_key_arn
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
