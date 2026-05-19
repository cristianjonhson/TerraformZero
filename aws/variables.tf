variable "aws_region" {
  description = "La región de AWS donde se desplegarán los recursos."
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "Clave de acceso para AWS, se recomienda usar variables de entorno o un gestor de secretos."
  type        = string
  default     = "test"
}

variable "aws_secret_key" {
  description = "Clave secreta para acceder a AWS, se recomienda usar variables de entorno o un gestor de secretos."
  type        = string
  default     = "test"
}

variable "aws_s3_bucket_name" {
  description = "Nombre base del bucket S3 a crear en AWS."
  type        = string
  default     = "terraform-zero-bucket"
}

variable "env" {
  description = "Entorno de despliegue, por ejemplo: dev, staging, prod."
  type        = string
  default     = "dev"
}

variable "random_pet_length" {
  description = "Cantidad de palabras que tendrá el sufijo aleatorio."
  type        = number
  default     = 2
}

variable "project_name" {
  description = "Nombre del proyecto para incluirlo en las etiquetas de AWS."
  type        = string
  default     = "TerraformZero"
}
