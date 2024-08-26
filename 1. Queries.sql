CREATE TABLE sales ( 
 invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
 branch VARCHAR(3) NOT NULL,
 city VARCHAR(30) NOT NULL,
 customer_type VARCHAR(30) NOT NULL,
 gender VARCHAR(10) NOT NULL ,
 product_line VARCHAR(100) NOT NULL,
 unit_price DECIMAL(10,2) NOT NULL,
 quantity INT NOT NULL ,
 VAT FLOAT(6,4) NOT NULL ,
 total DECIMAL(10,2) NOT NULL ,
 date DATE NOT NULL ,
 time TIMESTAMP NOT NULL ,
 payment_method DECIMAL(10,2) NOT NULL ,
 cogs DECIMAL(10,2) NOT NULL ,
 gross_margin_percentage FLOAT(11,9) NOT NULL,
 gross_income DECIMAL(10,2) ,
 rating FLOAT(2,1));
 
 
INSERT INTO sales (invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, VAT, total, date, time, payment_method, cogs, gross_margin_percentage, gross_income, rating) VALUES
('INV001', 'A', 'New York', 'Member', 'Female', 'Health and beauty', 23.45, 5, 0.0750, 125.95, '2023-07-01', '2023-07-01 10:15:00', 1, 117.13, 0.123456789, 8.82, 9.1),
('INV002', 'B', 'Los Angeles', 'Normal', 'Male', 'Electronic accessories', 15.00, 3, 0.0700, 48.30, '2023-07-02', '2023-07-02 12:30:00', 2, 45.10, 0.067800123, 3.20, 8.7),
('INV003', 'C', 'Chicago', 'Member', 'Female', 'Home and lifestyle', 35.70, 2, 0.0900, 78.54, '2023-07-03', '2023-07-03 15:45:00', 1, 73.60, 0.065432189, 4.94, 9.4),
('INV004', 'A', 'Houston', 'Normal', 'Male', 'Health and beauty', 12.50, 4, 0.0650, 53.25, '2023-07-04', '2023-07-04 11:00:00', 3, 50.00, 0.060001123, 3.25, 8.0),
('INV005', 'B', 'Phoenix', 'Member', 'Female', 'Electronic accessories', 45.00, 1, 0.0800, 48.60, '2023-07-05', '2023-07-05 16:15:00', 2, 44.80, 0.085456723, 3.80, 9.0),
('INV006', 'C', 'Philadelphia', 'Normal', 'Male', 'Home and lifestyle', 22.50, 6, 0.0700, 144.90, '2023-07-06', '2023-07-06 09:30:00', 1, 136.50, 0.095120000, 8.40, 8.5),
('INV007', 'A', 'San Antonio', 'Member', 'Female', 'Health and beauty', 30.00, 2, 0.0500, 63.00, '2023-07-07', '2023-07-07 13:45:00', 3, 60.00, 0.090050333, 3.00, 9.2),
('INV008', 'B', 'San Diego', 'Normal', 'Male', 'Electronic accessories', 20.00, 5, 0.0850, 108.50, '2023-07-08', '2023-07-08 17:00:00', 2, 100.00, 0.093333345, 8.50, 8.8),
('INV009', 'C', 'Dallas', 'Member', 'Female', 'Home and lifestyle', 18.75, 3, 0.0750, 60.94, '2023-07-09', '2023-07-09 12:15:00', 1, 56.25, 0.081234567, 4.69, 9.3),
('INV010', 'A', 'San Jose', 'Normal', 'Male', 'Health and beauty', 25.00, 1, 0.0700, 26.75, '2023-07-10', '2023-07-10 15:30:00', 3, 25.00, 0.064000125, 1.75, 8.1),
('INV011', 'B', 'Austin', 'Member', 'Female', 'Electronic accessories', 40.00, 4, 0.0650, 170.20, '2023-07-11', '2023-07-11 18:45:00', 2, 160.00, 0.088000125, 10.20, 9.5),
('INV012', 'C', 'Jacksonville', 'Normal', 'Male', 'Home and lifestyle', 29.90, 2, 0.0550, 62.94, '2023-07-12', '2023-07-12 09:00:00', 1, 59.80, 0.094500123, 3.14, 8.6);

select * from sales;

#add new column called as dayname
alter table sales
add dayname varchar(50);

#add values--to dayname
#date---dayname(date)
update sales
set dayname=DAYNAME(date);

select  date,dayname(date)
from sales;

#add values--to monthname
alter table sales
add monthname varchar(100);

UPDATE sales
SET monthname = MONTHNAME(Date);

select date,monthname(date)
from sales;

#time of day--add
alter table sales
add time_of_day varchar(150);
 
 #update values of timeofday
update sales
set time_of_day=(
case
when 'time'  between '00:00:00' and '12:00:00' then 'morning'
when 'time'  between '12:00:00' and '09:00:00' then 'afternoon'
else 'night'
end );

#GENERIC QUESTIONS
# 1.find how many of unique city does the data have
select distinct(city) from sales;

select count(distinct(city)) as newc
from sales;

#another method
#select city,count(*) as totalcity 
#from sales
#group by city;


# 2.find in which city is each branch?
 select distinct(city),branch from sales;
 
 ---- PRODUCT ANALYSIS----
 #QUESTION ON PRODUCTS
 # 1.HOW MANY UNIQUE PRODUCT LINES DOES THE DATA HAVE?
 select count(distinct(product_line))
 as new_count
 from sales;
 
 select distinct(product_line) from sales;
 
 # 2. What is the most selling product line?
 select product_line,max(quantity) as new_count
 from sales
 group by product_line
 order by new_count desc
 limit 1;
 
 #another method
select product_line,max(quantity) as new_count
 from sales
 group by product_line;
 
 #another method
 select sum(quantity) as newqty,product_line
 from sales
 group by product_line
 order by newqty desc;
 
 # 3. What is the most common payment method?
 select payment_method,sum(quantity) as new_count
 from sales
 group by payment_method
 order by new_count desc;
 
 # 4. What is the total revenue by month? 
select monthname as month,sum(total) as total_revenue
from sales
group by monthname
order by total_revenue desc;

 # 5. What is the city with the largest revenue?
SELECT city, SUM(Total) as total_revenue
FROM sales
GROUP BY City
ORDER BY total_revenue DESC;

 # 6. What month had the largest COGS?
 select max(cogs) as largest_cogs,monthname
from sales
group by monthname
order by largest_cogs desc;

#another method
SELECT SUM(cogs) AS TOTAL, monthname as month
FROM sales
GROUP BY monthname
ORDER BY TOTAL DESC;

# 7. What product line had the largest revenue?
SELECT SUM(Total) AS total_revenue, product_line 
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

#another method
select max(total) as total_revenue,product_line
from sales
group by product_line
order by total_revenue desc;

# 8. What product line had the largest VAT?
SELECT product_line, AVG(VAT) AS VAT 
FROM sales
GROUP BY product_line
ORDER BY VAT DESC;

# 9. Fetch each product line and add a column to those 
-- product line showing "Good", "Bad". Good if its greater than average sales------
SELECT AVG(Quantity) AS AVG_SALES
FROM sales;

SELECT product_line,
       CASE
           WHEN  AVG(Quantity) > 5 THEN "Good"
       ELSE "Bad"
	END AS result
FROM sales
GROUP BY product_line;

# 10. Which branch sold more products than average product sold?
SELECT Branch, SUM(Quantity) 
FROM sales
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM sales);

 #another same code
select branch,max(quantity) as newqty
 from sales 
 group by branch
 having newqty>(select avg(quantity) from sales);

# 11. What is the average rating of each product line?
SELECT ROUND(AVG(Rating),1) AS AVG_RT, product_line
FROM sales
GROUP BY product_line
ORDER BY AVG_RT;


 # 12. Find gross income by each city
 select city,sum(gross_income) as newme
 from sales
 group by city;  
 
 #another method
 select city,count(gross_income) as newcount
 from sales
 group by city;  #count of city will be given


--- CUSTOMER ANALYSIS --------
 # 1. What is the most common product line by gender?
 select gender,max(product_line) as newprod
 from sales
 group by gender
 order by newprod asc;
 
 # 2. How many unique customer types does the data have?
 select count(distinct(customer_type))
 from sales;
 
 select distinct(customer_type) from sales;

#-- 3. What is the most common customer type?----
SELECT customer_type, COUNT(*) AS CNT
FROM sales
GROUP BY customer_type
ORDER BY CNT DESC;

# 4. Which customer type buys the most?
SELECT customer_type , COUNT(*)
FROM sales
GROUP BY customer_type;

#5. What is the gender of most of the customers?
SELECT Gender, COUNT(*) 
FROM sales
GROUP BY Gender;

# 6. How many unique payment methods does the data have?------------
SELECT DISTINCT payment_method
FROM sales;

# 7. What is the gender distribution per branch?
SELECT Branch,Gender,
       COUNT(*) AS gender_count,
       COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY Branch) AS gender_percentage
FROM sales
GROUP BY Branch, Gender;

#another method
select branch,gender,count(*) as newct
from sales
group by gender,branch;

# 8. Which time of the day do customers give most ratings?
SELECT time_of_day, ROUND(AVG(Rating),2) AS most_ratings
FROM sales
GROUP BY time_of_day
ORDER BY most_ratings DESC;

# 9. Which time of the day do customers give most ratings per branch
SELECT time_of_day, Branch,ROUND(AVG(Rating),2) AS most_ratings
FROM sales
GROUP BY time_of_day,Branch
ORDER BY most_ratings DESC;

# 10.  Which day of the week has the best avg ratings?
SELECT dayname, ROUND(AVG(Rating),2) AS AVRG
FROM sales
GROUP BY dayname 
ORDER BY AVRG DESC;

# 11. Which day of the week has the best average ratings per branch?
SELECT dayname,Branch, ROUND(AVG(Rating),2) AS best_avg_rating
FROM sales
GROUP BY dayname, Branch
ORDER BY best_avg_rating DESC;

--- SALES ANALYSIS----
# 1. Number of sales made in each time of the day per weekday
SELECT time_of_day,dayname, COUNT(*) AS SALES
FROM sales
GROUP BY time_of_day, dayname
ORDER BY SALES DESC;

# Number of sales made in each time  on "monday"
SELECT time_of_day,dayname, COUNT(*) AS SALES
FROM sales
WHERE dayname = "monday" 
GROUP BY time_of_day, dayname
ORDER BY SALES DESC;

# 2. Which of the customer types brings the most revenue?
SELECT customer_type , ROUND(SUM(Total),2) AS REVENUE
FROM sales
GROUP BY customer_type
ORDER BY REVENUE;

#3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
SELECT ROUND(AVG(VAT),2) AS LTP, City
FROM sales
GROUP BY City
ORDER BY LTP DESC;

# 4. Which customer type pays the most in VAT?
SELECT customer_type, ROUND(AVG(VAT),2) AS MST
FROM sales
GROUP BY customer_type
ORDER BY MST DESC;

 