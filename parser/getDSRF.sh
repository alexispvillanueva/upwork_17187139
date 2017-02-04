#!/bin/bash
scriptname=`basename $0 .sh`

pdfnpage="$1"

getAmount() {

  (>&2 echo [${scriptname}] getAmount ${pdfnpage} "$1")
  echo "$1" | awk '{
      for (i=1; i<=NF; i++) {
        gsub(/\.\.*\./,"",$i)
        if($i ~ /,[0-9][0-9][0-9]/) print $i;
      }
  }'

}

# PATTERN 1 {debt service reserve.*,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" -i "debt service reserve" ${pdfnpage} 2> /dev/null | grep ",[0-9][0-9][0-9]"`
if [ $? == 0 ]
then
  getAmount "$line"
  (>&2 echo "[${scriptname}] ${pdfnpage} matched pattern 1")
  exit 0
fi

# PATTERN 2 {deposit to.*reserve.*,[0-9][0-9][0-9]}
line=`pdfgrep  -C "line" -i "deposit to" ${pdfnpage} 2> /dev/null | grep -i "reserve.*,[0-9][0-9][0-9]"`
if [ $? == 0 ]
then
  getAmount "$line"
  (>&2 echo "[${scriptname}] ${pdfnpage} matched pattern 2")
  exit 0
fi

# PATTERN 3 {reserves.*,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" -i "reserves" ${pdfnpage} 2> /dev/null | grep ",[0-9][0-9][0-9]"`
if [ $? == 0 ]
then
  getAmount "$line"
  (>&2 echo "[${scriptname}] ${pdfnpage} matched pattern 3")
  exit 0
fi

# PATTERN 4 {reserves.*,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" -i "debt reserve" ${pdfnpage} 2> /dev/null | grep ",[0-9][0-9][0-9]"`
if [ $? == 0 ]
then
  getAmount "$line"
  (>&2 echo "[${scriptname}] ${pdfnpage} matched pattern 4")
  exit 0
fi

# Special space character
# PATTERN 5 {debt service reserve.*,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" -i "debt service reserve" ${pdfnpage} 2> /dev/null | grep ",[0-9][0-9][0-9]"`
if [ $? == 0 ]
then
  getAmount "$line"
  (>&2 echo "[${scriptname}] ${pdfnpage} matched pattern 5")
  exit 0
fi

# PATTERN 6 {reserves.*,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" -i "reserve fund" ${pdfnpage} 2> /dev/null | grep ",[0-9][0-9][0-9]"`
if [ $? == 0 ]
then
  getAmount "$line"
  (>&2 echo "[${scriptname}] ${pdfnpage} matched pattern 6")
  exit 0
fi

# PATTERN 7 {reserves.*,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" -i "certificate reserve" ${pdfnpage} 2> /dev/null | grep ",[0-9][0-9][0-9]"`
if [ $? == 0 ]
then
  getAmount "$line"
  (>&2 echo "[${scriptname}] ${pdfnpage} matched pattern 7")
  exit 0
fi


(>&2 echo "[${scriptname}] ${pdfnpage} no pattern matched")
exit 1

