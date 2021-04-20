waitForJenkinsStartup () {

    #Avoid exit on error if jenkins is not started yet
    set +e

    online=1
    while [ $online -ne 0 ]
    do
	    echo 'Waiting for jenkins startup...'
        sleep 3
	    { echo 'println(jenkins.model.Jenkins.instance''.getItem("buildOnAgentManually"))' | java -jar ../common/jenkins-cli.jar -s http://localhost:8080 -auth admin:123 groovy =; } 2> /dev/null
        online=$?
    done

    set -e

    echo "------------------------------------"
    echo "Jenkins is fully started."
    echo "------------------------------------"

}

