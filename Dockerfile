FROM ubuntu

RUN apt-get update
RUN apt-get install -y wkhtmltopdf xvfb
RUN apt-get install -y fonts-arphic-*
RUN apt-get install zlib1g-dev vim wget
RUN apt-get install apt-get install libpcre3 libpcre3-dev
RUN apt-get install apt-get install openssl libssl-dev
RUN apt-get install apt-get install gcc make build-essential

RUN mkdir -p /home/dcgz/source
RUN mkdir -p /home/dcgz/soft
RUN cd /home/dcgz/source
RUN wget http://nginx.org/download/nginx-1.12.2.tar.gz






