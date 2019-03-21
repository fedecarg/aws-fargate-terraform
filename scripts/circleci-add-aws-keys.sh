#!/usr/bin/env bash

mkdir -p ~/.aws

echo "[federico]\naws_access_key_id=${AWS_ACCESS_KEY}\naws_secret_access_key=${AWS_SECRET_KEY}" >> ~/.aws/credentials
