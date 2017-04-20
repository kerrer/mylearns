docker run -d --name etcd -p 2379:2379 quay.io/coreos/etcd:v3.1.0-rc.1


:etcd
============
docker run --rm -it -p 4001:4001 -p 7001:7001 -v /var/etcd/:/data microbox/etcd:latest 
docker run --rm -it -p 4001:4001 -p 7001:7001 microbox/etcd:latest 

:redis
==============================================================================
docker run -d -p 6379:6379  -v /work/data/redis:/data  --name redis redis redis-server   --appendonly yes
docker run -v /work/data/redis:/data -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf --name myredis redis redis-server /usr/local/etc/redis/redis.conf  --appendonly yes


:zookeeper
===================================
docker run -d --restart=always --name zkserver -p 5151:8181 -p 2181:2181 -p 2888:2888 -p 3888:3888  -e HOSTNAME=zk.max.com mbabineau/zookeeper-exhibitor


mongodb:
docker run --name mongo -p 27017:27017 -v /work/volum/mongo:/data/db -d daocloud.io/mongo
