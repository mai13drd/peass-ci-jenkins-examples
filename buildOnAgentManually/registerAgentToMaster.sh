#!/bin/bash

IP=$1

cat <<EOF | java -jar ../common/jenkins-cli.jar -s "http://localhost:8080" -auth admin:123 create-node jenkins_agent-1
<slave>
  <name>jenkins_agent-1</name>
  <description></description>
  <remoteFS>/home/ubuntu/jenkins_home</remoteFS>
  <numExecutors>1</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
  <launcher class="hudson.plugins.sshslaves.SSHLauncher" plugin="ssh-slaves@1.31.5">
    <host>$1</host>
    <port>22</port>
    <credentialsId>jenkins_agent-1_credentials</credentialsId>
    <launchTimeoutSeconds>60</launchTimeoutSeconds>
    <maxNumRetries>10</maxNumRetries>
    <retryWaitTime>15</retryWaitTime>
    <sshHostKeyVerificationStrategy class="hudson.plugins.sshslaves.verifiers.NonVerifyingKeyVerificationStrategy"/>
    <tcpNoDelay>true</tcpNoDelay>
  </launcher>
  <label></label>
  <nodeProperties/>
</slave>
EOF
