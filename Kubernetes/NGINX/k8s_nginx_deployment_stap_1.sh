#
    # Kubernetes MicroK8S Minikube demo deployment NGINX stap 1
    # Stap 1 is deployment van omgeving met NGINX versie 14
    echo '#! /bin/bash' > /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo '#' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo 'cd /home/$USER'  >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo 'clear' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo "echo 'Stap 1 Deployment NGINX versie 14 gestart ...'" >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo 'kubectl apply -f /home/$USER/yaml/kubernetes/nginx/deployment.yml' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo 'kubectl expose deployment nginx-deployment --type=NodePort --port=8080' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo 'kubectl describe deployment nginx-deployment' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo 'kubectl get pods -l app=nginx' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    echo 'minikube service --all' >> /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    chmod +x /home/$SUDO_USER/demos/kubernetes/applicaties/nginx/replicas/k8s_nginx_deployment_stap_1.sh
    #