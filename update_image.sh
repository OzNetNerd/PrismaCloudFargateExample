#!/bin/bash
IDENTITY_INFO=$(aws sts get-caller-identity --output text)
ACCOUNT_ID=$(echo "$IDENTITY_INFO" | cut -f1)
REGION=$(aws ec2 describe-availability-zones --query 'AvailabilityZones[0].RegionName' --output text)
REGISTRY_URL=$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
DATE=`date +%Y.%m.%d.%H.%M.%S`
docker build -t $REGISTRY_URL/$APP_NAME:latest -t $REGISTRY_URL/$APP_NAME:$DATE $APP_DIR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REGISTRY_URL
aws ecr create-repository --repository-name $APP_NAME
docker push $REGISTRY_URL/$APP_NAME:latest
docker push $REGISTRY_URL/$APP_NAME:$DATE