#
    # Kubernetes MicroK8S Minikube demo deployment NGINX stap 2
    # Stap 2 is updaten van NGINX van versie 14 naar versie 16
    echo '#! /bin/bash' > /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo '#'   >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo 'cd /home/$USER' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo 'clear'  >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo "echo 'Stap 2 Updaten NGiNX van versie 14 naar versie 16 gestart ...'" >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo 'kubectl apply -f /home/$USER/yaml/kubernetes/nginx/deployment-update.yml' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo 'kubectl describe deployment nginx-deployment' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo 'kubectl get pods -l app=nginx' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    echo 'minikube service --all'  >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    chmod +x /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_2.sh
    #