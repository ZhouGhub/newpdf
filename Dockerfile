FROM ubuntu

RUN apt-get update
RUN apt-get install -y wkhtmltopdf xvfb
RUN apt-get install -y fonts-arphic-*
RUN apt-get install -y zlib1g-dev vim wget
RUN apt-get install -y libpcre3 libpcre3-dev
RUN apt-get install -y openssl libssl-dev
RUN apt-get install -y gcc make build-essential

RUN mkdir -p /home/dcgz/source
RUN mkdir -p /home/dcgz/soft
RUN cd /home/dcgz/source
RUN wget http://nginx.org/download/nginx-1.12.2.tar.gz






