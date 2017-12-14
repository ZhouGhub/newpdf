FROM ubuntu
MAINTAINER  17385815259@163.com

RUN apt-get update
RUN apt-get install -y wkhtmltopdf xvfb
RUN apt-get install -y fonts-arphic-*
RUN apt-get install -y zlib1g-dev vim wget
RUN apt-get install -y libpcre3 libpcre3-dev
RUN apt-get install -y openssl libssl-dev
RUN apt-get install -y gcc make build-essential

RUN apt-get install -y nginx
CMD service nginx start

EXPOSE 8080