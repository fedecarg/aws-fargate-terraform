#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -qq -y python-pip libpython-dev
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install awscli --upgrade --ignore-installed urllib3
