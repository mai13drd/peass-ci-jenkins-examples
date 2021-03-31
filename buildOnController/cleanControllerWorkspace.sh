#!/bin/bash

docker rm -f jenkins_controller 

rm -rf ../jenkins_controller_home/{*,.*}

cd ../jenkins_controller_home

cat << EOF > .gitignore
*
!.gitignore
EOF
