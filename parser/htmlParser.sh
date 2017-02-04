#!/bin/bash
scriptname=`basename $0 .sh`
logfile=${LOGDIR}/${scriptname}.log
parserjar=${PRSDIR}/parser.jar

id=$1
rawhtml=${RAWDIR}/${id}/${id}.html

if test -z $id 
then
  echo "Parameter required."
  exit
fi

if test ! -s "${rawhtml}"
then
  echo "Html file to parse not found [${rawhtml}]"
  exit
fi

issue_name=${RAWDIR}/${id}/${id}_issue_name
issue_detail=${RAWDIR}/${id}/${id}_issue_detail
parsedpdflink=${RAWDIR}/${id}/${id}_pdf_link

/usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=00 ${parserjar} 2> /dev/null
if [ $? != 0 ]
then
   echo "[${scriptname}] ${rawhtml} download error."
   mv ${rawhtml} ${rawhtml}.err
   exit
fi

# Parse raw html format # 1
/usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=11 ${parserjar} 2> /dev/null > ${issue_name}
if [ $? == 0 ]
then
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=12 ${parserjar} 2> /dev/null > ${issue_detail}
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=13 ${parserjar} > ${parsedpdflink} 2> /dev/null  
  echo "[${scriptname}] [$SECONDS sec] ${rawhtml} matched parse format 1"
  exit
fi

# Parse raw html format # 2 (if above fails)
/usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=21 ${parserjar} 2> /dev/null > ${issue_name}
if [ $? == 0 ]
then
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=22 ${parserjar} 2> /dev/null > ${issue_detail}
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=23 ${parserjar} > ${parsedpdflink} 2> /dev/null
  echo "[${scriptname}] [$SECONDS sec] ${rawhtml} matched parse format 2"
  exit
fi

# Parse raw html format # 3 (if above fails)
/usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=31 ${parserjar} 2> /dev/null > ${issue_name}
if [ $? == 0 ]
then
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=32 ${parserjar} 2> /dev/null > ${issue_detail}
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=33 ${parserjar} > ${parsedpdflink} 2> /dev/null
  echo "[${scriptname}] [$SECONDS sec] ${rawhtml} matched parse format 3"
  exit
fi

# Parse raw html format # 4 (if above fails)
/usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=41 ${parserjar} 2> /dev/null > ${issue_name}
if [ $? == 0 ]
then
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=42 ${parserjar} 2> /dev/null > ${issue_detail}
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=43 ${parserjar} > ${parsedpdflink} 2> /dev/null
  echo "[${scriptname}] [$SECONDS sec] ${rawhtml} matched parse format 4"
  exit
fi

# Parse raw html format # 5 (if above fails)
/usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=51 ${parserjar} 2> /dev/null > ${issue_name}
if [ $? == 0 ]
then
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=52 ${parserjar} 2> /dev/null > ${issue_detail}
  /usr/bin/java -ea -DlogFileName=${logfile} -DinputFile="${rawhtml}" -jar -DparseFormat=53 ${parserjar} > ${parsedpdflink} 2> /dev/null
  echo "[${scriptname}] [$SECONDS sec] ${rawhtml} matched parse format 5"
  exit
fi


echo "[${scriptname}] [$SECONDS sec] ${rawhtml} unknown parse format"

rm ${issue_name} 
rm ${issue_detail}
rm ${parsedpdflink}

