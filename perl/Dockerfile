# Dockerfile for Rethinkdb 
# http://www.rethinkdb.com/
FROM ubuntu:14.04
MAINTAINER Steven Max <maxkerrer@126.com>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori
RUN sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list
#RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main universe" > /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update
#RUN apt-get upgrade -y
RUN apt-get install -y build-essential  curl git-core 

RUN perl -v
RUN curl -L http://install.perlbrew.pl | bash  &&  source ~/perl5/perlbrew/etc/bashrc
RUN perlbrew install perl-5.22.0 && perlbrew switch perl-5.22.0
RUN perl -v

#RUN curl -L http://cpanmin.us | perl - --sudo Dancer2
#RUN cd / && dancer2 -a MyWeb::App
#EXPOSE 5000
#WORKDIR /MyWeb-App
#CMD ["plackup", "-r", "bin/app.psgi"]

#ADD ./mojo.pl /mojo.pl
#RUN curl -L https://cpanmin.us | perl - -M https://cpan.metacpan.org -n Mojolicious
#EXPOSE 3000
#CMD ["morbo","/mojo.pl"]