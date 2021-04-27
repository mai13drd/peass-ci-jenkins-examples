#!/bin/bash

set -e

source ../common/functions.sh
#wait some time until jenkins_agent-1 is online and build is started
sleep 10
waitForBuildEnd "buildOnAgentManually"
