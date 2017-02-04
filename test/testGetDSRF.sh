#!/bin/bash

export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="${BASDIR}/parser"
export RAWDIR="${BASDIR}/raw"
export OUTDIR="${BASDIR}/output"
export LOGDIR="${BASDIR}/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"

export LOG=1

file=$1
if [ "$file" != "" ] 
then
  ${PRSDIR}/getDSRF.sh ${RAWDIR}/$file
  exit
fi

ctr=2
for link in `cat "${INPDIR}/done/GA Issues.txt"`
do
  id=`echo $link | cut -d"=" -f2`
  pdfn=`ls ${RAWDIR}/${id}-*.pdf | grep -v "\-1.pdf"`

  echo "$ctr) $id $pdfn"
  [ "${pdfn}" != "" ] && ${PRSDIR}/getDSRF.sh $pdfn
  ret=$?
  echo "$ctr) $id $pdfn return=$ret"

  read
  ctr=`expr $ctr + 1`
done

