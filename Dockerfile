FROM ubuntu
MAINTAINER  17385815259@163.com

RUN apt-get update
RUN apt-get install -y wkhtmltopdf xvfb
RUN apt-get install -y fonts-arphic-*
RUN apt-get install -y zlib1g-dev vim wget
RUN apt-get install -y libpcre3 libpcre3-dev
RUN apt-get install -y openssl libssl-dev
RUN apt-get install -y gcc make build-essential

RUN mkdir -p /var/tmp/nginx/client
RUN mkdir -p /home/dcgz/source
RUN mkdir -p /home/dcgz/soft

RUN cd /home/dcgz/source

RUN wget http://nginx.org/download/nginx-1.12.2.tar.gz
RUN wget http://cn2.php.net/distributions/php-7.0.26.tar.gz

RUN tar -xf nginx-1.12.2.tar.gz
RUN tar -xf php-7.0.26.tar.gz
WORKDIR nginx-1.12.2 && ./configure  \
--prefix=/usr/local/nginx \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--with-http_ssl_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_realip_module \
--with-http_gzip_static_module \
--with-mail_ssl_module \
--with-debug \
--with-stream \
--http-client-body-temp-path=/var/tmp/nginx/client \
--http-proxy-temp-path=/var/tmp/nginx/proxy \
--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
--http-scgi-temp-path=/var/tmp/nginx/scgi \
--with-http_stub_status_module \
--with-http_gzip_static_module \

&& make && make install

ADD nginx.conf /home/dcgz/soft/nginx/conf/nginx.conf
CMD /usr/local/nginx/sbin/nginx  -g "daemon off;"

EXPOSE 80