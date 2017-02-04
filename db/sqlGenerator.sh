#!/bin/bash
scriptname=`basename $0 .sh`

id=$1
sqloutput="${RAWDIR}/${id}/${id}.sql"

${DBDIR}/outputToSQL.sh $id > "${sqloutput}"

echo "[${scriptname}] [$SECONDS sec] ${sqloutput} generated"

