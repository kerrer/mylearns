#http://elasticsearch.cn/book/elasticsearch_definitive_guide_2.x/running-elasticsearch.html
#https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
#https://www.elastic.co/guide/en/kibana/current/_pulling_the_image.html

https://www.elastic.co/guide/en/logstash/1.5/advanced-pipeline.html


1.
docker run --rm -it --name elasticsearch -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" -e "http.cors.allow-headers=Authorization" -e "http.cors.enabled=true" -e "http.cors.allow-origin='*'" docker.elastic.co/elasticsearch/elasticsearch:5.3.0

docker run --rm -it --name elasticsearch -p 9200:9200 -v /work/elk/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml  docker.elastic.co/elasticsearch/elasticsearch:5.3.0
 
4.
docker run --rm -it --name kibana --link elasticsearch:elasticsearch -p 5601:5601  docker.elastic.co/kibana/kibana:5.3.0 --plugins elastic/sense

2.
docker run --rm -it --name elasticsearch-head -p  9100:9100 --link elasticsearch:elasticsearch mobz/elasticsearch-head:5
http://localhost:9100/index.html?base_uri=http://172.17.0.2:9200&auth_user=elastic&auth_password=changeme

3.
docker run --rm -it --name logstash --link elasticsearch:elasticsearch  -v /work/elk/pipeline/:/usr/share/logstash/pipeline/ -v /work/elk/logstash/logstash.yml:/usr/share/logstash/config/logstash.yml   docker.elastic.co/logstash/logstash:5.3.0
#docker run --rm -it -v ~/settings/logstash.yml:/usr/share/logstash/config/logstash.yml docker.elastic.co/logstash/logstash:5.3.0
#docker run --rm -it -v ~/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:5.3.0

5.
docker run --rm -it --name filebeat --link logstash:logstash -v /work/elk/beats/filebeat.yml:/filebeat.yml -v /work/elk/beats/logstash-tutorial.log:/logstash-tutorial.log prima/filebeat


Filebeat->logstash->elasticsearch


elastic   changeme


kibana plugin
======================================================
/bin/kibana plugin --install elastic/sense
/bin/kibana plugin --install elastic/sense
./bin/kibana-plugin  -i sense -u file:///
