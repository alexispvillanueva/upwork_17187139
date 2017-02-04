#!/bin/bash

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_55.jdk/Contents/Home
export BASDIR="/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb"
export PRSDIR="$BASDIR/parser"
export RAWDIR="$BASDIR/raw"
export OUTDIR="$BASDIR/output"
export LOGDIR="$BASDIR/log"
export LIBDIR=${BASDIR}/lib
export INPDIR=${BASDIR}/input

$PRSDIR/reader.sh 2 4 "GA Issues.xlsx"
