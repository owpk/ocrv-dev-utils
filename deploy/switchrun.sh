#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -l|--local) echo "1"; break ;;
    esac
    shift
done
