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

    building=$(eval $command)
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

    DEMO_PROJECT_NAME=demo-project
    JOB_FOLDER=$(pwd)/../jenkins_controller_home/jobs/$1
    DEMO_HOME=$JOB_FOLDER/$DEMO_PROJECT_NAME
    PEASS_DATA=$JOB_FOLDER/peass-data
    CHANGES_DEMO_PROJECT=$PEASS_DATA/changes.json

    WORKSPACE="workspace_peass"
    EXECUTION_FILE=$PEASS_DATA/execute_workspace.json
    DEPENDENCY_FILE=$PEASS_DATA/deps_workspace.json
    if [ $1 == "buildOnManuallyStartedAgent" ]
    then
        DEMO_HOME=../jenkins_agent-1_home/$DEMO_PROJECT_NAME
        WORKSPACE=$1"_peass"
        EXECUTION_FILE=$PEASS_DATA/execute_$1.json
        DEPENDENCY_FILE=$PEASS_DATA/deps_$1.json
    fi

    VERSION="$(cd "$DEMO_HOME" && git rev-parse HEAD)"
    echo "$VERSION"
    echo $(pwd) && ls
    cd $JOB_FOLDER && ls
    cd $PEASS_DATA/visualization && ls
    cd $PEASS_DATA/visualization/$VERSION && ls

#var source in de.dagere.peass.ExampleTest_test.js is empty, so this fails!
    SOURCE_METHOD_LINE=$(grep "Callee.method1_" $PEASS_DATA/visualization/$VERSION/de.dagere.peass.ExampleTest_test.js -A 3 \
        | head -n 3 \
        | grep innerMethod)
    if [[ "$SOURCE_METHOD_LINE" != *"innerMethod();" ]]
    then
        echo "Line could not be detected - source reading probably failed."
        echo "SOURCE_METHOD_LINE: $SOURCE_METHOD_LINE"
        echo "------------------------------------"
        cat $PEASS_DATA/visualization/$VERSION/de.dagere.peass.ExampleTest_test.js
        echo "------------------------------------"
        exit 1
    else
        echo "SOURCE_METHOD_LINE is correct."
    fi
}
