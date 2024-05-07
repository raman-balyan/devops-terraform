module "label_vpc" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  context    = module.base_label.context
  name       = "vpc"
  attributes = ["main"]
}

module "subnets" {
  source  = "hashicorp/subnets/cidr"
  version = "1.0.0" 

  base_cidr_block = var.vpc_cidr
  networks = [
    { name = "public", new_bits = 4 },
    { name = "private", new_bits = 4 }
  ]
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = module.base_label.tags
}

# =========================
# Create your subnets here
# =========================

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = module.subnets.network_cidr_blocks["public"]
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = module.base_label.tags
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = module.subnets.network_cidr_blocks["public"]
  availability_zone = var.availability_zone

  tags = module.base_label.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = module.base_label.tags
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = module.base_label.tags
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
