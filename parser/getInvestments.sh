#!/bin/bash
scriptname=`basename $0 .sh`

id=$1

pdfraw=${RAWDIR}/${id}/${id}.pdf
inv_pages=${RAWDIR}/${id}/${id}_inv_pages

# Condition #1
# 1) Program finds the keyword "investments" (not case sensitive). 
# 2) Program checks if keyword "investments" is the only word in the line (this is considered as heading)
# 3) Program captures the page where keyword was found and the page after (in case investments section spans 2 pages)

# Step 1
pdfgrep -C "line" -in "investments" ${pdfraw} | grep -i ": *investments$" > ${inv_pages}

# Step 2
for p in `cut -d: -f1 ${inv_pages}`
do
  e=$[$p+1]

  $PRSDIR/pdfSplitPage.sh $id $p $e

  echo ${id}-${p}-${e}.pdf >> ${inv_pages}
done

if [ -s ${inv_pages} ] 
then
  echo "[${scriptname}] [$SECONDS sec] ${pdfraw} matched condition 1"
  exit 0
fi

# Condition #2
# 1) Program finds the keyword "investment of" (not case sensitive).
# 2) Program checks if keyword exactly match "Investment" (w/ big letter I) or INVESTMENTS (ALL CAPS)
# 3) Program finds the another keyword "invested" within the page found in Steps 1 & 2
# 4) Program captures the page and the page after, if Step 1, 2 & 3 conditions are met

# Step 1
pdfgrep -C "line" -in "investment of" ${pdfraw} | egrep "Investment|INVESTMENT" | grep -v "\.\.\.\." > ${inv_pages}

if [ ! -s ${inv_pages} ]
then

  # Condition #2.1
  # 1) Program finds the keyword "investment" (not case sensitive).
  # 2) Program finds the another keyword "section" (not case sensitive) within the line(s) found in Step 1 (considered as heading)
  # 3) Program finds the another keyword "invested" within the page found in Steps 1 & 2
  # 4) Program captures the page and the page after, if Step 1, 2 & 3 conditions are met
  pdfgrep -C "line" -in "investment" ${pdfraw} | grep -i "section" | grep -v "\.\.\.\." > ${inv_pages}
fi

for p in `cut -d: -f1 ${inv_pages}`
do

   $PRSDIR/pdfSplitPage.sh $id $p

   pdfgrep -i "invested" ${RAWDIR}/${id}/${id}-${p}.pdf > /dev/null
   ret=$?

   if [ ${ret} == 0 ] 
   then
     rm ${RAWDIR}/${id}/${id}-${p}.pdf 
     e=$[$p+1]
     $PRSDIR/pdfSplitPage.sh $id $p $e
     echo ${id}-${p}-${e}.pdf >> ${inv_pages}

   fi
done

if [ -s ${inv_pages} ]
then
  echo "[${scriptname}] [$SECONDS sec] ${pdfraw} matched condition 2"
  exit 0
fi

echo "[${scriptname}] [$SECONDS sec] ${pdfraw} no condition matched"
exit 1
