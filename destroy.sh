docker system prune
docker volume prune

minikube delete --profile flux
minikube delete --profile tf-controller
