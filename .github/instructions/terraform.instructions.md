---
description: "Guia basica para trabajar con Terraform en este repositorio."
applyTo: "infra/**/*.tf"
---

# Terraform Instructions (Basico)

## Objetivo
Mantener cambios en Terraform claros, seguros y reproducibles.

## Alcance
- Aplicar estas reglas a archivos Terraform dentro de `infra/`.

## Reglas basicas
- Reutiliza variables definidas en `infra/variables.tf` antes de hardcodear valores.
- Si cambia el comportamiento, actualiza outputs en `infra/output.tf`.
- Evita introducir providers, modulos o backend nuevos sin justificarlo.

## Validacion obligatoria
Ejecuta este flujo antes de dar por listo un cambio:

1. `terraform fmt`
2. `terraform init` (si cambian providers o modulos)
3. `terraform validate`
4. `terraform plan`

## Seguridad
- No incluir secretos en codigo, variables por defecto, outputs ni ejemplos.
- No versionar `.terraform/`, `*.tfstate`, ni `*.tfstate.backup`.

## Documentacion
- Si agregas variables nuevas o cambias la forma de ejecucion, actualiza `README.md`.
