File: /job/cache
Chcon: chcon -Rt svirt_sandbox_file_t /job/cache


docker registry:
========================================================================
- proxy for cache:[https://blog.docker.com/2015/10/registry-proxy-cache-docker-open-source/]
  1. get config.xml: docker run -it --rm --entrypoint cat registry:2 /etc/docker/registry/config.yml > /data/config.yml
  2. Update the ‘http’ section to configure TLS:
    http:
      addr: :5000
      tls:
            certificate: /var/lib/registry/domain.crt
            key: /var/lib/registry/domain.key
  3. Add a ‘proxy’ section to your configuration file to enable the cache
    proxy:
      remoteurl: https://registry-1.docker.io
      username: [username]
      password: [password]
      
  4. docker run -d --restart=always -p 5000:5000 \
     --name docker-proxy \
     -h proxy.tdocker.com  \
     -v /job/cache/docker/proxy:/var/lib/registry \
     registry:2 /var/lib/registry/config.yml 
     
  5. test
       curl -I https://proxy.tdocker.com:5000/v2/
  6. client
      --registry-mirror=https://proxy.tdocker.com:5000
  7. test
     curl -k https://proxy.tdocker.com:5000/v2/_catalog
     curl -k https://proxy.tdocker.com:5000/v2/library/busybox/tags/lis  
  
- private registry:[https://docs.docker.com/registry/deploying]
   1. docker run -d -p 5001:5000 --restart=always --name docker-repo \
      -h repo.tdocker.com \
      -v /job/cache/docker/repo:/var/lib/registry \
      -e REGISTRY_HTTP_TLS_CERTIFICATE=/var/lib/registry/certs/domain.crt \
      -e REGISTRY_HTTP_TLS_KEY=/var/lib/registry/certs/domain.key \
      registry:2
   
   2. docker run -d --restart=always -p 5001:5000 \
      --name docker-repo \
      -h repo.tdocker.com \
      -v /job/cache/docker/repo:/var/lib/registry  \
      registry:2 /var/lib/registry/config.yml
      
   3. test
    docker tag hello-world:latest repo.tdocker.com:5001/hello-mine:latest
    docker push repo.tdocker.com:5001/hello-mine:latest
    curl -k -v -X GET https://repo.tdocker.com:5001/v2/hello-mine/tags/list
 
- DOCKER_OPTS="--registry-mirror=https://proxy.tdocker.com:5000  --insecure-registry proxy.tdocker.com:5000 --insecure-registry repo.tdocker.com:5001"

- domain.key:[https://docs.docker.com/registry/insecure/]
  1. Generate your own certificate:
  mkdir -p certs && openssl req \ -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key \ -x509 -days 365 -out certs/domain.crt
  2. Instruct every docker daemon to trust that certificate
     cp domain.crt /etc/docker/certs.d/tdocker.com:5000/ca.crt
  
- auth:
  1. mkdir auth
     docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > auth/htpasswd
  2. docker run -d -p 5000:5000 --restart=always --name registry \
  -v `pwd`/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -v `pwd`/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:2
  3. docker login myregistrydomain.com:5000
  
- GUI:
  1. docker run -p 8080:8080 -e REG1=http://dev:5000/v1/ -e REG2=http://prod/v1/ atcol/docker-registry-ui
  2. docker run -p 8080:8080 --name registry-ui -e REG1=http://172.17.0.2:5000/v2/ atcol/docker-registry-ui 

---------------------------
docker tag ca0b87324204 localhost:5000/apache-php
sudo docker push localhost:5000/apache-php
sudo docker search localhost:5000/apache
docker run -d -p 80 -p 3306 -v /work/WebSites/public/www.yx129.com:/var/www/html localhost:5000/apache-php

curl -X GET localhost:5000/v2/repositories/apache/tags
curl -X DELETE localhost:5000/v2/repositories/apache-php/tags/latest

apt-cache:
========================================================================
docker run --name apt-cacher-ng -d --restart=always \
--publish 3142:3142  \
--volume /job/cache/apt:/var/cache/apt-cacher-ng  \
sameersbn/apt-cacher-ng

------
  - On CentOS, edit /etc/yum.conf and add:
       proxy=http://[ip-of-your-local-apt-cacher-ng-server]:3142
  - on debian,/etc/apt/apt.conf.d/01proxy with the following content:
       Acquire::HTTP::Proxy "http://172.17.42.1:3142";
       Acquire::HTTPS::Proxy "false";


squid proxy:
========================================================================
docker run --name squid -d --restart=always \
  --publish 3128:3128 \
  --volume /job/cache/squid/squid.conf:/etc/squid3/squid.conf \
  --volume /job/cache/squid/cache:/var/spool/squid3 \
  sameersbn/squid:3.3.8-20
  --------------
  1. edit .bashrc:
   - export ftp_proxy=http://172.17.42.1:3128
   - export http_proxy=http://172.17.42.1:3128
   - export https_proxy=http://172.17.42.1:3128
  2. edit Dockerfile: 
   - ENV http_proxy=http://172.17.42.1:3128 \
     https_proxy=http://172.17.42.1:3128 \
     ftp_proxy=http://172.17.42.1:3128

polipo
========================================================================
docker run -d --restart=always --name=http-proxy -p 8123:8123 chenzhiwei/polipo
Following is to change a socket proxy to http proxy.
# docker run -d --name=http-proxy --net=host chenzhiwei/polipo   proxyAddress=0.0.0.0 socksParentProxy=127.0.0.1:1080 socksProxyType=socks5
 ----------------
 use it with curl, wget or git: export all_proxy=http://1.2.3.4:8123

nginx proxy:
========================================================================

nginx web:
========================================================================
docker run --name nginx -d -p 8082:80 \
-v /job/cache/nginx/html:/usr/share/nginx/html \
nginx




