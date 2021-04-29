waitForJenkinsStartup () {

    command="{ echo 'println(jenkins.model.Jenkins.instance''.getItem(\"$1\"))' | java -jar ../common/jenkins-cli.jar -s \
        http://localhost:8080 -auth admin:123 groovy =; } &>/dev/null"

    online=1
    while [ $online -ne 0 ]
    do
	    echo 'Waiting for jenkins startup...'
        sleep 3
        eval $command
        online=$?
    done

    echo "------------------------------------"
    echo "Jenkins is fully started."
    echo "------------------------------------"
}

waitForBuildEnd () {

    command="echo 'println(jenkins.model.Jenkins.instance''.getItem(\"$1\").lastBuild.building)' | java -jar ../common/jenkins-cli.jar -s \
            http://localhost:8080 -auth admin:123 groovy ="

    building=true
    while [ "$building" = true ]
    do
        sleep 5
	    building=$(eval $command)
        echo 'Jenkins is still building...'
    done

    echo "------------------------------------"
    echo 'Jenkins finished building.'
    echo "------------------------------------"
}

checkResults () {

    JOBFOLDER="$(pwd)/../jenkins_controller_home/jobs/$1"
    PEASS_DATA=$JOBFOLDER/peass-data
    echo "PEASS_DATA: $PEASS_DATA"

    # If minor updates to the project occur, the version name may change
    #RIGHT_SHA="$(cd $JOBFOLDER/workspace && git rev-parse HEAD)"
    VERSION=$(cat $JOBFOLDER/peass-data/execute.json | grep "versions" -A 1 | grep -v "version" | tr -d "\": {")
    echo "Version: $VERSION"

    #PREVIOUS_SHA="$RIGHT_SHA~1"
    PREVIOUS_VERSION="$VERSION~1"

    #This does not work for buildOnAgentManually since workspace_peass is then named buildOnAgentManually_peass
    if [ ! -f $JOBFOLDER/peass-data/execute.json ]
    then
        WORKSPACE="workspace"
        if [ $1="buildOnAgentManually" ]
        then
            WORKSPACE=$1
            echo "WORKSPACE: $WORKSPACE"
        fi

        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        echo "$JOBFOLDER/peass-data/execute.json could not be found!"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

        echo "Main Logs:"
        #only containing empty folders for buildOnController and buildOnAgentAutomatic, not present at all for buildOnAgentManually
        #ls $JOBFOLDER/$WORKSPACE"_peass"/
        ls $PEASS_DATA/$WORKSPACE"_peass"

        #only containing empty folders for buildOnController and buildOnAgentAutomatic, not present at all for buildOnAgentManually
	    #ls $JOBFOLDER/workspace_peass/logs/

	    echo "projektTemp:"
	    ls $JOBFOLDER/peass-data/$WORKSPACE"_peass"/projectTemp/

        ls $JOBFOLDER/peass-data/$WORKSPACE"_peass"/projectTemp/1_peass/

        ls $JOBFOLDER/peass-data/$WORKSPACE"_peass"/projectTemp/1_peass/logs/

        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        echo "cat $JOBFOLDER/peass-data/$WORKSPACE"_peass"/projectTemp/1_peass/logs/$PREVIOUS_VERSION/*/*"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        cat $JOBFOLDER/peass-data/$WORKSPACE"_peass"/projectTemp/1_peass/logs/$PREVIOUS_VERSION/*/*

        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        echo "cat $JOBFOLDER/peass-data/$WORKSPACE"_peass"/projectTemp/1_peass/logs/$VERSION/*/*"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        cat $JOBFOLDER/peass-data/$WORKSPACE"_peass"/projectTemp/1_peass/logs/$VERSION/*/*

	    exit 1
    fi

    #Check, if peass-data/changes.json contains the correct commit-SHA
    TEST_SHA=$(grep -A1 'versionChanges" : {' $JOBFOLDER/peass-data/changes.json | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')
    if [ "$VERSION" != "$TEST_SHA" ]
    then
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    echo "commit-SHA is not equal to the SHA in peass-data/changes.json!"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    cat $JOBFOLDER/peass-data/changes.json
	    exit 1
    else
	    echo "peass-data/changes.json contains the correct commit-SHA."
    fi

    #Check, if a slowdown is detected for innerMethod
    STATE=$(grep '"call" : "de.test.Callee#innerMethod",\|state' $JOBFOLDER/peass-data/visualization/$VERSION/de.test.CalleeTest_onlyCallMethod1.js | grep "innerMethod" -A 1 | grep '"state" : "SLOWER",' | grep -o 'SLOWER')
    if [ "$STATE" != "SLOWER" ]
    then
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    echo "State for de.test.Callee#innerMethod in de.test.CalleeTest_onlyCallMethod1.js has not the expected value SLOWER, but was $STATE!"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    cat $JOBFOLDER/peass-data/visualization/$VERSION/de.test.CalleeTest_onlyCallMethod1.js
	    exit 1
    else
	    echo "Slowdown is detected for innerMethod."
    fi

    sourceMethodLine=$(grep "de.test.Callee.method1_" $JOBFOLDER/peass-data/visualization/$VERSION/de.test.CalleeTest_onlyCallMethod1.js -A 3 | head -n 3 | grep innerMethod)
    if [[ "$sourceMethodLine" != *"innerMethod();" ]]
    then
	    echo "Line could not be detected - source reading probably failed."
	    echo "Line: "
	    echo $sourceMethodLine
	    exit 1
    fi
}
