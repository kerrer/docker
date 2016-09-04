# Dockerfile for Rethinkdb 
# http://www.rethinkdb.com/
FROM python:2.7
MAINTAINER Steven Max <maxkerrer@126.com>
ADD . /code
WORKDIR /code
RUN pip install --upgrade pip && pip install -r requirements.txt
RUN apt-get install -y npm && npm install -g less less-plugin-clean-css

EXPOSE 8069
CMD ["/odoo.sh"]
