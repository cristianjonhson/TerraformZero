# Version minima de Terraform y proveedores requeridos por este modulo raiz, en este caso el proveedor de AWS.
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  #  Configuración del proveedor AWS, como región o credenciales, puede ser definida aquí o a través de variables de entorno.
  region = var.aws_region
  #provider para conectarse a ministack, se recomienda usar variables de entorno o un gestor de secretos para las claves.
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
