# docker/api/Dockerfile

# Build image dựa vào base ruby 3.0.0 bản alpine cho nhẹ, mình suggest nên dùng bản alpine, thiếu gì thì cài thêm
# Nếu bạn không quen, hoặc đơn giản không thích thì có thể dùng bản đầy đủ ruby:3.0.0
FROM ruby:3.0.0-alpine3.13

# update các dependencies và cài đặt những package cần thiết để app của bạn có thể work
RUN apk add --no-cache --update build-base mariadb-dev tzdata imagemagick

# Định nghĩa path mà code của app sẽ lưu ở đó
ENV APP_DIR /Users/renkyrou/Desktop/Ruby/demo
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# Copy Gemfile và Gemfile.lock vào image
COPY Gemfile $APP_DIR/Gemfile
COPY Gemfile.lock $APP_DIR/Gemfile.lock
# Cài đặt bundler với version tương thích nếu bị lỗi
RUN gem install bundler:2.2.3
RUN bundle install

# Copy toàn bộ source code ở context hiện tại vào image (sẽ ignore những file, folder ở .dockerignore)
COPY . $APP_DIR

# Copy file entrypoint vào /usr/bin và cấp quyền thực thi để chạy các script lúc run container
COPY docker/api/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose ra port 3000 trong container
EXPOSE 3000
# Start container bằng command rails server -b 0.0.0.0
CMD ["rails", "server", "-b", "0.0.0.0"]
