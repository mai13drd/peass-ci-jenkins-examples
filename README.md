# Introduction
- This is a testproject for running peass-ci performance-measurements in a jenkins pipeline.

## run execute.sh to build and start jenkins_master- and slave-container

## login to jenkins on http://localhost:8080:
- user: admin<br>
- password: 123

## you should see the seed-job (which is already built at jenkins-startup) and the example, which is built by the seed-job but not built itself yet.

## configure slave-container as build-node:
- add new node under:<br>
    localhost:8080/computer/new<br>
- configure like in configure_agent-1.png<br>
- get IP-adress of slave to set for Hostname:<br>
    docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' agent-1<br>
- add credentials:<br>
    user: jenkins<br>
    password: jenkins

## configure example-project to be built on agent-1
- in example-projects configuration -> "Restrict where this project can be run" -> agent-1 (the name, you gave your node)

