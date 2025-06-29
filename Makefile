APP_NAME=python-flask
SERVICE_NAME=$(APP_NAME)-service
IMAGE_NAME=$(APP_NAME):latest

.PHONY: build deploy service status logs clean

build:
	minikube start --driver=docker && docker build -t $(IMAGE_NAME) .

deploy:
	kubectl apply -f manifests/deployment.yaml
	kubectl apply -f manifests/service.yaml

service:
	minikube service $(SERVICE_NAME)

status:
	kubectl get pods -l app=$(APP_NAME)
	kubectl get svc $(SERVICE_NAME)

logs:
	kubectl logs -l app=$(APP_NAME) -f

clean:
	kubectl delete all --all && minikube stop
