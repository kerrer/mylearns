1. chcon -Rt svirt_sandbox_file_t /work/data/mysql/
2. chcon -Rt svirt_sandbox_file_t /work/data/postgres/


mysql 
================
docker run --name mysql -e MYSQL_ROOT_PASSWORD=mmmm -d -p 3306:3306 mysql

docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=mmmm  -v /work/data/mysql/mysql:/var/lib/mysql mysql
client: 
 - docker run -it --link mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
 - docker run -it --rm mysql mysql -hsome.mysql.host -usome-mysql-user -p

 
mariadb
===================
docker run --name some-mariadb -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb
client:
 - docker run -it --link some-mariadb:mysql --rm mariadb sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
 - docker run -it --rm mariadb mysql -hsome.mysql.host -usome-mysql-user -p
 
 
-------------
postgresql:
docker run -d --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=mmmm -d postgres
client:
  - docker run -it --rm --link postgres:postgres postgres psql -h postgres -U postgres 
 
 
 
 mogodb
======================================================================
 docker run --name mongo -d -p 27017:27017 mongo
 docker run --name mongo-express -d --link mongo:mongo -p 8081:8081 mongo-express
