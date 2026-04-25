# Outputs para validar rapidamente que el recurso local_file se creo correctamente.
output "generated_file_path" {
  description = "Ruta del archivo generado por el recurso local_file."
  value       = local_file.example.filename
}

output "generated_file_content" {
  description = "Contenido generado en el archivo local."
  value       = local_file.example.content
}

output "random_pet_suffix" {
  description = "Sufijo aleatorio generado por el provider hashicorp/random."
  value       = random_pet.project_suffix.id
}
