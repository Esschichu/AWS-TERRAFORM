terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

module "my_vpc"{
    source = "../module/vpc"
    vpc_cidr = "192.168.0.0/16"
    tenancy = "default"
    vpc_id = "${module.my_vpc.vpc_id}"
    subnet_cidr = "192.168.0.0/24"
}

module "my_ec2"{
    source = "../module/ec2"
    ec2_count = 1
    instance_type = "t2.micro"
    subnet_id = "${module.my_vpc.subnet_id}"
}