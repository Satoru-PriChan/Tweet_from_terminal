# Twitter Automatic

Twitter/X自動投稿ツール - コマンドラインからツイートを投稿できるシンプルなBashスクリプト

## 機能

- twurlの簡単インストール機能
- コマンドラインから直接ツイートを投稿
- 複数アカウントのサポート
- スクリプト内でアカウント認証が可能
- アカウント一覧の表示

## 必要要件

- `twurl` (Twitter API用のコマンドラインツール)
- Twitter Developer Account
- Twitter API credentials

## セットアップ

### 1. twurlのインストール

#### 方法1: tweet.shスクリプトを使用（簡単）

```bash
./tweet.sh -s
# または
./tweet.sh --setup
```

#### 方法2: 直接インストール

```bash
gem install twurl
```

※ 権限エラーが出る場合は `sudo gem install twurl` を実行してください。

### 2. Twitter API認証情報の取得

1. https://developer.twitter.com/ にアクセス
2. Developer Accountでサインイン（未作成の場合は作成）
3. 新しいAppを作成（または既存のものを使用）
4. "Keys and Tokens" セクションに移動
5. 以下の情報を取得:
   - **API Key** (Consumer Key)
   - **API Secret** (Consumer Secret)
   - **Access Token**
   - **Access Token Secret**

### 3. twurlの認証

#### 方法1: tweet.shスクリプトを使用（簡単）

```bash
./tweet.sh -a YOUR_API_KEY YOUR_API_SECRET
# または
./tweet.sh --authorize YOUR_API_KEY YOUR_API_SECRET
```

その後、ブラウザで表示されるPINコードを入力してください。

#### 方法2: twurlコマンドを直接使用

以下のコマンドで認証情報を設定:

```bash
twurl authorize --consumer-key YOUR_API_KEY \
                --consumer-secret YOUR_API_SECRET \
                --access-token YOUR_ACCESS_TOKEN \
                --access-token-secret YOUR_ACCESS_TOKEN_SECRET
```

または、対話式で設定:

```bash
twurl authorize --consumer-key YOUR_API_KEY \
                --consumer-secret YOUR_API_SECRET
```

### 4. セットアップの確認

```bash
twurl accounts
```

設定したアカウントが表示されればOKです。

## 使い方

### セットアップ (twurlインストール)

```bash
./tweet.sh -s
# または
./tweet.sh --setup
```

### 基本的な投稿

```bash
./tweet.sh "ここにメッセージを入力"
```

### アカウントを指定して投稿

```bash
./tweet.sh "ここにメッセージを入力" アカウント名
```

### アカウント認証

```bash
./tweet.sh -a YOUR_API_KEY YOUR_API_SECRET
# または
./tweet.sh --authorize YOUR_API_KEY YOUR_API_SECRET
```

### アカウント一覧を表示

```bash
./tweet.sh -l
# または
./tweet.sh --list
# または
./tweet.sh accounts
```

### ヘルプを表示

```bash
./tweet.sh -h
# または
./tweet.sh --help
```

## 例

```bash
# セットアップ (twurlをインストール)
./tweet.sh -s

# ヘルプを表示
./tweet.sh -h

# アカウントを認証
./tweet.sh -a abc123xyz abc123secretxyz

# デフォルトアカウントで投稿
./tweet.sh "今日はいい天気です"

# 特定のアカウントで投稿
./tweet.sh "新製品のお知らせ" company_account

# 利用可能なアカウントを確認
./tweet.sh -l
```

## トラブルシューティング

### 投稿に失敗する場合

1. twurlが正しくインストールされているか確認:
   ```bash
   which twurl
   ```

2. アカウントが認証されているか確認:
   ```bash
   twurl accounts
   ```

3. API認証情報が有効か確認（Twitter Developer Portalで確認）

### 複数アカウント使用時

デフォルトアカウントを設定:
```bash
twurl set default YOUR_USERNAME
```

## ライセンス

このプロジェクトは自由に使用できます。

## 注意事項

- Twitter APIの利用規約を遵守してください
- API Rate Limitに注意してください
- 自動投稿の頻度には気をつけてください

## 参考ウェブサイト
【決定版】ターミナルからX (Twitter) に投稿！twurlで快適コマンドラインライフ https://note.com/takaesu7431/n/n91d4a36bb7b2
Twitter Developer Portal https://developer.x.com/en
