# Docker Apache PHP

## To Build

``` bash
$ docker build -t max/openbravo .
```

### To Run

Use [docker volumes](http://docs.docker.io/use/working_with_volumes/) to expose
your web content to the apache web server.

``` bash
# run docker openbravo
$ CONTAINER=$(docker run --name openbravo -d -p 8080:8080 -v /work/webapps:/usr/local/tomcat/openbravo max/openbravo)

# get the http port
$ docker port $CONTAINER 80
0.0.0.0:49206
```

### To access the database
``` bash
# get the mysql port
$ docker port $CONTAINER 3306
0.0.0.0:49205

# get [dockerhost] IP reading 'inet addr' value
$ ifconfig docker0 | grep 'inet addr'
          inet addr:172.17.42.1  Bcast:0.0.0.0  Mask:255.255.0.0

$ mysql -h172.17.42.1 -uroot -P 49205
```
