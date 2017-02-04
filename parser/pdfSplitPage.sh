#!/bin/bash
#pdfbox=${LIBDIR}/pdfbox-app-1.8.9.jar
pdfbox=${LIBDIR}/pdfbox-app-2.0.3.jar

split() {

  s=$1
  #java -Djava.awt.headless=true -jar ${pdfbox} PDFSplit -split ${s} -startPage ${p} -endPage ${e} -outputPrefix ${RAWDIR}/${id}/split ${rawpdf}
  #echo java -Djava.awt.headless=true -jar ${pdfbox} PDFSplit -split ${s} -startPage ${p} -endPage ${e} ${rawpdf}
  java -Djava.awt.headless=true -jar ${pdfbox} PDFSplit -split ${s} -startPage ${p} -endPage ${e} ${rawpdf}
  test -s ${splitpage} && mv ${splitpage} ${pdfpage}
}

id=$1
p=$2
e=$3
s=1

splitpage=${RAWDIR}/${id}/${id}-1.pdf
splitpage2=${RAWDIR}/${id}/${id}-2.pdf
rawpdf=${RAWDIR}/${id}/${id}.pdf
pdfpage=${RAWDIR}/${id}/${id}-${p}.pdf

if [ -z $e ]
then
  e=$p
else 
  pdfpage=${RAWDIR}/${id}/${id}-${p}-${e}.pdf
  s=$[${e}-${p}+1]
fi

split $s

while [ -s $splitpage2 ]
do
  rm $splitpage2
  s=$[$s+1]
  split $s
done
