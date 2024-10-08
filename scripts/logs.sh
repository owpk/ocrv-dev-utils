#!/bin/bash

PROJ=$1

VIM=0

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -v|--vim) VIM=1; ;;
    esac
    shift
done

LOG=$HOME/ocrv/run/$PROJ/logs/$PROJ.log

if [ $VIM -eq 1 ]; then
   nvim $LOG
else 
   multitail -n 3000 -cT ansi $LOG
fi
