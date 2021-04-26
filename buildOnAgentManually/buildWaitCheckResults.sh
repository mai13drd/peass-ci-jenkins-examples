#!/bin/bash

./buildOnAgentManually.sh
./waitForJenkinsStartup.sh
./registerAgentToController.sh
#wait some time until jenkins_agent-1 is online and build is started
sleep 10
./waitForBuildEnd.sh
./checkResults.sh
