FROM ruby:4.0.5

# 1. 必要なツール（C言語のコンパイルツールやPostgres接続ライブラリなど）をインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# 2. コンテナ内の作業ディレクトリを `/app` に指定
WORKDIR /app

# 3. Gemの設計図（Gemfile/Gemfile.lock）だけを先にコピーしてGemをインストール
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# 4. 手元のプロジェクトファイルをまるごとコンテナ内にコピー
COPY . /app

# 5. 3000番ポートを開放して、Railsサーバーを立ち上げる
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
