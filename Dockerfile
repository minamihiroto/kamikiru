FROM ruby:2.7.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# 必要なパッケージのインストール
RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  nodejs yarn

# 作業ディレクトリの作成、設定
RUN mkdir /app_name
##作業ディレクトリ名をAPP_ROOTに割り当て 以下$APP_ROOTで参照
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT

# おまじない
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]