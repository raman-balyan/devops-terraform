module "base_label" {
  source    = "cloudposse/label/null"
  version   = "0.25.0"
  namespace = "ll"
  environment = var.environment
  tags      = var.tags
}
