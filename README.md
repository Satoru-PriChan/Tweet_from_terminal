# Twitter Automatic

Twitter/X Automation Tool - A simple Bash script to post tweets from the command line

## Features

- Easy twurl installation
- Post tweets directly from command line
- Multiple account support
- Account authorization within the script
- Display list of accounts

## Requirements

- `twurl` (Command-line tool for Twitter API)
- Twitter Developer Account
- Twitter API credentials

## Setup

### 1. Install twurl

#### Method 1: Using tweet.sh script (Easy)

```bash
./tweet.sh -s
# or
./tweet.sh --setup
```

#### Method 2: Direct installation

```bash
gem install twurl
```

※ If you get a permission error, run `sudo gem install twurl`.

### 2. Get Twitter API Credentials

1. Go to https://developer.twitter.com/
2. Sign in with your Developer Account (create one if needed)
3. Create a new App (or use an existing one)
4. Navigate to "Keys and Tokens" section
5. Get the following information:
   - **API Key** (Consumer Key)
   - **API Secret** (Consumer Secret)
   - **Access Token**
   - **Access Token Secret**

### 3. Authorize twurl

#### Method 1: Using tweet.sh script (Easy)

```bash
./tweet.sh -a YOUR_API_KEY YOUR_API_SECRET
# or
./tweet.sh --authorize YOUR_API_KEY YOUR_API_SECRET
```

Then enter the PIN code displayed in your browser.

#### Method 2: Using twurl command directly

Set credentials with the following command:

```bash
twurl authorize --consumer-key YOUR_API_KEY \
                --consumer-secret YOUR_API_SECRET \
                --access-token YOUR_ACCESS_TOKEN \
                --access-token-secret YOUR_ACCESS_TOKEN_SECRET
```

Or set up interactively:

```bash
twurl authorize --consumer-key YOUR_API_KEY \
                --consumer-secret YOUR_API_SECRET
```

### 4. Verify Setup

```bash
twurl accounts
```

If your configured account is displayed, you're all set!

## Usage

### Setup (Install twurl)

```bash
./tweet.sh -s
# or
./tweet.sh --setup
```

### Basic Tweet

```bash
./tweet.sh "Your message here"
```

### Tweet with Specific Account

```bash
./tweet.sh "Your message here" account_name
```

### Authorize Account

```bash
./tweet.sh -a YOUR_API_KEY YOUR_API_SECRET
# or
./tweet.sh --authorize YOUR_API_KEY YOUR_API_SECRET
```

### List Accounts

```bash
./tweet.sh -l
# or
./tweet.sh --list
# or
./tweet.sh accounts
```

### Show Help

```bash
./tweet.sh -h
# or
./tweet.sh --help
```

## Examples

```bash
# Setup (install twurl)
./tweet.sh -s

# Show help
./tweet.sh -h

# Authorize account
./tweet.sh -a abc123xyz abc123secretxyz

# Tweet with default account
./tweet.sh "Nice weather today"

# Tweet with specific account
./tweet.sh "New product announcement" company_account

# Check available accounts
./tweet.sh -l
```

## Troubleshooting

### If posting fails

1. Check if twurl is installed correctly:
   ```bash
   which twurl
   ```

2. Check if account is authorized:
   ```bash
   twurl accounts
   ```

3. Verify API credentials are valid (check in Twitter Developer Portal)

### Using Multiple Accounts

Set default account:
```bash
twurl set default YOUR_USERNAME
```

## License

This project is free to use.

## Notes

- Please comply with Twitter API terms of service
- Be aware of API Rate Limits
- Be careful with automated posting frequency

## References
- [Complete Guide] Post to X (Twitter) from Terminal! Comfortable Command Line Life with twurl https://note.com/takaesu7431/n/n91d4a36bb7b2
- Twitter Developer Portal https://developer.x.com/en
