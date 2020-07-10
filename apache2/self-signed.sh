#!/bin/bash
set -e
RESET='\e[0m'
BIBla='\e[1;90m';
BIRed='\e[1;91m';
BIGre='\e[1;92m'; 
BIYel='\e[1;93m';
BIBlu='\e[1;94m';
BIPur='\e[1;95m';
BICya='\e[1;96m';  
BIWhi='\e[1;97m';

export CERT_NAME=server
export PERSON_NAME=user
export OPENSSL_CONF="${PWD}/self.cnf"

echo -e "${BIRed}Generate an RSA Private Key for the Certificate Authority${RESET}"
openssl genrsa -aes256 -out ${CERT_NAME}.key 4096

echo -e "${BIRed}Now create the insecure key, the one without a passphrase, and shuffle the key names${RESET}"
openssl rsa -in ${CERT_NAME}.key -out ${CERT_NAME}.key.insecure
mv ${CERT_NAME}.key ${CERT_NAME}.key.secure
mv ${CERT_NAME}.key.insecure ${CERT_NAME}.key
echo -e "${BIRed}Create the CSR for Server${RESET}"
openssl req -new -key ${CERT_NAME}.key -out ${CERT_NAME}.csr

echo -e "${BIRed}Create Self-Signed Certificate for the Certificate Authority${RESET}"
openssl req -new -x509 -days 3650 -key ${CERT_NAME}.key -out ${CERT_NAME}.crt


echo -e "${BIGre}====Generate an RSA Private Key for the Personal Certificate===${RESET}"
openssl genrsa -aes256 -out ${PERSON_NAME}.key 4096

echo -e "${BIYel}===Create the Certificate Signing Request[Common Name] must deffence with server===${RESET}"
openssl req -new -key ${PERSON_NAME}.key -out ${PERSON_NAME}.csr

echo -e "${BIBlu}===Sign the Certificate Using the Certificate Authority===${RESET}"
openssl x509 -req -days 3650 -in ${PERSON_NAME}.csr -CA ${CERT_NAME}.crt -CAkey ${CERT_NAME}.key -set_serial 1 -out ${PERSON_NAME}.crt -addtrust emailProtection -addreject clientAuth -addreject serverAuth -trustout -extfile self.cnf -extensions smime
#Output shold be...
#Signature ok
#subject=O = TEST COMPANY, CN = Test User, emailAddress = test_user@dalesandro.net
#Getting CA Private Key
#Enter pass phrase for ca.key:

echo -e "${BIPur}===Package the Certificate into the PKCS12 Format===${RESET}"
openssl pkcs12 -export -in ${PERSON_NAME}.crt -inkey ${PERSON_NAME}.key -out ${PERSON_NAME}.p12




echo -e "${BICya}Installing the Certificate to Server${RESET}"
sudo cp server.crt /etc/ssl/certs/
sudo cp server.key /etc/ssl/private/


