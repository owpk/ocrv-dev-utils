#!/bin/bash
git config core.editor vim
git config pull.rebase false 
git config user.name "$USER"
git config user.email "--auto--"
git add .
git commit -m "$(date +'%Y-%m-%d')-updates"
git pull origin master --strategy-option=ours
