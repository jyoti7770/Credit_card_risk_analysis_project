# Credit_card_risk_analysis_project
![bank image](https://github.com/jyoti7770/Credit_card_risk_analysis_project/blob/main/bank%20img.webp)

## PROJECT OVERVIEW
This project focuses on analyzing credit card transactions to detect and understand fraudulent activities.
Using SQL queries, the project identifies suspicious transactions, high-risk regions, banks, and customers with elevated fraud probability scores.

Objectives

- Detect transactions above suspicious thresholds.
- Identify multiple transactions in short time frames.
- Highlight states, banks, and card types with higher fraud risk.
- Calculate fraud rates by category and location.
- Recognize customers with high fraud probability scores.

Queries & Insights

1. Transactions Above Suspicious Amount
```sql
select Transaction_ID,Transaction_Amount,
Transaction_Date from credit_card
where Transaction_Amount>20000
order by Transaction_Date ;
```
Insight: Flags high-value transactions that may indicate fraud.

2. Multiple transaction in short time Frame
```sql
SELECT Transaction_ID, COUNT(*) AS TxnCount,
MIN(Transaction_Date) AS StartTime,
MAX(Transaction_Date) AS EndTime
FROM credit_card
GROUP BY Transaction_ID;
```
Insight: Helps detect unusual transaction bursts from the same card.

3. Top 5 state with the highest fraud rate
```sql
select
    State,
    count(*) AS TotalTransactions,
    sum(case when IsFraud = 1 then 1 else 0 end) as FraudTransactions,
    round(sum(case when IsFraud = 1 then 1 else 0 end) * 100 / count(*), 2) as FraudRatePercent
from credit_card
group by State
order by FraudRatePercent desc
limit 5;
```
Insight: Identifies regions more prone to fraud.

 4. Transactions from high-risk State.
```sql
select State,sum(Transaction_Amount)as total_trans_amount
from credit_card
group by State
order by total_trans_amount desc
limit 5;
```
Insight: These states contribute the largest share of transaction volume. 

5. count of fraud done by each card_Type.
```sql
select Card_Type ,count(*) as fraudcount
from credit_card
where IsFraud = 1
group by Card_Type
order by fraudcount desc;
```
Insight: Determines which card types are more vulnerable to fraud.

6. fraud score by bank.
```sql
select Bank,sum(Fraud_Score)as total_fraud
from credit_card
where IsFraud=1
group by Bank
order by total_fraud desc;
```
Insight: Highlights banks facing higher fraud risks.

7. Customers with high fraud probability score
```sql
select Customer_Name,(Fraud_Score/100) as high_fraudprobability_score,State
from credit_card
where IsFraud = 1
order by high_fraudprobability_score desc
limit 5;
```
Insight: Lists customers with the highest fraud probability scores.

## Findings
- List of suspicious transactions.

- Fraud rates per state and card type.

- Fraud score distribution by bank.

- Top high-risk customers.

##Future Enhancements

Automate fraud detection pipeline using Python + SQL.

Integrate machine learning models for predictive fraud analysis.

Develop a dashboard using Power BI.


   
