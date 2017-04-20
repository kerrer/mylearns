apache2
========================================================================
docker build -t max/apache . [office php]
docker run -d -p 80:80 --name apache2 -v /job/WebSites/public/wlyy.yx129.com:/var/www/html max/apache

docker run --name apache2 -p 80:80 -p 443:443 -d -v /job/WebSites/public/wlyy.yx129.com:/var/www/html eboraas/apache-php
#docker run -d -p 80:80 -p 3306:3306 --name apache -v /job/WebSites/public/wlyy.yx129.com:/var/www/html max/apache-php

Nginx
========================================================================
$ docker run --name some-nginx -v /some/content:/usr/share/nginx/html:ro -d nginx


tomcat:
========================================================================
docker run --name openbravo -d -p 8080:8080 -v /work/webapps/openbravo:/usr/local/tomcat/webapps/openbravo tomcat:7.0
docker run -it --rm -v /work/data/tomcat/conf/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml -p 8888:8080 tomcat:7

docker run --name tomcat8 -p 8888:8080  -v /work/data/tomcat/webapps:/usr/local/tomcat/webapps tomcat:8.0  /bin/bash -c "sed  -i '/<\/tomcat-users>/i <user username=\"root\" password=\"mmmm\" roles=\"admin\"\/>' /usr/local/tomcat/conf/tomcat-users.xml"

docker run --name tomcat8 -p 8888:8080  -v /work/data/tomcat/webapps:/usr/local/tomcat/webapps tomcat:8.0 

docker run --name openbravo -d -p 8080:8080 -v /work/webapps/openbravo:/usr/local/tomcat/webapps/openbravo tomc

tomee:
========================================================================
docker run -it --rm -p 8888:8080 -v "${PWD}"/tomcat-users.xml:/usr/local/tomee/conf/tomcat-users.xml tomee:8-jre-1.7.2-webprofile


wildfly
========================================================================
- To boot in standalone mode
docker run -it jboss/wildfly
deployment: /opt/jboss/wildfly/standalone/deployments/

- To boot in domain mode
docker run -d --name  wildfly -p 8080:8080 -p 8888:8888 jboss/wildfly /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent && /opt/jboss/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0
deployment: /opt/jboss/wildfly/domain/deployments/

admin
------------
FROM jboss/wildfly
RUN /opt/jboss/wildfly/bin/add-user.sh admin mmmm --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
docker build --tag=jboss/wildfly-admin .
docker run -d --name  wildfly -p 8080:8080 -p 9991:9990 jboss/wildfly-admin


glassfish
========================================================================
docker run -it --name glassfish  -p 4848:4848 -p 8080:8080 glassfish/server
--
  asadmin> start-domain
  asadmin> stop-domain
  asadmin> change-admin-password
  http://localhost:4848/ admin glassfish
  
