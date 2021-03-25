#!/bin/bash

docker build -t jenkins_master ../files/master

mkdir -p ../jenkins_master_home/jobs/demo-pipeline
cp ../files/master/casc.yaml ../jenkins_master_home

mkdir -p ../jenkins_master_home/plugins
cp ../files/peass-ci.hpi ../jenkins_master_home/plugins

cp ../files/master/demo-pipeline/config.xml ../jenkins_master_home/jobs/demo-pipeline

docker run -d --name jenkins_master --rm --publish 8080:8080 --volume $(pwd)/../jenkins_master_home:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker \
    --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=123 -uroot jenkins_master
