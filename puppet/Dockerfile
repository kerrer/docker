# Dockerfile for Rethinkdb 
# http://www.rethinkdb.com/
FROM ubuntu:14.04
#FROM phusion/baseimage
MAINTAINER Steven Max <maxkerrer@126.com>

# Use baseimage-docker's init system.
#CMD ["/sbin/my_init"]

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori
RUN sed -i "s/archive.ubuntu.com/mirrors.sohu.com/g" /etc/apt/sources.list

# ...put your own build instructions here...
RUN apt-get update && apt-get -y upgrade && apt-get -y install wget   && apt-get clean

RUN wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb -O /tmp/puppet-repo.deb \
    && dpkg -i /tmp/puppet-repo.deb  \ 
    && rm /tmp/puppet-repo.deb 


RUN apt-get update 
RUN apt-get install -y puppetmaster-passenger 



# Clean up certificates
RUN rm -rf /var/lib/puppet

VOLUME /var/lib/puppet /etc/puppet/modules /etc/puppet/manifests

EXPOSE 8140

ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

