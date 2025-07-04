doskey docker=vctl $1
vctl system config -c 2
vctl system config -m 8g
vctl system start
vctl volume prune -f
vctl run -d -p 9000:9000 -p 9001:9001 -e "MINIO_ROOT_USER=minio99" -e "MINIO_ROOT_PASSWORD=minio123" minio/minio server /data --console-address ":9001"