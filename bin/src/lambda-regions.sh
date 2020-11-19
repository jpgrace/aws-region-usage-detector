#!/bin/bash

. .secrets.sh

aws configservice list-discovered-resources \
  --resource-type "AWS::Lambda::Function" \
  | jq '.resourceIdentifiers | length'

# echo -n "Fetching data: "
# aws lambda list-functions \
#   --max-items 10 \
#   | jq '[ .Functions[] as $func | $func | .FunctionArn | if contains("us-east-1") then $func else empty end ]'
# echo -n "."
# HAS_USEAST1=$(aws lambda list-functions \
#   --filters "Name=availability-zone,Values=us-east-1*" \
#   --max-items 1 \
#   | jq '.Reservations | length')

# echo -n "."
# HAS_USEAST2=$(aws lambda list-functions \
#   --filters "Name=availability-zone,Values=us-east-2*" \
#   --max-items 1 \
#   | jq '.Reservations | length')

# echo -n "."
# HAS_USWEST1=$(aws lambda list-functions \
#   --filters "Name=availability-zone,Values=us-west-1*" \
#   --max-items 1 \
#   | jq '.Reservations | length')

# echo -n "."
# HAS_USWEST2=$(aws lambda list-functions \
#   --filters "Name=availability-zone,Values=us-west-2*" \
#   --max-items 1 \
#   | jq '.Reservations | length')

# echo -n "."
# HAS_SAEAST1=$(aws lambda list-functions \
#   --filters "Name=availability-zone,Values=sa-east-1*" \
#   --max-items 1 \
#   | jq '.Reservations | length')

# echo ""

# HAS_ANY=$(($HAS_USEAST1 + $HAS_USEAST2 + $HAS_USWEST1 + $HAS_USWEST2 + $HAS_SAEAST1))

# if [ $HAS_ANY -ne 0 ]; then
#   echo -n "AWS account has resources in: "
#   if [ $HAS_USEAST1 -ne 0 ]; then
#     echo -n "us-east-1 "
#   fi
#   if [ $HAS_USEAST2 -ne 0 ]; then
#     echo -n "us-east-2 "
#   fi
#   if [ $HAS_USWEST1 -ne 0 ]; then
#     echo -n "us-west-1 "
#   fi
#   if [ $HAS_USWEST2 -ne 0 ]; then
#     echo -n "us-west-2 "
#   fi
#   if [ $HAS_SAEAST1 -ne 0 ]; then
#     echo -n "sa-east-1 "
#   fi
# else
#   echo "AWS account has NO EC2 resources!"
# fi

# echo ""
