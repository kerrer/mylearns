$gem sources --remove https://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem sources -l

bundle config mirror.https://rubygems.org/ https://ruby.taobao.org/
gem install rails --no-document
