#!/bin/bash

docker rm -f jenkins_controller

rm -rf ../jenkins_controller_home/{*,.*}
rm -rf ../common/peass
rm -rf ../common/peass-ci

cd ../jenkins_controller_home

cat << EOF > .gitignore
*
!.gitignore
EOF
