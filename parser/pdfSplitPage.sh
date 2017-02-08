#!/bin/bash
#pdfbox=${LIBDIR}/pdfbox-app-1.8.9.jar
pdfbox=${LIBDIR}/pdfbox-app-2.0.3.jar

split() {

  s=$1
  echo java -Djava.awt.headless=true -jar ${pdfbox} PDFSplit -split ${s} -startPage ${p} -endPage ${e} ${rawpdf}
  java -Djava.awt.headless=true -jar ${pdfbox} PDFSplit -split ${s} -startPage ${p} -endPage ${e} -outputPrefix ${RAWDIR}/${id}/split ${rawpdf}
  test -s ${splitpage} && mv ${splitpage} ${pdfpage}
}

id=$1
p=$2
e=$3

splitpage=${RAWDIR}/${id}/split-1.pdf
rawpdf=${RAWDIR}/${id}/${id}.pdf
pdfpage=${RAWDIR}/${id}/${id}-${p}.pdf

if [ -z $e ]
then
  e=$p
else 
  pdfpage=${RAWDIR}/${id}/${id}-${p}-${e}.pdf
fi

split $e
