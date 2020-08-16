FROM ruby:2.6.3

ENV LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    LC_CTYPE="utf-8"

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  vim \
  default-mysql-client \
  yarn

WORKDIR /webapp

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle update --bundler
RUN bundle install -j4

ADD . /webapp

RUN mkdir -p tmp/sockets

EXPOSE 3000