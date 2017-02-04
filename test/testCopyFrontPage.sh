#!/bin/bash

export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="${BASDIR}/parser"
export RAWDIR="${BASDIR}/raw"
export OUTDIR="${BASDIR}/output"
export LOGDIR="${BASDIR}/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"

export LOG=1

id=$1
if [ "$id" != "" ] 
then
  ${PRSDIR}/copyFrontPage.sh $id
  exit
fi

ctr=2
for link in `cat "${INPDIR}/done/GA Issues.txt"`
do
  id=`echo $link | cut -d"=" -f2`

  echo "$ctr) $id"
  ${PRSDIR}/copyFrontPage.sh ${id}
  ret=$?
  echo "$ctr) $id return=$ret"
  read
  ctr=`expr $ctr + 1`
done

