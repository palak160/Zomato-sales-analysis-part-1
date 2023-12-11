-- What is the total amount each customer spent on Zomato?
SELECT sales.userid, SUM(product.price) as total FROM sales
INNER JOIN product ON sales.product_id = product.product_id
GROUP BY sales.userid

-- How many days has each customer visited Zomato?
Select userid,COUNT(distinct created_date)as no_of_visits FROM sales
GROUP BY userid

-- What was the first product purhased by each customer?
SELECT * FROM 
(select *, rank() over (partition by userid ORDER BY created_date) as rnk from sales) as Zomato WHERE rnk = 1

-- What is the most purchased item on the menu and how many times was it purchased by all customers?
Select userid,count(product_id) from sales where product_id =
(Select product_id from sales group by product_id order by count(product_id) desc limit 1) group by userid

-- Which item was most popular for each customer?
Select * from
(Select *, rank() over(partition by userid order by cnt desc) as rnk from
(Select userid, product_id, count(product_id)as cnt from sales group by userid, product_id) as prd )as prd2
Where rnk = 1