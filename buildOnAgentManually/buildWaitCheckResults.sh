#!/bin/bash

./buildOnAgentManually.sh
./waitForJenkinsStartup.sh
./registerAgentToController.sh
./waitForBuildEnd.sh
./checkResults.sh
