FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install nodejs -y
RUN apt-get install npm -y
RUN nodejs -v

COPY . /

CMD ["nodejs","server.js"]
EXPOSE 9001
