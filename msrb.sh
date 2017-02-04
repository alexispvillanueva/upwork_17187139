#!/bin/bash
# ------------------------------------------------------------------
# Description	: This is the main entry script  
# Author	: Alexis Villanueva 
# 		: http://www.upwork.com/o/profiles/users/_~01c306f4f303234f24/
# Created	: 2016-10-29
# Updated	: 2016-10-29
# Version	: 0.1
# ------------------------------------------------------------------

BASDIR=`pwd`

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_55.jdk/Contents/Home
export LOGDIR=${BASDIR}/log
export CRWDIR=${BASDIR}/crawler
export PRSDIR=${BASDIR}/parser
export RAWDIR="/Volumes/MacDrive/msrb/raw"
export LIBDIR=${BASDIR}/lib
export OUTDIR=${BASDIR}/output
export INPDIR=${BASDIR}/input
export DBDIR=${BASDIR}/db
export URL="http://emma.msrb.org/IssueView/IssueDetails.aspx"
export LOG=1

param=$1

java -version

main() {

  id=$1	
  clean=$2
  donotdelete=$3

  $CRWDIR/htmlCrawler.sh "${id}"
  $PRSDIR/htmlParser.sh "${id}"

  parsedpdflink=${RAWDIR}/${id}/${id}_pdf_link
  dsrf=${RAWDIR}/${id}/${id}_dsrf

  if [ ! -s "${parsedpdflink}" ]
  then
    echo "[${scriptname}] [$SECONDS sec] ${parsedpdflink} is empty or not found"
  fi

  rm ${dsrf}

  for pdflink in `gtac "${parsedpdflink}"`
  do
    if [ ! -s ${dsrf} ] 
    then
      $CRWDIR/pdfCrawler.sh "${id}" "${pdflink}"
      $PRSDIR/pdfParser.sh "${id}" "${clean}" "${donotdelete}"
    fi
  done

  $CRWDIR/imgCrawler.sh "${id}"
  $DBDIR/sqlGenerator.sh "${id}"
  $DBDIR/insertOrUpdateDB.sh "${id}"

}

main_test() {

  id=$1

  $DBDIR/sqlGenerator.sh "${id}"
  $DBDIR/insertOrUpdateDB.sh "${id}"

}


batch() {

  txtinputfile="$1"
  htmloutput="$2"

  # Crawl and parse each link in input file
  for link in `cat "${INPDIR}/${txtinputfile}"`
  do
    id=`echo $link | cut -d"=" -f2`
    main $id
  done
  # generate sql file
  # $PRSDIR/batchOutputToSQL.sh "${txtinputfile}" 

  # update database
  # $DBDIR/batchUpdatetoDB.sh "${txtinputfile}" 

}

# Check Database
$DBDIR/checkDB.sh 
if [ $? == 1 ]
then
  exit 1
fi

# Single text input processing
echo $param | grep txt$
if [ $? == 0 ]
then
  txtinputfile="$param"
  htmloutput="`basename "${txtinputfile}" .txt`.html"
  batch "$txtinputfile" "$htmloutput"
  exit
fi


# Single ID processing
if [ ! -z "${param}" ]
then
  id=$param
  # Single processing
  main $id 0 0
  exit
fi

# Multiple excel input processing
txtinputfile="input.txt"
ls -tr ${INPDIR}/*.xlsx > ${INPDIR}/.excel_files

grep " " ${INPDIR}/.excel_files > /dev/null
if [ $? == 0 ]
then
  echo "Renaming input file to remove space in filename."
  grep " " ${INPDIR}/.excel_files
  while read xlsinputfile
  do
    nospace=`echo $xlsinputfile | tr -d ' '`
    echo mv "$xlsinputfile" "$nospace"
    mv "$xlsinputfile" "$nospace"
  done < ${INPDIR}/.excel_files
fi

ls -tr ${INPDIR}/*.xlsx > ${INPDIR}/.excel_files

# look for xlsx files in input dir
while read xlsinputfile 
do
  echo $xlsinputfile
  ${PRSDIR}/xlsxExtractLinks.sh "${xlsinputfile}" > "${INPDIR}/${txtinputfile}"
  htmloutput="`basename "${xlsinputfile}" .xlsx`.html"
  batch "$txtinputfile" "$htmloutput"
  mv $xlsinputfile ${INPDIR}/done
done < ${INPDIR}/.excel_files

exit
