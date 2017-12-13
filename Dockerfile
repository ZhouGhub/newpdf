FROM ubuntu
RUN apt-get update
RUN apt-get install -y nginx
ADD nginx.conf /etc/nginx/nginx.conf

CMD nginx

EXPOSE 8001