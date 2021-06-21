#!/bin/bash


echo "Enter the alias for the app:"
read ALIAS

echo "Enter the passowrd for the key:"
read PASSWORD

keytool -genkey -v -keystore "key.pkcs12" -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 10000 -alias $ALIAS --storepass $PASSWORD --keypass $PASSWORD -dname "cn=Unknown, ou=Unknown, o=Unknown, c=Unknown" && echo " 🥳 - The key has benn created at ${CREATION_DIRECTORY}/key.pcks12"
