#!/usr/bin/env bash
set -e

cd terraform
cd backend && ./plan && cd ..
./init $DEPLOY_ENV
./plan $DEPLOY_ENV $CIRCLE_SHA1
./apply
cd ..