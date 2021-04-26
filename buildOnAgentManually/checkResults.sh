#!/bin/bash

set -e

JOBFOLDER="$(pwd)/../jenkins_controller_home/jobs/$1"
WORKSPACE="$(pwd)/../jenkins_agent-1_home/workspace"

RIGHT_SHA="$(cd $WORKSPACE/buildOnAgentManually && git rev-parse HEAD)"
#echo "RIGHT_SHA: $RIGHT_SHA"

PREVIOUS_SHA="$RIGHT_SHA~1"
#echo "PREVIOUS_SHA: $PREVIOUS_SHA"

if [ ! -f $JOBFOLDER/peass-data/execute.json ]
then
    echo "$JOBFOLDER/peass-data/execute.json could not be found!"
    echo "Main Logs"

#	 ls $JOBFOLDER/workspace_peass/
    ls $WORKSPACE/buildOnAgentManually_peass

#	 ls $JOBFOLDER/workspace_peass/logs/
    ls $WORKSPACE/buildOnAgentManually_peass/logs

	echo "projektTemp"
#	 ls $JOBFOLDER/peass-data/workspace_peass/projectTemp/
    ls $JOBFOLDER/peass-data/buildOnAgentManually_peass/projectTemp

#    ls $JOBFOLDER/peass-data/workspace_peass/projectTemp/1_peass/
    ls $JOBFOLDER/peass-data/buildOnAgentManually_peass/projectTemp/1_peass/

#    ls $JOBFOLDER/peass-data/workspace_peass/projectTemp/1_peass/logs/
    ls $JOBFOLDER/peass-data/buildOnAgentManually_peass/projectTemp/1_peass/logs

#    echo "cat $JOBFOLDER/peass-data/workspace_peass/projectTemp/1_peass/logs/$PREVIOUS_SHA/*/*"
    echo "cat $JOBFOLDER/peass-data/buildOnAgentManually_peass/projectTemp/1_peass/logs/$PREVIOUS_SHA/*/*"
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
#    cat $JOBFOLDER/peass-data/workspace_peass/projectTemp/1_peass/logs/$PREVIOUS_SHA/*/*
    cat $JOBFOLDER/peass-data/buildOnAgentManually_peass/projectTemp/1_peass/logs/$PREVIOUS_SHA/*/*
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

#    echo "cat $JOBFOLDER/peass-data/workspace_peass/projectTemp/1_peass/logs/$RIGHT_SHA/*/*"
    echo "cat $JOBFOLDER/peass-data/buildOnAgentManually_peass/projectTemp/1_peass/logs/$RIGHT_SHA/*/*"
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
#    cat $JOBFOLDER/peass-data/workspace_peass/projectTemp/1_peass/logs/$RIGHT_SHA/*/*
    cat $JOBFOLDER/peass-data/buildOnAgentManually_peass/projectTemp/1_peass/logs/$RIGHT_SHA/*/*
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

    exit 1
fi

#Check, if peass-data/changes.json contains the correct commit-SHA
TEST_SHA=$(grep -A1 'versionChanges" : {' $JOBFOLDER/peass-data/changes.json | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')
if [ "$RIGHT_SHA" != "$TEST_SHA" ]
then
    echo "commit-SHA is not equal to the SHA in peass-data/changes.json!"
    cat $JOBFOLDER/peass-data/changes.json
    exit 1
else
    echo "peass-data/changes.json contains the correct commit-SHA."
fi

# If minor updates to the project occur, the version name may change
VERSION=$(cat $JOBFOLDER/peass-data/execute.json | grep "versions" -A 1 | grep -v "version" | tr -d "\": {")
echo "Version: $VERSION"
