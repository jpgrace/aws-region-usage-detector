#!/bin/bash

. .env.sh
. .secrets.sh

echo -ne "\nFetching data: "

aws configservice list-aggregate-discovered-resources \
  --configuration-aggregator-name "ZXVenturesOrganizationConfigAggregator" \
  --resource-type "AWS::EC2::Instance" \
  --filters AccountId=$AWS_ACCOUNT \
  | jq '.ResourceIdentifiers as $res |'`
    `' $res |'`
    `' length |'`
    `' tostring |'`
    `' . as $total |'`
    `' $res |'`
    `' group_by(.SourceRegion) as $src |'`
    `' [ $src[] as $region |'`
    `' $region |'`
    `' length |'`
    `' tostring |'`
    `' . as $len |'`
    `' $region[0].SourceRegion + "=" + $len ] |'`
    `' join(",") + ",total=" + $total'

# NUM_EC2_INSTANCES=$(aws configservice list-aggregate-discovered-resources \
#   --configuration-aggregator-name "ZXVenturesOrganizationConfigAggregator" \
#   --resource-type "AWS::EC2::Instance" \
#   --filters AccountId=$AWS_ACCOUNT \
#   | jq '.ResourceIdentifiers | length')
# echo -n "."

# NUM_LAMBDAS=$(aws configservice list-aggregate-discovered-resources \
#   --configuration-aggregator-name "ZXVenturesOrganizationConfigAggregator" \
#   --resource-type "AWS::Lambda::Function" \
#   --filters AccountId=$AWS_ACCOUNT \
#   | jq '.ResourceIdentifiers | length')
# echo -n "."

# NUM_RDS_INSTANCES=$(aws configservice list-aggregate-discovered-resources \
#   --configuration-aggregator-name "ZXVenturesOrganizationConfigAggregator" \
#   --resource-type "AWS::RDS::DBInstance" \
#   --filters AccountId=$AWS_ACCOUNT \
#   | jq '.ResourceIdentifiers | length')
# echo -n "."

# NUM_DYNAMODB_TABLES=$(aws configservice list-aggregate-discovered-resources \
#   --configuration-aggregator-name "ZXVenturesOrganizationConfigAggregator" \
#   --resource-type "AWS::DynamoDB::Table" \
#   --filters AccountId=$AWS_ACCOUNT \
#   | jq '.ResourceIdentifiers | length')
# echo -n "."

# echo -e "\n"

# HAS_ANY=$(($NUM_EC2_INSTANCES + NUM_LAMBDAS + NUM_RDS_INSTANCES + NUM_DYNAMODB_TABLES))

# if [ $HAS_ANY -ne 0 ]; then
#   echo "AWS account $AWS_ACCOUNT has the following resource types: "
#   if [ $NUM_EC2_INSTANCES -ne 0 ]; then
#     echo "AWS::EC2::Instance = $NUM_EC2_INSTANCES"
#   fi
#   if [ $NUM_LAMBDAS -ne 0 ]; then
#     echo "AWS::Lambda::Function = $NUM_LAMBDAS"
#   fi
#   if [ $NUM_RDS_INSTANCES -ne 0 ]; then
#     echo "AWS::RDS::DBInstance = $NUM_RDS_INSTANCES"
#   fi
#   if [ $NUM_DYNAMODB_TABLES -ne 0 ]; then
#     echo "AWS::DynamoDB::Table = $NUM_DYNAMODB_TABLES"
#   fi
# else
#   echo "AWS account has NO resources!"
# fi

# echo ""
