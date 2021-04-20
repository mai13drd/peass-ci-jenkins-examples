#!/bin/bash

./buildOnController.sh
./waitForBuildEnd.sh
./checkResults.sh
