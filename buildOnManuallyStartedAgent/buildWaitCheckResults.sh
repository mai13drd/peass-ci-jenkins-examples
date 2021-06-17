#!/bin/bash

../common/scripts/buildPeassAndPeassCI.sh
./buildOnManuallyStartedAgent.sh
./waitForJenkinsStartup.sh
#./registerAgentToController.sh
./testCreateNode.sh
./waitForBuildEnd.sh
./checkResults.sh
