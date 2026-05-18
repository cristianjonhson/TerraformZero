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
