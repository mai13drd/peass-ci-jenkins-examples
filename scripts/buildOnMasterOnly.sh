#!/bin/bash

docker build -t jenkins_master ../files/master
docker build -t slave ../files/slave

cp ../files/master/casc.yaml ../jenkins_master_home

mkdir -p ../jenkins_master_home/plugins
cp ../files/peass-ci.hpi ../jenkins_master_home/plugins

./installPeass.sh
cp -r ../files/.m2 ../jenkins_master_home

mkdir -p ../jenkins_master_home/jobs
cp -r ../files/demo-project ../jenkins_master_home/jobs/

docker run --name jenkins_master --rm --publish 8080:8080 --volume $(pwd)/../jenkins_master_home:/var/jenkins_home \
    --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=123 jenkins_master
