FROM ubuntu:focal-20220826

RUN echo "\
deb http://archive.ubuntu.com/ubuntu focal main universe\n\
deb http://archive.ubuntu.com/ubuntu focal-updates main universe\n\
deb http://security.ubuntu.com/ubuntu focal-security main universe\n\
" > /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get -qy update && apt-get -qy upgrade
RUN apt-get -qy --no-install-recommends install \
        supervisor tzdata sudo bash \
        ca-certificates gnupg2 \
        bzip2 zip unzip \
        curl wget rsync net-tools \
    && apt-get -fqy install && apt autoclean -qy && apt autoremove -qy

RUN mkdir /app    

CMD [ "bash" ]