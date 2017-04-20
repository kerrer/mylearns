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

docker run --name='activemq' -it --rm \
    -e 'ACTIVEMQ_MIN_MEMORY=512' \
    -e 'ACTIVEMQ_MAX_MEMORY=2048'\
    -P
    webcenter/activemq:latest


rabbitmq
========================================================================
$ docker run -d --hostname my-rabbit --name some-rabbit rabbitmq:3
$ docker run -d --hostname my-rabbit --name rabbit -p 15672:15672 -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=mmmm rabbitmq:3-management

-e RABBITMQ_DEFAULT_VHOST=my_vhost
-p 5672
-p 25672



