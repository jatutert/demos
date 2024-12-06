::	DEMO Kubernetes / Minikube
::	Auteur: John Tutert
::	2024
:: 
::
::	Stap 3 / Scaling the application by increasing the replica count (van 2 naar 4 stuks) 
::
@ECHO OFF
@CLS
@ECHO NGINX Deployment Replicas verhogen van 2 naar 4 
:: 
@kubectl apply -f "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Kubernetes\YAML\NGINX"\3-deployment-scale.yaml
::
@kubectl describe deployment nginx-deployment
::
@kubectl get pods -l app=nginx
