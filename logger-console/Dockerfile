FROM ruby:2.4.2-alpine

ENV HOME /opt/app
WORKDIR $HOME

RUN \
  apk -U add git build-base libstdc++

ADD . $HOME

RUN \
  gem install bundler --no-ri --no-rdoc && \
  bundle install

RUN \
  apk del build-base git && \
  rm -rf /var/cache/apk/*

ENTRYPOINT ["foreman", "start"]

# vim: ft=Dockerfile:
