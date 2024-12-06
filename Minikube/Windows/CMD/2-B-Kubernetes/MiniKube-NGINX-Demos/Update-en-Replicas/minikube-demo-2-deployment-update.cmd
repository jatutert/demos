::	DEMO Kubernetes / Minikube
::	Auteur: John Tutert
::	2024
::
::	Stap 2	Updaten Deployment NGINX bijwerken van versie 14 naar versie 16 
::
@ECHO Updaten Deployment NGINIX van versie 14 naar versie 16 gestart ...
::
@kubectl apply -f "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Kubernetes\YAML\NGINX"\2-deployment-update.yaml 
@kubectl describe deployment nginx-deployment
@kubectl get pods -l app=nginx
