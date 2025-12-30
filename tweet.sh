#!/bin/bash

# --- Setup Option ---
if [ "$1" = "-s" ] || [ "$1" = "--setup" ]; then
  echo "## ⚙️  Installing twurl ##"
  echo "Running command: gem install twurl"
  gem install twurl
  if [ $? -eq 0 ]; then
    echo "## ✅ twurl installation completed! ##"
    echo "Next step: Authorize your account with ./tweet.sh -a API_KEY API_SECRET"
  else
    echo "## ❌ twurl installation failed. ##"
    echo "You may need sudo: sudo gem install twurl"
  fi
  exit $?
fi

# --- Help Option ---
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "## 📖 tweet.sh - Twitter/X Automation Tool ##"
  echo ""
  echo "Usage:"
  echo "  Setup (install twurl):"
  echo "    ./tweet.sh -s"
  echo "    ./tweet.sh --setup"
  echo ""
  echo "  Basic tweet:"
  echo "    ./tweet.sh \"Your message here\""
  echo ""
  echo "  Tweet with specific account:"
  echo "    ./tweet.sh \"Your message here\" account_name"
  echo ""
  echo "  Authorize account:"
  echo "    ./tweet.sh -a API_KEY API_SECRET"
  echo "    ./tweet.sh --authorize API_KEY API_SECRET"
  echo ""
  echo "  List accounts:"
  echo "    ./tweet.sh -l"
  echo "    ./tweet.sh --list"
  echo "    ./tweet.sh accounts"
  echo ""
  echo "  Show help:"
  echo "    ./tweet.sh -h"
  echo "    ./tweet.sh --help"
  echo ""
  echo "Examples:"
  echo "  ./tweet.sh -s"
  echo "  ./tweet.sh \"Nice weather today\""
  echo "  ./tweet.sh \"New product announcement\" company_account"
  echo "  ./tweet.sh -a abc123xyz abc123secretxyz"
  echo "  ./tweet.sh -l"
  exit 0
fi

# --- Account Authorization Option ---
if [ "$1" = "-a" ] || [ "$1" = "--authorize" ]; then
  if [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: ./tweet.sh --authorize API_KEY API_SECRET"
    echo "Example: ./tweet.sh --authorize your_api_key your_api_secret"
    exit 1
  fi
  echo "## 🔐 Running twurl account authorization ##"
  echo "API Key: $2"
  echo "API Secret: $3"
  twurl authorize --consumer-key "$2" --consumer-secret "$3"
  exit $?
fi

# --- List Accounts Option ---
if [ "$1" = "-l" ] || [ "$1" = "--list" ] || [ "$1" = "accounts" ]; then
  echo "## 📋 Available Accounts ##"
  twurl accounts
  exit 0
fi

# --- Initial Setup ---
# First argument is tweet content, second argument is account name
TWEET_CONTENT="$1"
ACCOUNT_NAME="$2" # Accept empty second argument as-is

# --- Pre-execution Check ---

# If tweet content (first argument) is empty, show usage and exit
if [ -z "$TWEET_CONTENT" ]; then
  echo "Usage:"
  echo "  Setup: ./tweet.sh -s (or --setup)"
  echo "  Basic: ./tweet.sh \"Your message here\""
  echo "  With account: ./tweet.sh \"Your message here\" account_name"
  echo "  Authorize: ./tweet.sh -a API_KEY API_SECRET (or --authorize)"
  echo "  List accounts: ./tweet.sh -l (or --list, accounts)"
  echo "  Show help: ./tweet.sh -h (or --help)"
  exit 1
fi

# --- twurl Option Setup ---

# Check if account name is specified
if [ -n "$ACCOUNT_NAME" ]; then
    ACCOUNT_OPTION="-u $ACCOUNT_NAME"
    echo "## 🐦 Posting to X (Account: $ACCOUNT_NAME)... ##"
else
    ACCOUNT_OPTION=""
    echo "## 🐦 Posting to X (Default account)... ##"
fi

# --- Tweet Posting ---

echo "Tweet content: \"$TWEET_CONTENT\""

# Call X API v2 tweets endpoint using twurl
# ACCOUNT_OPTION variable contains "-u account_name" or ""
twurl -u $ACCOUNT_OPTION -X POST -A "Content-type: application/json" -d "{\"text\": \"$TWEET_CONTENT\"}" /2/tweets

if [ $? -eq 0 ]; then
    echo "## ✅ Tweet posted successfully! ##"
else
    echo "## ❌ Tweet posting failed. ##"
fi
