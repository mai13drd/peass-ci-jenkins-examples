rm -rf ../jenkins_master_home/{*,.*}
rm -rf ../jenkins_slave-1_home/{*,.*}

cd ../jenkins_master_home

cat << EOF > .gitignore
*
!.gitignore
EOF

cp .gitignore ../jenkins_slave-1_home
