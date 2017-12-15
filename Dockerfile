FROM centos:latest
MAINTAINER frankie onez0714@163.com

RUN yum -y update
RUN yum install -y pcre-devel wget net-tools gcc zlib zlib-devel make openssl-devel
RUN mkdir -p /home/dcgz/software
RUN mkdir -p /var/tmp/nginx/client
RUN wget http://nginx.org/download/nginx-1.12.2.tar.gz
RUN tar -zxvf nginx-1.12.2.tar.gz

WORKDIR /home/dcgz/software && ./configure  \
--prefix=/usr/local/nginx1.12.2 \
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

RUN make -j 8 && make install
RUN rm -vf /usr/local/nginx/conf/nginx.conf

ADD nginx.conf /usr/local/nginx/conf/nginx.conf

CMD "/usr/local/nginx/sbin/nginx  -g "daemon off;"

EXPOSE 80