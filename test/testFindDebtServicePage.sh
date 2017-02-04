#!/bin/bash

export PRSDIR="../parser"
export LOG=1

for file in `ls ../raw/*.txt | grep "\-[0-9]*.txt" | grep -v "\-0.txt"`
do
  echo $file
  ../parser/findDebtServicePage.sh $file
  echo 
done

