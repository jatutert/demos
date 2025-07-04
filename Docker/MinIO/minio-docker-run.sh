#! /bin/bash
#
# Minio Object Storage on Docker
docker run -d -p 9000:9000 -p 9001:9001 -p 9090:9090 --name minio -v /home/$USER/data/minio:/data -e "MINIO_ROOT_USER=minio1234" -e "MINIO_ROOT_PASSWORD=minio1234" minio/minio server /data --console-address ":9001"
echo MINIO_ROOT_USER=minio1234
echo MINIO_ROOT_PASSWORD=minio1234
