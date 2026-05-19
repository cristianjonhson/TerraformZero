# Version minima de Terraform y proveedores requeridos por este modulo raiz, en este caso el proveedor de AWS.
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  #  Configuración del proveedor AWS, como región o credenciales, puede ser definida aquí o a través de variables de entorno.
  region = var.aws_region
  #provider para conectarse a ministack, se recomienda usar variables de entorno o un gestor de secretos para las claves.
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  # Configuraciones adicionales para evitar validaciones innecesarias en entornos de desarrollo o pruebas. (Exclusivo para ministack o entornos similares, no recomendado para producción)
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true

  # Soluciona el error:
  # bucket.localhost:4566 no such host
  #s3_use_path_style = true
  endpoints {
    #   Redirige las llamadas al servicio S3 a un endpoint local, útil para pruebas con herramientas como ministack.
    s3 = "http://localhost:4566"
  }
}
