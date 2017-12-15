#This is My first Dockerfile#version 1.0
#Author: hh
#Base image 基础镜像
FROM centos
#MAINTAINER 维护者信息
MAINTAINER hh Wang
#ADD
ADD pcre-8.38.tar.gz /usr/local/srcADD nginx-1.9.3.tar.gz /usr/local/src
#RUN
RUN yum -y install wget gcc gcc-c++ make openssl openssl-devel
RUN useradd -s /sbin/nologin -M www-data-data
#WORKDIR
WORKDIR /usr/local/src/nginx-1.9.3
RUN ./configure --prefix=/usr/local/nginx --user=www-data --group=www-data --with-http_ssl_module --with-http_stub_status_module \
--with-pcre && make && make install
RUN echo "daemon off;">>/usr/local/nginx/conf/nginx.conf
#ENV定义环境变量
ENV PATH /usr/local/nginx/sbin:$PATH
#EXPOSE 映射端口
EXPOSE 80 CMD ["nginx"]