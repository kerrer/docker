# Dockerfile for Rethinkdb 
# http://www.rethinkdb.com/
FROM ubuntu:14.04
MAINTAINER Steven Max <maxkerrer@126.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori
RUN sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list
#RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main universe" > /etc/apt/sources.list
#RUN apt-get clean
RUN apt-get update
#RUN apt-get upgrade -y

#1.8
#RUN apt-get install -y  build-essential zlib1g zlib1g-dev openssl libcurl4-openssl-dev
#1.9
RUN apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison nodejs subversion
ADD ./ruby-1.9.3-p551.tar.gz /
ADD ./rubygems-2.4.8.tgz /
ADD ./start.sh   /start.sh

RUN cd /ruby-1.9.3-p551 && ./configure && make && make install
#RUN cd /ruby-1.8.7-p358/ext/zlib && ruby ./extconf.rb && make && make install 
RUN cd /rubygems-2.4.8 && ruby setup.rb 

RUN  gem -v
RUN gem sources -l
RUN gem sources  --remove https://rubygems.org/ && gem sources --add https://ruby.taobao.org/
RUN gem install rails  --no-document
RUN bundle config mirror.https://rubygems.org https://ruby.taobao.org
RUN mkdir -p /opt/rails/hello && rails new /opt/rails/hello
EXPOSE 3001
WORKDIR /opt/rails/hello

CMD ["rails","server","-b0.0.0.0","-p3001"]
