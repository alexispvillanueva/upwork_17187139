#!/bin/bash
logfile=`basename $0 .sh`
sheet="$1"
column="$2"
filename="$3"

/usr/bin/java -jar -ea -DlogFileName=${LOGDIR}/${logfile}.log -Dworksheet="${sheet}" -Dcolumn="${column}" -Dfilename="${filename}"  ${PRSDIR}/reader.jar 
