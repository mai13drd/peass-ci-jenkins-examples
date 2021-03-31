# Peass-CI sample usage project

This project provides several examples for the usage of the [Peass-CI-Plugin](https://github.com/DaGeRe/peass-ci). 

## Overview
This project demonstrates the usage of the [Peass-CI-Plugin](https://github.com/DaGeRe/peass-ci) on a Jenkins server. The plugin can be used to detect performance differences and their potentially causes between different versions of a Java project. Therefore, the Jenkins server executes a pipeline-build of the Java project, measuring its performance.
Each example uses the [demo-with-jenkinsfile](https://github.com/DaGeRe/demo-with-jenkinsfile) as the testproject. The Jenkins server will execute the build according to the testprojects Jenkinsfile. In the Jenkinsfile the parameters of the perfomance measurements are configured.

## General Approach
All examples run Jenkins inside a Docker container. Scripts are provided to build/configure and start the container. Also a Jenkins pipeline job is configured and will be built, as soon as Jenkins is online.

## Important
Each example has its own folder. Make sure to always run the appropriate scripts from the appropriate folder! Before executing another example, don't forget to cleanup the Jenkins workspace! Therefore a script is provided for each example. <br>
To login to Jenkins on http://localhost:8080, enter *admin* as user and *123* as password.

### Build testproject on Jenkins controller
This will execute a build on a Jenkins server running inside a Docker container

* Move to folder *buildOnController* and execute *buildOnController.sh*. After that, a Docker container named *jenkins_controller* is running.

* After Jenkins is fully started (means http://localhost:8080 can be loaded), you can login.

* You will see, that a pipeline-project named *buildOnController* is configured and a build is already running.

* If the build is finished, you can check the builds dashboard. You will find informations about performance changes and their possibly causes.
