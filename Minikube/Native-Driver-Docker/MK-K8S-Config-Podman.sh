#! /bin/bash
minikube config set driver podman
minikube config set WantUpdateNotification true
minikube config set WantBetaUpdateNotification false
minikube config set WantVirtualBoxDriverWarning false
export MINIKUBE_IN_STYLE=false
export MINIKUBE_SUPPRESS_DOCKER_PERFORMANCE=true