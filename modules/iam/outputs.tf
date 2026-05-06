output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role[0].arn
}

output "eks_nodegroup_role_arn" {
  value = aws_iam_role.eks_nodegroup_role[0].arn
}