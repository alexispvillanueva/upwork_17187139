#!/bin/bash
scriptname=`basename $0 .sh`

txtnpage="$1"

# PATTERN 1 {debt service reserve.*,[0-9][0-9][0-9]}
awk 'BEGIN{FOUND="false"; N=0};{

  if(GETNEXT==1) {
    if($0 ~ /,[0-9][0-9][0-9]/) {
      for (i=1; i<=NF; i++) {
        if($i ~ /,[0-9][0-9][0-9]/) {
          print $i;
        }
      }
      FOUND="true"
      exit 0
    }

    if($0 ~ /[a-z]/) {
      FOUND="false"
      GETNEXT=0
    }
  };

  if(tolower($0) ~ /debt service reserve/ || tolower($0) ~ /deposit to.*reserve/) {
    if($0 !~ /,[0-9][0-9][0-9]/) {
      GETNEXT=1
    } else {
      for (i=1; i<=NF; i++) {
        gsub(/\.\.*\./,"",$i)
        if($i ~ /,[0-9][0-9][0-9]/) print $i;
      }
      FOUND="true"
      exit 0
    }
  }

};END{
  if(FOUND == "false") {
    exit 1
  }
}' ${txtnpage}

if [ $? == "0" ]
then
  (>&2 echo "[${scriptname}] ${txtnpage} matched pattern 1")
  exit 0
fi


# PATTERN 2 {debt service reserve.*,[0-9][0-9][0-9]}
awk 'BEGIN{FOUND="false"; N=0};{

  if(GETNEXT==1) {
    if($0 ~ /,[0-9][0-9][0-9]/) {
      for (i=1; i<=NF; i++) {
        if($i ~ /,[0-9][0-9][0-9]/) {
          print $i;
        }
      }
      FOUND="true"
      exit 0
    }

    if($0 ~ /[a-z]/) {
      FOUND="false"
      GETNEXT=0
    }
  };

  if(tolower($0) ~ /debt service/) {
    if($0 !~ /,[0-9][0-9][0-9]/) {
      GETNEXT=1
    } else {
      for (i=1; i<=NF; i++) {
        gsub(/\.\.*\./,"",$i)
        if($i ~ /,[0-9][0-9][0-9]/) print $i;
      }
      FOUND="true"
      exit 0
    }
  }

};END{
  if(FOUND == "false") {
    exit 1
  }
}' ${txtnpage}

if [ $? == "0" ]
then
  (>&2 echo "[${scriptname}] ${txtnpage} matched pattern 2")
  exit 0
fi

(>&2 echo "[${scriptname}] ${txtnpage} no pattern matched")
exit 1



