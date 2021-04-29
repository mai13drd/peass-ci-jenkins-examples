#!/bin/bash

./buildOnAgentAutomatic.sh
./waitForJenkinsStartup.sh
./waitForBuildEnd.sh
./checkResults.sh
