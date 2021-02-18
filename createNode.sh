#!/bin/bash
     
#cat <<EOF | java -jar jenkins-cli.jar -s $1 create-node $2

cat <<EOF | java -jar jenkins-cli.jar -s "http://localhost:8080" -auth admin:123 create-node agent-1
<slave>
  <name>'agent-1'</name>
  <description></description>
  <remoteFS>/home/ubuntu</remoteFS>
  <numExecutors>1</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
  <launcher class="hudson.plugins.sshslaves.SSHLauncher" plugin="ssh-slaves@1.31.5">
    <host>172.17.0.2</host>
    <port>22</port>
    <credentialsId>68791c3d-8d51-4f75-8dd8-67014ad7a963</credentialsId>
    <launchTimeoutSeconds>60</launchTimeoutSeconds>
    <maxNumRetries>10</maxNumRetries>
    <retryWaitTime>15</retryWaitTime>
    <sshHostKeyVerificationStrategy class="hudson.plugins.sshslaves.verifiers.NonVerifyingKeyVerificationStrategy"/>
    <tcpNoDelay>true</tcpNoDelay>
  </launcher>
  <label></label>
  <nodeProperties/>
  <userId>22</userId>
</slave>
EOF
