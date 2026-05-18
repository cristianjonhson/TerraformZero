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
