# jenkinsPipeline

This is a testproject for running peass-ci performance-measurements in a jenkins docker-container.

<br>

## Setup

* All scripts has to be run from inside scripts-folder!

### Build demo-project on jenkins_master only
* Run buildOnMasterOnly.sh to build and start jenkins_master-container.

* Wait until jenkins_master-container is fully started (check, if http://localhost:8080 can be loaded).

* Login to jenkins on http://localhost:8080:<br>
    user: admin<br>
    password: 123

* You should see the demo-project-job which clones github.com/mai13drd/demo-project and has already a peass-ci buildstep configured.

* Build the demo-project to measure differences in performance between the last two commits.

### Build demo-pipeline in a docker-agent
* If you ran the above steps before, you should clean the workspace of master! Use cleanWorkspaces.sh for that.

* Run preparePipelineBuild.sh to build and start jenkins_master-container.

* Wait until jenkins is fully started (check, if http://localhost:8080 can be loaded).

* Login to jenkins (same credentials as above).

* You will see the configured pipeline-job "demo-pipeline", notice its pipeline script configuration.

* If you start the build, jenkins will autonomous start a docker-container-image (node:14-alpine) and use it to build the demo-pipeline inside. This time, you have no performance measurements. There is just a shell-command executed which outputs the node-version of the node:14-alpine docker-container.

* Since preparePipelineBuild.sh starts the jenkins-container as user root, you have to run cleanWorkspaces.sh as sudo now. So you will have the appropriate rights to delete folders and files in jenkins_master_home.
