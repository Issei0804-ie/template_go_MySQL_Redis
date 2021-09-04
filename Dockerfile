FROM golang:latest

WORKDIR /go/src/app

# timezone change
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#RUN apt clean -y
#RUN apt update -y 
#RUN apt upgrade -y

RUN apt-get update && apt-get install -y wget

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir -p /var/log/backend/
RUN touch /var/log/backend/backend.log

CMD dockerize -wait tcp://db:3306 go run /go/src/app/main.go >> /var/log/backend/backend.log
