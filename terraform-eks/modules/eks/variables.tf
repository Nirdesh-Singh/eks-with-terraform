variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the cluster"
  type        = list(string)
}

variable "eks_cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  type        = string
}

variable "eks_node_group_role_arn" {
  description = "IAM Role ARN for EKS Node Group"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

# Add your variable declarations here

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
}

# Add your variable declarations here

variable "private_subnet_cidrs" {
  description = "The CIDR blocks of the private subnets where the EKS cluster will allow inbound traffic"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "alb_ingress_role_arn" {
  type = string
}

variable "ebs_csi_driver_role_arn" {
  description = "IAM role ARN for EBS CSI driver"
  type        = string
}

variable "account_id" {
  description = "AWS account ID where the IAM role will be created"
  type        = string
}