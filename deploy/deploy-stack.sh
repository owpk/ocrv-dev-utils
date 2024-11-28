#!/bin/sh

export DETACH=y

./auth.sh -l
./gateway.sh -l
./pn.sh -l
./fs.sh -l
