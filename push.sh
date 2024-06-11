#!/bin/bash

HOME_BRANCH=$1
REMOTE_WORK=origin
REMOTE_HOME=gh

git fetch --all
git checkout master
git pull
git branch --track $HOME_BRANCH $REMOTE_HOME/$HOME_BRANCH
git checkout $HOME_BRANCH
git push -u $REMOTE_WORK $HOME_BRANCH
