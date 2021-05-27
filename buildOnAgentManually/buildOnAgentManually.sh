#!/bin/bash

set -e

docker build -t jenkins_controller ../common/controller
docker build -t jenkins_agent ../common/agent

cp ../common/controller/casc.yaml ../jenkins_controller_home

mkdir -p ../jenkins_controller_home/plugins
cp ../common/peass-ci/target/peass-ci.hpi ../jenkins_controller_home/plugins

mkdir -p ../jenkins_controller_home/jobs/buildOnAgentManually
cp config.xml ../jenkins_controller_home/jobs/buildOnAgentManually

tar -xf ../common/demo-project.tar.xz --directory ../jenkins_controller_home/jobs/buildOnAgentManually

cp credentials.xml ../jenkins_controller_home/

docker run -d --name jenkins_agent-1 --rm \
    --volume $(pwd)/../jenkins_agent-1_home:/home/ubuntu/jenkins_home jenkins_agent

AGENT_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins_agent-1)
echo "------------------------------------"
echo "IP of jenkins_agent-1 is: $AGENT_IP"
echo "------------------------------------"

docker run -d --name jenkins_controller --rm --publish 8080:8080 \
    --volume $(pwd)/../jenkins_controller_home:/var/jenkins_home \
    --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=123 jenkins_controller
