FROM ruby:3.2.2-alpine3.18

# dependencies
RUN apk add --no-cache --update build-base tzdata postgresql-dev

# nokogiri from https://nokogiri.org/tutorials/installing_nokogiri.html#other-installation-scenarios
RUN apk add --no-cache libxml2 libxslt gcompat && \
  apk add --no-cache --virtual .gem-installdeps libxml2-dev libxslt-dev gcompat && \
  gem install nokogiri --platform=aarch64-linux -- --use-system-libraries && \
  rm -rf $GEM_HOME/cache && \
  apk del .gem-installdeps

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:2.4.10
RUN bundle lock --add-platform aarch64-linux-musl && bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
