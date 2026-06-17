---
description: "Crea una base de Terraform simple y valida para este repositorio."
---

# Crear Terraform Basico

## Objetivo
Genera o ajusta archivos Terraform en `infra/` con una solucion minima, clara y reproducible.

## Requisitos
- Usa Terraform `>= 1.5.0`.
- Reutiliza variables de `infra/variables.tf` antes de hardcodear valores.
- Si cambia el comportamiento, actualiza `infra/output.tf`.
- No agregues providers, modulos o backend nuevos sin justificarlo.
- No incluyas secretos en codigo, variables por defecto ni outputs.

## Flujo de trabajo
1. Implementa solo los cambios necesarios en `infra/`.
2. Ejecuta en este orden:
   - `terraform fmt`
   - `terraform init` (solo si cambian providers o modulos)
   - `terraform validate`
   - `terraform plan`
3. Si algo falla, corrige y vuelve a validar.

## Formato de respuesta
- Explica primero el impacto funcional.
- Luego lista los cambios por archivo.
- Incluye comandos exactos para reproducir la validacion.
- Si falta contexto critico, indicalo antes de asumir.
