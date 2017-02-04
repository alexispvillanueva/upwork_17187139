#!/bin/bash

id=$1

pagesmatch=`ls ${RAWDIR}/${id}/${id}-*.pdf | grep -v "\-1.pdf" | sort -t- -k2 -n`
found="false"

for pdfn in ${pagesmatch}
do
  txtn=`echo $pdfn | sed 's/pdf$/txt/'`

  # Find page that contains "sources and" and "debt service reserve fund" and delete if not found

  if [ ! -s "${txtn}" ] && [ "${found}" == "false" ]
  then
    ${PRSDIR}/pdfExtractText.sh ${pdfn}
  fi

  [ "${found}" == "false" ] && ${PRSDIR}/getDSRFFromText.sh "${txtn}"

  if [ $? == 0 ] && [ ${found} == "false" ]
  then
    echo `basename ${pdfn}` 
    found="true"
  fi
done

if [ "${found}" == "false" ]
then
  exit 1
fi
