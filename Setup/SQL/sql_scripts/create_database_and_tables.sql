#CREATE DATABASE
CREATE DATABASE IF NOT EXISTS ONLINE_LEARNING_DB;

#USE DATABASE
USE ONLINE_LEARNING_DB;

#DROP TABLES
DROP TABLE IF EXISTS MASTER_DATA_TABLE_REGIME_1;
DROP TABLE IF EXISTS MASTER_DATA_TABLE_REGIME_2;
DROP TABLE IF EXISTS DATA_TABLE;
DROP TABLE IF EXISTS COEFFICIENTS;
DROP TABLE IF EXISTS PREDICTIONS;
DROP TABLE IF EXISTS TRAINING_DATA;

#CREATE DATA_TABLE
CREATE TABLE IF NOT EXISTS DATA_TABLE (
  ID MEDIUMINT NOT NULL AUTO_INCREMENT,
  X1 DOUBLE NOT NULL,
  Y DOUBLE NOT NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS TRAINING_DATA (
  ID MEDIUMINT NOT NULL,
  X1 DOUBLE NOT NULL,
  Y DOUBLE NOT NULL,
  PRIMARY KEY (`ID`)
);

#CREATE MASTER_DATA_TABLE_REGIME_1
CREATE TABLE IF NOT EXISTS MASTER_DATA_TABLE_REGIME_1 (
  ID MEDIUMINT NOT NULL AUTO_INCREMENT,
  X1 DOUBLE NOT NULL,
  Y DOUBLE NOT NULL,
  PRIMARY KEY (`ID`)
);

#CREATE MASTER_DATA_TABLE_REGIME_2
CREATE TABLE IF NOT EXISTS MASTER_DATA_TABLE_REGIME_2 (
  ID MEDIUMINT NOT NULL AUTO_INCREMENT,
  X1 DOUBLE NOT NULL,
  Y DOUBLE NOT NULL,
  PRIMARY KEY (`ID`)
);

#CREATE COEFFICIENTS TABLE
CREATE TABLE IF NOT EXISTS COEFFICIENTS (
  BETA0 DOUBLE NOT NULL,
  BETA1 DOUBLE NOT NULL
);

#CREATE PREDICTIONS TABLE
CREATE TABLE IF NOT EXISTS PREDICTIONS (
  Y DOUBLE NOT NULL,
  PRED DOUBLE NOT NULL
);

#INSERT DATA
SET GLOBAL LOCAL_INFILE = TRUE;

LOAD DATA LOCAL INFILE './Data/regime_1.csv' 
INTO TABLE MASTER_DATA_TABLE_REGIME_1
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(X1, Y);

LOAD DATA LOCAL INFILE './Data/regime_2.csv' 
INTO TABLE MASTER_DATA_TABLE_REGIME_2
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(X1, Y);