#!/bin/bash
scriptname=`basename $0 .sh`

id=$1
url="${URL}?id=${id}"
html="${RAWDIR}/${id}/${id}.html"

test ! -s "${html}" &&  /usr/bin/java -ea -DlogFileName=${LOGDIR}/${scriptname}.log -Durl="${url}" -Did="${id}" -DfileName="$html" -DsaveCookies=true -jar ${CRWDIR}/crawler.jar 2> /dev/null

if [ -s "${html}" ]
then
  echo "[${scriptname}] [$SECONDS sec] ${html} download complete"
fi
