# App-manifest

Plataforma de despliegue continuo local que automatiza el despliegue de aplicaciones Flask en Kubernetes usando Minikube, simulando un flujo GitOps básico.

Repositorio monitorizador: [git-monitor](https://github.com/AlemEsv/pc4-grupo4-tema1)

## Características principales

- **Aplicación Flask contenerizada** con multi-stage builds.
- Despliegue automatizado en Kubernetes local (Minikube).
- Monitoreo de cambios en Git y aplicación automática de manifiestos
- Validación de manifiestos YAML con hooks de pre-commit
- **Pruebas unitarias** para scripts de automatización.
- Gestión de tareas con **GitHub Projects** (Kanban).
