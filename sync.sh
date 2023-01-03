#!/bin/bash

ACTION='\033[1;90m'
FINISHED='\033[1;96m'
READY='\033[1;92m'
NOCOLOR='\033[0m' # No Color
ERROR='\033[0;31m'

# rm -rf repos
# mkdir repos

if [ -z "$1" ]
  then
    echo "No repo supplied"
    exit 1
fi

repo=$1

echo "Syncing $repo:"
# printf "\tCloning...\n"
# git clone git@github.com:nativescript-community/$repo.git --recursive repos/$repo
cd ../$repo

node tools/sync.js
git diff

echo
git config --global user.email "actions@github.com"
git config --global user.name "GitHub Actions"
git add .
git commit --author="$GITHUB_ACTOR <$GITHUB_ACTOR@users.noreply.github.com>" -m "chore: update common files"
printf "\tChanges committed.\n"
if git push 
then
    printf "\tChanges pushed.\n"
else
    printf "\tPush failed.\n"
    exit 1
fi