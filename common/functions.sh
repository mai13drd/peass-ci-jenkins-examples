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

    PEASS_DATA=$(pwd)/../jenkins_controller_home/jobs/$1/peass-data

    # If minor updates to the project occur, the version name may change
    VERSION="b02c92af73e3297be617f4c973a7a63fb603565b"
    PREVIOUS_VERSION="e80d8a1bf747d1f70dc52260616b36cac9e44561"

    WORKSPACE="workspace_peass"
    EXECUTE_FILE=$PEASS_DATA/execute_workspace.json
    if [ $1 == "buildOnAgentManually" ]
    then
        WORKSPACE=$1"_peass"
        EXECUTE_FILE=$PEASS_DATA/execute_$1.json
    fi

    if [ ! -f $EXECUTE_FILE ]
    then
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        echo "$EXECUTE_FILE could not be found!"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

        echo "Main Logs:"
        ls $PEASS_DATA/$WORKSPACE

	    echo "projektTemp:"
	    ls $PEASS_DATA/$WORKSPACE/projectTemp/

        echo "projectTemp/tree_"$VERSION"_peass:"
        ls $PEASS_DATA/$WORKSPACE/projectTemp/tree_"$VERSION"_peass/

        echo "projectTemp/tree_"$PREVIOUS_VERSION"_peass:"
        ls $PEASS_DATA/$WORKSPACE/projectTemp/tree_"$PREVIOUS_VERSION"_peass/

        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        echo "cat $PEASS_DATA/$WORKSPACE/projectTemp/tree_"$VERSION"_peass/logs/$VERSION/*/*"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        cat $PEASS_DATA/$WORKSPACE/projectTemp/tree_"$VERSION"_peass/logs/$VERSION/*/*

        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        echo "cat $PEASS_DATA/$WORKSPACE/projectTemp/tree_"$PREVIOUS_VERSION"_peass/logs/$PREVIOUS_VERSION/*/*"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        cat $PEASS_DATA/$WORKSPACE/projectTemp/tree_"$PREVIOUS_VERSION"_peass/logs/$PREVIOUS_VERSION/*/*

	    exit 1
    fi

    #Check, if peass-data/changes.json contains the correct commit-SHA
    TEST_SHA=$(grep -A1 'versionChanges" : {' $PEASS_DATA/changes.json | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')

    if [ "$VERSION" != "$TEST_SHA" ]
    then
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    echo "commit-SHA is not equal to the SHA in peass-data/changes.json!"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    cat $PEASS_DATA/changes.json
	    exit 1
    else
	    echo "peass-data/changes.json contains the correct commit-SHA."
    fi

    #Check, if a slowdown is detected for innerMethod
    STATE=$(grep '"call" : "de.test.Callee#innerMethod",\|state' $PEASS_DATA/visualization/$VERSION/de.test.CalleeTest_onlyCallMethod1.js \
        | grep "innerMethod" -A 1 | grep '"state" : "SLOWER",' | grep -o 'SLOWER')

    if [ "$STATE" != "SLOWER" ]
    then
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    echo "State for de.test.Callee#innerMethod in de.test.CalleeTest_onlyCallMethod1.js has not the expected value SLOWER, but was $STATE!"
        echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	    cat $PEASS_DATA/visualization/$VERSION/de.test.CalleeTest_onlyCallMethod1.js
	    exit 1
    else
	    echo "Slowdown is detected for innerMethod."
    fi

#    sourceMethodLine=$(grep "de.test.Callee.method1_" $PEASS_DATA/visualization/$VERSION/de.test.CalleeTest_onlyCallMethod1.js \
#        -A 3 | head -n 3 | grep innerMethod)

#    if [[ "$sourceMethodLine" != *"innerMethod();" ]]
#    then
#	    echo "Line could not be detected - source reading probably failed."
#	    echo "Line: "
#	    echo $sourceMethodLine
#	    exit 1
#    fi
}
