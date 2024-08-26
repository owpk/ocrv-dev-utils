#!/bin/bash

projects=(
   "deploy" 
   "auth" 
   "bff" 
   "pn-backend" 
   "pn-front" 
   "fs-front" 
   "fs-backend"
)

CUR=$(pwd)

install() {
   HOST="$1"
   TARGET_DIR="$2"
   
   mkdir -p $TARGET_DIR
   
   echo "project list: $PR"

   for i in ${projects[@]}; do
      target="$HOST/$i.git"
      echo "installing project $target"
      git clone $target $TARGET_DIR/
   done
}

# czt
CZT=$HOME/ocrv/czt
CZT_GIT_HOST="git@gitlab.ocrv.ru:czt-portal"
CZT_HTTP_HOST="https://gitlab.ocrv.ru/czt-portal"

CZT_HOST=$CZT_GIT_HOST

install $CZT_HOST $CZT 

# ext

EXT=$HOME/ocrv/ext
EXT_GIT_HOST="git@github.com:alexandr170288"
EXT_HTTP_HOST="https://github.com/alexandr170288"

EXT_HOST=$EXT_GIT_HOST

projects=(
   "auth"
   "pn-backend"
)

install $EXT_HOST $EXT
