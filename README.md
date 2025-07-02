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


### Manifiestos

#### 1. Deployment

Define la configuración para desplegar la aplicación Flask en un cluster de kubernetes local(minikube), especificando el número de réplicas, la imagen del contenedor y puertos de exposición.

**Problemas que resuelve:**

- La aplicación puede estar disponible mediante 4 replicas, otorgando un mayor grado de disponibilidad por si hay fallos en el primer pod elegido.

**Cómo probarlo:**

```bash
kubectl apply -f manifests/deployment.yaml
kubectl get deployments
kubectl get pods -l app=python-flask
```

#### 2. Service

Expone la aplicación Flask dentro del clúster local, proporcionando un punto de acceso estable entre las 4 réplicas del deployment.

**Cómo probarlo:**

```bash
kubectl apply -f manifests/service.yaml
kubectl get services
kubectl describe service python-flask-service
```

#### 3. Policy

La NetworkPolicy implementa control de tráfico a nivel de red, restringiendo el acceso al puerto de la aplicación python-flask solo desde pods autorizados.

**Problemas que resuelve:**

- Prevención de accesos no autorizados a servicios críticos

**Cómo probarlo:**

```bash
kubectl apply -f manifests/policy.yaml
kubectl get networkpolicy
kubectl describe networkpolicy python-flask-policy
```
