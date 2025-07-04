#
    # Kubernetes MicroK8S Minikube demo deployment NGINX stap 3
    # Stap 3 is replicatecount van 2 naar 4 bijwerken 
    echo '#! /bin/bash'   > /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    echo 'cd /home/$USER' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    echo 'clear' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    echo "echo 'Stap 3 Aanpassen aantal replicas van 2 naar 4 gestart ...'" >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    echo 'kubectl apply -f /home/$USER/yaml/kubernetes/nginx/deployment-scale.yaml' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    echo 'kubectl describe deployment nginx-deployment' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    echo 'kubectl get pods -l app=nginx' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    echo 'minikube service --all'  >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    chmod +x /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_3.sh
    #