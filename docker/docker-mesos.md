
mesosphere
==============================
  1. docker run -d --net=host netflixoss/exhibitor:1.5.2

  
  2. docker run -d --name mesos-master --net=host \
  -e MESOS_PORT=5050 \
  -e MESOS_ZK=zk://172.17.0.1:2181/mesos \
  -e MESOS_QUORUM=1 \
  -e MESOS_REGISTRY=in_memory \
  -e MESOS_LOG_DIR=/var/log/mesos \
  -e MESOS_WORK_DIR=/var/tmp/mesos \
  -v "/work/data/mesos/log:/var/log/mesos" \
  -v "/work/data/mesos/tmp:/var/tmp/mesos" \
  mesosphere/mesos:1.1.01.1.0-2.0.107.ubuntu1404   /usr/sbin/mesos-master 

  
  3. docker run -d --net=host --name mesos-slave --privileged \
  -e MESOS_PORT=5051 \
  -e MESOS_MASTER=zk://172.17.0.1:2181/mesos \
  -e MESOS_SWITCH_USER=0 \
  -e MESOS_CONTAINERIZERS=docker,mesos \
  -e MESOS_LOG_DIR=/var/log/mesos \
  -e MESOS_WORK_DIR=/var/tmp/mesos \
  -v "/work/data/mesos/log:/var/log/mesos" \
  -v "/work/data/mesos/tmp:/var/tmp/mesos" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /cgroup:/cgroup \
  -v /sys:/sys \
  -v /usr/bin/docker:/usr/local/bin/docker \
   mesosphere/mesos:1.1.01.1.0-2.0.107.ubuntu1404   /usr/sbin/mesos-slave
 
  4. docker run --net=host -e PORT0=8080 -e PORT1=8081 mesosphere/chronos \
     --zk_hosts 172.17.0.1:2181 --master zk://172.17.0.1:2181/mesos
  
  5. docker run \
     -e MESOS_LOG_DIR=/var/log/mesos \
     -e MESOS_WORK_DIR=/var/tmp/mesos \
     -v "/work/data/mesos/log:/var/log/mesos" \
     -v "/work/data/mesos/tmp:/var/tmp/mesos" \
     mesosphere/marathon --master local --zk zk://172.17.0.1:2181/marathon


mesoscloud
=======================================
docker run -d \
-e MESOS_HOSTNAME=ip.address \
-e MESOS_IP=ip.address \
-e MESOS_QUORUM=2 \
-e MESOS_ZK=zk://node-1:2181,node-2:2181,node-3:2181/mesos \
--name mesos-master --net host --restart always mesoscloud/mesos-master

docker run -d \
-e MESOS_HOSTNAME=ip.address \
-e MESOS_IP=ip.address \
-e MESOS_MASTER=zk://node-1:2181,node-2:2181,node-3:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name slave --net host --privileged --restart always \
mesoscloud/mesos-slave

docker run -d \
-e MARATHON_HOSTNAME=ip.address \
-e MARATHON_HTTPS_ADDRESS=ip.address \
-e MARATHON_HTTP_ADDRESS=ip.address \
-e MARATHON_MASTER=zk://node-1:2181,node-2:2181,node-3:2181/mesos \
-e MARATHON_ZK=zk://node-1:2181,node-2:2181,node-3:2181/marathon \
--name marathon --net host --restart always mesoscloud/marathon

docker run -d \
-e CHRONOS_HTTP_PORT=4400 \
-e CHRONOS_MASTER=zk://node-1:2181,node-2:2181,node-3:2181/mesos \
-e CHRONOS_ZK_HOSTS=node-1:2181,node-2:2181,node-3:2181 \
--name chronos --net host --restart always mesoscloud/chronos
