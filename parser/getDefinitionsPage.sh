#!/bin/bash
scriptname=`basename $0 .sh`

id=$1

pdfraw=${RAWDIR}/${id}/${id}.pdf

# PATTERN 1 {$,[0-9][0-9][0-9]}
line=`pdfgrep -C "line" -in "definitions" ${pdfraw} 2> /dev/null`;
if [ $? == 0 ]
then
  echo "$line" | awk '{

    split($0,a,":");
    page=a[1];
    delete a;

    if($0 ~ /\.\.\./ || $0 ~ /\. \. \./) {
      # exlcude table of contents
      absolute_exclude[page]=1
    }
    else if ($0 ~ "following definitions" || $0 ~ "DEFINITIONS" || $0 ~ "Definitions") {
      # include [override exclude]
      include[page]=1
    }
    else if ($0 ~ /definitions/) {
      # exclude small caps
      exclude[page]=1
    }

    all[page]=NF":"$0

  } END {

     for (page in all) {
       if(absolute_exclude[page] != 1 && (exclude[page] != 1 || include[page] == 1)) {
          print all[page]
       }
       else {
          #print all[page]"***exluded"
       }
     }
  }' | sort -n 

  (>&2 echo "[${scriptname}] [$SECONDS sec] ${pdfraw} matched pattern 1")
  exit 0
fi

(>&2 echo "[${scriptname}] [$SECONDS sec] ${pdfraw} no pattern matched")
exit 1
