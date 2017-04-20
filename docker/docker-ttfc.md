1. busybox
========================================================================
docker run -d --name busybox   --restart=always  \
  -v /job/cache/ttfc/db/mysql:/var/lib/mysql \
  -v /job/cache/ttfc/db-back:/mysql/back \
  -v /job/cache/ttfc/db/postgres:/postgres/data \
  busybox
  
2. mysql vs postgresql
========================================================================
docker run -d --name mysql_ttfc     --restart=always  --volumes-from busybox -p 3306:3306   -e MYSQL_ROOT_PASSWORD=mmmm    mysql
docker run -d --name postgres_ttfc  --restart=always  --volumes-from busybox -p 5432:5432   -e POSTGRES_PASSWORD=mmmm -e PGDATA=/postgres/data   postgres

3. phpmyadmin vs phpgadmin
========================================================================
docker run --rm --name myadmin  --link mysql_ttfc:db   -e PMA_ARBITRARY=1 -e PMA_HOST=db  -p 8080:80 phpmyadmin/phpmyadmin
docker run -i -d --name pgadmin -p 8082:80   -e APACHE_SERVERNAME=jacksoncage.se       -e POSTGRES_HOST=localhost -e POSTGRES_PORT=5432 -v /etc/localtime:/etc/localtime jacksoncage/phppgadmin

4. www
========================================================================
docker run -d --name xraymove  --link mysql_ttfc:mysql   -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=xraymove  -e VIRTUAL_HOST=xray.max.com    wordpress
docker run -d --name zwzwen    --link mysql_ttfc:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=zwzwen    -e VIRTUAL_HOST=zwz.max.com     wordpress
docker run -d --name daifei    --link mysql_ttfc:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=daifei    -e VIRTUAL_HOST=df.max.com      wordpress
docker run -d --name erp       --link mysql_ttfc:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=erp       -e VIRTUAL_HOST=erp.max.com     wordpress
docker run -d --name wugu      --link mysql_ttfc:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=wugu      -e VIRTUAL_HOST=wugu.max.com    wordpress
docker run -d --name citta     --link mysql_ttfc:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=citta     -e VIRTUAL_HOST=citta.max.com   wordpress
docker run -d --name matain    --link mysql_ttfc:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=matain    -e VIRTUAL_HOST=matain.max.com  wordpress

docker run -d --name qing      --link mysql_ttfc:mysql  -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=qing    -e VIRTUAL_HOST=qing.max.com  wordpress

5. Front Proxy
========================================================================
docker run -d  --restart=always -p 80:80 --name proxy -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=unix:///var/run/docker.sock jwilder/nginx-proxy

6. Mysql Backup
========================================================================
docker run -d  --name mysql-backup --restart=always -e DB_USER=root -e DB_PASS=mmmm -e DB_DUMP_FREQ=3600 -e DB_DUMP_BEGIN=+0 -e DB_DUMP_TARGET=/mysql/back --link mysql:db --volumes-from busybox deitch/mysql-backup


