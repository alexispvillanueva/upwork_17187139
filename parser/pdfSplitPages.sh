#!/bin/bash
scriptname=`basename $0 .sh`

id=$1
clean=$2

rawpdf=${RAWDIR}/${id}/${id}.pdf
pdffirstpage=${RAWDIR}/${id}/${id}-1.pdf

pdfnpage="`grep pdf ${RAWDIR}/${id}/${id}_dsrf 2> /dev/null`"
test -z "${pdfnpage}" && pdfnpage="xxx" 

if [ "${clean}" == "1" ]  || test ! -s "${RAWDIR}/${id}/${pdfnpage}" || test ! -s ${pdffirstpage} 
then

  # Split first Page and convert to text
  test ! -s ${pdffirstpage} && ${PRSDIR}/pdfSplitPage.sh ${id} 1

  if [ ! -s ${pdffirstpage} ]
  then
    echo "[${scriptname}] [$SECONDS sec] Cannot split first page"
    #mv ${rawpdf} ${rawpdf}.err
    exit 1
  fi

  # Split pages with "sources and" string pattern
  pdfgrep -in " sources and" ${rawpdf} | cut -d: -f1 | grep -v "^1$" > ${RAWDIR}/${id}/${id}_pages
  pdfgrep -in "and uses" ${rawpdf} | cut -d: -f1 | grep -v "^1$"  >> ${RAWDIR}/${id}/${id}_pages

  # There's a special space character between "souces and"
  if [ ! -s ${RAWDIR}/${id}/${id}_pages ]
  then
    pdfgrep -in "sources and" ${rawpdf} | cut -d: -f1 | grep -v "^1$" >> ${RAWDIR}/${id}/${id}_pages
    pdfgrep -in "and uses" ${rawpdf} | cut -d: -f1 | grep -v "^1$" >> ${RAWDIR}/${id}/${id}_pages
  fi

  sort -nu ${RAWDIR}/${id}/${id}_pages -o ${RAWDIR}/${id}/${id}_pages

  # Split pages with "sources and" string pattern
  for p in `cat ${RAWDIR}/${id}/${id}_pages`
  do
    pdfpage=${RAWDIR}/${id}/${id}-${p}.pdf
    test ! -z ${pdfpage} && ${PRSDIR}/pdfSplitPage.sh ${id} ${p}
  done

fi

echo "[${scriptname}] [$SECONDS sec] done"
