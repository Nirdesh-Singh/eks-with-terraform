output "eks_cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_group_role_arn" {
  description = "IAM Role ARN for EKS Node Group"
  value       = aws_iam_role.eks_node_group_role.arn
}

output "alb_ingress_role_arn" {
  value = aws_iam_role.alb_ingress_role.arn
}

output "ebs_csi_driver_role_arn" {
  value = aws_iam_role.ebs_csi_driver.arn
}

