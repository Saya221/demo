FROM ruby:3.2.2-bullseye

RUN apt update && apt-get install -y build-essential

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:2.4.10 && bundle lock --add-platform aarch64-linux-musl &&\
  bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
