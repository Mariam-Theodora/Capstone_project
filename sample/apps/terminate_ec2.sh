#!/bin/bash

# Set the AMI name you want to filter and terminate
AMI_NAME="amazon-eks-node-1.27-v20230728"

# Get a list of instance IDs with the specified AMI name
INSTANCE_IDS=$(aws ec2 describe-instances --filters "Name=image-name,Values=${AMI_NAME}" --query 'Reservations[*].Instances[*].InstanceId' --output text)

if [[ -z "$INSTANCE_IDS" ]]; then
  echo "No instances with the specified AMI found."
else
  # Terminate the instances
  aws ec2 terminate-instances --instance-ids $INSTANCE_IDS
  echo "Terminated instances: $INSTANCE_IDS"
fi
