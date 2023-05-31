FROM ubuntu:mantic

RUN apt update && apt install -y curl git libssl-dev libreadline-dev zlib1g-dev build-essential
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash \
  && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /root/.bashrc \
  && echo 'eval "$(rbenv init -)"' >> /root/.bashrc \
  && . /root/.bashrc \
  && rbenv install 3.0.0 \
  && rbenv global 3.0.0
