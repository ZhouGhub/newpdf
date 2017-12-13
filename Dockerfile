FROM ubuntu
RUN apt-get update
RUN apt-get install nginx
RUN wget /home/http://nginx.org/download/nginx-1.12.2.tar.gz