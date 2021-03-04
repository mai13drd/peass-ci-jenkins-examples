FROM ubuntu:latest

RUN apt update && apt install openssh-server sudo curl -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 jenkins

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk maven git && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME


RUN  echo 'jenkins:jenkins' | chpasswd

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
