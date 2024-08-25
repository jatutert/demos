::	DEMO Kubernetes / Minikube
::	Auteur: John Tutert
::	2023
:: 
::
::	Stap 3 / Scaling the application by increasing the replica count (van 2 naar 4 stuks) 
::
@ECHO OFF
@CLS
@ECHO NGINX Deployment Replicas verhogen van 2 naar 4 
:: 
kubectl apply -f "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Kubernetes\YAML\NGINX"\deployment-scale.yml
:: kubectl apply -f "D:\OneDrive - Saxion\Eigen-Scripts\GIT-jatutert-VagrantFile\k8s-demo\YAML\NGINX"\deployment-scale.yml
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
