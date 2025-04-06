resource "aws_eks_node_group" "eks_nodes" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  node_group_name = "cheap-node-group"
  node_role_arn  = var.eks_node_group_role_arn
  subnet_ids     = var.subnet_ids

  instance_types = ["t3.medium"] # The cheapest possible instance

  scaling_config {
    min_size     = 2
    desired_size = 2
    max_size     = 2
  }

  tags = {
    Name = "eks-node-group"
  }
}
