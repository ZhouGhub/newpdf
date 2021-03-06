FROM ubuntu
MAINTAINER  17385815259@163.com

####
# install Library and software
####
RUN apt-get update
RUN apt-get install -y xvfb fonts-arphic-* zlib1g-dev vim wget libpcre3 libpcre3-dev openssl libssl-dev gcc make build-essential tar
RUN apt-get install -y libxml2 libxml2-dev libbz2-dev bzip2 libzip-dev libjpeg-dev libgd-dev curl libcurl3 libcurl3-dev libmcrypt4 libmcrypt-dev libssl-dev openssl libreadline-dev libfreetype6-dev

####
# new creat folder
####
RUN mkdir -p /var/tmp/nginx/client
RUN mkdir -p /home/dcgz/source
RUN mkdir -p /var/www/default
RUN mkdir -p /var/www/site/www.pdf.com

####
# Switch directory download
####
WORKDIR /home/dcgz/source
RUN wget http://nginx.org/download/nginx-1.12.2.tar.gz
RUN wget http://cn2.php.net/distributions/php-7.0.26.tar.gz
RUN tar -xf nginx-1.12.2.tar.gz
RUN tar -xf php-7.0.26.tar.gz

####
# Switch directory done
####
WORKDIR /home/dcgz/source/nginx-1.12.2
RUN ./configure  \
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
--with-http_gzip_static_module
RUN make && make install

####
# Switch directory done
####
WORKDIR /home/dcgz/source/php-7.0.26
RUN ./configure \
--prefix=/usr/local/php70 \
--enable-fpm \
--enable-calendar \
--enable-ctype \
--enable-dom \
--enable-exif \
--enable-fileinfo \
--enable-filter \
--enable-ftp \
--enable-hash \
--enable-iconv \
--enable-json \
--enable-mbstring \
--enable-mysqlnd \
--enable-pcntl \
--enable-pdo \
--enable-phar \
--enable-posix \
--enable-session \
--enable-shmop \
--enable-simplexml \
--enable-soap \
--enable-sockets \
--enable-tokenizer \
--enable-xml \
--with-zlib \
--with-bz2 \
--with-curl \
--with-gd \
--with-mcrypt \
--with-mysqli \
--with-openssl \
--with-readline \
--with-pdo-mysql=mysqlnd \
--with-freetype-dir \
--with-jpeg-dir
RUN make && make install

####
#Copy the file to the folder
####
ADD php-fpm.conf /usr/local/php70/etc/php-fpm.conf
ADD www.conf /usr/local/php70/etc/php-fpm.d/www.conf
ADD phpinfo.php /var/www/site/www.pdf.com/phpinfo.php
ADD index.php /var/www/default/index.php
ADD nginx.conf /usr/local/nginx/conf/nginx.conf
ADD run.sh /usr/local/sbin/run.sh
ADD simsun.ttc /usr/share/fonts/simsun.ttc
ADD wkhtmltox/bin/wkhtmltopdf /usr/sbin/wkhtmltopdf

####
#Modify permissions
####
RUN chmod 777 /usr/local/sbin/run.sh
RUN chmod 777 /usr/sbin/wkhtmltopdf
RUN chmod 755 /var/www/site/www.pdf.com/phpinfo.php
RUN mv /var/www/site/www.pdf.com/phpinfo.php /var/www/site/www.pdf.com/index.php
####
#Execute the script
####
CMD /usr/local/sbin/run.sh

####
#VOLUME virtual floder to localhost floder
####
VOLUME ["/usr/local/nginx/logs","/var/log/docker_nginx_logs"]

EXPOSE 80
#EXPOSE 8080