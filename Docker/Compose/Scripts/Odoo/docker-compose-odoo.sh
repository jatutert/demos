#! /bin/bash
docker compose -f /home/$USER/Demos/Docker/Compose/YAML/Odoo/docker-compose-odoo-vagrant.yml up --quiet-pull -d
echo "Odoo port 10016"
echo "Chat port 20016"
