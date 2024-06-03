#!/bin/bash

LID="lt-0d2c299c1cfb51b34"
LVER=1
INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
echo "Input is missing "
exit 1
fi

IP=$(aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER --tag-specification 
"ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$INSTANCE_NAME}" "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}" | jq .Instances[].PrivateIpAddress | sed 's/"//g') 
