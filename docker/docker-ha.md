docker run -d --name busybox   --restart=always  -v /work/data/mysql/all:/var/lib/mysql -v /work/data/mysql/back:/mysql/back -v /work/data/postgres/all:/postgres/data busybox
docker run -d --name mysql     --restart=always  --volumes-from busybox -p 3306:3306   -e MYSQL_ROOT_PASSWORD=mmmm    mysql
docker run -d --name postgres  --restart=always  --volumes-from busybox -p 5432:5432   -e POSTGRES_PASSWORD=mmmm -e PGDATA=/postgres/data   postgres

docker run -d --name myadmin   --restart=always  --link mysql:db        -e PMA_ARBITRARY=1 -e PMA_HOST=db  -p 8080:80 phpmyadmin/phpmyadmin
docker run -i -d --name pgadmin -p 8082:80   -e APACHE_SERVERNAME=jacksoncage.se       -e POSTGRES_HOST=localhost -e POSTGRES_PORT=5432 -v /etc/localtime:/etc/localtime jacksoncage/phppgadmin

docker run -d --name xraymove  --restart=always  --link mysql:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=xraymove  -e VIRTUAL_HOST=xray.max.com wordpress
docker run -d --name zwzwen    --restart=always  --link mysql:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=zwzwen    -e VIRTUAL_HOST=zwz.max.com wordpress
docker run -d --name daifei    --restart=always  --link mysql:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=daifei    -e VIRTUAL_HOST=df.max.com wordpress
docker run -d --name erp       --restart=always  --link mysql:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=erp       -e VIRTUAL_HOST=erp.max.com wordpress
docker run -d --name wugu      --restart=always  --link mysql:mysql     -e  WORDPRESS_DB_PASSWORD=mmmm  -e WORDPRESS_DB_NAME=wugu      -e VIRTUAL_HOST=wugu.max.com wordpress

docker run -d  --restart=always -p 80:80 --name proxy -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=unix:///var/run/docker.sock jwilder/nginx-proxy
docker run -d  --name mysql-backup --restart=always -e DB_USER=root -e DB_PASS=mmmm -e DB_DUMP_FREQ=3600 -e DB_DUMP_BEGIN=+0 -e DB_DUMP_TARGET=/mysql/back --link mysql:db --volumes-from busybox deitch/mysql-backup

docker run -d --name odoo      --restart=always  --link postgres:db  -v /work/data/odoo/config:/etc/odoo  -e VIRTUAL_HOST=odoo.max.com   -e VIRTUAL_PORT=8069  odoo
