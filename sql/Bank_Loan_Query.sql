USE Bank_Loan_DB

SELECT * FROM Bank_Loan_Data

-- TOTAL LOAN APPLICATION 

SELECT COUNT(id) AS Total_Loan_Applications
FROM Bank_Loan_Data 

-- Month-To-Date (MTD) TOTAL LOAN APPLICATION

SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM Bank_Loan_Data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- Previous Month-To-Date (PMTD) TOTAL LOAN APPLICATION

SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM Bank_Loan_Data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Total Funded Amount

SELECT SUM(loan_amount) AS Total_Amount
FROM Bank_Loan_Data

-- MTD Total Funded Amount

SELECT SUM(loan_amount) AS MTD_Total_Amount
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Total Funded Amount

SELECT SUM(loan_amount) AS PMTD_Total_Amount
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Total Amount Received

SELECT SUM(total_payment) AS Total_Payment
FROM Bank_Loan_Data

-- MTD Total Amount Received

SELECT SUM(total_payment) AS MTD_Total_Payment
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Total Amount Received

SELECT SUM(total_payment) AS PMTD_Total_Payment
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Average Interest Rate

SELECT ROUND(AVG(int_rate) * 100,2)  AS Avg_Interest_Rate
FROM Bank_Loan_Data

-- MTD Average Interest Rate

SELECT ROUND(AVG(int_rate) * 100,2)  AS MTD_Avg_Interest_Rate
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Average Interest Rate

SELECT ROUND(AVG(int_rate) * 100,2)  AS PMTD_Avg_Interest_Rate
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

 
-- AVG Debt-to_Income Ratio (DTI)

SELECT ROUND(AVG(DTI) * 100,2)  AS Avg_DTI
FROM Bank_Loan_Data

-- MTD AVG Debt-to_Income Ratio (DTI)

SELECT ROUND(AVG(DTI) * 100,2)  AS MTD_Avg_DTI
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD AVG Debt-to_Income Ratio (DTI)

SELECT ROUND(AVG(DTI) * 100,2)  AS PMTD_Avg_DTI
FROM Bank_Loan_Data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021



-- GOOD LOAN APPLICATION
SELECT COUNT(id)  AS Good_loan_application
FROM Bank_Loan_Data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
 

-- GOOD LOAN PERCENTAGE

SELECT 
     (COUNT( CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)* 100)
     / COUNT(id) AS Good_loan_percentage
FROM Bank_Loan_Data

-- Good Loan Funded Amount

SELECT SUM(loan_amount)  AS Good_loan_funded_Amount
FROM Bank_Loan_Data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-- Good Loan Received Amount

SELECT SUM(total_payment)  AS Good_loan_Received
FROM Bank_Loan_Data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'



-- BAD LOAN APPLICATION
SELECT COUNT(id)  AS Bad_loan_application
FROM Bank_Loan_Data
WHERE loan_status = 'Charged Off'
 


-- BAD LOAN PERCENTAGE
SELECT 
     (COUNT( CASE WHEN loan_status = 'Charged Off' THEN id END)* 100)
     / COUNT(id) AS Bad_loan_percentage
FROM Bank_Loan_Data

-- Bad Loan Funded Amount

SELECT SUM(loan_amount)  AS Bad_loan_funded_Amount
FROM Bank_Loan_Data
WHERE loan_status = 'Charged Off'


-- Bad Loan Received Amount

SELECT SUM(total_payment)  AS Bad_loan_Received
FROM Bank_Loan_Data
WHERE loan_status = 'Charged Off'

 
 -- LOAN STATUS
  
SELECT
      loan_status AS Loan_Status,
      COUNT(id) AS Total_Loan_Application,
      SUM(total_payment) AS Total_Amount_Received,
      SUM(loan_amount) AS Total_Funded_Amount,
FROM 
     Bank_Loan_Data
GROUP BY 
        loan_status

-- MTD BY Loan Status 

SELECT
      loan_status AS Loan_Status,
      SUM(total_payment) AS Mtd_Total_Amount_Received,
      SUM(loan_amount) AS Mtd_Total_Funded_Amount
FROM 
     Bank_Loan_Data
WHERE
     MONTH(issue_date) = 12
GROUP BY 
       loan_status


-- Dashboard 2 : Overview


-- Monthly Trends By Issue Date


SELECT 
     MONTH(issue_date) AS Month_Number,
     DATENAME(MONTH,issue_date) AS Month_Name,
     COUNT(id) AS Total_Loan_Application,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount
FROM
    Bank_Loan_Data
GROUP BY
        DATENAME(MONTH,issue_date),
        MONTH(issue_date)
ORDER BY
        MONTH(issue_date)


-- Regional Analysis By State

SELECT 
     address_state,
     COUNT(id) AS Total_Loan_Application,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount,
FROM
    Bank_Loan_Data
GROUP BY
        address_state
ORDER BY
       SUM(total_payment) DESC
        

-- LOAN TERM ANALYSIS

SELECT 
     term,
     COUNT(id) AS Total_Loan_Application,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount
FROM
    Bank_Loan_Data
GROUP BY
        term
ORDER BY
       term 


-- EMPLOYEE LENGTH ANALYSIS

SELECT 
     emp_length,
     COUNT(id) AS Total_Loan_Application,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount
FROM
    Bank_Loan_Data
GROUP BY
        emp_length
ORDER BY
       emp_length


-- LOAN PURPOSE BREAKDOWN

SELECT 
     purpose,
     COUNT(id) AS Total_Loan_Application,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount
FROM
    Bank_Loan_Data
GROUP BY
        purpose
ORDER BY
        COUNT(id) DESC



-- HOME OWNERSHIP ANALYSIS

SELECT 
     home_ownership,
     COUNT(id) AS Total_Loan_Application,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount
FROM
    Bank_Loan_Data
GROUP BY
        home_ownership
ORDER BY
        COUNT(id) DESC


