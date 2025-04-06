# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnet_cidrs[0]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[0]

  tags = {
    Name                         = "public-subnet"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

}

# Public Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnet_cidrs[1]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[1]

  tags = {
    Name                            = "public-subnet-2"
    "kubernetes.io/role/elb"       = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnet_cidrs[2]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[2] # ap-south-1c

  tags = {
    Name                             = "public-subnet-3"
    "kubernetes.io/role/elb"         = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


# Private Subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[1]

  tags = {
    Name                                 = "private-subnet-1"
    "kubernetes.io/role/internal-elb"    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


# Private Subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[2]

  tags = {
    Name                                 = "private-subnet-2"
    "kubernetes.io/role/internal-elb"    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
