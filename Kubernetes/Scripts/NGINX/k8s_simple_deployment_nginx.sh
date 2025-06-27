echo '#! /bin/bash'                                 > /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo '#'                                           >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo 'cd /home/$USER'                              >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo 'clear'                                       >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo 'kubectl create deployment nginx-webserver --image=nginx' >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo 'kubectl expose deployment nginx-webserver --type="NodePort" --port 80' >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo 'kubectl describe deployment nginx-webserver' >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo 'kubectl get svc nginx-webserver'             >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    echo 'minikube service --all'                      >> /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh
    chmod +x /home/$SUDO_USER/k8s-demo/nginx/simple/k8s_simple_deployment_nginx.sh