DROP TABLE `msrb`.`ISSUES`;

CREATE TABLE `msrb`.`ISSUES` (
  `ID` VARCHAR(50) NOT NULL,
  `DETAILS_NAME` VARCHAR(500) NULL,
  `DATED_DATE` DATE NULL,
  `CUSIP` VARCHAR(60) NULL,
  `MATURITY_DATE` DATE NULL,
  `INTEREST_RATE` FLOAT NULL,
  `INITIAL_OFFER_PRICE` FLOAT NULL,
  `SECURITY_DESC` VARCHAR(100) NULL,
  `FITCH_RATING` VARCHAR(60) NULL,
  `KBRA_RATING` VARCHAR(60) NULL,
  `MOODYS_RATING` VARCHAR(60) NULL,
  `SP_RATING` VARCHAR(60) NULL,
  `FRONT_PAGE` VARCHAR(60) NULL,
  `ISSUE_AMOUNT` VARCHAR(100) NULL,
  `SOURCES_AND_USES_PAGE` VARCHAR(60) NULL,
  `DSRF_AMOUNT` VARCHAR(100) NULL,
  `DSRF_PAGE` VARCHAR(60) NULL,
  `DEFINITIONS_PAGE` VARCHAR(60) NULL,
  `CREATED_DATE` datetime NULL,
  `UPDATED_DATE` datetime NULL,
  PRIMARY KEY (`ID`));
