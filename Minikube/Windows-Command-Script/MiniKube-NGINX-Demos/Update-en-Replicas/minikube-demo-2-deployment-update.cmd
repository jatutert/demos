::	DEMO Kubernetes / Minikube
::	Auteur: John Tutert
::	2023
::
::	Stap 2	Updaten Deployment NGINX bijwerken van versie 14 naar versie 16 
::
@ECHO Updaten Deployment NGINIX van versie 14 naar versie 16 gestart ...
kubectl apply -f "D:\OneDrive - Saxion\Eigen-Scripts\GIT-jatutert-VagrantFile\k8s-demo\YAML\NGINX"\deployment-update.yml 
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
