#!/bin/bash

ACTION='\033[1;90m'
FINISHED='\033[1;96m'
READY='\033[1;92m'
NOCOLOR='\033[0m' # No Color
ERROR='\033[0;31m'

rm -rf repos
mkdir repos

submodules=("demo-ng" "demo-react" "demo-svelte" "demo-vue" "tools")

if [ -z "$1" ]
  then
    echo "No repo supplied"
    exit 1
fi

repo=$1

echo "Syncing $repo:"
printf "\tCloning...\n"
git config --unset-all http.https://github.com/.extraheader
git clone https://$ACTOR:$GITHUB_TOKEN@github.com/nativescript-community/$repo.git --recursive repos/$repo
cd repos/$repo
for submodule in "${submodules[@]}"
do
    if [ -d "$submodule" ]; then
        printf "\tConfirming $submodule is up-to-date...\n"
        cd $submodule
        git fetch
        HEADHASH=$(git rev-parse HEAD)
        UPSTREAMHASH=$(git rev-parse master@{upstream})

        if [ "$HEADHASH" != "$UPSTREAMHASH" ]
        then
            echo -e ${ERROR}Not up to date with origin. Aborting.${NOCOLOR}
            echo
            exit 0
        fi
        cd ..
    fi
done
node tools/sync.js
git diff
echo
git config --global user.email "actions@github.com"
git config --global user.name "GitHub Actions"
git add .
git commit --author="$ACTOR <$ACTOR@users.noreply.github.com>" -m "chore: update common files"
printf "\tChanges committed.\n"
# if git push 
# then
#     printf "\tChanges pushed.\n"
# else
#     printf "\tPush failed.\n"
#     exit 1
# fi