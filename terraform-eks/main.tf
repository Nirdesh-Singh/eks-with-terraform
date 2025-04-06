

module "vpc" {
  source                 = "./modules/vpc"
  region                 = var.region
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  availability_zones     = var.availability_zones
  alb_sg_id              = module.security-groups.alb_security_group_id
  cluster_name           = var.cluster_name
}


module "security-groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"
  region = var.region
  oidc_provider_arn = module.eks.oidc_provider_arn
  account_id        = data.aws_caller_identity.current.account_id
}

module "eks" {
  source                  = "./modules/eks"
  region                  = var.region
  cluster_name            = var.cluster_name
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnet_ids
  eks_cluster_role_arn    = module.iam.eks_cluster_role_arn
  eks_node_group_role_arn = module.iam.eks_node_group_role_arn
  ssh_key_name            = var.ssh_key_name
  private_subnet_cidrs    = var.private_subnet_cidrs
  alb_ingress_role_arn    = module.iam.alb_ingress_role_arn
  ebs_csi_driver_role_arn = module.iam.ebs_csi_driver_role_arn
  account_id              = data.aws_caller_identity.current.account_id
}
