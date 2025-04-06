output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "vpc_endpoint_eks" {
  description = "VPC Endpoint ID for EKS"
  value       = aws_vpc_endpoint.eks.id
}

output "vpc_endpoint_ec2" {
  description = "VPC Endpoint ID for EC2"
  value       = aws_vpc_endpoint.ec2.id
}

output "vpc_endpoint_sts" {
  description = "VPC Endpoint ID for STS"
  value       = aws_vpc_endpoint.sts.id
}

