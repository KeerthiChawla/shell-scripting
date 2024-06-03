#!/bin/bash

LID="lt-0d2c299c1cfb51b34"
LVER=1

aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER | jq .Instances.InstanceId
