# Dockerfile for Rethinkdb 
# http://www.rethinkdb.com/
##docker run -d --name odoo -p 8069:8069 -v $(pwd):/opt/odoo max/odoo
FROM ubuntu:14.04
MAINTAINER Steven Max <maxkerrer@126.com>
RUN python3 --version
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori
RUN sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list
#RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main universe" > /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y  build-essential 
RUN apt-get install -y openssl libcurl4-openssl-dev zlib1g-dev libpq-dev
RUN apt-get install -y libxml2 libxml2-dev libxslt1-dev libsasl2-dev libjpeg-dev
ADD ./Python-2.7.9.tgz /
ADD ./get-pip.py /get-pip.py
ADD ./requirements.txt /requirements.txt
ADD ./odoo.sh /odoo.sh
RUN chmod +x /odoo.sh

RUN cd /Python-2.7.9 && ./configure && make && make install
RUN which python
RUN python /get-pip.py
#RUN pip install virtualenv virtualenvwrapper
#RUN mkdir -p /opt/virtualenvs
#ENV WORKON_HOME /opt/virtualenvs
#RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh \
#    && mkvirtualenv myapp \
#    && workon myapp \
#    && pip install -r /mycode/myapp/requirements.txt"
RUN pip install -r /requirements.txt -i https://pypi.mirrors.ustc.edu.cn/simple

RUN apt-get install -y npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g less less-plugin-clean-css

EXPOSE 8069

CMD ["/odoo.sh"]
