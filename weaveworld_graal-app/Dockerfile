ARG DATE_VERSION=20220901
FROM weaveworld/ubuntu:u20-${DATE_VERSION}

RUN apt-get update && apt-get -qy --no-install-recommends install \
    git
    
ARG GRAAL_VERSION=22.2.0
ARG JAVA_VERSION=17
ARG MAVEN_MAIN_VERSION=3
ARG MAVEN_VERSION=3.8.6

ADD https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-java${JAVA_VERSION}-linux-amd64-${GRAAL_VERSION}.tar.gz /tmp
RUN tar xfz /tmp/graalvm*.tar.gz -C /usr/share && mv /usr/share/graalvm* /usr/share/graalvm
ENV JAVA_HOME="/usr/share/graalvm"
ENV PATH="/usr/share/graalvm/bin:${PATH}"
RUN gu install js

ADD https://dlcdn.apache.org/maven/maven-${MAVEN_MAIN_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz /tmp
RUN tar xf /tmp/apache-maven-*.tar.gz -C /usr/share && mv /usr/share/apache-maven-* /usr/share/maven
ENV M2_HOME="/usr/share/maven"
ENV MAVEN_HOME="/usr/share/maven"
ENV PATH="/usr/share/maven/bin:${PATH}"

RUN rm -fr /tmp/*.tar.gz 

RUN wget -P /bin https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh

ADD fs /
RUN chmod +x /bin/graal*

WORKDIR /app

CMD [ "graal_app" ]