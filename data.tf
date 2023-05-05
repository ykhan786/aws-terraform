## Use this data source to get the access to the effective Account ID, User ID, and ARN in which Terraform is authorized.
data "aws_caller_identity" "current" {}

## Get the availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

## Get the latest RHEL 8 AMI

data "aws_ami" "ec2_ami" {
  
  filter {
        name = "name"
        values = ["RHEL-8.6.0_HVM-20230301-x86_64-0-Hourly2-GP2"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  
  owners = ["amazon"]
  most_recent = true
}