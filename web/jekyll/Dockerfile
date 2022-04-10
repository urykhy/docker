FROM debian:buster

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends make gcc g++ libc6-dev libssl-dev ruby-dev ruby-bundler \
    && rm -rf /var/lib/apt/lists/*

# get path from `ruby -r rubygems -e 'puts Gem.user_dir'`, ugly hack since https://github.com/moby/moby/issues/29110
ENV PATH=/root/.gem/ruby/2.5.0/bin:$PATH

RUN gem install --clear-sources --user-install jekyll:4.2.2 jekyll-category-pages

WORKDIR /srv/jekyll
ENV USER=root