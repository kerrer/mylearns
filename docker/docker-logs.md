
Kibana=
==============


StatsD + Grafana + InfluxDB 
=============================
StatsD 是一个使用 Node.js 开发的简单的网络守护进程，通过 UDP 或者 TCP 方式侦听各种统计信息，包括计数器和定时器，并发送聚合信息到后端服务，例如 Graphite 、 ElasticSearch 、 InfluxDB 等等，这里 列出了支持的 backend 
Grafana 是一个使用 Go 开发的开源的、功能齐全的、好看的仪表盘和图表的编辑器，可用来做日志的分析与展示曲线图（如 api 的请求日志），支持多种 backend ，如 ElasticSearch 、 InfluxDB 、 OpenTSDB 等等。在线 DEMO 。
InfluxDB 是一个使用 Go 语言开发的开源分布式时序、事件和指标数据库，无需外部依赖，其设计目标是实现分布式和水平伸缩扩展。

---------------
docker run -d \
  --name statsd-influxdb-grafana \
  -p 3003:9000 \
  -p 3004:8083 \
  -p 8086:8086 \
  -p 22022:22 \
  -p 8125:8125/udp \
  samuelebistoletti/docker-statsd-influxdb-grafana

InfluxDB/collectd/Grafana 
==================
采集数据（collectd）-> 存储数据（InfluxDB) -> 显示数据（Grafana）

docker run -i -p 3000:3000 \
  -e "GF_SERVER_ROOT_URL=http://grafana.server.name"  \
  -e "GF_SECURITY_ADMIN_PASSWORD=secret  \
  grafana/grafana
docker run -p 8083:8083 -p 8086:8086 \
      -v influxdb:/var/lib/influxdb \
      influxdb
      
      

HTTP_USER=admin                 Username for HTTP auth, using admin by default
HTTP_PASS=**Random**        Password for HTTP auth. Change it, otherwise system will generate a random password.

INFLUXDB_PROTO=http                 Protocol of your InfluxDB
INFLUXDB_HOST=**ChangeMe**          Host of your InfluxDB (without protocol)
INFLUXDB_PORT=8086                  Port number of your InfluxDB
INFLUXDB_NAME=**ChangeMe**          Database name of your InfluxDB
INFLUXDB_USER=root                  Username of your InfluxDB
INFLUXDB_PASS=root                  Password of your InfluxDB

docker run -d -p 80:80 -e INFLUXDB_HOST=influxdb-1-tifayuki.delta.tutum.io -e INFLUXDB_PORT=8086 -e INFLUXDB_NAME=testdb -e INFLUXDB_USER=root -e INFLUXDB_PASS=root tutum/grafana

ELASTICSEARCH_PROTO=http            Protocol of your Elasticsearch
ELASTICSEARCH_HOST=**None**         Host of your Elasticsearch (without protocol)
ELASTICSEARCH_PORT=9200             Port number of your Elasticsearch
ELASTICSEARCH_USER=**None**         Username for elasticsearch if it has HTTP basic auth enabled (leave it to **None** if no HTTP basic auth is needed)
ELASTICSEARCH_PASS=**None**         Password for elasticsearch if it has HTTP basic auth enabled (leave it to **None** if no HTTP basic auth is needed)

docker run -d -p 80:80 -e INFLUXDB_HOST=influxdb-1-tifayuki.delta.tutum.io -e INFLUXDB_PORT=8086 -e INFLUXDB_NAME=testdb -e INFLUXDB_USER=root -e INFLUXDB_PASS=root -e ELASTICSEARCH_HOST=elasticsearch-1-tifayuki.beta.tutum.io -e ELASTICSEARCH_PORT=9200 -e ELASTICSEARCH_USER=admin -e ELASTICSEARCH_PASS=admin tutum/grafana




docker run -d --volume=/var/influxdb:/data -p 8083:8083 -p 8086:8086 tutum/influxdb
docker run -d -p 8083:8083 -p 8086:8086 -e ADMIN_USER="root" -e INFLUXDB_INIT_PWD="somepassword" -e PRE_CREATE_DB="db1;db2;db3" tutum/influxdb:latest
