# Variables de entrada para personalizar nombre de proyecto y archivo de salida.
variable "output_file" {
  description = "Ruta del archivo que creara Terraform con el provider local."
  type        = string
  default     = "generated/hola.txt"
}

variable "project_name" {
  description = "Nombre del proyecto para incluirlo en el contenido generado."
  type        = string
  default     = "TerraformZero"
}
