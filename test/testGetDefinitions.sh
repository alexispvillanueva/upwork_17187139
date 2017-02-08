#!/bin/bash

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_55.jdk/Contents/Home
export BASDIR="/Users/aleisha/git/upwork_17187139"
export PRSDIR="${BASDIR}/parser"
export RAWDIR="/Volumes/MacDrive/msrb/raw"
export OUTDIR="${BASDIR}/output"
export LOGDIR="${BASDIR}/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"

export LOG=1

java -version

id=$1
if [ "$id" != "" ] 
then
  ${PRSDIR}/getDefinitions.sh $id
  exit
fi


