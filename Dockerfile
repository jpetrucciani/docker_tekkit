FROM ubuntu

MAINTAINER jacobi@mimirhq.com

WORKDIR /minecraft
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get install -y python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer wget unzip
RUN wget -O /tmp/tekkit.zip http://servers.technicpack.net/Technic/servers/tekkitmain/Tekkit_Server_v1.2.9g.zip
RUN unzip /tmp/tekkit.zip -d /minecraft/
ADD ./launch.sh /minecraft/launch.sh
RUN chmod +x /minecraft/launch.sh

VOLUME /minecraft
EXPOSE 25565

ENTRYPOINT ["java", "-Xmx2G", "-Xms1G", "-jar", "Tekkit.jar", "nogui"]
