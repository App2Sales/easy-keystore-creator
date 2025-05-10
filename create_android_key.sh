#!/bin/bash

# If arguments are provided, use them; otherwise, prompt the user.
if [ $# -eq 2 ]; then
  ALIAS="$1"
  PASSWORD="$2"
else
  read -p "Enter the alias for the app: " ALIAS
  read -s -p "Enter the password for the key: " PASSWORD
  echo ""
fi

CREATION_DIRECTORY=$(pwd)

keytool -genkey -v \
  -keystore "key.pkcs12" \
  -storetype PKCS12 \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias "$ALIAS" \
  -storepass "$PASSWORD" \
  -keypass "$PASSWORD" \
  -dname "cn=Unknown, ou=Unknown, o=Unknown, c=Unknown"

if [ $? -eq 0 ]; then
  echo "🥳 - The key has been created at ${CREATION_DIRECTORY}/key.pkcs12"
else
  echo "❌ - Failed to create the key"
fi
