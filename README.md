# Peass-CI sample usage project

This project provides several examples for the usage of the [Peass-CI-Plugin](https://github.com/DaGeRe/peass-ci). 

## Overview
This project demonstrates the usage of the [Peass-CI-Plugin](https://github.com/DaGeRe/peass-ci) on a Jenkins server. The plugin can be used to detect performance differences and their potentially causes between different versions of a Java project. Therefore, the Jenkins server executes a pipeline-build of the Java project, measuring its performance.
Each example uses the [demo-with-jenkinsfile](https://github.com/DaGeRe/demo-with-jenkinsfile) as the testproject.

## General Approach
All examples run Jenkins inside a Docker container. Scripts are provided to build/configure and start the container(s). Also a Jenkins pipeline-job is configured by copying a *config.xml* to its appropriate folder in Jenkins. The *config.xml* defines the jobs pipeline in which the parameters of the performance measurements are set.

Two YAML-files in *.github/workflows* configure *buildOnController* and *buildOnAgentAutomatic* to be built on github-actions with Java 8, 11 and 15. They include the four steps *Build and run container*, *Wait for jenkins startup*, *Wait for build end* and *Check results*. So after the measurements are started, it is waited for their end and measurement-results are checked afterwards.

## Important
Each example has its own folder. Make sure to always run the appropriate scripts from the appropriate folder!

Before executing another example, don't forget to cleanup the Jenkins workspace! Therefore a script is provided for each example. Run the cleanup-scripts with sudo, since the containers are started as user root!

To log in to Jenkins on http://localhost:8080, enter *admin* as user and *123* as password.

### Build testproject on Jenkins controller
This will execute a build on a Jenkins server running inside a Docker container

* Move to folder *buildOnController* and execute *buildOnController.sh*. After that, a Docker container named *jenkins_controller* is running.

* After Jenkins is fully started (means http://localhost:8080 can be loaded), you can log in.

* You will see, that a pipeline-project named *buildOnController* is configured and a build is already running.

* If the build is finished, you can check its dashboard. You will find informations about performance changes and their possibly causes.

* You can run *checkResults.sh* afterwards, to check if measurement-results are as expected.

* Running *buildWaitCheckResults.sh* will run all the steps executed at github-actions, as described in section *General Approach*. So instead of running each single step on its own, you can also execute *buildWaitCheckResults.sh*.

* Clean the workspace of Jenkins controller using *cleanControllerWorkspace.sh*.

### Build testproject in a manually registered Jenkins agent
This will execute a build inside a Jenkins agent. Therefore, next to the Docker container for the Jenkins controller, a second one is started and manually registered to Jenkins as build-agent.

* Move to folder *buildOnAgentManually*.

* Execute *buildOnAgentManually.sh*. After that, two Docker containers are running, named *jenkins_controller* and *jenkins_agent-1*.

* Wait until jenkins is fully started (means http://localhost:8080 can be loaded) and log in.

* You will see, that a pipeline-project named *buildOnAgentManually* is configured.

* Run *registerAgentToController.sh*. This will register *jenkins_agent-1* as build agent.

* As soon as *jenkins_agent-1* is online in Jenkins, the build will start.

* If the build is finished, you can check its dashboard. You will find informations about performance changes and their possibly causes.

* You can run *checkResults.sh* afterwards, to check if measurement-results are as expected.

* Running *buildWaitCheckResults.sh* will run all the steps as described above. So instead of running each single step on its own, you can also execute *buildWaitCheckResults.sh*.

* Clean the workspaces of Jenkins controller and agent using *cleanWorkspaces.sh*.

### Build testproject in an agent automatically started by Jenkins controller

This will execute a build inside a Jenkins agent. The agent is started by Jenkins controller. The pipeline is configured to pull the Docker image "maven:3.6.3-jdk-11" and use it as build agent.

* Move to folder *buildOnAgentAutomatic*.

* Execute *buildOnAgentAutomatic.sh*. After that, a Docker container named *jenkins_controller* is running.

* After Jenkins is fully started (means http://localhost:8080 can be loaded), you can log in.

* You will see, that a pipeline-project named *buildOnAgentAutomatic* is configured and a build is already running.

* If the build is finished, you can check its dashboard. You will find informations about performance changes and their possibly causes.

* You can run *checkResults.sh* afterwards, to check if measurement-results are as expected.

* Running *buildWaitCheckResults.sh* will run all the steps as described above. So instead of running each single step on its own, you can also execute *buildWaitCheckResults.sh*.

* Clean the workspace of Jenkins controller using *cleanControllerWorkspace.sh*.
