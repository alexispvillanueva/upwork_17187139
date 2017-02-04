#!/bin/bash
scriptname=`basename $0 .sh`

sql="${DBDIR}/checkDB.sql"

mysql -uroot < ${sql}
if [ $? == 0 ]
then
  echo "[${scriptname}] [$SECONDS sec] ${id} connected to database"
  exit 0
fi

echo "[${scriptname}] ${id} database connect error"
exit 1
