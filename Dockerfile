FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl gnupg

RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | apt-key add - && curl -SsL -o /etc/apt/sources.list.d/playit-cloud.list https://playit-cloud.github.io/ppa/playit-cloud.list

RUN apt-get update

RUN apt-get install playit -y

RUN adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
