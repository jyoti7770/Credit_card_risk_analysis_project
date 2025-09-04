use credit_card_db;
select * from credit_card;

# 1.Transaction Above Suspicious amount
select Transaction_ID,Transaction_Amount,
Transaction_Date from credit_card
where Transaction_Amount>20000
order by Transaction_Date ;

# 2. Multiple transaction in short time Frame

SELECT Transaction_ID, COUNT(*) AS TxnCount, MIN(Transaction_Date) AS StartTime, MAX(Transaction_Date) AS EndTime
FROM credit_card
GROUP BY Transaction_ID;

# 3. Top 5 state with the highest fraud rate

select
    State,
    count(*) AS TotalTransactions,
    sum(case when IsFraud = 1 then 1 else 0 end) as FraudTransactions,
    round(sum(case when IsFraud = 1 then 1 else 0 end) * 100 / count(*), 2) as FraudRatePercent
from credit_card
group by State
order by FraudRatePercent desc
limit 5;

# 4. Transactions from high-risk State.

select State,sum(Transaction_Amount)as total_trans_amount
from credit_card
group by State
order by total_trans_amount desc
limit 5;

# 5. count of fraud done by each card_Type

select Card_Type ,count(*) as fraudcount
from credit_card
where IsFraud = 1
group by Card_Type
order by fraudcount desc;

# 6. fraud score by bank

select Bank,sum(Fraud_Score)as total_fraud
from credit_card
where IsFraud=1
group by Bank
order by total_fraud desc;

# 7. Customers with high fraud probability score

select Customer_Name,(Fraud_Score/100) as high_fraudprobability_score,State
from credit_card
where IsFraud = 1
order by high_fraudprobability_score desc
limit 5;

# total transaction amount via transaction category
select Transaction_Category,
sum(Transaction_Amount) as total_amount from credit_card
group by Transaction_Category;



