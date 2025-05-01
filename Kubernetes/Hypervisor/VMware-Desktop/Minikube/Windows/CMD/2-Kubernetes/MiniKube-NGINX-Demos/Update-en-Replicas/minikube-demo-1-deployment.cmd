::
::	DEMO Kubernetes / Minikube
::	Gemaakt door John Tutert
::	2024
::
:: Update 24 aug 2024 
:: Verwijzing naar Directories aangepast 
::
:: 
:: https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/
:: is basis voor dit script
::
::
::	Stap 1	Deployment NGINX versie 14  
::
:: 
@kubectl apply -f "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Kubernetes\YAML\NGINX"\1-deployment.yaml
::
@kubectl expose deployment nginx-deployment --type="NodePort" --port 80
::
@kubectl describe deployment nginx-deployment
:: 
@PAUSE
@CLS
@ECHO Overzicht actieve omgeving   
@kubectl get nodes 
@kubectl get services -A
@kubectl get deployments -A 
:: @kubectl get pods -l app=nginx
@kubectl get pods 
@PAUSE
:: 
::
@minikube ip
::
@minikube ssh "ip addr l eth0"
@kubectl get services -A
@echo neem ip adres en laatste poortnummer achter nodeport bijv. 32334
@echo type ip adres en : en hierachter poortnummer in de webbrowser
::
:: @minikube service --all 