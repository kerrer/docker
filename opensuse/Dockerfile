FROM mmckeen/opensuse-13-1  
MAINTAINER Matthew McKeen <matthew@mmckeen.net>

RUN zypper -n in nginx

# tell Nginx to stay foregrounded
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# run
ENTRYPOINT /usr/sbin/nginx -c /etc/nginx/nginx.conf

# expose HTTP
EXPOSE 80
