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

variable "random_pet_length" {
  description = "Cantidad de palabras usadas por random_pet para generar el sufijo."
  type        = number
  default     = 2
}

variable "generated_folder" {
  description = "Ruta de una carpeta adicional que Terraform mantendra en el filesystem local."
  type        = string
  default     = "generated/artifacts"
}
