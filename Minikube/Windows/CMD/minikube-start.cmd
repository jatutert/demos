:: Verwijderen eventuele aanwezige omgeving
@minikube stop 
@minikube delete
:: Minikube bijwerken naar laatste versie
:: winget uninstall --id Kubernetes.minikube
:: winget install -id Kubernetes.minikube
:: minikube delete
@minikube config set driver vmware
:: minikube config set driver virtualbox
@minikube config set memory 8192
@minikube config set cpus 4 
:: minikube config set driver virtualbox
:: minikube start --no-vtx-check
minikube start