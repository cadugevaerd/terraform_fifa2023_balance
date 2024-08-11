module "producao" {
  source                 = "../../infra"
  repositorio            = "producao"
  AWS_REGION             = ""
  AWS_ACCESS_KEY_ID      = "" # Deixe em branco; será preenchido pela variável de ambiente
  AWS_SECRET_ACCESS_KEY  = "" # Deixe em branco; será preenchido pela variável de ambiente
}

output "dns_alb" {
  value = module.producao.dns_name
}