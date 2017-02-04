#!/bin/bash

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_55.jdk/Contents/Home
export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="$BASDIR/parser"
export RAWDIR="/Volumes/MacDrive/msrb/raw"
export OUTDIR="$BASDIR/output"
export LOGDIR="$BASDIR/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"

id=$1
clean=$2

$PRSDIR/pdfSplitPages.sh $id $clean
