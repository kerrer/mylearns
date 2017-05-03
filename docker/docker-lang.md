python:
========================================================================
docker run -d --name ipython -p 88:8888 -e "PASSWORD=mmmm" -e "USE_HTTP=1" ipython/notebook
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp python:3 python your-daemon-or-script.py

perl:
===================
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp perl:5.20 perl your-daemon-or-script.pl
docker run -it rakudo-star
docker run -it rakudo-star -e 'say "Hello!"'
 

ruby,perl,go,erlang
==============================

docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp ruby:2.1 ruby your-daemon-or-script.rb

docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:1.3 go build -v
docker run -it --rm --name erlang-inst1 -v "$PWD":/usr/src/myapp -w /usr/src/myapp erlang escript your-escript.erl



php-framework
===================================================================================
wordpress,drupal,joomla


Ada
======================================
Check version
$ docker run --rm -i -t -v $(pwd):/source nacyot/ada-gnat:apt gnat
GNAT 4.6
Copyright 1996-2010, Free Software Foundation, Inc.
...
Run Hello, World
$ docker run --rm -i -t -v $(pwd):/source nacyot/ada-gnat:apt gnatmake /source/hello_world.adb
$ docker run --rm -i -t -v $(pwd):/source nacyot/ada-gnat:apt ./hello_world

=============================================================================



php：
  drupal,symfony,cakephp,thinkphp,wordpress
  
  
nodejs: 
  wolf
  
java:
  dubbox,spring,jeesite
  
scala:
   Play,Scalatra
groovy:
   grail,glide
clojure:
   Compojure
go:
   revel


ruby:
   rails,redmine
