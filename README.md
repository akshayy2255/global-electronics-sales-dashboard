# Global Electronics Sales Analytics Dashboard

## Project Overview

This project is an end-to-end **Data Analyst portfolio project** where raw sales data is transformed into meaningful business insights using **SQL and Power BI**.

The dashboard provides insights into:

* Profit trends over time
* Customer demographics
* Product category performance
* Country-wise profit distribution
* Brand contribution

---

## 🧠 Key Business Insights

* 📈 Profit peaked in **2019**, followed by a decline
* 🌍 **UK and Germany** are the top-performing markets
* 💻 **Computers category** dominates with ~40% contribution
* 👴 **Senior customers** generate the highest revenue (~33M)
* 🏆 **Contoso** leads in customer contribution
* 🎯 Strategy: Focus on **younger audience growth**

---

## 🗂️ Dataset Details

The dataset consists of 3 main tables:

### 1. Customers

* Customer demographics (Age, Gender, Location,etc)

### 2. Products

* Product details (Category, Brand, Cost, Price,etc)

### 3. Sales

* Transaction-level data (Orders, Quantity, Dates,etc)

---

## ⚙️ Data Processing (SQL)

Key steps performed:

* Data cleaning (handling NULLs, duplicates, invalid values)
* Feature engineering:

  * `SalesAmount = Quantity × UnitPrice`
  * `CostAmount = Quantity × UnitCost`
  * `Profit = Sales - Cost`
  * `ProfitMargin (%)`
* Customer segmentation:

  * Young (<25)
  * Adult (25–50)
  * Senior (>50)
* Created final view: `final_sales_data`

---

## 📊 Dashboard Features (Power BI)

### 🔹 Key Visuals

* Year-wise Profit Trend
* Profit by Country
* Product Category Distribution
* Revenue by Age Group
* Profit by Gender
* Top Brands by Customers

### 🔹 KPIs

* Total Customers
* Profit Margin %
* Total Profit

---

## 🛠️ Tech Stack

* **SQL (PostgreSQL)** – Data cleaning & transformation
* **Power BI** – Data visualization
* **Excel/CSV** – Data source

---

## 📁 Project Structure

```
├── data/
│   ├── Customers.csv
│   ├── Products.csv
│   └── Sales.csv
│
├── sql/
│   └── data_cleaning.sql
│
├── dashboard/
│   └── powerbi_dashboard.pbix
│
└── README.md
```

---

## 📌 How to Run

1. Import CSV files into PostgreSQL
2. Run SQL script (`data_cleaning.sql`)
3. Load processed data into Power BI
4. Open `.pbix` file to explore dashboard

---

## 💡 Future Improvements

* Add forecasting (Time Series)
* Build ML model for customer segmentation
* Deploy dashboard online (Power BI Service)
* Create automated ETL pipeline

---

## 🙌 Author

**Akshay Choudhary**
Aspiring Data Analyst | SQL | Power BI | Python

---

## ⭐ If you like this project

Give it a ⭐ on GitHub and connect with me!
