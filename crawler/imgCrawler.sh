#!/bin/bash
scriptname=`basename $0 .sh`

id=$1
issue_detail=${RAWDIR}/${id}/${id}_issue_detail

if [ ! -s "${issue_detail}" ]
then
  echo "[${scriptname}] [$SECONDS sec] ${issue_detail} is empty or not found"
  exit 1
fi

download() {

  rawpng=$1
  pnglink=$2
  echo "[${scriptname}] ${rawpng} downloading"
  test ! -s "${rawpng}" &&  /usr/bin/java -ea -DspringConfig="png" -Dpng="$pnglink" -DlogFileName=${LOGDIR}/${scriptname}.log -Did="${id}" -DfileName="$rawpng" -DsaveCookies=true -jar ${CRWDIR}/crawler.jar 2> /dev/null

  if [ -s "${rawpng}" ]
  then
    echo "[${scriptname}] [$SECONDS sec] ${rawpng} download complete"
  else 
    echo "[${scriptname}] [$SECONDS sec] ${rawpng} download error"
  fi

}

# Get CUSIP
pnglink=`sort -k 2,3 ${issue_detail} | tail -1 | cut -f1 | grep ImageGenerator | sed 's/^..//g'`

if [ ! -z ${pnglink} ] 
then

  rawpng="${RAWDIR}/${id}/${id}_cusip.png"
  download $rawpng $pnglink

fi

# Get Current Fitch LT Rating
pnglink=`sort -k 2,3 ${issue_detail} | tail -1 | cut -f6 | grep ImageGenerator | sed 's/^..//g'`

if [ ! -z ${pnglink} ]
then
  rawpng="${RAWDIR}/${id}/${id}_rating_fitch.png"
  download $rawpng $pnglink
fi

# Get Current KBRA LT Rating
pnglink=`sort -k 2,3 ${issue_detail} | tail -1 | cut -f7 | grep ImageGenerator | sed 's/^..//g'`

if [ ! -z ${pnglink} ]
then
  rawpng="${RAWDIR}/${id}/${id}_rating_kbra.png"
  download $rawpng $pnglink
fi

# Get Current Moody's LT Rating
pnglink=`sort -k 2,3 ${issue_detail} | tail -1 | cut -f8 | grep ImageGenerator | sed 's/^..//g'`

if [ ! -z ${pnglink} ]
then
  rawpng="${RAWDIR}/${id}/${id}_rating_moody.png"
  download $rawpng $pnglink
fi

# Get Current S&P LT Rating
pnglink=`sort -k 2,3 ${issue_detail} | tail -1 | cut -f9 | grep ImageGenerator | sed 's/^..//g'`

if [ ! -z ${pnglink} ]
then
  rawpng="${RAWDIR}/${id}/${id}_rating_sp.png"
  download $rawpng $pnglink
fi
