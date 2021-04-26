#!/bin/bash

./buildOnAgentManually.sh
./waitForJenkinsStartup.sh
./registerAgentToController.sh "$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins_agent-1)"

#wait some time until jenkins_agent-1 is online and build is started
sleep 5

./waitForBuildEnd.sh
./checkResults.sh
