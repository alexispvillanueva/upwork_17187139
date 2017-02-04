#!/bin/bash
scriptname=`basename $0 .sh`

id=$1
sql="${RAWDIR}/${id}/${id}.sql"

mysql -uroot < ${sql}
if [ $? == 0 ]
then
  echo "[${scriptname}] [$SECONDS sec] ${id} record updated"
  exit 0
fi

echo "[${scriptname}] ${id} database update error"
