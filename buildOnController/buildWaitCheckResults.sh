#!/bin/bash

./buildPeassAndPeassCI.sh
./buildOnController.sh
./waitForJenkinsStartup.sh
./waitForBuildEnd.sh
./checkResults.sh
