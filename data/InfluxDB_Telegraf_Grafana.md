docker run -d --name grafana \
    -v /var/lib/grafana:/var/lib/grafana \
    -e "GF_USERS_ALLOW_SIGN_UP=false" \
    -e "GF_USERS_ALLOW_ORG_CREATE=false" \
    -e "GF_SECURITY_ADMIN_USER=user" \
    -e "GF_SECURITY_ADMIN_PASSWORD=password" \
    grafana/grafana:develop
    
docker run -d -p <privateIP>:8086:8086 \
--name=influxdb \
-v /home/core/config.toml:/config/config.toml \
--volume=/var/influxdb:/data \
-e ADMIN_USER="user"  \
-e INFLUXDB_INIT_PWD="pass" \
-e PRE_CREATE_DB="telegraf" \
tutum/influxdb:0.10


Minimal example to start an InfluxDB container:

$ docker run -d --name influxdb -p 8083:8083 -p 8086:8086 influxdb
Starting Telegraf using the default config, which connects to InfluxDB at http://localhost:8086/:

$ docker run --net=container:influxdb telegraf

docker run -p 9092:9092 kapacitor
