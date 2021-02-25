#!/bin/bash

#docker build -t jenkins_master ../files/master
#docker build -t slave ../files/slave

cp ../files/master/casc.yaml ../jenkins_master_home

mkdir -p ../jenkins_master_home/jobs/seed-job/workspace/dslScripts
mkdir -p ../jenkins_master_home/plugins

cp ../files/peass-ci.hpi ../jenkins_master_home/plugins

#./installPeass.sh
cp -r ../files/.m2 ../jenkins_master_home/.m2

cp ../files/master/seed-job/config.xml ../jenkins_master_home/jobs/seed-job
cp ../files/master/dslScripts/helloWorld.groovy ../jenkins_master_home/jobs/seed-job/workspace/dslScripts

cp ../files/master/dslScripts/scriptApproval.xml ../jenkins_master_home
cp ../files/master/credentials.xml ../jenkins_master_home

docker run -d --name agent-1 --rm --volume $(pwd)/../jenkins_slave-1_home:/home/ubuntu/jenkins_home slave
echo "IP of slave is: $(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' agent-1)"

docker run -d --name jenkins_master --rm --publish 8080:8080 --volume $(pwd)/../jenkins_master_home:/var/jenkins_home \
    --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=123 jenkins_master
