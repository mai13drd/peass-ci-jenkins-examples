#!/bin/bash

../common/scripts/buildPeassAndPeassCI.sh
./buildOnControllerCompileError.sh
./waitForJenkinsStartup.sh
./waitForBuildEnd.sh
./checkResults.sh
