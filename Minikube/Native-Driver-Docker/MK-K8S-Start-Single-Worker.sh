minikube stop
minikube delete
minikube start --kubernetes-version=stable --nodes=1 --cni=flannel
minikube addons enable dashboard
minikube addons enable portainer
minikube addons enable kubevirt
minikube service list