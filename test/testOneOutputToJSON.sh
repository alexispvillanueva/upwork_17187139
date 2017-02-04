#!/bin/bash

export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="${BASDIR}/parser"
export RAWDIR="${BASDIR}/raw"
export OUTDIR="${BASDIR}/output"
export LOGDIR="${BASDIR}/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"
export URL="http://emma.msrb.org/IssueView/IssueDetails.aspx"

id=$1

${PRSDIR}/oneOutputToJSON.sh $id

