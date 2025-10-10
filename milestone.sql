use ecomm;
select * from ecomm.customer_churn;
select round(avg(warehousetohome)) 
as mean_WHTH 
from customer_churn
 where warehousetohome is not null;
 
select round(avg(hourspendonapp)) 
as mean_HSOA from 
customer_churn 
where hourspendonapp is not null;
select round(avg(orderamounthikefromlastyear))
 as mean_OAHY 
 from customer_churn 
 where Orderamounthikefromlastyear is not null;
 
select round(avg(daysincelastorder)) 
as mean_DSLO from 
customer_churn where 
daysincelastorder is not null;

update customer_churn 
set warehousetohome=16 
where warehousetohome is null;

update customer_churn set 
hourspendonapp=3 where 
hourspendonapp is null;
update customer_churn set 
orderamounthikefromlastyear=16 
where orderamounthikefromlastyear is null;

update customer_churn 
set daysincelastorder=5
 where daysincelastorder is null;
select tenure,count(*)
 as tenure_count 
 from customer_churn 
 group by tenure 
 order by tenure_count desc
 limit 1;
 
select couponused,count(*)
 as couponused_count 
 from customer_churn 
 group by couponused 
 order by couponused_count 
 limit 1;
 
select ordercount,count(*) 
as order_count 
from customer_churn 
group by ordercount 
order by order_count 
limit 1;
UPDATE customer_churn 
SET Tenure = 0 
WHERE Tenure IS NULL;

UPDATE customer_churn 
SET CouponUsed = 1 
WHERE CouponUsed IS NULL;
UPDATE customer_churn 
SET OrderCount = 2 
WHERE OrderCount IS NULL;

delete from customer_churn
where warehousetohome >100;

UPDATE customer_churn SET 
PreferredLoginDevice = 'Mobile Phone' 
WHERE PreferredLoginDevice = 'Phone';

UPDATE customer_churn 
SET PreferedOrderCat = 'Mobile Phone' 
WHERE PreferedOrderCat = 'Mobile';

UPDATE customer_churn SET 
PreferredPaymentMode = 'Cash on Delivery' 
WHERE PreferredPaymentMode = 'COD';

UPDATE customer_churn SET 
PreferredPaymentMode = 'Credit Card' 
WHERE PreferredPaymentMode = 'CC';

alter table customer_churn 
rename column PreferedOrderCat
 to PreferredOrderCat;
alter table customer_churn 
rename column HourSpendOnApp 
to HoursSpendOnApp;

ALTER TABLE customer_churn 
ADD COLUMN ComplaintReceived VARCHAR(3),
ADD COLUMN ChurnStatus VARCHAR(10);

UPDATE customer_churn 
SET ComplaintReceived = CASE WHEN Complain = 1 
THEN 'Yes' 
ELSE 'No' 
END,
ChurnStatus = CASE WHEN Churn = 1 
THEN 'Churned'
 ELSE 'Active' 
 END;
 
ALTER TABLE customer_churn 
DROP COLUMN Churn,
DROP COLUMN Complain;

SELECT ChurnStatus, COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY ChurnStatus;

SELECT ROUND(AVG(Tenure),2) AS AvgTenure,
ROUND(SUM(CashbackAmount),2) AS TotalCashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';

SELECT ROUND( (SUM(CASE WHEN ComplaintReceived='Yes' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS PercentChurnedComplained
FROM customer_churn
WHERE ChurnStatus = 'Churned';

SELECT CityTier, COUNT(*) AS CountChurned
FROM customer_churn
WHERE ChurnStatus='Churned' AND PreferredOrderCat='Laptop & Accessory'
GROUP BY CityTier
ORDER BY CountChurned DESC
LIMIT 1;

SELECT PreferredPaymentMode, COUNT(*) AS CountActive
FROM customer_churn
WHERE ChurnStatus='Active'
GROUP BY PreferredPaymentMode
ORDER BY CountActive DESC
LIMIT 1;

SELECT SUM(OrderAmountHikeFromlastYear) AS TotalOrderAmountHike
FROM customer_churn
WHERE MaritalStatus='Single' AND PreferredOrderCat='Mobile Phone';

SELECT ROUND(AVG(NumberOfDeviceRegistered),2) AS AvgDevicesUPI
FROM customer_churn
WHERE PreferredPaymentMode='UPI';

SELECT CityTier, COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY CityTier
ORDER BY CustomerCount DESC
LIMIT 1;

SELECT Gender, SUM(CouponUsed) AS TotalCouponsUsed
FROM customer_churn
GROUP BY Gender
ORDER BY TotalCouponsUsed DESC
LIMIT 1;

SELECT PreferredOrderCat, COUNT(*) AS CustomerCount, MAX(HoursSpendOnApp) AS MaxHoursSpent
FROM customer_churn
GROUP BY PreferredOrderCat;

SELECT SUM(OrderCount) AS TotalOrderCount
FROM customer_churn
WHERE PreferredPaymentMode='Credit Card' 
  AND SatisfactionScore = (SELECT MAX(SatisfactionScore) FROM customer_churn);

SELECT ROUND(AVG(SatisfactionScore),2) AS AvgSatisfactionScore
FROM customer_churn
WHERE ComplaintReceived='Yes';

SELECT PreferredOrderCat, COUNT(*) AS CustomerCount
FROM customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY CustomerCount DESC;

SELECT PreferredOrderCat, ROUND(AVG(CashbackAmount),2) AS AvgCashback
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY AvgCashback DESC
LIMIT 3;

SELECT PreferredPaymentMode,avg(tenure) as avg_tenure
FROM customer_churn
WHERE OrderCount = 500
GROUP BY PreferredPaymentMode
HAVING avg(tenure) =10;

SELECT 
CASE 
WHEN WarehouseToHome <=5 THEN 'Very Close Distance'
WHEN WarehouseToHome <=10 THEN 'Close Distance'
WHEN WarehouseToHome <=15 THEN 'Moderate Distance'
ELSE 'Far Distance'
END AS DistanceCategory,
ChurnStatus,
COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY DistanceCategory, ChurnStatus;

SELECT *
FROM customer_churn
WHERE MaritalStatus='Married'
AND CityTier=1
AND OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);
use ecomm;
create table customer_returns(
ReturnID int primary key,
customerID int not null,
ReturnDate date,
RefundAmount int, 
FOREIGN KEY (CustomerID) REFERENCES customer_churn(CustomerID));
INSERT INTO customer_returns (ReturnID, CustomerID, ReturnDate, RefundAmount)
VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);
select * from ecomm.customer_returns;

SELECT 
customer_returns.CustomerID,
customer_returns.ReturnID,
customer_returns.ReturnDate,
customer_returns.RefundAmount,
customer_churn.ChurnStatus,
customer_churn.ComplaintReceived
FROM customer_returns
JOIN customer_churn
ON customer_returns.CustomerID = customer_churn.CustomerID
WHERE customer_churn.ChurnStatus = 'Churned'
AND customer_churn.ComplaintReceived = 'Yes';

