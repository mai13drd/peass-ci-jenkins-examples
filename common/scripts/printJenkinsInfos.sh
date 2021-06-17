#!/bin/bash

java -jar ../common/jenkins-cli.jar -s http://localhost:8080 -auth admin:123 get-node jenkins_agent-1
echo "-----------------------------------------------------"
java -jar ../common/jenkins-cli.jar -s http://localhost:8080 -auth admin:123 list-jobs
echo "-----------------------------------------------------"
java -jar ../common/jenkins-cli.jar -s http://localhost:8080 -auth admin:123 who-am-i
echo "-----------------------------------------------------"
