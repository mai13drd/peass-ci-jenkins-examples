#!/bin/bash

../common/scripts/buildPeassAndPeassCI.sh
./buildOnJenkinsStartedAgent.sh
./waitForJenkinsStartup.sh
./waitForBuildEnd.sh
./checkResults.sh
