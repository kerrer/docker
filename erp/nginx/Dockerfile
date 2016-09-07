# Dockerfile for Rethinkdb 
# http://www.rethinkdb.com/
FROM nginx:1.9
MAINTAINER Steven Max <maxkerrer@126.com>
#COPY nginx.conf /etc/nginx/nginx.conf
#RUN sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list
RUN mv /etc/apt/sources.list /etc/apt/sources.list.ori
ADD ./sources.list /etc/apt/sources.list
#RUN apt-get update \
#    && apt-get install -y curl \ 
#    && echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list \
#    && echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list \
#    && curl http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN apt-get update && apt-get install -y \
			php5-fpm \
            php5-common \
			php5-curl \
			php5-gd \
			php5-intl \
			php5-mcrypt \
			php5-mysqlnd \			
			php5-pgsql \			
			php5-sqlite \
			php5-tidy \
			php5-xmlrpc \
			php5-xsl \
			&& sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf

ADD docker-entrypoint.sh /entrypoint.sh
ADD test.php /usr/share/nginx/html/test.php
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
