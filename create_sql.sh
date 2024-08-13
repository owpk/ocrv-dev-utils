#!/bin/sh

TMP_DBML=/tmp/dbml_schema.dbml
pbpaste > $TMP_DBML
dbml2sql $TMP_DBML | pbcopy
