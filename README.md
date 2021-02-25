# jenkinsPipeline

This is a testproject for running peass-ci performance-measurements in a jenkins docker-container.

<br>

## Setup

* Run buildOnMasterOnly.sh from inside the scripts-folder to build and start jenkins_master-container.

* Wait until jenkins_master-container has been started.

* Login to jenkins on http://localhost:8080:<br>
    user: admin<br>
    password: 123

* You should see the demo-project-job which clones a demo-project and has already a "Versionsperformance messen"-buildstep configured.

* Build the demo-project to measure differences in performance between the last two commits.
