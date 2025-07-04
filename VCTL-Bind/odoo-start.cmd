vctl system config -c 2
vctl system config -m 8g
vctl system start
vctl volume prune -f
:: Start a PostgreSQL server
vctl run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:15
::  Start an Odoo instance
vctl run -p 8069:8069 --name odoo --link db:db -t odoo