#!/bin/bash

rm -rf repos
mkdir repos

submodules=("demo-ng" "demo-react" "demo-svelte" "demo-vue" "tools")

if [ -z "$1" ]
  then
    echo "No repo supplied"
    exit 1
fi

repo=$1

echo "Updating $repo:"
printf "\tCloning...\n"
git config --unset-all http.https://github.com/.extraheader
git clone https://$ACTOR:$GITHUB_TOKEN@github.com/nativescript-community/$repo.git --recursive repos/$repo
cd repos/$repo
for submodule in "${submodules[@]}"
do
    if [ -d "$submodule" ]; then
        printf "\tChecking $submodule for updates...\n"
        cd $submodule
        git checkout master
        git pull
        cd ..
    fi
done

if [[ `git status --porcelain` ]]; then
    printf "\tChanged have been made...\n"
    echo "::set-output name=changes::true"

    git config --global user.email "actions@github.com"
    git config --global user.name "GitHub Actions"
    git add .
    git commit --author="$ACTOR <$ACTOR@users.noreply.github.com>" -m "chore: update submodules"
    printf "\tChanges committed.\n"
    # if git push 
    # then
    #     printf "\tChanges pushed.\n"
    # else
    #     printf "\tPush failed.\n"
    #     exit 1
    # fi
else
    echo "::set-output name=changes::false"
    printf "\tNothing has been changed\n"
fi