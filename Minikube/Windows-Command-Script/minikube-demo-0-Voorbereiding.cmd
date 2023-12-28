echo off 
cls
::
::	Opschonen
::
rmdir %HOMEPATH%\minikube-demo /S /Q 
::
::	Aanmaken Directory structuur 
:: 
mkdir %HOMEPATH%\minikube-demo
:: 
mkdir %HOMEPATH%\minikube-demo\nginx
:: [1] Creating and exploring an nginx deployment
mkdir %HOMEPATH%\minikube-demo\nginx\1-deployment 
:: [2] Updating the deployment
mkdir %HOMEPATH%\minikube-demo\nginx\2-deployment-update 
:: [3] Scaling the application by increasing the replica count
mkdir %HOMEPATH%\minikube-demo\nginx\3-deployment-scale  
::
::	Downloaden YAML Bestanden 
::
:: [1] Creating and exploring an nginx deployment
curl -s -o %HOMEPATH%\minikube-demo\nginx\1-deployment\deployment.yml https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/application/deployment.yaml
:: [2] Updating the deployment
curl -s -o %HOMEPATH%\minikube-demo\nginx\2-deployment-update\deployment-update.yml https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/application/deployment-update.yaml
:: [3] Scaling the application by increasing the replica count
curl -s -o %HOMEPATH%\minikube-demo\nginx\3-deployment-scale\deployment-scale.yml https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/application/deployment-scale.yaml
::
::
Echo Aanmaken structuur en download gereed 