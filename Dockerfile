FROM ubuntu:20.04
ENV JAVA_HOME=/u01/middleware/jdk-11.0.1
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.74
ENV PATH=$PATH:$JAVA_HOME/bin:$TOMCAT_HOME/bin

RUN mkdir -p /u01/middleware
RUN mkdir -p /u01/middleware/covido
WORKDIR /u01/middleware

ADD https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz .
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.74/bin/apache-tomcat-9.0.74.tar.gz .
RUN tar -xzvf openjdk-11.0.1_linux-x64_bin.tar.gz 
RUN tar -xzvf apache-tomcat-9.0.74.tar.gz
RUN apt update -y
RUN apt install -y curl
RUN apt install -y mysql-client-8.0
RUN apt install -y net-tools

RUN rm openjdk-11.0.1_linux-x64_bin.tar.gz
RUN rm apache-tomcat-9.0.74.tar.gz

COPY . ./covido
COPY target/covido.war ${TOMCAT_HOME}/webapps
COPY run.sh .
RUN chmod u+x run.sh
ENTRYPOINT [ "./run.sh" ]
CMD [ "tail", "-f", "/dev/null" ]
