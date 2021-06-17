#!/bin/bash

source ../common/functions.sh
echo "Wait until jenkins_agent-1 is online and build is started."
sleep 30
waitForBuildEnd "buildOnManuallyStartedAgent"
