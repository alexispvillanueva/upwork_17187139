#!/bin/bash
scriptname=`basename $0 .sh`

id=$1
IDDIR=${RAWDIR}/${id}

. ${DBDIR}/var.sh

getBaseName() {
  I=$1
  O=$2

  if [ -s ${I} ]
  then
    basename ${I} > ${O}
  fi
}

#1) DETAILS_NAME
#2) DATED_DATE
if [ -s ${issue_name} ] 
then
  cut -f1 ${issue_name} > ${DETAILS_NAME}
  cut -f2 ${issue_name} | grep "[0-9]" > ${DATED_DATE}
fi

#3) CUSIP
getBaseName ${cusip} ${CUSIP}

#4) MATURITY_DATE
#5) INTEREST_RATE
#6) INITIAL_OFFER_PRICE
#7) SECURITY_DESC
if [ -s ${issue_detail} ]
then
  sort -k 2,3 ${issue_detail} | tail -1 | cut -f2 > ${MATURITY_DATE}
  sort -k 2,3 ${issue_detail} | tail -1 | cut -f3 | grep "[0-9]" > ${INTEREST_RATE}
  sort -k 2,3 ${issue_detail} | tail -1 | cut -f4 | grep "[0-9]" > ${INITIAL_OFFER_PRICE}
  sort -k 2,3 ${issue_detail} | tail -1 | cut -f5 > ${SECURITY_DESC}
fi

#8) FITCH_RATING
getBaseName ${fitch} ${FITCH_RATING}

#9) KBRA_RATING
getBaseName ${kbra} ${KBRA_RATING}

#10) MOODYS_RATING
getBaseName ${moodys} ${MOODYS_RATING}

#11) SP_RATING
getBaseName ${sp} ${SP_RATING}

#12) FRONT_PAGE
getBaseName ${pdffirstpage} ${FRONT_PAGE}

#13) ISSUE_AMOUNT
awk 'BEGIN{ORS=" "};{print $0}' ${issue_amount} | sed "s/ $//g" > ${ISSUE_AMOUNT}

#14) SOURCES_AND_USES_PAGE
if [ -s ${sources_uses_page} ]
then
  sort -n ${sources_uses_page} | awk 'BEGIN{ORS=" "};{print $0}' | sed "s/ $//g" > ${SOURCES_AND_USES_PAGE}
fi

#15) DSRF_AMOUNT
#16) DSRF_PAGE
if [ -s ${dsrf} ]
then
  awk 'BEGIN{ORS=" "};{if ($0 !~ /pdf/) print $0}' ${dsrf} | sed "s/ $//g" > ${DSRF_AMOUNT}
  awk '{if ($0 ~ /pdf/) print $0}' ${dsrf} > ${DSRF_PAGE}
fi

#17) DEFINITIONS_PAGE
grep pdf  ${def_pages} | sort -n |awk 'BEGIN{ORS=" "};{print $0}' | sed "s/ $//g" > ${DEFINITIONS_PAGE}

#18) INVESTMENTS PAGE
grep pdf  ${inv_pages} | sort -n |awk 'BEGIN{ORS=" "};{print $0}' | sed "s/ $//g" > ${INVESTMENTS_PAGE}


# Generate SQL

L=`wc -l ${DBDIR}/fields.txt | awk '{print $1}'`
echo "INSERT INTO msrb.ISSUES ("
echo "  ID,"
for F in `cut -d, -f1 ${DBDIR}/fields.txt `
do
  test -s ${IDDIR}/${id}_${F}.txt && echo "  $F,"
done
echo "  CREATED_DATE"

echo ") VALUES ("
echo "  '$id',"
for FC in `cat ${DBDIR}/fields.txt `
do
  F=`echo $FC | cut -d, -f1`
  C=`echo $FC | cut -d, -f2`
  if [ "$F" != "MATURITY_DATE" ] && [ "$F" != "DATED_DATE" ]
  then
    test -s ${IDDIR}/${id}_${F}.txt && echo "  '`cut -c1-${C} ${IDDIR}/${id}_${F}.txt`',"
  else 
    test -s ${IDDIR}/${id}_${F}.txt && echo "  STR_TO_DATE('`cat ${IDDIR}/${id}_${F}.txt`','%m/%d/%Y'),"
  fi
done
echo "  CURRENT_TIMESTAMP()"
echo ") ON DUPLICATE KEY UPDATE "

for FC in `cat ${DBDIR}/fields.txt `
do
  F=`echo $FC | cut -d, -f1`
  C=`echo $FC | cut -d, -f2`
  if [ "$F" != "MATURITY_DATE" ] && [ "$F" != "DATED_DATE" ]
  then
    test -s ${IDDIR}/${id}_${F}.txt && echo "  $F = '`cut -c1-${C} ${IDDIR}/${id}_${F}.txt`',"
  else 
    test -s ${IDDIR}/${id}_${F}.txt && echo "  $F = STR_TO_DATE('`cat ${IDDIR}/${id}_${F}.txt`','%m/%d/%Y'),"
  fi
done
echo "  UPDATED_DATE = CURRENT_TIMESTAMP()"

echo "; commit;"




