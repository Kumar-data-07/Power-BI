# Amazon Sales Analysis – 2022

## 📊 Project Overview

This project focuses on analyzing Amazon sales data to understand sales performance, customer behavior, product performance, fulfilment methods, and geographical sales distribution.

The project follows an end-to-end data analytics workflow:

Data Cleaning → ETL → MySQL → SQL Analysis → Power BI Dashboard

---

## 🎯 Business Objectives

- Analyze overall sales performance
- Identify monthly revenue trends
- Analyze sales across Indian states
- Compare Amazon and Merchant fulfilment
- Compare B2B and B2C customers
- Identify top-performing products
- Analyze cancelled and completed orders
- Calculate important business KPIs

---

## 🛠️ Tools & Technologies

- Python
- Pandas
- Jupyter Notebook
- MySQL
- MySQL Workbench
- SQL
- Power BI

---

## 🔄 Project Workflow

### 1. Data Cleaning – Python

Python and Pandas were used for:

- Handling missing values
- Cleaning text fields
- Converting date columns
- Converting numeric columns
- Creating derived columns
- Identifying cancelled orders
- Creating revenue-related fields
- Preparing the cleaned dataset for MySQL

### 2. ETL – MySQL

The cleaned dataset was loaded into MySQL using a staging and fact-table approach.

Tables:

- `stg_amazon_sales`
- `fact_sales`

SQL was used to transform and analyze the data.

### 3. Data Analysis – SQL

Key analyses included:

- Monthly revenue
- Category sales
- State-wise sales
- Fulfilment analysis
- Order status analysis
- B2B vs B2C analysis
- Product performance
- Promotion analysis
- Cancellation rate
- Average Order Value
- Data quality validation

### 4. Power BI Dashboard

An interactive dashboard was created to present the major business insights.

---

## 📌 Dashboard KPIs

| KPI | Value |
|---|---:|
| Total Orders | 120K |
| Completed Orders | 103K |
| Cancelled Orders | 17K |
| Units Sold | 110.99K |
| Total Revenue | ₹71.67M |
| Average Order Value | ₹694.55 |

---

## 📈 Dashboard Features

### Monthly Revenue Trend
Shows how revenue changed throughout the available 2022 period.

### Revenue by State
An India map and state-level analysis show the geographical distribution of revenue.

### Revenue by Fulfilment Method
Compares Amazon fulfilment and Merchant fulfilment performance.

### Customer Type Analysis
Compares B2B and B2C sales.

### Top 10 Products
Identifies products with the highest revenue and unit sales.

### Interactive Filters
The dashboard includes filters for:

- Order Date
- Category
- Courier Status

---

## 💡 Key Insights

- Maharashtra generated the highest state-level revenue.
- Amazon fulfilment contributed significantly more revenue than Merchant fulfilment.
- B2C customers represented the majority of sales.
- Product-level analysis identified the highest-performing SKUs.
- Revenue varied considerably across the analyzed months.

---

## 📷 Dashboard Preview

![Amazon Sales Dashboard](Dashboard/amazon_sales_dashboard.png)

---

## 🚀 Skills Demonstrated

- Data Cleaning
- Exploratory Data Analysis
- ETL
- SQL
- MySQL
- Python
- Pandas
- Data Modeling
- Power BI
- Dashboard Design
- Business Intelligence
- Data Visualization
- Business KPI Analysis

---

## 👤 Author

**Kumar**

Aspiring Data Analyst | Power BI | SQL | Python | Data Visualization
