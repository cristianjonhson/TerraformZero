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
  region = "us-east-1"
}
