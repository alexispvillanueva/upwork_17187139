#!/bin/bash

export BASDIR="/Users/aleisha/git/upwork_17187139"
export PRSDIR="${BASDIR}/parser"
export RAWDIR="/Volumes/MacDrive/msrb/raw"
export OUTDIR="${BASDIR}/output"
export LOGDIR="${BASDIR}/test"
export LIBDIR="${BASDIR}/lib"
export INPDIR="${BASDIR}/input"
export DBDIR="${BASDIR}/db"

id=$1

${DBDIR}/outputToSQL.sh $id

