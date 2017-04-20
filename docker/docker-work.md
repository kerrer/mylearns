 docker run --name some-drupal -p 8080:80 -d drupal
  docker run --name some-drupal --link some-mysql:mysql -d drupal
  docker run --name some-drupal --link some-postgres:postgres -d \
    -v /path/on/host/modules:/var/www/html/modules \
    -v /path/on/host/profiles:/var/www/html/profiles \
    -v /path/on/host/sites:/var/www/html/sites \
    -v /path/on/host/themes:/var/www/html/themes \
    drupal
    
docker run --name some-joomla --link some-mysql:mysql -p 8080:80 -d joomla



solr


XWiki
