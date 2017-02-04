#!/bin/bash
#pdfbox=${LIBDIR}/pdfbox-app-1.8.9.jar
pdfbox=${LIBDIR}/pdfbox-app-2.0.3.jar

pdfn=$1
test -s "${pdfn}" && java -Djava.awt.headless=true -jar ${pdfbox} ExtractText ${pdfn} 2> /dev/null
