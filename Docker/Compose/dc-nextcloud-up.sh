#! /bin/bash
#
docker compose -f /home/$USER/Demos/Docker/Compose/dc-nextcloud-mariadb.yml up --quiet-pull -d
echo NextCloud port 8888
