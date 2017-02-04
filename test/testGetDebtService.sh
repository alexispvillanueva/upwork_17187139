#!/bin/bash

for file in `ls ../raw/*.txt | grep "\-[0-9]*.txt" | grep -v "\-0.txt"`
do
  echo $file
  ../parser/getDebtService.sh $file
  echo $?
done

