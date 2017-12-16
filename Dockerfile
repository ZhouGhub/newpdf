FROM ubuntu
MAINTAINER  17385815259@163.com

RUN echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y wkhtmltopdf xvfb
RUN apt-get install -y fonts-arphic-*
RUN apt-get install -y zlib1g-dev vim wget
RUN apt-get install -y libpcre3 libpcre3-dev
RUN apt-get install -y openssl libssl-dev
RUN apt-get install -y nginx
RUN apt-get install -y gcc make build-essential \
    &&rm -rf /var/lib/apt/lists/*

ADD nginx.conf /etc/nginx/nginx.conf
ADD site-config /etc/nginx/sites-available/default
ADD index.php /var/www/html/index.php

CMD service php7.0-fpm start;nginx
EXPOSE 80