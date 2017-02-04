#!/bin/bash

export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="$BASDIR/parser"
export RAWDIR="$BASDIR/raw"
export OUTDIR="$BASDIR/output"
export LOGDIR="$BASDIR/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"

export LOG=1

file=$1
if [ "$file" != "" ] 
then
  ${PRSDIR}/getDebtService2.sh ${RAWDIR}/$file
  exit
fi

for file in `ls ${RAWDIR}/*.pdf | grep "\-[0-9]*.pdf" | grep -v "\-1.pdf"`
do
  echo $file
  ${PRSDIR}/getDebtService2.sh $file
  read
done

