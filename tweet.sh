#!/bin/bash

# --- セットアップオプション ---
if [ "$1" = "-s" ] || [ "$1" = "--setup" ]; then
  echo "## ⚙️  twurlをインストールします ##"
  echo "実行コマンド: gem install twurl"
  gem install twurl
  if [ $? -eq 0 ]; then
    echo "## ✅ twurlのインストールが完了しました！ ##"
    echo "次のステップ: ./tweet.sh -a API_KEY API_SECRET でアカウントを認証してください"
  else
    echo "## ❌ twurlのインストールに失敗しました。 ##"
    echo "sudoが必要な場合があります: sudo gem install twurl"
  fi
  exit $?
fi

# --- ヘルプオプション ---
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "## 📖 tweet.sh - Twitter/X自動投稿ツール ##"
  echo ""
  echo "使い方:"
  echo "  セットアップ (twurlインストール):"
  echo "    ./tweet.sh -s"
  echo "    ./tweet.sh --setup"
  echo ""
  echo "  基本投稿:"
  echo "    ./tweet.sh \"ここにメッセージを入力\""
  echo ""
  echo "  アカウント指定投稿:"
  echo "    ./tweet.sh \"ここにメッセージを入力\" アカウント名"
  echo ""
  echo "  アカウント認証:"
  echo "    ./tweet.sh -a API_KEY API_SECRET"
  echo "    ./tweet.sh --authorize API_KEY API_SECRET"
  echo ""
  echo "  アカウント一覧:"
  echo "    ./tweet.sh -l"
  echo "    ./tweet.sh --list"
  echo "    ./tweet.sh accounts"
  echo ""
  echo "  ヘルプ表示:"
  echo "    ./tweet.sh -h"
  echo "    ./tweet.sh --help"
  echo ""
  echo "例:"
  echo "  ./tweet.sh -s"
  echo "  ./tweet.sh \"今日はいい天気です\""
  echo "  ./tweet.sh \"新製品のお知らせ\" company_account"
  echo "  ./tweet.sh -a abc123xyz abc123secretxyz"
  echo "  ./tweet.sh -l"
  exit 0
fi

# --- アカウント認証オプション ---
if [ "$1" = "-a" ] || [ "$1" = "--authorize" ]; then
  if [ -z "$2" ] || [ -z "$3" ]; then
    echo "使い方: ./tweet.sh --authorize API_KEY API_SECRET"
    echo "例: ./tweet.sh --authorize your_api_key your_api_secret"
    exit 1
  fi
  echo "## 🔐 twurlアカウント認証を実行します ##"
  echo "API Key: $2"
  echo "API Secret: $3"
  twurl authorize --consumer-key "$2" --consumer-secret "$3"
  exit $?
fi

# --- アカウント一覧表示オプション ---
if [ "$1" = "-l" ] || [ "$1" = "--list" ] || [ "$1" = "accounts" ]; then
  echo "## 📋 利用可能なアカウント一覧 ##"
  twurl accounts
  exit 0
fi

# --- 初期設定 ---
# 第二引数がアカウント名、第一引数が投稿内容
TWEET_CONTENT="$1"
ACCOUNT_NAME="$2" # 第二引数が空でもそのまま受け入れる

# --- 実行前のチェック ---

# 投稿内容 (第一引数) が空の場合は使い方を表示して終了
if [ -z "$TWEET_CONTENT" ]; then
  echo "使い方:"
  echo "  セットアップ: ./tweet.sh -s (または --setup)"
  echo "  基本: ./tweet.sh \"ここにメッセージを入力\""
  echo "  アカウント指定: ./tweet.sh \"ここにメッセージを入力\" アカウント名"
  echo "  アカウント認証: ./tweet.sh -a API_KEY API_SECRET (または --authorize)"
  echo "  アカウント一覧: ./tweet.sh -l (または --list, accounts)"
  echo "  ヘルプ表示: ./tweet.sh -h (または --help)"
  exit 1
fi

# --- twurlのオプション設定 ---

# アカウント名が指定されているかチェック
if [ -n "$ACCOUNT_NAME" ]; then
    ACCOUNT_OPTION="-u $ACCOUNT_NAME"
    echo "## 🐦 Xに投稿します (アカウント: $ACCOUNT_NAME)... ##"
else
    ACCOUNT_OPTION=""
    echo "## 🐦 Xに投稿します (デフォルトアカウント)... ##"
fi

# --- 投稿処理 ---

echo "投稿内容: \"$TWEET_CONTENT\""

# twurlコマンドでX API v2のtweetsエンドポイントを叩く
# ACCOUNT_OPTION 変数には "-u account_name" または "" が入っている
twurl -u $ACCOUNT_OPTION -X POST -A "Content-type: application/json" -d "{\"text\": \"$TWEET_CONTENT\"}" /2/tweets

if [ $? -eq 0 ]; then
    echo "## ✅ 投稿が完了しました！ ##"
else
    echo "## ❌ 投稿に失敗しました。 ##"
fi