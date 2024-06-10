# ип базы 172.22.10.23

# логин 
# pn_service
 
# пароль
# pn-secret
 
# база 
# pndb

DB_NAME=$1
DB_USER=pn_service
DUMP="./dump/dump_$DB_NAME.sql"

pg_dump --verbose --host=172.22.10.23 --port=5432 --username=$DB_USER --format=p --encoding=UTF-8 --inserts --no-privileges --no-owner --file $DUMP -n public $DB_NAME

#ssh pn_service@172.22.10.23 "pg_dump -v -h localhost -U $DB_USER -Fc $DB_NAME" > $DUMP
# docker exec -i $CONTAINER_NAME pg_restore -U $DB_USER -v -d $DB_NAME < $DUMP
