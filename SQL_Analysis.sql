-- Project to collect information of an online Store (Shipping jewelry to Customers in Viet Nam)
-- Creating the sales table.
Create Table sales (
Product_Name varchar,
Unit_Sold int,
Price_VND int,
Product_Quality_Rate int,
Service_Quality_Rate int,
Delivery_Rate int,
Comment VARCHAR,
Customer_ID int);

-- Insert values into sales table from CSV file
Copy sales from 'C:\Data Analyst\Personal Project\Sales Table.csv' DELIMITER ',' CSV header;

-- See all values of Sales table
Select * from sales;

/*Group Data by Customer ID to collect purchasing time of each customer
and total sales for each customer*/
Select Customer_id,
count (customer_id) as Purchasing_Time,
sum (Price_VND) as total_sales
from sales
group by Customer_id
order by purchasing_time desc;

/*Create Customers table that collect detailed information of customers
who using online shopping services.*/ 
Create table customers (
Customer_ID int,
Customer_Name varchar,
Location varchar,
Gender varchar,
Source varchar);

-- Input Data into Customers table from CSV file
Copy Customers from 'C:\Data Analyst\Personal Project\Customers.csv' Delimiter ',' CSV Header;

/* having spelling mistake with source "Refferal" -> need
to replace by the correct one "Referral"*/
Update Customers
set source = 'Referral'
where source = 'Refferal';

/* Analysing Sources that approach most customers as well as bring most revenues for the company
and RANKING them */
select 
b.Source,
Count (b.source) as Number_of_Buyers,
sum (a.price_vnd) as Total_Sales
from sales as a
Left Join customers as b
on a.customer_id = b.customer_id
Group by Source
Order by Total_Sales desc
; -- (1)
--Analysing royal/ potential customers based on their revenues they brings to company.
Select 
a.customer_id,
b.customer_name,
sum (a.price_vnd) as Total_Sales
from sales as a
Left Join customers as b
on a.customer_id = b.customer_id
Group by a.customer_id, b.customer_name
Order by Total_Sales desc
limit 10; -- (2)

--Summary
/* 
Based on (1), can see that:
- Facebook approaches most customers, then Tik Tok and Instagram
-> Can focus on marketing campaigns those sources to approach more customers
- Other sources can improve the numbers of buyers by:
+ Referral source: give vouchers/discounts/ Freeship in the next purchase for 
current customers when they refer new customers.
Based on (2), can see the Top 10 of royal/ potential customers
--> can keep the long-term relationship with these customers 
by upgrading their membership card level to Silver/ Gold to get
more benefits (discounts, promotions, gifts... ) in the next purchase.
*/




