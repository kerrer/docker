nginx-proxy
===========


etcd+haproxy
============
1. etcd host
$ hostname --all-ip-addresses | awk '{print $1}'
10.170.71.226

$ docker run -d --name etcd -p 4001:4001 -p 7001:7001 coreos/etcd

2. backhost 1
$ docker run -d -p 8000:8000 --name whoami -t jwilder/whoami
736ab83847bb12dddd8b09969433f3a02d64d5b0be48f7a5c59a594e3a6a3541
$ docker run --name docker-register -d -e HOST_IP=$(hostname --all-ip-addresses | awk '{print $1}') -e ETCD_HOST=10.170.71.226:4001 -v /var/run/docker.sock:/var/run/docker.sock -t jwilder/docker-register
77a49f732797333ca0c7695c6b590a64a7d75c14b5ffa0f89f8e0e21ae47ae3e

3. backhost2 
docker run -d -p 8000:8000 --name whoami -t jwilder/whoami
4eb0498e52076275ee0702d80c0d8297813e89d492cdecbd6df9b263a3df1c28
$ docker run --name docker-register -d -e HOST_IP=$(hostname --all-ip-addresses | awk '{print $1}') -e ETCD_HOST=10.170.71.226:4001 -v /var/run/docker.sock:/var/run/docker.sock -t jwilder/docker-register
832e77c83591cb33bba53859153eb91d897f5a278a74d4ec1f66bc9b97deb221

4. client
   docker run -d --net host --name docker-discover -e ETCD_HOST=10.170.71.226:4001 -p 127.0.0.1:1936:1936 -t jwilder/docker-discover
   ocker run -e HOST_IP=$(hostname --all-ip-addresses | awk '{print $1}') -i -t ubuntu:14.04 /bin/bash


skydock+skydns
==================================

# start your daemon with the -dns flag, figure it out...
docker -d --bip=172.17.42.1/16 --dns=172.17.42.1 # + what other settings you use

docker pull crosbymichael/skydns
docker run -d -p 172.17.42.1:53:53/udp --name skydns crosbymichael/skydns -nameserver 8.8.8.8:53 -domain docker

docker pull crosbymichael/skydock
docker run -d -v /var/run/docker.sock:/docker.sock --name skydock crosbymichael/skydock -ttl 30 -environment dev -s /docker.sock -domain docker -name skydns


docker run -d --name redis1 crosbymichael/redis

docker run -t -i crosbymichael/redis-cli -h redis1.redis.dev.docker

dig @172.17.42.1 +short redis1.redis.dev.docker

docker run -d --name redis2 crosbymichael/redis
docker run -d --name redis3 crosbymichael/redis

dig @172.17.42.1 +short redis.dev.docker
172.17.0.4
172.17.0.5
172.17.0.6

dnsdock and CoreOs

dnsdock and CoreOs
================
