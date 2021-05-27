#!/bin/bash

../common/scripts/buildPeassAndPeassCI.sh
./buildOnAgentManually.sh
./waitForJenkinsStartup.sh
./registerAgentToController.sh
./waitForBuildEnd.sh
./checkResults.sh
