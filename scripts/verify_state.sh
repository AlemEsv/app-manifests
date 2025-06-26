#!/bin/bash

service_name="$1"

if [ -z "$service_name" ]; then
  echo "Uso: $0 <nombre-del-servicio>"
  exit 1
fi

echo "Verificando que todos los pods estén corriendo..."

# Obtener todos los pods y verificar que existan
total_pods=$(kubectl get pods --no-headers 2>/dev/null | wc -l)
if [ "$total_pods" -eq 0 ]; then
  echo "No se encontraron pods en el cluster."
  exit 1
fi

# Verificar que TODOS los pods estén en estado: running
verify_state_pods=$(kubectl get pods --no-headers | grep -v Running)
if [ ! -z "$verify_state_pods" ]; then
  echo "Hay pods que no están en estado Running:"
  echo "$verify_state_pods"
  exit 1
fi

echo "Los $total_pods pods están en estado Running."

echo "Verificando que el servicio $service_name existe..."
kubectl get svc "$service_name" > /dev/null 2>&1 || { 
  echo "El servicio $service_name no existe"; 
  exit 1; 
}
echo "Servicio $service_name encontrado."

echo "Verificación completada."