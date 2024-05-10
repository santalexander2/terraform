variable "region" {
  type        = string
  description = "AWS Region"

}

variable "AWS_ACCESS_KEYS" {
  type        = string
  description = "AWS Access keys"

}

variable "AWS_SECRET_KEYS" {
  type        = string
  description = "AWS secret keys of the Terraform"
}

variable "ami" {
  type    = string
}

variable "vpc_name" {
  type        = string
  description = "vpc name"
  default     = "GoProApp"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_1_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_2_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "subnet_3_cidr_block" {
  type    = string
  default = "10.0.3.0/24"
}

variable "subnet_4_cidr_block" {
  type    = string
  default = "10.0.4.0/24"
}

variable "az-1" {
  type    = string
  default = "us-west-1b"
}

variable "az-2" {
  type    = string
  default = "us-west-1c"
}

variable "pub_sub_1_name" {
  type    = string
  default = "pub-sub_GoProApp-1b"
}

variable "pub_sub_2_name" {
  type    = string
  default = "pub-sub_GoProApp-1c"
}

variable "priv_sub_1_name" {
  type    = string
  default = "priv-sub_GoProApp-1b"
}

variable "priv_sub_2_name" {
  type    = string
  default = "priv-sub_GoProApp-1c"
}

variable "public_ip" {
  type    = bool
  default = "true"
}

variable "ig_name" {
  type    = string
  default = "IG_GoProApp"
}

variable "eip" {
  type    = bool
  default = "true"
}

variable "nat_gw_name" {
  type    = string
  default = "NAT_GW_GoProApp"
}

variable "eip_name" {
  type    = string
  default = "MyEIP"
}

variable "priv_rt_name" {
  type    = string
  default = "priv_RT_GoProApp"
}

variable "pub_rt_name" {
  type    = string
  default = "pub_RT_GoProApp"
}

variable "dest_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance_type" {
  type        = string
  description = "instance_type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "key_name"
  default     = "awskey"
}

variable "tag_name" {
  type        = string
  description = "tag_name"
  default     = "master-controler"
}

variable "tag_app" {
  type        = string
  description = "tag_app"
  default     = "GoProApp"
}

variable "tag_author" {
  type        = string
  description = "tag_author"
  default     = "Terraform"
}

variable "tag_env" {
  type        = string
  description = "tag_env"
  default     = "dev"
}

variable "tag_owner" {
  type        = string
  description = "tag_owner"
  default     = "DevOps"
}

variable "sg_name" {
  type        = string
  description = "sg_name"
  default     = "master-controller_sg"
}

variable "sg_description" {
  type        = string
  description = "sg_description"
  default     = "Allows port 22"
}

variable "sg_sidr_ipv4" {
  type    = string
  default = "0.0.0.0/0"
}

variable "port22" {
  type    = number
  default = "22"
}

variable "port80" {
  type    = number
  default = "80"
}

variable "egress_port" {
  type    = number
  default = "0"
}

variable "ip_protocol" {
  type    = string
  default = "tcp"
}

variable "all_ip_protocol" {
  type    = number
  default = "-1"
}