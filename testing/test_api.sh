#!/usr/bin/env bash

# Quick & dirty test of Azkaban via API: http://azkaban.github.io/azkaban/docs/2.5/#ajax-api
# require: jq

# usage : ./test_api.sh ip:port

AZK_WEB="$1"
PROJECT_NAME="TestProject"
FLOW_NAME="testflow"
CMD="$(which curl) -k"
SESSION="$($CMD -s -k -X POST --data "action=login&username=azkaban&password=azkaban" https://$AZK_WEB |jq '.["session.id"]'|sed 's/"//g')"

echo -e "### Create project: $PROJECT_NAME \n"
$CMD -X POST -d "session.id=$SESSION&name=$PROJECT_NAME&description=pouet" https://$AZK_WEB/manager?action=create

echo -e "\n\n### Upload flow: $FLOW_NAME.zip \n"
$CMD -i -H "Content-Type: multipart/mixed" -X POST -F "session.id=$SESSION" -F 'ajax=upload' -F "file=@$FLOW_NAME.zip;type=application/zip" -F "project=$PROJECT_NAME" https://$AZK_WEB/manager

echo -e "\n\n### Execute flow: $FLOW_NAME \n"
$CMD -G -d "session.id=$SESSION&ajax=executeFlow&project=$PROJECT_NAME&flow=$FLOW_NAME" https://$AZK_WEB/executor

sleep 2
echo -e "\n\n### Get flow execution status of: $FLOW_NAME \n"
$CMD -G -d "session.id=$SESSION&ajax=fetchFlowExecutions&project=$PROJECT_NAME&flow=$FLOW_NAME&start=0&length=3" https://$AZK_WEB/manager

sleep 5
echo -e "\n\n### Delete project: $PROJECT_NAME"
$CMD -G -d "session.id=$SESSION&delete=true&project=$PROJECT_NAME" https://$AZK_WEB/manager
