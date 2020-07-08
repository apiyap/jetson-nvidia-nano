#!/bin/bash
set -e
#My OpenSSL:
#Key:
openssl genrsa -out server_key.pem 2048

#Certificate Signing Request:
openssl req -new -key server_key.pem -out server_csr.pem

#Certificate:
openssl x509 -req -days 1825 -in server_csr.pem -signkey server_key.pem -out server_cert.pem
