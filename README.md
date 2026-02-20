**/*Data Warehouse*/**
---------------------------------------------------------------------------------------------------------------------------------------------------------------
📌 Project Overview
---------------------------------------------------------------------------------------------------------------------------------------------------------------

This project simulates a how to create a data warehouse and how to implements a multi-layered data warehouse architecture using SQL Server.

The goal is to design and build a scalable data pipeline using the Bronze(raw_data) → Silver(processed_data) → Gold(analytics) layered approach to transform raw data into analytics-ready data models.

**This project demonstrates:**

Data warehouse schema design

ETL transformation using SQL

Star schema modeling

Data cleaning and validation

Fact and dimension modeling

Query optimization

Business-ready data views for BI tools

**🏗 Architecture Overview**

CSV Files
   ↓
Bronze Layer (Raw Tables)
   ↓
Silver Layer (Cleaned & Transformed Data)
   ↓
Gold Layer (Star Schema - Fact & Dimensions)

**🥉 Bronze layer(raw_data_layer) - contains raw ingested data from flat CSV files without transformation.**

Data Sources:
We have two system CRM and ERP

**CRM:**

customers.csv

product.csv

sales.csv

**ERP:**

CUST_AZ12.csv

LOC_A101.csv

PX_CAT_G1V2.csv

**Characteristics:**

No data cleaning

Load timestamp added

Preserves original structure

**Purpose:**

Maintain data lineage and raw history.

**🥈 Silver Layer(processed_data_layer) – Cleaned & Transformed Data**

The Silver layer applies business logic and data quality rules.

Transformations include:

Removing duplicates

Handling null values

Standardizing date formats

Cleaning inconsistent text values

Validating shipment statuses

Deriving delivery delay metrics

Purpose:
Create structured, reliable, analytics-ready tables.

**🥇 Gold Layer(analytics_layer) – Star Schema Model**

The Gold layer implements dimensional modeling for reporting.

created View for Fact and Dimension Table

__Fact Table:__
Customer 
Product
__Dimension Table:__
Sales

Purpose:
Support BI reporting and analytical queries.

🔎 Data Volume

Customer: 18000+ row
Product: 4000+ row
Sales: 80,000+ row data

🛠 Technologies Used

SQL Server

Star Schema Modeling

**📌 Future Enhancements**

Scheduled ETL execution

Data quality monitoring


**🎯 Target Role Alignment**

This project demonstrates practical knowledge required for a Data Engineer role, including:

ETL design

Data warehouse architecture

Dimensional modeling

Data transformation best practices

Business-aligned analytics support
