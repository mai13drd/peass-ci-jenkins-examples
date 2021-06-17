#!/bin/bash
     
JENKINS_URL="http://localhost:8080"
NODE_NAME=jenkins_agent-1
NODE_HOME='/home/ubuntu/jenkins_home'
EXECUTORS=1
SSH_PORT=22
CRED_ID=jenkins_agent-1_credentials
USERID=${USER}

IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins_agent-1)
echo "IP: $IP"

cat <<EOF | java -jar ../common/jenkins-cli.jar -s "$JENKINS_URL" -auth admin:123 create-node "$NODE_NAME"
<slave>
  <name>${NODE_NAME}</name>
  <description></description>
  <remoteFS>${NODE_HOME}</remoteFS>
  <numExecutors>${EXECUTORS}</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
  <launcher class="hudson.plugins.sshslaves.SSHLauncher" plugin="ssh-slaves@1.5">
    <host>${NODE_NAME}</host>
    <port>${SSH_PORT}</port>
    <credentialsId>jenkins_agent-1_credentials</credentialsId>
  </launcher>
  <label>jenkins_agent-1</label>
  <nodeProperties/>
  <userId>admin</userId>
</slave>
EOF
