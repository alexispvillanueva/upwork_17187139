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
  ${PRSDIR}/htmlParser.sh $id
  exit
fi

ctr=2
for link in `cat "${INPDIR}/done/GA Issues.txt"`
do
  id=`echo $link | cut -d"=" -f2`

  echo "$ctr) $id"
  ${PRSDIR}/htmlParser.sh ${id}
  ret=$?

  echo ${RAWDIR}/${id}_issue_name
  cat ${RAWDIR}/${id}_issue_name
  echo ${RAWDIR}/${id}_issue_detail
  cat ${RAWDIR}/${id}_issue_detail

  echo "$ctr) $id return=$ret"
  read
  ctr=`expr $ctr + 1`
done

