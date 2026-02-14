#! /bin/bash
docker compose -f /home/$USER/Demos/Docker/Compose/dc-odoo-postgresql.yml up --quiet-pull -d
echo "Odoo port 10016"
echo "Chat port 20016"
