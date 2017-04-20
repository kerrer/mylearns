BUILD


docker run --name postgres -e POSTGRES_PASSWORD=mmmm -d postgres
docker run -d -e POSTGRES_USER=openbravo -e POSTGRES_PASSWORD=mmmm --name db_openbravo postgres:9.4
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db_odoo postgres:9.4
docker run -p 8069:8069 --name odoo --link db_odoo:db -t odoo
docker run -it --rm --link db_odoo:postgres postgres psql -h postgres -U postgres




docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=mmmm -d mysql:tag
docker run -it --link mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'


docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:7.0-cli php your-script.php
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp openjdk:7 javac Main.java
docker run --rm -it -v "$PWD":/usr/src/myapp --link db_openbravo:db -w /usr/src/myapp openjdk:8

docker run -v /path/to/config:/etc/odoo -p 8069:8069 --name odoo --link db_odoo:db -t odoo
docker run -p 8069:8069 --name odoo --link db:db -t odoo -- --db-filter=odoo_db_.*

odoo
============================
docker run -d -p 5433:5432 -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db_odoo postgres
1. docker run -p 8069:8069 --name odoo --link db_odoo:db -t odoo
   docker stop odoo
   docker start -a odoo
2. docker build -t max/odoo .
   docker run -t  -p 8066:8069 --name odoo2 --link db_odoo:db  -v /work/ERP/test/odoo:/opt/odoo max/odoo
   login:admin admin

openbravo
=========================
1. docker run -d -p 5434:5432 -e POSTGRES_USER=openbravo -e POSTGRES_PASSWORD=openbravo --name db_openbravo postgres:9.3
2. docker run  -it --rm -v /work/ERP/test/main:/home/max/openbravo --link db_openbravo:db -w  /home/max/openbravo max/ant:oracle_jdk
   docker run  -it --rm -v /work/ERP/test/main:/home/max/openbravo --link db_openbravo:db -w  /home/max/openbravo max/ant:openjdk8

3. ant setup &&  ant install.source && ant war
4. docker run -it --rm --name openbravo -p 8080:8080 --link db_openbravo:db -v /work/ERP/test/main/lib/openbravo.war:/usr/local/tomcat/webapps/openbravo.war  -v  /job/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml tomcat:8.5/9.0

   docker run -it --rm -p 8080:8080 --link db_openbravo:db  -v /work/ERP/test/main/WebContent:/usr/local/tomee/webapps/openbravo -v  /job/tomcat-users.xml:/usr/local/tomee/conf/tomcat-users.xml tomee:8-jdk-7.0.1-plume

weberp
==============================
docker run -d --name db_weberp -e MYSQL_ROOT_PASSWORD=mmmm -e MYSQL_USER=weberp -e MYSQL_PASSWORD=weberp  -e MYSQL_DATABASE=weberp mysql
docker run -p 88:80 -it --rm -v /work/ERP/test/webERP:/var/www/html --link db_weberp:db richarvey/nginx-php-fpm

redmime:
==================================
docker run -d --name db_redmine -e POSTGRES_PASSWORD=redmine -e POSTGRES_USER=redmine postgres

1. docker run -d --name mysql-redmine \
   -e MYSQL_ROOT_PASSWORD=mmmm -e MYSQL_DATABASE=redmine  \
   -v /work/data/mysql/redmine:/var/lib/mysql mysql

2. docker run -d --name redmine -p 3000:3000 \
  -v /work/data/redmine/files:/usr/src/redmine/files \
  -v /work/data/redmine/plugins:/usr/src/redmine/plugins  \
  --link db_redmine:postgres redmine
  
php_stock
===================================
docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mmmm  mysql
docker run -p 89:80 -it --rm -v /work/ERP/test/php_stock_zip/php_stock:/var/www/html --link mysql:db richarvey/nginx-php-fpm

run
=========================
export CATALINA_OPTS="-Djava.awt.headless=true -Xms384M -Xmx512M -XX:MaxPermSize=256M"
docker run -it --rm -p 8888:8080 -v "$PWD"/openbravo:/usr/local/tomcat/openbravo tomcat:8.0
docker run -it --rm -p 8080:8080 --link db_openbravo:db -v "$PWD"/openbravo/web.war:/usr/local/tomcatwebapps/openbravo.war tomcat:8.0
docker run -it --rm -p 8080:8080 --link db_openbravo:db -v "$PWD"/tomcat/webapps/openbravo:/usr/local/tomcat/webapps/openbravo tomcat:8.0


docker run -it --rm -p 8888:8080 -v "$PWD"/openbravo/web.war:/usr/local/tomee/webapps/openbravo.war  tomee:8-jdk-7.0.1-plume
