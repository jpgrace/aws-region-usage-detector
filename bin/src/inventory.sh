#!/bin/bash

. .secrets.sh

echo -n "Fetching data: "

NUM_EC2_INSTANCES=$(aws configservice list-discovered-resources \
  --resource-type "AWS::EC2::Instance" \
  | jq '.resourceIdentifiers | length')
echo -n "."

NUM_LAMBDAS=$(aws configservice list-discovered-resources \
  --resource-type "AWS::Lambda::Function" \
  | jq '.resourceIdentifiers | length')
echo -n "."

NUM_RDS_INSTANCES=$(aws configservice list-discovered-resources \
  --resource-type "AWS::RDS::DBInstance" \
  | jq '.resourceIdentifiers | length')
echo -n "."

NUM_DYNAMODB_TABLES=$(aws configservice list-discovered-resources \
  --resource-type "AWS::DynamoDB::Table" \
  | jq '.resourceIdentifiers | length')
echo -n "."

echo ""

HAS_ANY=$(($NUM_EC2_INSTANCES + $NUM_LAMBDAS + $NUM_RDS_INSTANCES + NUM_DYNAMODB_TABLES))

if [ $HAS_ANY -ne 0 ]; then
  echo "AWS account has the following resource types: "
  if [ $NUM_EC2_INSTANCES -ne 0 ]; then
    echo "AWS::EC2::Instance = $NUM_EC2_INSTANCES"
  fi
  if [ $NUM_LAMBDAS -ne 0 ]; then
    echo "AWS::Lambda::Function = $NUM_LAMBDAS"
  fi
  if [ $NUM_RDS_INSTANCES -ne 0 ]; then
    echo "AWS::RDS::DBInstance = $NUM_RDS_INSTANCES"
  fi
  if [ $NUM_DYNAMODB_TABLES -ne 0 ]; then
    echo "AWS::DynamoDB::Table = $NUM_DYNAMODB_TABLES"
  fi
else
  echo "AWS account has NO resources!"
fi

echo ""
