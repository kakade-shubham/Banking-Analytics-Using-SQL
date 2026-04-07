----------------------- 👤 Customer Analysis -----------------------

-- 1.	What is the total number of customers? 
SELECT COUNT(`customer ID`) AS Total_Customers
FROM Customers;

-- 2.	How many customers are there in each city? 
SELECT City,COUNT(*) AS Total_customer
FROM customers
GROUP BY City
ORDER BY Total_Customer DESC;

-- 3.Who are the top 5 customers based on total account balance?
SELECT C.`Customer ID`,
	`First Name`,
    `Last Name`,
    A.`Account ID`,
    `Account Type`,
	SUM(`Account Balance`) AS Total_Balance
FROM Customers AS C
INNER JOIN Accounts AS A
ON C.`Customer ID` = A.`Customer ID`
GROUP BY C.`Customer ID`,`First Name`,`Last Name`
ORDER BY Total_Balance DESC
LIMIT 5;


----------------------- 💸 Transaction Analysis -----------------------

-- 1. What is the monthly transaction trend?
SELECT DATE_FORMAT(`Transaction Date`,'%Y - %m') AS `Year & Month`,
	COUNT(*) AS Total_Transactions,
	SUM(`Transaction Amount`) AS Total_Amount
FROM Transactions
GROUP BY `Year & Month`
ORDER BY `Year & Month`;

-- 2.	What is the average transaction amount?
SELECT ROUND(AVG(`Transaction Amount`),1) AS Average_amount
FROM Transactions;

-- 3.	Who are the top 5 customers based on transaction count?
SELECT C.`Customer ID`,
	C.`First Name`,
	C.`Last Name`,
    COUNT(T.`TransactionID`) AS Total_transactions
FROM Transactions AS T
INNER JOIN Accounts AS A
ON T.`Account ID` = A.`Account ID`
INNER JOIN Customers AS C
ON C.`Customer ID` = A.`Customer ID`
GROUP BY C.`Customer ID`,C.`First Name`,C.`Last Name`
ORDER BY Total_transactions DESC
LIMIT 5;


-- 4.	What is the daily transaction amount trend?
SELECT `Transaction Date`,
    COUNT(*) AS Total_transactions,
    SUM(`Transaction Amount`) AS Total_Amount
FROM Transactions
GROUP BY `Transaction Date`
ORDER BY `Transaction Date` ASC;

-- OR

SELECT `Transaction Date`,	
    COUNT(*) AS Total_Count,
    SUM(`Transaction Amount`) AS Total_transactions
FROM Transactions
GROUP BY `Transaction Date`	
ORDER BY `Transaction Date` ASC;


----------------------- 🚨 Fraud / Risk Analysis -----------------------

-- 1.	Which transactions are high-value transactions (greater than 3,000)? 
SELECT *
FROM Transactions
WHERE `Transaction Amount` > 3000
ORDER BY `Transaction Amount` DESC;

-- 2.	Which transactions are above the average transaction amount?
-- Using Sub-queries
SELECT *
FROM Transactions
WHERE `Transaction Amount` >
(
	SELECT ROUND(AVG(`Transaction Amount`),2)
	FROM Transactions
);

-- Using Window Function
SELECT Row_Number() OVER() AS `Sr.No`,
	Temp.*
FROM 
	(
		SELECT *,
			ROUND(AVG(`Transaction Amount`) OVER(),2) AS Average_Amount
			FROM Transactions
	) AS Temp 
WHERE `Transaction Amount` > Average_Amount;

-- 3.	Which accounts have multiple transactions on the same day (more than 3)?
SELECT `Account ID`, `Transaction Date`,COUNT(*) AS Total_Count
FROM transactions
GROUP BY `Account ID`,`Transaction Date`
HAVING COUNT(*) > 3
ORDER BY Total_Count DESC;

-- 4.	Which customers have very high transaction frequency? 
SELECT `Account ID`,`Transaction Date`,COUNT(*) AS Trans_Frequency
FROM Transactions
GROUP BY `Transaction Date`,`Account ID`
HAVING COUNT(*) > 50
ORDER BY Trans_Frequency DESC;

-- OR

SELECT C.`Customer ID`,
	`First Name`,
	`Last Name`,
    COUNT(T.`TransactionID`) AS Transaction_Count
FROM Customers AS C
INNER JOIN Accounts AS A
ON C.`Customer ID` = A.`Customer ID`
INNER JOIN Transactions AS T
ON T.`Account ID` = A.`Account ID`
GROUP BY C.`Customer ID`,`First Name`,`Last Name`
HAVING 	COUNT(T.`TransactionID`) > 10
ORDER BY Transaction_Count DESC;


----------------------- 🏦 Loan Analysis -----------------------

-- 1. What is the distribution of loan statuses? 
SELECT `Loan Status`,COUNT(*) AS Total_Count
FROM Loans
GROUP BY `Loan Status`
ORDER BY Total_Count DESC;

-- 2. What is the total loan amount by loan type?
SELECT `Loan Type`,SUM(`Loan Amount`) AS Total_Amount
FROM Loans
GROUP BY `Loan Type`
ORDER BY Total_Amount DESC;

-- 3. Which loans are high-risk (Rejected or Pending)? 
SELECT *
FROM Loans
WHERE `Loan Status` IN ('Rejected','Pending');


----------------------- 💳 Credit Card Analysis -----------------------

-- 1. Which customers are close to their credit limit (above 80%)?
SELECT C1.`Customer ID`,
	`First Name`,
    `Last Name`,
    `Card Type`,
    `Credit Limit`,
    `Credit Card Balance`
FROM Customers AS C1
INNER JOIN CreditCards AS C2
ON C1.`Customer ID` = C2.`Customer ID`
WHERE `Credit Card Balance` > `Credit Limit` * 0.8;

-- OR

SELECT *
FROM CreditCards
WHERE `Credit Card Balance` > `Credit Limit` * 0.8;
	

-- 2. Which customers have overdue credit card payments? 
SELECT *
FROM CreditCards
WHERE Current_date() > `Payment Due Date`;


----------------------- 📝 Feedback Analysis -----------------------

-- 1. What is the count of feedback by feedback type?
SELECT `Feedback Type`, COUNT(*) AS Total_Count
FROM Feedback
GROUP BY `Feedback Type`
ORDER BY Total_Count DESC;

-- 2. What is the distribution of resolution status? 

SELECT `Resolution Status`,COUNT(*) AS Total_resolution_Count
FROM Feedback
GROUP BY `Resolution Status`;

-- 3. What is the average resolution time for feedback?

SELECT AVG(DATEDIFF(`Feedback Date`,`Resolution Date`)) AS Avg_Days
FROM Feedback
WHERE `Resolution Date` IS NOT NULL;


----------------------- 🔥 Advanced Analysis -----------------------

-- 1.	How can customers be ranked based on total account balance?
SELECT `Customer ID`, 
	`Account Type`,
	SUM(`Account Balance`) AS Total_Balance,
    Rank() OVER(ORDER BY SUM(`Account Balance`) DESC)AS Account_Balance
FROM Accounts
GROUP BY `Customer ID`,`Account Type`;


-- 2.	What is the running total of transactions over time? 
SELECT `TransactionID`,
	`Transaction Date`,
	SUM(`Transaction Amount`) OVER(ORDER BY `Transaction Date`) AS Running_Total
FROM Transactions;