#!/bin/bash

#Give jenkins some time to startup and start building
sleep 15

building=true
while [ building ]
do
	sleep 5
	building=$(echo 'println(jenkins.model.Jenkins.instance''.getItem("demo-pipeline_masterOnly").lastBuild.building)' | ../java -jar jenkins-cli.jar -s http://localhost:8080 -auth admin:123 groovy =)
	echo 'Jenkins is still building...'
done

./checkResults.sh
