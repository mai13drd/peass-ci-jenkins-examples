cd files/master
docker build -t jenkins_master .

cd ../slave
docker build -t slave .

cd ../..
cp files/master/casc.yaml jenkins_master_home/

docker run -d --name jenkins_master --rm --publish 8080:8080 --volume $(pwd)/jenkins_master_home:/var/jenkins_home \
--env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=123 jenkins_master

docker run -d --name agent-1 --rm --volume $(pwd)/jenkins_slave-1_home:/var/jenkins_home slave


