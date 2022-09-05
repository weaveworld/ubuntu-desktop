ARG UBUNTU_MAIN=focal
ARG UBUNTU_DATE=20220826
FROM ubuntu:${UBUNTU_MAIN}-${UBUNTU_DATE}

ARG UBUNTU_MAIN
RUN echo "\
deb http://archive.ubuntu.com/ubuntu ${UBUNTU_MAIN} main universe\n\
deb http://archive.ubuntu.com/ubuntu ${UBUNTU_MAIN}-updates main universe\n\
deb http://security.ubuntu.com/ubuntu ${UBUNTU_MAIN}-security main universe\n\
" > /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get -qy update && apt-get -qy upgrade
RUN apt-get -qy --no-install-recommends install \
        supervisor sudo bash tzdata locales language-pack-en \
        ca-certificates gnupg2 \
        bzip2 zip unzip \
        curl wget rsync net-tools \
    && apt-get -fqy install && apt autoclean -qy && apt autoremove -qy

RUN mkdir /app    

CMD [ "bash" ]