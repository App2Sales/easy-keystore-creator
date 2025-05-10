#!/bin/bash

# Check for CLI arguments: alias, password, and optional destination
if [ $# -ge 2 ]; then
  ALIAS="$1"
  PASSWORD="$2"
  DESTINATION="${3:-.}"  # default to current directory if not provided
else
  read -p "Enter the alias for the app: " ALIAS
  read -s -p "Enter the password for the key: " PASSWORD
  echo ""
  read -p "Enter destination path (relative to current dir, default: .): " DESTINATION
  DESTINATION="${DESTINATION:-.}"
fi

# Ensure destination exists
mkdir -p "$DESTINATION"

OUTPUT_FILE="$DESTINATION/key.pkcs12"

keytool -genkey -v \
  -keystore "$OUTPUT_FILE" \
  -storetype PKCS12 \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias "$ALIAS" \
  -storepass "$PASSWORD" \
  -keypass "$PASSWORD" \
  -dname "cn=Unknown, ou=Unknown, o=Unknown, c=Unknown"

if [ $? -eq 0 ]; then
  echo "🥳 - The key has been created at $(realpath "$OUTPUT_FILE")"
else
  echo "❌ - Failed to create the key"
fi
