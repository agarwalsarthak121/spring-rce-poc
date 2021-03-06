# The Tomcat version coincides with the embedded Tomcat provided by
# spring-boot-starter-parent 2.6.3.  It has to be below 9.0.62 because the
# latter shipped a protection against the particular exploit of the CVE.
ARG TOMCAT_MAJOR="9"
ARG TOMCAT_VERSION="${TOMCAT_MAJOR}.0.56"
ARG TOMCAT_DIST="https://archive.apache.org/dist/tomcat"
FROM maven:3-jdk-11-slim as build

# Make the above arguments visible to shell.  This is a special Dockerfile trick.
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG TOMCAT_MAJOR
ARG TOMCAT_VERSION
ARG TOMCAT_DIST
# We don't need to persist the above for the runtime with ENV.

RUN mkdir /usr/src/s4s
COPY . /usr/src/s4s
WORKDIR /usr/src/s4s
RUN mvn package -DskipTests

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get
RUN apt-get update && \
    apt-get install -y vim

RUN mkdir -p /opt/tomcat
WORKDIR /opt/tomcat
RUN env
RUN curl -O --progress-bar \
    "${TOMCAT_DIST}/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
RUN ls -al
RUN tar xvzf "apache-tomcat-${TOMCAT_VERSION}.tar.gz"
RUN mv "apache-tomcat-${TOMCAT_VERSION}"/* /opt/tomcat/

RUN cp -a /usr/src/s4s/target/spring-rce-demo.war \
	/opt/tomcat/webapps/

# Just a declaration.
EXPOSE 8080

# 1. Avoid Maven container's copying the Maven cache and running maven with the run arguments.
# 2. Run Tomcat.
ENTRYPOINT []

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
