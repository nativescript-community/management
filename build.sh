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

echo "Building $repo:"
printf "\tCloning...\n"

git clone https://$GITHUB_ACTOR:$ACTIONS_TOKEN@github.com/nativescript-community/$repo.git --recursive repos/$repo

cd repos/$repo
npm i

if grep -q "lerna run build.all" "package.json"
then
    npm run build.all 
else
    npm run build
fi
if [ $? -eq 0 ]
then
    echo -e ${FINISHED}$repo was built successfully.${NOCOLOR}
else
    echo -e ${ERROR}$repo failed to build.${NOCOLOR}
    exit 1
fi