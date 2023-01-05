#!/bin/bash

# rm -rf repos
# mkdir repos

submodules=("demo-ng" "demo-react" "demo-svelte" "demo-vue" "tools")

if [ -z "$1" ]
  then
    echo "No repo supplied"
    exit 1
fi

repo=$1

echo "Updating submodules to https for $repo:"
# printf "\tCloning...\n"
# git clone git@github.com:nativescript-community/$repo.git --recursive repos/$repo
cd $repo

sed -i 's/git@github.com:/https:\/\/github.com\//' .gitmodules

git submodule sync

if [[ `git status --porcelain` ]]; then
    printf "\tChanged have been made...\n"

    git config --global user.email "actions@github.com"
    git config --global user.name "GitHub Actions"
    git add .
    git commit --author="$GITHUB_ACTOR <$GITHUB_ACTOR@users.noreply.github.com>" -m "chore: update submodules to https"
    printf "\tChanges committed.\n"
    if git push 
    then
        printf "\tChanges pushed.\n"
    else
        printf "\tPush failed.\n"
        exit 1
    fi
else
    printf "\tNothing has been changed\n"
fi