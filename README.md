# 🛒 SQL Challenge - Consumer Goods Analysis

This repository contains the solutions to the **SQL Challenge** presented by **Codebasics.io**. The challenge focuses on analyzing data related to consumer goods, using SQL to extract valuable insights from a dataset. Below is a summary of the requests and corresponding solutions.

## 📑 Challenge Overview

### **1. Markets for "Atliq Exclusive" in the APAC Region**
**Request:** Provide a list of markets in which the customer "Atliq Exclusive" operates its business within the APAC region.  
**Output:**  
- `market_name`

### **2. Percentage Increase in Unique Products (2021 vs. 2020)**
**Request:** Determine the percentage increase in unique products in 2021 compared to 2020.  
**Output:**  
- `unique_products_2020`
- `unique_products_2021`
- `percentage_chg`

### **3. Unique Product Counts by Segment**
**Request:** Generate a report listing the count of unique products for each segment, sorted in descending order of product counts.  
**Output:**  
- `segment`
- `product_count`

### **4. Segment with Most Increase in Unique Products (2021 vs. 2020)**
**Request:** Identify the segment that saw the greatest increase in unique products from 2020 to 2021.  
**Output:**  
- `segment`
- `product_count_2020`
- `product_count_2021`
- `difference`

### **5. Products with Highest and Lowest Manufacturing Costs**
**Request:** Get the products with the highest and lowest manufacturing costs.  
**Output:**  
- `product_code`
- `product`
- `manufacturing_cost`

### **6. Top 5 Customers by Average Pre-Invoice Discount in 2021 (India)**
**Request:** Generate a report on the top 5 customers who received the highest average pre-invoice discount percentage in the fiscal year 2021 within the Indian market.  
**Output:**  
- `customer_code`
- `customer`
- `average_discount_percentage`

### **7. Monthly Gross Sales for "Atliq Exclusive"**
**Request:** Provide a complete report of the Gross Sales Amount for "Atliq Exclusive" for each month. This analysis is intended to help identify low and high-performing months.  
**Output:**  
- `Month`
- `Year`
- `Gross_sales_Amount`

### **8. Maximum Total Sold Quantity by Quarter in 2020**
**Request:** Determine which quarter in 2020 had the maximum total sold quantity.  
**Output:**  
- `Quarter`
- `total_sold_quantity`

### **9. Channel with Highest Gross Sales in 2021 and Its Contribution**
**Request:** Identify the channel that brought in the most gross sales in the fiscal year 2021, and calculate its percentage of contribution.  
**Output:**  
- `channel`
- `gross_sales_mln`
- `percentage`

### **10. Top 3 Products by Division (Total Sold Quantity in 2021)**
**Request:** Generate a report listing the top 3 products in each division based on total sold quantity in the fiscal year 2021.  
**Output:**  
- `division`
- `product_code`
- `product`
- `total_sold_quantity`
- `rank_order`

## 🛠️ **Technologies Used**
- SQL
- MySQL
- Data Analysis

## 🚀 **Getting Started**
To explore the SQL queries and solutions:
-  [SQL Queries](https://github.com/SandeepChinta4/SQL-Consumer-Goods/blob/main/SQL_Resume_Challenge.sql)
-  [Output](https://github.com/SandeepChinta4/SQL-Consumer-Goods/tree/main/Output)

## 💡 **Conclusion**
This challenge demonstrates the power of SQL in extracting and analyzing data from complex datasets. The solutions provided here offer insights into market operations, product performance, customer behavior, and more.

