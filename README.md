# 概要
Jira Sprint Report を slack に通知するツールです

# 実行方法

1. 事前準備
  - google chrome のインストール
  - ImageMagick のインストール
2. ライブラリのインストール
```
bundle install --path vendor/bundle
```
3. 環境変数ファイルの作成
```
cp .dotenv.sample .dotenv
vi .dotenv
```
4. Ruboty の起動
```
bundle exec ruboty --dotenv -l main.rb
```

# 備考
burndown chart 取得のための Jira へのログインは Selenium で起動した headless Chrome 
上で二段階認証を行います  
初回ログイン時やセッション切れの場合、ログイン情報を求められるためターミナルから必要な情報を入力してください
