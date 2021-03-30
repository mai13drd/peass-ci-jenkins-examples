# jenkinsPipeline

This is a testproject for running peass-ci performance-measurements in a jenkins docker-container.

<br>

## Setup

* All scripts has to be run from inside scripts-folder!

### Build demo-project on jenkins_master
* Run buildOnMasterOnly.sh to build and start jenkins_master-container.

* Wait until jenkins_master-container is fully started (check, if http://localhost:8080 can be loaded).

* Login to jenkins on http://localhost:8080:<br>
    user: admin<br>
    password: 123

* You should see the job "demo-project" which clones github.com/mai13drd/demo-project and has already a peass-ci buildstep configured.

* Build the demo-project to measure differences in performance between the last two commits.

### Build demo-pipeline_masterOnly
* This step will perform a pipeline-build.

* If you ran the above steps before, you should clean the workspace of master! Use cleanWorkspaces.sh for that.

* Run preparePipelineBuild_MasterOnly.sh to build and start jenkins_master-container.

* Wait until jenkins is fully started (check, if http://localhost:8080 can be loaded).

* Login to jenkins (same credentials as above).

* You will see the configured pipeline-job "demo-pipeline_masterOnly".

* Notice the jobs pipeline-script-configuration:
    * First, the job will clone a test-project.
    * In stage('Test') measurement parameters are configured.
    * In a post-step, the script checkResults.sh is executed. This will perform some checks on the measurement-results.

* Since preparePipelineBuild_MasterOnly.sh starts the jenkins-container as user root, you have to run cleanWorkspaces.sh with sudo now! So you will have the appropriate rights to delete folders and files in jenkins_master_home.
