#!/bin/bash

export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="${BASDIR}/parser"
export RAWDIR="/Volumes/MacDrive/msrb/raw"
export OUTDIR="${BASDIR}/output"
export LOGDIR="${BASDIR}/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"
export URL="http://emma.msrb.org/IssueView/IssueDetails.aspx"

txtinputfile=$1
htmloutput=$2

if [ -z $txtinputfile ] || [ -z $htmloutput ]
then
 echo batchOutputToJSON.sh {txtinputfile} {htmloutput}
 exit
fi


${PRSDIR}/batchOutputToJSON.sh $txtinputfile $htmloutput

