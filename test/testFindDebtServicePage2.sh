#!/bin/bash

export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="$BASDIR/parser"
export RAWDIR="$BASDIR/raw"
export OUTDIR="$BASDIR/output"
export LOGDIR="$BASDIR/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"

export PRSDIR="../parser"
export LOG=1

for file in `ls ${RAWDIR}/*.pdf | grep "\-[0-9]*.pdf" | grep -v "\-1.pdf"`
do
  echo $file
  ${PRSDIR}/findDebtServicePage2.sh $file
done

