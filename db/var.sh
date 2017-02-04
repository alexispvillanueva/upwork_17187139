
if [ -z ${id} ]
then
  echo "[${scriptname}] [$SECONDS sec] ${rawhtml} no ID parameter"
  exit
fi

IDDIR=${RAWDIR}/${id}

issue_name=${IDDIR}/${id}_issue_name
cusip=${IDDIR}/${id}_cusip.png
issue_detail=${IDDIR}/${id}_issue_detail
fitch=${IDDIR}/${id}_rating_fitch.png
kbra=${IDDIR}/${id}_rating_kbra.png
moodys=${IDDIR}/${id}_rating_moody.png
sp=${IDDIR}/${id}_rating_sp.png
pdffirstpage=${IDDIR}/${id}-1.pdf
issue_amount=${IDDIR}/${id}_issue_amount
sources_uses_page=${IDDIR}/${id}_pages
dsrf=${IDDIR}/${id}_dsrf
def_pages=${IDDIR}/${id}_def_pages
inv_pages=${IDDIR}/${id}_inv_pages

DETAILS_NAME=${IDDIR}/${id}_DETAILS_NAME.txt
DATED_DATE=${IDDIR}/${id}_DATED_DATE.txt
CUSIP=${IDDIR}/${id}_CUSIP.txt
MATURITY_DATE=${IDDIR}/${id}_MATURITY_DATE.txt
INTEREST_RATE=${IDDIR}/${id}_INTEREST_RATE.txt
INITIAL_OFFER_PRICE=${IDDIR}/${id}_INITIAL_OFFER_PRICE.txt
SECURITY_DESC=${IDDIR}/${id}_SECURITY_DESC.txt
FITCH_RATING=${IDDIR}/${id}_FITCH_RATING.txt
KBRA_RATING=${IDDIR}/${id}_KBRA_RATING.txt
MOODYS_RATING=${IDDIR}/${id}_MOODYS_RATING.txt
SP_RATING=${IDDIR}/${id}_SP_RATING.txt
FRONT_PAGE=${IDDIR}/${id}_FRONT_PAGE.txt
ISSUE_AMOUNT=${IDDIR}/${id}_ISSUE_AMOUNT.txt
SOURCES_AND_USES_PAGE=${IDDIR}/${id}_SOURCES_AND_USES_PAGE.txt
DSRF_AMOUNT=${IDDIR}/${id}_DSRF_AMOUNT.txt
DSRF_PAGE=${IDDIR}/${id}_DSRF_PAGE.txt
DEFINITIONS_PAGE=${IDDIR}/${id}_DEFINITIONS_PAGE.txt
INVESTMENTS_PAGE=${IDDIR}/${id}_INVESTMENTS_PAGE.txt

