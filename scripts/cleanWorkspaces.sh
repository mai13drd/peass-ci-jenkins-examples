docker rm -f jenkins_master 
docker rm -f agent-1 
rm -rf ../jenkins_master_home/{*,.*}
rm -rf ../jenkins_slave-1_home/{*,.*}

cd ../jenkins_master_home

cat << EOF > .gitignore
*
!.gitignore
EOF

cp .gitignore ../jenkins_slave-1_home
