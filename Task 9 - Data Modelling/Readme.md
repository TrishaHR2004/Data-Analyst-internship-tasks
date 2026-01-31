# 📊 Task 9 — Star Schema Data Modeling (E-Commerce Churn & Orders)

## 🔹 Overview
This project demonstrates the design and implementation of a **Star Schema data model** for an e-commerce dataset focused on customer behavior, product details, geographic region, and transactional order data.  

The goal is to transform raw transactional data into a **dimensional model** optimized for **Business Intelligence (BI) reporting, performance, and analytical scalability**.

---

## 🎯 Objectives
- Design a **star schema** using fact and dimension tables
- Implement the model in **PostgreSQL**
- Validate relationships in **Power BI Model View**
- Enable fast analytical queries for business insights
- Document and visualize the schema using a professional ER/Star diagram

---

## 🛠 Tools & Technologies
- **PostgreSQL** — Data storage and SQL modeling
- **Power BI Desktop** — Data modeling and visualization
- **Lucidchart / dbdiagram.io** — Schema diagram design
- **GitHub** — Version control and project documentation

---

## 🗂 Dataset Description
**E-Commerce Churn & Orders Dataset**  
The dataset contains transactional and behavioral data, including:
- Customer demographics and subscription details
- Product and category information
- Order and purchase history
- Geographic (country-level) data
- Pricing and quantity metrics

### Key Source Columns
- `orderid`, `customerid`, `productid`
- `age`, `gender`, `country`
- `signupdate`, `lastpurchasedate`, `orderdate`
- `unitprice`, `quantity`
- `purchasefrequency`, `cancellationscount`
- `productname`, `category`, `preferredcategory`

---

## 🏗 Star Schema Design

### ⭐ Fact Table
**`fact_orders`**  
Stores measurable business events:
- `unit_price`
- `quantity`
- `revenue`

Foreign Keys:
- `customer_key`
- `product_key`
- `date_key`
- `region_key`

---

### 🧩 Dimension Tables

#### `dim_customer`
Stores customer attributes:
- `customer_id`
- `age`
- `gender`
- `country`
- `subscription_status`
- `signup_date`
- `purchase_frequency`
- `cancellations_count`

#### `dim_product`
Stores product attributes:
- `product_id`
- `product_name`
- `category`
- `preferred_category`

#### `dim_date`
Stores time-based attributes:
- `full_date`
- `year`
- `month`
- `day`

#### `dim_region`
Stores geographic attributes:
- `country`

---

## 🔗 Relationships
All dimension tables have **one-to-many (1 : \*) relationships** with the fact table using **surrogate keys**:


