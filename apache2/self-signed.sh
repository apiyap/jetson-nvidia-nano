#!/bin/bash
set -e
export CERT_NAME=server
export PERSON_NAME=user
export OPENSSL_CONF="${PWD}/self.cnf"

echo "Generate an RSA Private Key for the Certificate Authority"
openssl genrsa -aes256 -out ${CERT_NAME}.key 4096

echo "Now create the insecure key, the one without a passphrase, and shuffle the key names"
openssl rsa -in ${CERT_NAME}.key -out ${CERT_NAME}.key.insecure
mv ${CERT_NAME}.key ${CERT_NAME}.key.secure
mv ${CERT_NAME}.key.insecure ${CERT_NAME}.key
echo "Create the CSR for Server"
openssl req -new -key ${CERT_NAME}.key -out ${CERT_NAME}.csr

echo "Create Self-Signed Certificate for the Certificate Authority"
openssl req -new -x509 -days 3650 -in ${CERT_NAME}.csr -key ${CERT_NAME}.key -out ${CERT_NAME}.crt


echo "====Generate an RSA Private Key for the Personal Certificate==="
openssl genrsa -aes256 -out ${PERSON_NAME}.key 4096

echo "===Create the Certificate Signing Request[Common Name] must deffence with server==="
openssl req -new -key ${PERSON_NAME}.key -out ${PERSON_NAME}.csr

echo "===Sign the Certificate Using the Certificate Authority==="
openssl x509 -req -days 3650 -in ${PERSON_NAME}.csr -CA ${CERT_NAME}.crt -CAkey ${CERT_NAME}.key -set_serial 1 -out ${PERSON_NAME}.crt -addtrust emailProtection -addreject clientAuth -addreject serverAuth -trustout -extfile self.cnf -extensions smime
#Output shold be...
#Signature ok
#subject=O = TEST COMPANY, CN = Test User, emailAddress = test_user@dalesandro.net
#Getting CA Private Key
#Enter pass phrase for ca.key:

echo "===Package the Certificate into the PKCS12 Format==="
openssl pkcs12 -export -in ${PERSON_NAME}.crt -inkey ${PERSON_NAME}.key -out ${PERSON_NAME}.p12




echo "Installing the Certificate to Server"
sudo cp server.crt /etc/ssl/certs
sudo cp server.key /etc/ssl/private


