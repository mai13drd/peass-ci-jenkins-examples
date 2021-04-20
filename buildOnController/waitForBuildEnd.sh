#!/bin/bash

set -e

#Give jenkins some time to startup and start building
echo 'Waiting for jenkins startup...'
sleep 20

building=true
while [ "$building" = true ]
do
    sleep 5
	building=$(echo 'println(jenkins.model.Jenkins.instance''.getItem("buildOnController").lastBuild.building)' | java -jar ../common/jenkins-cli.jar -s http://localhost:8080 -auth admin:123 groovy =)
    echo 'Jenkins is still building...'
done

echo 'Jenkins finished building.'
