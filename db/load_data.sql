LOAD DATA INFILE '/Users/aleisha/Documents/ODesk/20161023_Shannon_Scraper/msrb/db/sample.txt' 
REPLACE
INTO TABLE msrb.ISSUES
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
(
 ID,
 DETAILS_NAME
); 

