nginx+php-fpm:
=================================
1. docker run -it --name phpfpm -v /path/to/app:/app bitnami/php-fpm
2. docker run --name nginx -p 80:80 -v  /some/nginx.conf:/etc/nginx/nginx.conf:ro -v /work/data/nginx/html:/usr/share/nginx/html -d --link phpfpm:phpfpm nginx
server {
    listen 0.0.0.0:80;
    server_name yourapp.com;

    root /app;

    location / {
        index index.php;
    }

    location ~ \.php$ {
        # fastcgi_pass [PHP_FPM_LINK_NAME]:9000;
        fastcgi_pass yourapp:9000;
        fastcgi_index index.php;
        include fastcgi.conf;
    }
}

nginx+fastcgi:
======================================


nginx+passenger
==============
docker pull phusion/passenger-full
