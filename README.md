# jenkinsPipeline

This is a testproject for running peass-ci performance-measurements in a jenkins pipeline.

<br>

## Setup

* Run execute.sh to build and start jenkins_master- and slave-container.

* Login to jenkins on http://localhost:8080:<br>
    user: admin<br>
    password: 123

* You should see the seed-job (which is already built at jenkins-startup) and the example, which was built by the seed-job but not built itself yet.

<br>

## Configure slave-container as build-node for the example-job
* execute createNode.sh, use the ID of slave-container as shown after executing execute.sh
* for example: ./createNode.sh 172.20.0.2

<br>

## Configure example-job to be built on agent-1
* in example-projects configuration -> "Restrict where this project can be run" -> agent-1 (the name, you gave your node)

