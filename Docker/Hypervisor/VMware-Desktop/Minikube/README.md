# Demonstration

Sometimes you need/want to demonstrate e.g. Docker to your students or another person. 
So you need a demonstration enviroment. But you don't want to do everything manually. 
This repository has several scripted demonstration environments. 

## Vagrant

Minikube can be executed in several ways. 
One of the many way is to run Minikube inside a virtual machine (running Linux) on top of Docker. 
This demo uses a virtual machine within VMware Workstation or Fusion Pro running Ubuntu linux. 
Control of this environment is done with Vagrant from Hashicorp. 

To use this demo environment, Vagrant environment must first be set up. 
See the separate repository called Vagrant for more information on this. 

## Windows

Minikube can also be run within Windows (i.e. not within a virtual machine). 
In the background, Minikube does use a virtual machine. 
This virtual machine can run on Oracle Virtualbox but also on VMware Workstation Pro. 
The Windows folder mainly contains command files for controlling Minikube to give demos. 

### [Step 1] Installation

```shell
winget update
winget install --id Kubernetes.minikube --accept-package-agreements --accept-source-agreements
winget install --id Kubernetes.kubectl --accept-package-agreements --accept-source-agreements 
winget install --id cURL.cURL --accept-package-agreements --accept-source-agreements 
exit
```
The terminal MUST be closed to load the environment settings. Please don't skip the exit step. 

### [Step 2] Configuration 

Turn off emojij and colors in Minikube. 
Define directory for virtual machine with Docker or Kubernetes.

```shell
Setx /M MINIKUBE_IN_STYLE "false"
Setx /M MINIKUBE_HOME "The directory you want the virtual machine to be stored e.g. C:\VirtualMachine\MiniKube\"
exit
```

More information at https://minikube.sigs.k8s.io/docs/handbook/config/

The terminal MUST be closed to load the environment settings. Please don't skip the exit step. 

```shell
minikube config set memory 8192
minikube config set cpus 4 
minikube config set driver vmware
minikube config set WantUpdateNotification true 
minikube config set WantBetaUpdateNotification true
minikube config set WantVirtualBoxDriverWarning false
minikube config view
exit
```
Above are my configuration settings for memory and cpu. Change whatever you like best ! 

### [STEP 3] DOCKER DEMONSTRATION

If you want to demonstrate only Docker and NO Kubernetes, then execute the following steps. 
Move to STEP 3 Kubernetes demonstration if you want to demonstrate Kubernetes (NO Docker)

Starting Minikube with only Docker running inside the virtual machine:

```shell
minikube start --no-kubernetes
```

Download script and run the script within the virtual machine 
```shell
minikube ssh "curl -o /home/docker/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh"
minikube ssh "sudo chmod +x /home/docker/ubuntu-config-V3-latest.sh"
minikube ssh "sudo /home/docker/ubuntu-config-V3-latest.sh minikube"
```

Building custom image for Docker demonstration
```shell
minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
minikube ssh "/home/docker/docker/flask-demo/flask-demo-run.sh"
minikube ip
```

If you want to use Docker, then you need to get inside the virtual machine. 
This can be done via SSH

```shell
minikube ssh
```

### [STEP 3] KUBERNETES DEMONSTRATION

If you want to demonstrate Kubernetes, then execute the following steps: 

Starting Mininkube with Docker and Kubernetes running inside the virtual machine:

```shell
minikube start
```
Download example YAML files within the virtual machine 
```shell
minikube ssh
curl -s -o %HOMEDRIVE%\Downloads\deployment.yml https://raw.githubusercontent.com/jatutert/demos/main/Kubernetes/YAML/NGINX/deployment.yml
curl -s -o %HOMEDRIVE%\Downloads\deployment-update.yml https://raw.githubusercontent.com/jatutert/demos/main/Kubernetes/YAML/NGINX/deployment-update.yml
curl -s -o %HOMEDRIVE%\Downloads\deployment-scale.yml https://raw.githubusercontent.com/jatutert/demos/main/Kubernetes/YAML/NGINX/deployment-scale.yml
```

Give demonstration
```shell
kubectl apply -f %HOMEDRIVE%\Downloads\deployment.yml
kubectl expose deployment nginx-deployment --type="NodePort" --port 80
kubectl describe deployment nginx-deployment
kubectl apply -f %HOMEDRIVE%\Downloads\deployment-update.yml
kubectl get pods -l app=nginx
kubectl apply -f %HOMEDRIVE%\Downloads\deployment-scale.yml
kubectl get pods -l app=nginx
```

### Shutting down

```shell
minikube stop --all
exit
```

### Remove all traces of the virtual machine 

```shell
minikube delete --purge
exit
```