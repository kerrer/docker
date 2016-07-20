FROM nginx
COPY nginx_1-3-9.conf /etc/nginx/conf.d/nginx_1-3-9.conf
COPY docker-registry.conf /etc/nginx/docker-registry.conf
COPY auth/htpasswd  /etc/nginx/htpasswd
COPY certs/domain.crt /etc/ssl/certs/server.crt
COPY certs/domain.key /etc/ssl/private/server.key
