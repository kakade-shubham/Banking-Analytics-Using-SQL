SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS Banking_Analytics_using_SQL;

USE Banking_Analytics_using_sql;

SHOW TABLES;

CREATE TABLE IF NOT EXISTS Banking_Data
(
	`Customer ID` INT,
    `First Name` VARCHAR(50),
    `Last Name` VARCHAR(50),
    `Age` INT,
    `Gender` VARCHAR(10),
    `Address` VARCHAR(100),
    `City` VARCHAR(50),
    `Contact Number` VARCHAR(15),
    `Email` VARCHAR(50),
    `Account Type` VARCHAR(20),
    `Account Balance` DECIMAL(10,2),
    `Date Of Account Opening` DATE, -- Datatype taken Varchar because date format available in CSV is M/D/Y, Mysql supports Y-M-D format
    `Last Transaction Date` DATE,
    `Branch ID` INT,
    `TransactionID` INT,
    `Transaction Date` DATE,
    `Transaction Type` VARCHAR(10),
	`Transaction Amount` DECIMAL(10,2),
	`Account Balance After Transaction` DECIMAL(10,2),
    `Loan ID` INT,
    `Loan Amount` DECIMAL(10,2),
    `Loan Type` VARCHAR(50),
    `Interest Rate` DECIMAL(5,2),
	`Loan Term` INT,
    `Approval_Rejection Date` DATE,
    `Loan Status` VARCHAR(20),
    `CardID` INT,
    `Card Type` VARCHAR(20),
    `Credit Limit` DECIMAL(10,2),
    `Credit Card Balance` DECIMAL(10,2),
    `Minimum Payment Due` DECIMAL(10,2),
    `Payment Due Date` DATE,
    `Last Credit Card Payment Date` DATE,
    `Rewards Points` INT,
    `Feedback ID` INT,
    `Feedback Date` DATE,
    `Feedback Type` VARCHAR(50),
    `Resolution Status` VARCHAR(20),
    `Resolution Date` DATE,
    `Anomaly` VARCHAR(10)
);

DROP TABLE Banking_Data;

DESCRIBE Banking_Data;

SELECT * FROM Banking_Data;

-- Creating Customer Table
CREATE TABLE Customers
(
	`Customer ID` INT PRIMARY KEY,
    `First Name` VARCHAR(50),
    `Last Name` VARCHAR(50),
    `Age` INT,
    `Gender` VARCHAR(10),
    `Address` VARCHAR(100),
    `City` VARCHAR(50),
    `Contact Number` VARCHAR(15),
    `Email` VARCHAR(50)
);

-- Creating Accounts Table
CREATE TABLE Accounts
(
	`Account ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Customer ID` INT,
	`Account Type` VARCHAR(20),
    `Account Balance` DECIMAL(10,2),
    `Date Of Account Opening` DATE,
    `Last Transaction Date` DATE,
    `Branch ID` INT,
    CONSTRAINT FK_CustAccount
    FOREIGN KEY(`Customer ID`) REFERENCES Customers(`Customer ID`)
);

-- Creating Transaction Table
CREATE TABLE Transactions
(
	`TransactionID` INT PRIMARY KEY,
    `Account ID` INT,
    `Transaction Date` DATE,
    `Transaction Type` VARCHAR(10),
	`Transaction Amount` DECIMAL(10,2),
	`Account Balance After Transaction` DECIMAL(10,2),
    CONSTRAINT FK_AccountTrans
    FOREIGN KEY(`Account ID`) REFERENCES Accounts(`Account ID`)
);

-- Creating Loans Table
CREATE TABLE Loans
(
	`Loan ID` INT PRIMARY KEY,
    `Customer ID` INT,
    `Loan Amount` DECIMAL(10,2),
    `Loan Type` VARCHAR(50),
    `Interest Rate` DECIMAL(5,2),
	`Loan Term` INT,
    `Approval_Rejection Date` DATE,
    `Loan Status` VARCHAR(20),
    CONSTRAINT FK_LoanCust
    FOREIGN KEY(`Customer ID`) REFERENCES Customers(`Customer ID`)
);

-- Creating Credit card Table
CREATE TABLE CreditCards
(
	`CardID` INT PRIMARY KEY,
	`Customer ID` INT,
    `Card Type` VARCHAR(20),
    `Credit Limit` DECIMAL(10,2),
    `Credit Card Balance` DECIMAL(10,2),
    `Minimum Payment Due` DECIMAL(10,2),
    `Payment Due Date` DATE,
    `Last Credit Card Payment Date` DATE,
    `Rewards Points` INT,
    CONSTRAINT FK_CustCredit
    FOREIGN KEY(`Customer ID`) REFERENCES Customers(`Customer ID`)
);


-- Creating Feedback Table
CREATE TABLE Feedback
(
	`Feedback ID` INT PRIMARY KEY,
    `Customer ID` INT,
    `Feedback Date` DATE,
    `Feedback Type` VARCHAR(50),
    `Resolution Status` VARCHAR(20),
    `Resolution Date` DATE,
    CONSTRAINT FK_CustFeedback
    FOREIGN KEY(`Customer ID`) REFERENCES Customers(`Customer ID`)
);

SELECT * FROM Customers;
DESCRIBE Customers;

SELECT * FROM CreditCards;
DESCRIBE Creditcards;

SELECT * FROM Feedback;
DESCRIBE Feedback;

SELECT * FROM Accounts;
DESCRIBE Accounts;

SELECT * FROM Loans;
DESCRIBE Loans;

SELECT * FROM Transactions;
DESCRIBE Transactions;

-- Inserting data into the Customers table
INSERT INTO Customers
SELECT DISTINCT `Customer ID`, `First Name`, `Last Name`,`Age`,`Gender`,`Address`,`City`,`Contact Number`,`Email`
FROM Banking_Data;

-- Inserting data into the Accounts table
INSERT INTO Accounts
(`Customer ID`,`Account Type`,`Account Balance`,`Date Of Account Opening`,`Last Transaction Date`,`Branch ID`)
SELECT DISTINCT `Customer ID`,`Account Type`,`Account Balance`,`Date Of Account Opening`,`Last Transaction Date`,`Branch ID`
FROM Banking_Data;

-- Insrting data into Transaction table
INSERT INTO Transactions
SELECT DISTINCT 
	`TransactionID`,
	`Account ID`,
    `Transaction Date`,
    `Transaction Type`,
    `Transaction Amount`,
    `Account Balance After Transaction` 
FROM Banking_Data AS B
INNER JOIN Accounts AS A
ON B.`Customer ID` = A.`Customer ID`
AND B.`Account Type` = A.`Account Type`
AND B.`Branch ID` = A.`Branch ID`;

-- Inserting data into Load table
INSERT INTO Loans
SELECT DISTINCT `Loan ID`,`Customer ID`,`Loan Amount`,`Loan Type`,`Interest Rate`,`Loan Term`,`Approval_Rejection Date`,`Loan Status`
FROM Banking_Data
WHERE 'Loan ID' IS NOT NULL;

-- Inserting data into Creditcard table
INSERT INTO Creditcards 
SELECT DISTINCT `CardID`,`Customer ID`,`Card Type`,`Credit Limit`,`Credit Card Balance`,`Minimum Payment Due`,
`Payment Due Date`,`Last Credit Card Payment Date`,`Rewards Points`
FROM Banking_Data
WHERE `CardID` IS NOT NULL;

-- Inserting data into Feedback table
INSERT INTO Feedback
SELECT DISTINCT `Feedback ID`,`Customer ID`,`Feedback Date`,`Feedback Type`,`Resolution Status`,`Resolution Date`
FROM Banking_Data
WHERE `Feedback Id` IS NOT NULL;

