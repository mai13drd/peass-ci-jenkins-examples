#!/bin/bash

../common/scripts/buildPeassAndPeassCI.sh
./buildOnAgentAutomatic.sh
./waitForJenkinsStartup.sh
./waitForBuildEnd.sh
./checkResults.sh
