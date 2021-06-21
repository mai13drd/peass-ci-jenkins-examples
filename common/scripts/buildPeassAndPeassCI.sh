#!/bin/bash

set -e

cd ../common

git clone https://github.com/dagere/peass && \
    cd peass && \
    git reset --hard 87a99a81 && \
    ./mvnw clean install -pl dependency,measurement,analysis -DskipTests

cd ..

git clone https://github.com/dagere/peass-ci && \
    cd peass-ci && \
    git reset --hard 9b9f90e && \
    ./mvnw clean -B package --file pom.xml -DskipTests

