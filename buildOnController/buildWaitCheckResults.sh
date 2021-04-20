#!/bin/bash

./buildOnController.sh
./waitForJenkinsStartup.sh
./waitForBuildEnd.sh
./checkResults.sh
