#!/bin/bash

set -e

WORKSPACE="$(pwd)/../jenkins_master_home/jobs/demo-pipeline-maven_masterOnly/workspace"

RIGHT_SHA="$(cd $WORKSPACE && git rev-parse HEAD)"
PREVIOUS_SHA="$RIGHT_SHA~1"

if [ ! -f $WORKSPACE/../peass-data/execute.json ]
then
    echo "$WORKSPACE/../peass-data/execute.json could not be found!"
	echo "Main Logs"
	#ls ../demo-project_peass/
    ls $WORKSPACE/../workspace_peass/
	#ls ../demo-project_peass/logs/
    ls $WORKSPACE/../workspace_peass/logs/

	echo "projektTemp"
	#ls ../demo-project_peass/projectTemp/
    ls $WORKSPACE/../peass-data/workspace_peass/projectTemp/
	
    #ls ../demo-project_peass/projectTemp/1_peass/
    ls $WORKSPACE/../peass-data/workspace_peass/projectTemp/1_peass/

    #ls ../demo-project_peass/projectTemp/1_peass/logs/
    ls $WORKSPACE/../peass-data/workspace_peass/projectTemp/1_peass/logs/

    #cat ../demo-project_peass/projectTemp/1_peass/logs/bf6d4897d8b13dcdc23d0e29d9b3b1791dec9d34/*/*
    echo "cat $WORKSPACE/../peass-data/workspace_peass/projectTemp/1_peass/logs/$PREVIOUS_SHA/*/*"
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    cat $WORKSPACE/../peass-data/workspace_peass/projectTemp/1_peass/logs/$PREVIOUS_SHA/*/*
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

    #cat ../demo-project_peass/projectTemp/1_peass/logs/$RIGHT_SHA/*/*
    echo "cat $WORKSPACE/../peass-data/workspace_peass/projectTemp/1_peass/logs/$RIGHT_SHA/*/*"   
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    cat $WORKSPACE/../peass-data/workspace_peass/projectTemp/1_peass/logs/$RIGHT_SHA/*/*
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

	exit 1
fi
