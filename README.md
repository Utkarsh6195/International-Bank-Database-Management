# International Bank Database Management
- This project showcases the application of SQL skills in managing a database for an international bank. It involves analyzing customer transactions, identifying patterns, and implementing advanced SQL functionalities to optimize database operations.

## 📌 Problem Statement
- As the database developer for an international bank, you are tasked with deriving key insights from customer data and performing various operations such as creating stored procedures, triggers, and functions. The project focuses on handling transaction data, ensuring database integrity, and generating actionable insights for decision-making.

## 📂 Datasets
- Continent: Maps regions to their unique IDs.
- Customers: Tracks customer information with region details.
- Transaction: Captures transaction details like date, type, and amount.

## ⚙️ Key Tasks and Objectives

### Data Analysis:
- Count customers in each region who transacted in 2020.
- Identify the maximum and minimum transaction amounts for each transaction type.
- Filter customer transactions with deposits exceeding $2000.

### Data Validation:
- Detect duplicate records in the Customers table.
- Find transactions with minimum deposit amounts.

### Advanced SQL Implementation:
- Develop stored procedures to:
- Retrieve customer transaction details post-June 2020.
- Insert records into the Continent table.
- Display transactions on specific dates.

### Create user-defined functions to:
- Add 10% to transaction amounts.
- Calculate total transaction amounts for specific transaction types.
- Implement table-valued functions for detailed transaction reports.

### Error Handling:
- Use TRY...CATCH blocks to manage operations, such as printing region details and handling inserts.

### Triggers and Audits:
#### Create triggers for:
- Preventing table deletion.
- Auditing table data.
- Restricting simultaneous logins with the same user ID.

### Visualization and Reporting:
- Generate pivot tables for a summary of purchases, withdrawals, and deposits.
- Display the top customers based on transaction types.

## 🚀 Project Highlights

- Stored Procedures: Automated repetitive tasks like record insertion and data retrieval.
- Error Management: Ensured robust error handling using TRY...CATCH blocks.
- Triggers: Enhanced database security and functionality with dynamic triggers.
- Functions: Simplified complex calculations and aggregated data insights.
- Pivot Tables: Visualized transaction trends effectively.

## 📖 Learnings and Insights

#### This case study helped in mastering SQL operations like:
- Query optimization.
- Building dynamic and reusable code components.
Ensuring data integrity and security with advanced SQL techniques.
