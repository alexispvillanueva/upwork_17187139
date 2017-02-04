#!/bin/bash
scriptname=`basename $0 .sh`
logfile=${LOGDIR}/${scriptname}.log
pdfbox=${LIBDIR}/pdfbox-app-1.8.9.jar
log=1


id=$1
clean=$2
donotdelete=$3

if [ ! -s ${RAWDIR}/${id}/${id}.pdf ]
then
  echo "[${scriptname}] ${RAWDIR}/${id}/${id}.pdf is empty or not found"
  exit 1
fi

issue_amount=${RAWDIR}/${id}/${id}_issue_amount
dsrf=${RAWDIR}/${id}/${id}_dsrf
def_pages=${RAWDIR}/${id}/${id}_def_pages

${PRSDIR}/pdfSplitPages.sh $id $clean

# Issue Amount
${PRSDIR}/getIssueAmount.sh $id > ${issue_amount}

# Debt service reserve fund
${PRSDIR}/getDSRFMain.sh ${id} > ${dsrf}

if [ $? == 1 ]
then
   ${PRSDIR}/getDSRFFromTextMain.sh ${id} > ${dsrf}
fi

pdfnpage=`grep pdf ${dsrf}`

test -z $pdfnpage && pdfnpage="xxx" 

pdftodelete=`ls ${RAWDIR}/${id}/${id}-*.pdf | grep -v "\-1.pdf" | grep -v "${pdfnpage}"`

if [ "${donotdelete}" != "1" ]
then
  for pdf in ${pdftodelete}
  do
    txt=`echo $pdf | sed 's/pdf/txt/g'`
    rm $pdf
    rm $txt 2> /dev/null
  done
fi

echo "[${scriptname}] [$SECONDS sec] done"

# Get Definitions Page
${PRSDIR}/getDefinitionsPage.sh $id > ${def_pages}
#This is the new one --> ${PRSDIR}/getDefinitions.sh $id 
