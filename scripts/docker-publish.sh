#!/usr/bin/env bash
set -e

cd terraform
cd backend && ./plan
REPOSITORY_NAME=$(terraform output aws_ecr_repository_name)
REPOSITORY_URL=$(terraform output aws_ecr_repository_url)
AWS_REGION=$(terraform output aws_region)
AWS_PROFILE=$(terraform output aws_profile)

cd ..
./init $DEPLOY_ENV
./plan $DEPLOY_ENV
cd ..

$(aws ecr get-login --no-include-email --region $AWS_REGION --profile $AWS_PROFILE)

printf '{"env":  "%s","git_revision": "%s","ci_build_num": "%s","ci_username": "%s"}' \
       "$APP_ENV" \
       "$CIRCLE_SHA1" \
       "$CIRCLE_BUILD_NUM" \
       "$CIRCLE_USERNAME" \
       > src/release.json

docker build -t $REPOSITORY_NAME:$CIRCLE_SHA1 --build-arg ENVIRONMENT=$APP_ENV --build-arg DEPLOY_ENV=$DEPLOY_ENV --build-arg PORT=3000 .

docker tag $REPOSITORY_NAME:$CIRCLE_SHA1 ${REPOSITORY_URL}:${CIRCLE_SHA1}

docker push ${REPOSITORY_URL}:${CIRCLE_SHA1}