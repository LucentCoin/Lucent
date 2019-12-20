FROM debian:stretch
LABEL maintainer="Lucent Developers <dev@lucent.org>"
LABEL description="Dockerised LucentCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
