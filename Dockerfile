FROM openjdk:8-jdk-alpine

RUN apk add --no-cache curl tar bash procps

ARG MAVEN_VERSION=3.6.0
ARG USER_HOME_DIR="/home/maven"
ARG USER=1000

RUN adduser $USER -D

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN mkdir -p $MAVEN_CONFIG/repository
RUN chown $USER:$USER $USER_HOME_DIR -R

USER $USER
CMD ["mvn"]