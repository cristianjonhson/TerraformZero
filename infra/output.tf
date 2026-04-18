output "generated_file_path" {
  description = "Ruta del archivo generado por el recurso local_file."
  value       = local_file.example.filename
}

output "generated_file_content" {
  description = "Contenido generado en el archivo local."
  value       = local_file.example.content
}
