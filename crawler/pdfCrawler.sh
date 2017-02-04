#!/bin/bash
scriptname=`basename $0 .sh`

id=$1
pdfurl=$2

pdffirstpage=${RAWDIR}/${id}/${id}-1.pdf
tmppdf="${RAWDIR}/${id}/${id}.pdf"
rawpdf="${RAWDIR}/${id}${pdfurl}"
slctdpdflink=${RAWDIR}/${id}/${id}_pdf_link_selected
slctdpdfurl=`cat ${slctdpdflink}`

echo "[${scriptname}] ${rawpdf} downloading" 
if [ "${pdfurl}" != "${slctdpdfurl}" ]
then
  /usr/bin/java -ea -DspringConfig="pdf" -Dpdf="$pdfurl" -DlogFileName=${LOGDIR}/${scriptname}.log -Did="${id}" -DfileName="$rawpdf" -DsaveCookies=true -jar ${CRWDIR}/crawler.jar 2> /dev/null
  mv ${rawpdf} ${tmppdf}
  echo ${pdfurl} > ${slctdpdflink}
else 
  echo "[${scriptname}] ${rawpdf} is the current pdf"
fi

# Split first Page and convert to text
${PRSDIR}/pdfSplitPage.sh ${id} 1

if [ ! -s ${pdffirstpage} ]
then
  echo "[${scriptname}] Cannot split first page" 
  rm ${rawpdf} 
  echo "[${scriptname}] ${tmppdf} retry download" 
  /usr/bin/java -ea -DspringConfig="pdf" -Dpdf="$pdfurl" -DlogFileName=${LOGDIR}/${scriptname}.log -Did="${id}" -DfileName="$rawpdf" -Dhost="emma.msrb.org" -DsaveCookies=true -jar ${CRWDIR}/crawler.jar 2> /dev/null

  mv ${rawpdf} ${tmppdf}
  echo ${pdfurl} > ${slctdpdflink}

  ${PRSDIR}/pdfSplitPage.sh ${id} 1

  if [ ! -s ${pdffirstpage} ]
  then
    echo "[${scriptname}] Cannot split first page" 
    echo "[${scriptname}] [$SECONDS sec] ${tmppdf} download error"
    exit 1
  fi
fi

if [ -s "${tmppdf}" ]
then
  echo "[${scriptname}] [$SECONDS sec] ${tmppdf} download complete"
  exit 0
fi
