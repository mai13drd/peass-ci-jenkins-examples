cd ../files/.m2/repository/
rm -rf {*,.*}

cat << EOF > .gitignore
*
!.gitignore
EOF

git clone https://github.com/dagere/peass && \
    cd peass && mvn clean install -DskipTests -Dmaven.repo.local=.. && cd .. && rm -r -f peass
