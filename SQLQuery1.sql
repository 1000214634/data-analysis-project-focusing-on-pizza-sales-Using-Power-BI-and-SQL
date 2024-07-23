select*from pizza_sales

--A.KPIS

--1.Total Revenue(sum of the total price of all pizza orders)
select SUM(total_price) As Total_Revenue
from pizza_sales

--2.Average Order Value(The avearge amount spent per order,calculated by dividing the total revenue by the total number of orders)

 SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value
 FROM pizza_sales


 --3.Total Pizzas Sold(The sum of the quantities of all pizzas sold)
 select  sum(quantity)as Total_Pizza_Sold
 from pizza_sales

 --4.Total Orders(The total number of orders placed)
 select count(distinct(order_id)) as Total_Orders
 from pizza_sales

 --5.Average pizzas per order(The average number of pizzas sold per order,calculated by dividing the total number of pizzas sold by the total number of orders)

 select cast(cast(sum(quantity)As decimal(10,2))/
 cast(count(distinct order_id)As decimal(10,2))as decimal(10,2)) as avg_pizzas_per_order
 from pizza_sales

 --cast function-->convert value (of any type) into a specified data type
 --decimal(10,2) means that the result will be a decimal number with a total of 10 digits, with 2 of those digits being decimal places. 
 --This format is commonly used to represent monetary values or other quantities requiring two decimal places of precision.


 --6.Daily Trend for total orders:
 select DATENAME(DW,order_date) as order_day,count(distinct(order_id)) as total_orders
 from pizza_sales
 group by DATENAME(DW,order_date)

 /*
 1)DATENAME(DW, order_date) is a function that returns the name of the day of the week (e.g., Monday, Tuesday, etc.)
 from the order_date column in the pizza_sales table.
 
 2)GROUP BY DATENAME(DW, order_date) groups the results by the day of the week extracted from the order_date column. 
 This means that all rows with the same day of the week will be grouped together.
 
 */

 --7.Monthly trend for total orders:
 select DATENAME(Month,order_date) as order_month,count(distinct(order_id)) as total_orders 
 from pizza_sales
 group by DATENAME(Month,order_date)
 order by total_orders desc


 --8.Percentage of sales by pizza category:
 
 /*("Percentage of sales by pizza category" 
 refers to analyzing the distribution of sales among different types of pizzas 
 (such as cheese, pepperoni, vegetarian, etc.). This information helps businesses understand customer preferences, 
 identify popular items, and make informed decisions regarding menu offerings, pricing strategies, and marketing efforts.)


 The equation to calculate the percentage of sales by pizza category involves dividing the sales 
 of each pizza category by the total sales and 
 then multiplying by 100 to convert it to a percentage.
 

 Here's the equation in mathematical form:
Percentage of Sales for a Pizza Category=
(Sales of the Pizza Category/Total Sales)*100
 
 */


SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as
 total_revenue,
 CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales)
 AS DECIMAL(10,2)) AS PCT
 FROM pizza_sales
 GROUP BY pizza_category


 --9.Percentage of sales by pizza size:
 SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as
 total_revenue,
 CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales)
 AS DECIMAL(10,2)) AS PCT
 FROM pizza_sales
 GROUP BY pizza_size
 order by PCT desc

 --10.Total pizzas sold by pizza category:
 
 /*calculating the total pizzas sold by pizza category involves identifying the categories
 (like cheese, pepperoni, vegetarian), collecting sales data for each category (number of pizzas sold), 
 and then summing up these quantities to find the overall total of pizzas sold across all categories. 
 This information is valuable for understanding sales trends, analyzing customer preferences, 
 and making informed business decisions 
 related to menu offerings and marketing strategies.*/
 
 
 
 
 select pizza_category,sum(quantity)as total_quantity_sold
 from pizza_sales
 where month(order_date)=2
 --where datepart(quarter,order_date)=1
 group by pizza_category
 order by total_quantity_sold desc

 --11.Top 5 pizzas by revenue
 select top 5 pizza_name,sum(total_price)as total_revenue
 from pizza_sales
 group by pizza_name
 order by total_revenue desc

 --12.Bottom 5 pizzas by revenue
 select Top 5 pizza_name,sum(total_price)as total_revenue
 from pizza_sales
 group by pizza_name
 order by total_revenue asc

 --13.Top 5 pizzas by quantity
 select top 5 pizza_name,sum(quantity) as total_quantity
 from pizza_sales
 group by pizza_name
 order by total_quantity desc

--14.Bottom 5 pizzas by quantity
 select top 5 pizza_name,sum(quantity) as total_quantity
 from pizza_sales
 group by pizza_name
 order by total_quantity asc

 --15.Top 5 pizzas by total_orders
 select top 5 pizza_name,count(distinct(order_id)) as total_orders
 from pizza_sales
 group by pizza_name
 order by total_orders desc

 --16.Bottom 5 pizzas by total_orders
 select top 5 pizza_name,count(distinct(order_id)) as total_orders
 from pizza_sales
 group by pizza_name
 order by total_orders asc
