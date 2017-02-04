#!/bin/bash

# Get one xlsx file in input directory

xlsinputfile="$1"

if test -z "${xlsinputfile}"
then
  echo "Input file not found"
  exit 1
elif ! test -r "${xlsinputfile}"
then
  echo "Input file not readable"
  exit 1
fi

$PRSDIR/reader.sh 1 1 "${xlsinputfile}" 
