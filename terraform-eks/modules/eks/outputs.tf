output "eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_node_group_name" {
  value = aws_eks_node_group.eks_nodes.node_group_name
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for IAM roles"
  value       = aws_iam_openid_connect_provider.eks_oidc_provider.arn
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}
