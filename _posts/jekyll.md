# How to allow unsafe ports in Chrome

[http://douglastarr.com/how-to-allow-unsafe-ports-in-chrome](http://douglastarr.com/how-to-allow-unsafe-ports-in-chrome)

# config
```
$ cat _config.yml
port: 6000
```

# build for production
```
JEKYLL_ENV=production bundle exec jekyll build
```

# replace gem source mirror
```
gem sources --remove https://rubygems.org/
gem sources -a http://ruby.taobao.org/
gem sources -l
http://ruby.taobao.org/
```
