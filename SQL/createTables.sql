# This file contains draft tables for our SQL database called net_worth_db

CREATE TABLE IF NOT EXISTS userInfo (
	userID INT,
	firstName VARCHAR(45),
	lastName VARCHAR(45),
	username VARCHAR(45),
	password VARCHAR(45),
	email VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS netWorthInfo (
	userID INT,
	factor1 FLOAT,
	factor2 FLOAT,
	factor3 FLOAT,
	netWorth FLOAT
);

CREATE TABLE IF NOT EXISTS celebrityData (
	celebID INT,
	firstName VARCHAR(45),
	lastNAME VARCHAR(45),
	netWorth FLOAT,
	age INT,
	occupation VARCHAR(45),
	location VARCHAR(45)

);

