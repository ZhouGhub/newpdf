FROM ubuntu
RUN apt-get update
RUN apt-get install -y nginx
CMD nginx

EXPOSE 8001