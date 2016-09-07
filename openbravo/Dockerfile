FROM tomcat:7.0
MAINTAINER Eugene Ware <eugene@noblesamurai.com>

#RUN mv /etc/apt/sources.list /etc/apt/sources.list.ori
#ADD sources.list /etc/apt/sources.list
#RUN apt-get update
#RUN RUN apt-get -y upgrade
# Keep upstart from complaining
#ADD ./openbravo.xml /usr/local/tomcat/conf/Catalina/localhost/openbravo.xml
ADD ./tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
#RUN mkdir /usr/local/tomcat/openbravo

