#!/bin/bash
scriptname=`basename $0 .sh`

id=$1

pdffirstpage=${RAWDIR}/${id}/${id}-1.pdf

# PATTERN 1 {$,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" "\\\\$" ${pdffirstpage} | grep -vi '[a-z]' | sort -u | grep ",[0-9][0-9][0-9]"`;
if [ $? == 0 ]
then
  echo "$line" | awk '{
      for (i=1; i<=NF; i++) {
        if($i ~ /,[0-9][0-9][0-9]/) {
          print $i;
        }
      }
  }'
  (>&2 echo "[${scriptname}] ${pdffirstpage} matched pattern 1")
  exit 0
else 
  echo "null"
fi

(>&2 echo "[${scriptname}] ${pdffirstpage} no pattern matched")
exit 1
