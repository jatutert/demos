# op basis van https://appdev24.com/pages/62

# countryName                       = Country Name (2 letter code)
# countryName_default               = US
# stateOrProvinceName               = State or Province Name (full name)
# stateOrProvinceName_default       = NY
# localityName                      = Locality Name (eg, city)
# localityName_default              = New York
# organizationName                  = Organization Name (eg, company)
# organizationName_default          = Example, LLC



# MinIO API
openssl req -x509 -nodes -days 365 \
    -subj "/C=NL/ST=Overijssel/L=Raalte/O=tutsoft/OU=dev/CN=minio.local" \
    -newkey rsa:4096 -keyout selfsigned.key \
    -out selfsigned.crt

#MinIO UI
openssl req -x509 -nodes -days 365 \
    -subj "/C=NL/ST=Overijssel/L=Raalte/O=tutsoft/OU=dev/CN=minio-ui.local" \
    -newkey rsa:4096 -keyout selfsigned-ui.key \
    -out selfsigned-ui.crt

kubectl create namespace mlops

kubectl create secret tls minio-tls --namespace mlops --cert=selfsigned.crt --key=selfsigned.key
kubectl create secret tls minio-ui-tls --namespace mlops --cert=selfsigned-ui.crt --key=selfsigned-ui.key