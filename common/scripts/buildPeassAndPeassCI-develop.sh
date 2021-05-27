#!/bin/bash

set -e

cd ../common

git clone --branch develop https://github.com/dagere/peass && \
    cd peass && \
    ./mvnw clean install -pl dependency,measurement,analysis -DskipTests

cd ..

git clone --branch develop https://github.com/dagere/peass-ci && \
    cd peass-ci && \
    ./mvnw clean -B package --file pom.xml -DskipTests

