FROM ubuntu:latest

RUN apt update && \
	apt install -y openssh-server sudo curl openjdk-8-jdk maven git

RUN java -version

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 jenkins

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

RUN  echo 'jenkins:jenkins' | chpasswd

RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

USER jenkins
RUN cd && \
    git clone https://github.com/dagere/peass && \
    cd peass && \
    mvn clean install -DskipTests

USER root
RUN service ssh start

# Standard SSH port
EXPOSE 22

# Define default command.
CMD ["/usr/sbin/sshd","-D"]
