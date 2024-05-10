# # resource "aws_instance" "name_of_the_1st_block" {
# #   ami           = data.aws_ami.latest.id
# #   instance_type = var.instance_type
# #   key_name      = var.key_name

# #   tags = {
# #     Name       = var.tag_name
# #     app        = var.tag_app
# #     created_by = var.tag_author
# #     env        = var.tag_env
# #     owner      = var.tag_owner
# #     timestamp  = timestamp()
# #   }
# # }

# # data "aws_ami" "latest" {
# #   most_recent = true
# #   filter {
# #     name   = "name"
# #     values = ["amzn2-ami-hvm-*"]
# #   }
# #   filter {
# #     name   = "virtualization-type"
# #     values = ["hvm"]
# #   }
# #   owners = ["amazon"]
# # }

# # resource "aws_security_group" "first_sg" {
# #   name        = "my_security_group"
# #   description = "Allow port 22"

# #   tags = {
# #     Name = "SecGroup"
# #   }

# #   ingress {
# #     description = "Allow Port 22"
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     description = "Allow Port 80"
# #     from_port   = 80
# #     to_port     = 80
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1" #all protocols
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# # }

# # resource "aws_security_group" "webserver_sg" {
# #   name        = "webserver_security_group"
# #   description = "Allow port 80 and 443"

# #   tags = {
# #     Name = "SecGroup"
# #   }
# # }

# # resource "aws_vpc_security_group_ingress_rule" "allow_443" {
# #   security_group_id = aws_security_group.webserver_sg.id
# #   cidr_ipv4         = "0.0.0.0/0"
# #   from_port         = 443
# #   ip_protocol       = "tcp"
# #   to_port           = 443

# # }

# # resource "aws_vpc_security_group_ingress_rule" "allow_80" {
# #   security_group_id = aws_security_group.webserver_sg.id
# #   cidr_ipv4         = "0.0.0.0/0"
# #   from_port         = 80
# #   ip_protocol       = "tcp"
# #   to_port           = 80

# # }




# # 1ST TERRAFORM HOMEWORK
# # 1. Create S3 bucket and enable:
# #      versioning 
# #      force destroy 
# #      output region for s3 bucket
# # 2. Create EC2 instance "bastion_host"
# # Create security group "bastion_ssh" for bastion_host 
# # 3. Create IAM user "gitlab-apps-user".

# # All resources have to be with variables and tfvars file. use -var-file=terraform.tfvars flag to use it. 
# # All resources have to have the following outputs (if applicable): ID, name, ARN. 
# # All resources have to have tags. Make sure you create variables for tags too. 


# # S3
# resource "aws_s3_bucket" "hw-s3" {
#   bucket = var.s3_name

#   tags = {
#     Name       = var.tag_name
#     app        = var.tag_app
#     created_by = var.tag_author
#     env        = var.tag_env
#     owner      = var.tag_owner
#   }
# }

# resource "aws_s3_bucket" "hw-s3-force-destroy" {
#   bucket = var.s3_name

#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "versioning_hw-s3" {
#   bucket = aws_s3_bucket.hw-s3-force-destroy.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }


# # EC2

# resource "aws_instance" "hw-ec2" {
#   ami           = data.aws_ami.latest.id
#   instance_type = var.instance_type
#   key_name      = var.key_name

#   vpc_security_group_ids = [aws_security_group.bastion_ssh.id]  # Associate security group with the instance

#   tags = {
#     Name       = var.tag_name
#     app        = var.tag_app
#     created_by = var.tag_author
#     env        = var.tag_env
#     owner      = var.tag_owner
#   }
# }

# data "aws_ami" "latest" {
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   owners = ["amazon"]
# }

# resource "aws_security_group" "bastion_ssh" {
#   name        = var.sg_name
#   description = var.sg_description

#   tags = {
#     Name       = var.sg_name
#     app        = var.tag_app
#     created_by = var.tag_author
#     env        = var.tag_env
#     owner      = var.tag_owner
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_22" {
#   security_group_id = aws_security_group.bastion_ssh.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22

# }

# resource "aws_vpc_security_group_egress_rule" "all_traffic" {
#   security_group_id = aws_security_group.bastion_ssh.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 0
#   ip_protocol       = "-1"
#   to_port           = 0

# }



# # IAM user

# resource "aws_iam_user" "gitlab-apps-user" {
#   name = var.iam_user_name
#   path = "/"

#   tags = {
#     created_by = var.tag_author

#   }
# }

# resource "aws_iam_access_key" "gitlab-apps-user_key" {
#   user = aws_iam_user.gitlab-apps-user.name
# }




resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
    enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "pub_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_1_cidr_block
  availability_zone       = var.az-1
  map_public_ip_on_launch = var.public_ip

  tags = {
    Name = var.pub_sub_1_name
  }
}

resource "aws_subnet" "pub_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_2_cidr_block
  availability_zone       = var.az-2
  map_public_ip_on_launch = var.public_ip

  tags = {
    Name = var.pub_sub_2_name
  }
}

resource "aws_subnet" "priv_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_3_cidr_block
  availability_zone = var.az-1

  tags = {
    Name = var.priv_sub_1_name
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_4_cidr_block
  availability_zone = var.az-2

  tags = {
    Name = var.priv_sub_2_name
  }
}

# IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.ig_name
  }
}

# Elastic IP
resource "aws_eip" "eip" {
  tags = {
    Name = var.eip_name
  }
}

# Create NAT GW
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_subnet_1.id

  tags = {
    Name = var.nat_gw_name
  }
}

# Create public route table
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "PublicRouteTable"
  }
}

# Create private route table
resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.priv_rt_name
  }
}

# Routing for public route table (to internet gateway)
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_RT.id
  destination_cidr_block = var.dest_cidr_block
  gateway_id             = aws_internet_gateway.gw.id
}

# Routing for private route table (to NAT gateway)
resource "aws_route" "priv_NAT_gateway" {
  route_table_id         = aws_route_table.private_RT.id
  destination_cidr_block = var.dest_cidr_block
  gateway_id             = aws_nat_gateway.nat_gw.id
}

# Route table association for public subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id      = aws_subnet.pub_subnet_2.id
  route_table_id = aws_route_table.public_RT.id
}

# Route table association for private subnet
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.priv_subnet_1.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_RT.id
}

# Security group 

resource "aws_security_group" "sg_master" {
  name        = var.sg_name
  vpc_id      = aws_vpc.main.id
  description = var.sg_description

  tags = {
    Name       = var.sg_name
    app        = var.tag_app
    created_by = var.tag_author
    env        = var.tag_env
    owner      = var.tag_owner
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_22" {
  security_group_id = aws_security_group.sg_master.id
  cidr_ipv4         = var.sg_sidr_ipv4
  from_port         = var.port22
  ip_protocol       = var.ip_protocol
  to_port           = var.port22

}

resource "aws_vpc_security_group_ingress_rule" "allow_80" {
  security_group_id = aws_security_group.sg_master.id
  cidr_ipv4         = var.sg_sidr_ipv4
  from_port         = var.port80
  ip_protocol       = var.ip_protocol
  to_port           = var.port80

}

resource "aws_vpc_security_group_egress_rule" "all_traffic" {
  security_group_id = aws_security_group.sg_master.id
  cidr_ipv4         = var.sg_sidr_ipv4
  ip_protocol       = var.all_ip_protocol

}

# Master-controller (EC2 instance)
resource "aws_instance" "master-controller" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id = aws_subnet.pub_subnet_1.id

  vpc_security_group_ids = [aws_security_group.sg_master.id] # Associate security group with the instance

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname master-controller
              apt update
              apt install software-properties-common
              apt-add-repository --yes --update ppa:ansible/ansible
              apt install ansible -y
              apt install python3-pip
              pip3 install ansible
              EOF
  tags = {
    Name       = var.tag_name
    app        = var.tag_app
    created_by = var.tag_author
    env        = var.tag_env
    owner      = var.tag_owner
  }
}

data "aws_ami" "latest" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}