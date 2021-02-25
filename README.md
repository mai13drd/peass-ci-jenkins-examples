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

### Build demo-project on agent-1 node (still fails currently)

* If you ran the above steps before, you should clean the workspace of master! Use cleanWorkspaces.sh for that.

* Run execute.sh to build and start jenkins_master- and slave-container. Notice the shown IP of the slave-container.

* Wait until jenkins is fully started (check, if http://localhost:8080 can be loaded).

* Login to jenkins (same credentials as above).

* You should see the seed-job (which is already built at jenkins-startup) and the demo-project, which was built by the seed-job but is not built itself yet.

* Configure a peass-ci buildstep, everything else is configured already.

* Run createNode.sh with the shown IP of slave-container as parameter. This will trigger the build of demo-project.
