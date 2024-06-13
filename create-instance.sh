#!/bin/bash

LID="lt-072186c51d0a03700"
LVER=1

aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER | jq.Instances[].InstanceId