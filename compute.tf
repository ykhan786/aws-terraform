module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  ami  = local.ec2_ami_image_id
  associate_public_ip_address = false
  create = true
  create_iam_instance_profile = true
  iam_role_name = "ec2-role-demo"
  iam_role_description = "EC2 Role during demo"
  iam_role_path = "/"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  name = local.ec2_instance_name

  instance_type          = local.ec2_instance_type
  monitoring             = true
  vpc_security_group_ids = [
    aws_security_group.allow_http.id
  ]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Name   = local.ec2_instance_name
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "HTTP from loadbalancer"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [
        "0.0.0.0/0"
        ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "my-nlb"

  load_balancer_type = "network"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix      = "demo-"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]
  tags = {
    Environment = "Test"
  }
}