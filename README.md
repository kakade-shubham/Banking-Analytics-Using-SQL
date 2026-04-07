🏦 Banking Analytics SQL Project

📌 Project Overview
This project focuses on analyzing banking data to uncover insights into customer behavior, transaction trends, loan performance, credit card usage, and potential risk patterns.
The goal is to simulate a real-world banking scenario and apply SQL skills to support data-driven decision-making.

________________________________________
🎯 Objectives
•	Analyze customer demographics and distribution
•	Identify high-value customers and transaction behavior
•	Monitor transaction trends over time
•	Detect potential fraud or risk patterns
•	Evaluate loan performance and risk categories
•	Analyze credit card usage and payment behavior

________________________________________
📂 Dataset Information
•	Source: Kaggle (https://www.kaggle.com/datasets/alanjo/comprehensive-banking-database?select=Comprehensive_Banking_Database.csv)
•	Dataset Name: Comprehensive Banking Database
•	Records: 5,000 rows
•	Features: 40 columns

The dataset includes:
•	Customer details
•	Account information
•	Transactions
•	Loan data
•	Credit card usage
•	Feedback and anomaly flags
________________________________________

🏗️ Database Design
“I transformed a denormalized dataset into normalized relational tables to improve query efficiency and maintain data integrity.”

Tables Created:
•	Customers – Stores customer demographic details
•	Accounts – Stores account related information
•	Transactions – Stores transaction records
•	Loans – Stores loan details
•	CreditCards – Stores credit card information
•	Feedback – Stores customer feedback and resolution status

Key Concepts Used:
•	Primary Keys & Foreign Keys
•	Data normalization
•	Surrogate key creation (AccountID)
•	Table relationships

________________________________________
🛠️ Tools & Technologies
•	SQL (MySQL)
•	MySQL Workbench
•	Excel / Power Query (for data cleaning)
•	GitHub (for project hosting)

________________________________________
📊 Key SQL Concepts Applied
•	Joins (INNER JOIN, multiple table joins)
•	Aggregations (SUM, AVG, COUNT)
•	GROUP BY & HAVING
•	Subqueries
•	Common Table Expressions (CTE)
•	Window Functions (RANK, ROW_NUMBER, RUNNING TOTAL)

________________________________________
🔍 Analysis & Insights

👤 Customer Analysis
•	Identified top customers contributing to total account balances
•	Observed customer distribution across cities
•	Highlighted key customer segments for potential targeting

________________________________________
💸 Transaction Analysis
•	Analyzed monthly and daily transaction trends
•	Identified customers with highest transaction activity
•	Measured average transaction value

________________________________________
🚨 Fraud & Risk Analysis
•	Detected high-value and above-average transactions
•	Identified accounts with unusually high transaction frequency
•	Flagged potential anomalies for further investigation

________________________________________
🏦 Loan Analysis
•	Analyzed loan distribution by status and type
•	Identified high-risk loans (Rejected/Pending)
•	Evaluated average loan amounts across categories

________________________________________
💳 Credit Card Analysis
•	Identified customers close to credit limits
•	Detected overdue payments
•	Analyzed credit usage behavior

________________________________________
📝 Feedback Analysis
•	Identified common customer complaints through feedback type analysis  
•	Evaluated resolution status to measure the effectiveness of issue handling  
•	Analyzed average resolution time to assess customer support performance 

________________________________________
📈 Sample Business Insights
•	A small percentage of customers contribute significantly to total balances (high-value segment)
•	Transaction activity shows consistent patterns with occasional spikes
•	Certain accounts exhibit unusually high transaction frequency, indicating potential risk
•	A portion of loans falls under high-risk categories, requiring stricter evaluation
•	Some customers are nearing credit limits, indicating potential financial stress

________________________________________
🚀 How to Run the Project
1.	Import dataset into MySQL
2.	Create tables using Schema - Banking Analytics using SQL.sql
3.	Insert data into normalized tables
4.	Run queries from Insights_Questions.sql

________________________________________
💼 Key Learnings
•	Designed a normalized relational database from a flat dataset
•	Applied advanced SQL techniques for real-world analysis
•	Developed business-oriented insights from raw data
•	Improved problem-solving and data interpretation skills

________________________________________
🔗 Future Improvements
•	Build interactive dashboards using Power BI / Tableau
•	Add predictive analytics for risk detection
•	Automate data pipeline

________________________________________
🙌 Conclusion
•	This project demonstrates the practical application of SQL in a banking domain, covering data cleaning, database design, and analytical problem-solving.
•	It reflects real-world scenarios relevant to financial institutions and data analyst roles.
________________________________________
