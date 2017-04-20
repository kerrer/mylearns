 
docker exec -it apache /bin/bash -c "export TERM=xterm; exec bash"

docker ps
docker ps -a
docker images
docker rm
docker rmi
docker run -e VAR=value -e ANOTHER_VAR=another_value

sudo chcon -v -R  --type=httpd_sys_rw_content_t  templates_c
sudo chcon -v -R  --type=public_content_rw_t  templates_c cache
sudo chcon -v -R  --type=svirt_sandbox_file_t docker-registry

chcon -Rt svirt_sandbox_file_t /my/own/datadir


 docker ps -a -q | xargs -n 1 -I {}  docker rm {}
docker rmi $( docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

sync container datetime with host:
===================================
option 1: -v /etc/localtime:/etc/localtime:ro
option 2: -e "TZ=Asia/Shanghai"


===================================================================

sudo docker export <CONTAINER ID> > /home/export.tar  
cat /home/export.tar | sudo docker import - busybox-1-export:latest

sudo docker save busybox-1 > /home/save.tar
 docker load < /home/save.tar

gzip pause.tar

images:
========================================================================
phusion/baseimage:
busybox: BusyBox 是很多标准 Linux® 工具的一个单个可执行实现。BusyBox 包含了一些简单的工具，例如 cat 和 echo，还包含了一些更大、更复杂的工具，例如 grep、find、mount 以及 telnet（不过它的选项比传统的版本要少）；有些人将 BusyBox 称为 Linux 工具里的瑞士军刀
martin/docker-cleanup-volumes:

Alpine
========================================================================
A minimal Docker image based on Alpine Linux with a complete package index and only 5 MB in size!

scratch: an explicitly empty image, especially for building images "FROM scratch"



=================================================================================






 
docker exec -it apache /bin/bash -c "export TERM=xterm; exec bash"
docker exec -it mysql bash

docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
PID=$(docker inspect --format '{{.State.Pid}}' my_container_id)
nsenter --target $PID --mount --uts --ipc --net --pid

docker ps
docker ps -a
docker images
docker rm
docker rmi
docker run -e VAR=value -e ANOTHER_VAR=another_value

sudo chcon -v -R  --type=httpd_sys_rw_content_t  templates_c
sudo chcon -v -R  --type=public_content_rw_t  templates_c cache
sudo chcon -v -R  --type=svirt_sandbox_file_t docker-registry

chcon -Rt svirt_sandbox_file_t /my/own/datadir

clean
===========
docker ps -a -q | xargs -n 1 -I {}  docker rm {}

docker rm   $(docker ps -a -q)

docker rmi $( docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
===================================================================

sudo docker export <CONTAINER ID> > /home/export.tar  
cat /home/export.tar | sudo docker import - busybox-1-export:latest

sudo docker save busybox-1 > /home/save.tar
 docker load < /home/save.tar

gzip pause.tar
========================================================================







username: kermit
password: kermit
==============================================================================



=========
acbuild aims to support a workflow very similar to Dockerfiles, but with more flexibility and adherence to the Unix tools philosophy, and native image output in the modern ACI forma


===================================================

docker run -d --hostname my-rabbit --name some-rabbit rabbitmq
ocker run -it --rm --link some-rabbit:my-rabbit -e RABBITMQ_ERLANG_COOKIE='secret cookie here' -e RABBITMQ_NODENAME=rabbit@my-rabbit rabbitmq:3 bash
docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management

docker run --name='activemq' -d \
-e 'ACTIVEMQ_NAME=amqp-srv1' \
-e 'ACTIVEMQ_REMOVE_DEFAULT_ACCOUNT=true' \
-e 'ACTIVEMQ_ADMIN_LOGIN=admin' -e 'ACTIVEMQ_ADMIN_PASSWORD=your_password' \
-e 'ACTIVEMQ_WRITE_LOGIN=producer_login' -e 'ACTIVEMQ_WRITE_PASSWORD=producer_password' \
-e 'ACTIVEMQ_READ_LOGIN=consumer_login' -e 'ACTIVEMQ_READ_PASSWORD=consumer_password' \
-e 'ACTIVEMQ_JMX_LOGIN=jmx_login' -e 'ACTIVEMQ_JMX_PASSWORD=jmx_password' \
-e 'ACTIVEMQ_STATIC_TOPICS=topic1;topic2;topic3' \
-e 'ACTIVEMQ_STATIC_QUEUES=queue1;queue2;queue3' \
-e 'ACTIVEMQ_MIN_MEMORY=1024' -e  'ACTIVEMQ_MAX_MEMORY=4096' \
-e 'ACTIVEMQ_ENABLED_SCHEDULER=true' \
-v /data/activemq:/data/activemq \
-v /var/log/activemq:/var/log/activemq \
-p 8161:8161 \
-p 61616:61616 \
-p 61613:61613 \
webcenter/activemq:5.14.3

Drone 是一个建立在 Docker 之上的 持续集成(Continuous integration)系统。官方支持下面的系统和版本
Portainer is a lightweight management UI which allows you to easily manage your Docker host or Swarm cluster.
Shipyard 是一个基于 Web 的 Docker 管理工具，支持多 host，可以把多个 Docker host 上的 containers 统一管理；可以查看 images，甚至 build images；并提供 RESTful API 等等。 Shipyard 要管理和控制 Docker host 的话需要先修改 Docker host 上的默认配置使其支持远程管理。


