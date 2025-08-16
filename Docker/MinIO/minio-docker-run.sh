#! /bin/bash
#
# Minio Object Storage on Docker
#
# Minio API port     9000
# MinIO Console port 9090
#
# Minio is bereikbaar op poort 9212
# 
# LET OP ! Console address achterin het commando MOET op 9090 blijven staan 
# home/gebruiker/data/minio wordt gemapt naar data in de container
docker run -d -p 9211:9000 -p 9212:9090 --name minio_local -v /home/$USER/data/minio:/data -e "MINIO_ROOT_USER=minio1234" -e "MINIO_ROOT_PASSWORD=minio1234" minio/minio server /data --console-address ":9090"
docker logs minio_local
#
# Orgineel opstartcommando
# docker run -d -p 9000:9000 -p 9001:9001 -p 9090:9090 --name minio -v /home/$USER/data/minio:/data -e "MINIO_ROOT_USER=minio1234" -e "MINIO_ROOT_PASSWORD=minio1234" minio/minio server /data --console-address ":9001"
#
#
echo MINIO_ROOT_USER=minio1234
echo MINIO_ROOT_PASSWORD=minio1234
