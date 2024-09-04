#!/bin/bash

# Fetch the remote IP from config.json
if remote_ip=$(jq -r '.remote_ip' config.json); then
  echo "Fetched IP: $remote_ip"
else
  echo "Failed to fetch IP from config.json. Please check the URL or file."
  exit 1
fi

# Continue with the rest of your script