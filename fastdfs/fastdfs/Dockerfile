FROM ubuntu:16.10

#set the environment arguments
ENV FASTDFS_BASE=/fastdfs \
    FASTDFS_STORAGE=/fastdfs/storage \
    FASTDFS_TRACKER=/fastdfs/tracker \
    FASTDFS_CLIENT=/fastdfs/client \
    BUILD_PATH=/tmp/fastdfs \
    NGINX_VERSION=1.11.5 \
    PCRE_VERSION=8.39 \
    ZLIB_VERSION=1.2.8 \
    OPENSSL_VERSION=1.0.2j \
    TRACKER_SERVER=127.0.0.1:22122

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bk
ADD ./sources.list.yakkety /etc/apt/sources.list

#get all the dependences except nginx's service	
RUN apt-get update && apt-get install -y \
    g++ \
    gcc \
    git \
    make \
    wget \
    net-tools \
    nano      \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

#create the dir 
RUN mkdir -p ${BUILD_PATH}/libfastcommon \
 && mkdir -p ${BUILD_PATH}/fastdfs \
 && mkdir -p ${BUILD_PATH}/nginx \
 && mkdir -p ${BUILD_PATH}/download \
 && mkdir -p ${BUILD_PATH}/download/nginx_module \
 && mkdir -p ${FASTDFS_BASE}  \
 && mkdir -p ${FASTDFS_STORAGE}/data \
 && mkdir -p ${FASTDFS_TRACKER} \
 && mkdir -p  ${FASTDFS_CLIENT}

ADD libs/libfastcommon ${BUILD_PATH}/libfastcommon 
ADD libs/fastdfs       ${BUILD_PATH}/fastdfs 
ADD libs/fastdfs-nginx-module ${BUILD_PATH}/download/nginx_module
ADD libs/zlib-${ZLIB_VERSION}.tar.gz"       ${BUILD_PATH}/download/
ADD libs/nginx-${NGINX_VERSION}.tar.gz      ${BUILD_PATH}/nginx/
ADD libs/openssl-${OPENSSL_VERSION}.tar.gz  ${BUILD_PATH}/download/
ADD libs/pcre-${PCRE_VERSION}.tar.gz        ${BUILD_PATH}/download/


#compile the libfastcommon 
WORKDIR ${BUILD_PATH}/libfastcommon
RUN ./make.sh \
 && ./make.sh install 
 

#compile the fastdfs  
WORKDIR ${BUILD_PATH}/fastdfs
RUN  ./make.sh \
 && ./make.sh install 
 

#compile the nginx  
WORKDIR ${BUILD_PATH}/nginx/nginx-${NGINX_VERSION}
RUN ./configure --with-pcre=${BUILD_PATH}/download/pcre-${PCRE_VERSION} \
              --with-zlib=${BUILD_PATH}/download/zlib-${ZLIB_VERSION} \
              --with-openssl=${BUILD_PATH}/download/openssl-${OPENSSL_VERSION} \
              --with-http_ssl_module \
              --add-module=${BUILD_PATH}/download/nginx_module/src \
 && make \
 && make install 
 

WORKDIR /etc/fdfs/
RUN  cp storage.conf.sample storage.conf \
  &&  sed -i.bak -e "s|base_path=/home/yuqing/fastdfs|base_path=${FASTDFS_STORAGE}|" \
        -e "s|store_path0=/home/yuqing/fastdfs|store_path0=${FASTDFS_STORAGE}|"  \
        -e "s|tracker_server=192.168.209.121:22122|tracker_server=${TRACKER_SERVER}|"  \
        -e "s|http.server_port=8888|http.server_port=80|"  \
  storage.conf

RUN  cp tracker.conf.sample tracker.conf &&  sed -i.bak "s|base_path=/home/yuqing/fastdfs|base_path=${FASTDFS_TRACKER}|" tracker.conf

RUN  cp client.conf.sample client.conf &&  sed -i.bak -e "s|base_path=/home/yuqing/fastdfs|base_path=${FASTDFS_CLIENT}|" \
       -e "s|tracker_server=192.168.0.197:22122|tracker_server=${TRACKER_SERVER}|"  client.conf
       

RUN cp ${BUILD_PATH}/download/nginx_module/src/mod_fastdfs.conf /etc/fdfs/ \
    && sed -i.bak -e "s|tracker_server=tracker:22122|tracker_server=${TRACKER_SERVER}|" \
        -e "s|store_path0=/home/yuqing/fastdfs|store_path0=${FASTDFS_STORAGE}|" \
        -e "s|url_have_group_name = false|url_have_group_name = true|" mod_fastdfs.conf



RUN cp ${BUILD_PATH}/fastdfs/conf/http.conf  /etc/fdfs/ \
    && cp ${BUILD_PATH}/fastdfs/conf/mime.types  /etc/fdfs/ 



EXPOSE 23000 80 22122

ADD nginx.conf /usr/local/nginx/conf/
ADD start.sh /usr/bin/

#make the start.sh executable
RUN chmod 777 /usr/bin/start.sh

RUN  rm -rf ${BUILD_PATH}

WORKDIR /root
ENTRYPOINT ["/usr/bin/start.sh"]

MAINTAINER kerrer <maxkerrer@126.com>
