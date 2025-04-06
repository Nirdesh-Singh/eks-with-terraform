output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_security_group_id" {
  value = module.security-groups.alb_security_group_id
}

output "eks_cluster_id" {
  value = module.eks.eks_cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_node_group_name" {
  value = module.eks.eks_node_group_name
}
