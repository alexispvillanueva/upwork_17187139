#!/bin/bash
scriptname=`basename $0 .sh`

id=$1

pdfraw=${RAWDIR}/${id}/${id}.pdf
def_pages=${RAWDIR}/${id}/${id}_def_pages

# Condition #1
# 1) Program finds the keyword "definitions" (ignoring case). 
# - Then filters the results more based from list of keywords contained in definitions_start.txt file inside parser directory
# - This will be the starting page(s).
# 2) Program captures the next pages if the page contains words enclosed with quotation marks
# 3) Program ends capturing page if there's no more word enclosed with quotation marks 

# Step 1
pdfgrep -C "line" -in "definitions" ${pdfraw} | egrep -if ${PRSDIR}/definitions_start.txt 2> /dev/null > ${def_pages}

# Step 2
for startpage in `cut -d: -f1 ${def_pages}`
do
  p=$startpage

  $PRSDIR/pdfSplitPage.sh $id $p
  pdfgrep '“|"' ${RAWDIR}/${id}/${id}-${p}.pdf > /dev/null
  ret=$?
  rm -f ${RAWDIR}/${id}/${id}-${p}.pdf

  while [ ${ret} == 0 ]
  do
    p=$[$p+1]
    $PRSDIR/pdfSplitPage.sh $id $p
    pdfgrep '“|"' ${RAWDIR}/${id}/${id}-${p}.pdf > /dev/null
    ret=$?
    rm -f ${RAWDIR}/${id}/${id}-${p}.pdf
  done

  endpage=$[$p-1]

  #echo $startpage $endpage

  if [ $startpage -lt $endpage ]
  then
    $PRSDIR/pdfSplitPage.sh $id $startpage $endpage
    echo "${id}-${startpage}-${endpage}.pdf" >> ${def_pages}
  fi

done

(>&2 echo "[${scriptname}] [$SECONDS sec] ${pdfraw} matched pattern 1")
echo
exit 0

(>&2 echo "[${scriptname}] [$SECONDS sec] ${pdfraw} no pattern matched")
exit 1
