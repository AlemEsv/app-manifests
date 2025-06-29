APP_NAME=python-flask
IMAGE_NAME=$(APP_NAME):latest

.PHONY: start build deploy service status logs clean

start:
	minikube start --driver=docker

build:
	docker build -t $(IMAGE_NAME) .

deploy:
	kubectl apply -f manifests/deployment.yaml
	kubectl apply -f manifests/service.yaml

service:
	minikube service $(APP_NAME)

status:
	kubectl get pods -l app=$(APP_NAME)
	kubectl get svc $(APP_NAME)

logs:
	kubectl logs $$(kubectl get pods -l app=$(APP_NAME) -o jsonpath='{.items[0].metadata.name}')

clean:
	kubectl delete all --all
