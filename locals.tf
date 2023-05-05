locals {
  azs = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1]
    ]
  vpc_cidr = "192.168.0.0/16"
  private_subnets = [
    "192.168.1.0/24",
    "192.168.3.0/24"
  ]
  private_subnet_names = [
    "pvt-subnet-1",
    "pvt-subnet-2"
  ]
  public_subnets = [
    "192.168.2.0/24",
    "192.168.4.0/24"
  ]
  public_subnet_names = [
    "pub-subnet-1",
    "pub-subnet-2"
  ]

  ## COMPUTE
  ec2_instance_name = "demo"
  ec2_instance_type = "t2.micro"
  ec2_ami_image_id  = data.aws_ami.ec2_ami.image_id
}