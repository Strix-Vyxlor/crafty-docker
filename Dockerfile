FROM alpine:latest as install

RUN apk update
RUN apk upgrade

RUN apk add git libffi libffi-dev python3 python3-dev py3-pip alpine-sdk openjdk8-jre openjdk11-jre openjdk17-jre openjdk21-jre

RUN adduser -D -s /bin/ash crafty
RUN mkdir -p /crafty
RUN chown -R crafty:crafty /crafty

USER crafty
WORKDIR /crafty 
RUN git clone https://gitlab.com/crafty-controller/crafty-4.git 

RUN python3 -m venv .venv 
RUN source .venv/bin/activate && cd crafty-4 && pip3 install --no-cache-dir -r requirements.txt

COPY run_crafty.sh /crafty

FROM install as endpoint

USER crafty
WORKDIR /crafty

EXPOSE 25565
EXPOSE 8123
EXPOSE 8443

ENTRYPOINT ash /crafty/run_crafty.sh
