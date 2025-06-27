#! /bin/bash
#
docker compose -f /home/$USER/Demos/Docker/Compose/YAML/NextCloud/docker-compose-nextcloud-vagrant.yml up --quiet-pull -d
echo NextCloud port 8888
