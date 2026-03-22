DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    CustomerKey     INT PRIMARY KEY,
    Gender          VARCHAR(10),
    Name            VARCHAR(100),
    City            VARCHAR(100),
    StateCode       VARCHAR(10),
    State           VARCHAR(100),
    ZipCode         VARCHAR(20),
    Country         VARCHAR(100),
    Continent       VARCHAR(50),
    Birthday        DATE
);

CREATE TABLE products (
    ProductKey      INT PRIMARY KEY,
    ProductName     VARCHAR(200),
    Brand           VARCHAR(100),
    Color           VARCHAR(50),
    UnitCostUSD     NUMERIC(10,2),
    UnitPriceUSD    NUMERIC(10,2),
    SubcategoryKey  INT,
    Subcategory     VARCHAR(100),
    CategoryKey     INT,
    Category        VARCHAR(100)
);

CREATE TABLE sales (
    OrderNumber     VARCHAR(50),
    LineItem        INT,
    OrderDate       DATE,
    DeliveryDate    DATE,
    CustomerKey     INT,
    StoreKey        INT,
    ProductKey      INT,
    Quantity        INT,
    CurrencyCode    VARCHAR(10)
);
-- Customers
COPY customers
FROM 'D:\Global-Electronics-Analytics-Dashboard\Customers.csv'
DELIMITER ','
CSV HEADER
ENCODING 'LATIN1';

-- Products
COPY products
FROM 'D:\Global-Electronics-Analytics-Dashboard\Products.csv'
DELIMITER ','
CSV HEADER
ENCODING 'LATIN1';

-- Sales
COPY sales
FROM 'D:\Global-Electronics-Analytics-Dashboard\Sales.csv'
DELIMITER ','
CSV HEADER
ENCODING 'LATIN1';

ALTER TABLE customers
ALTER COLUMN StateCode TYPE VARCHAR(100);

-- Customers duplicates
DELETE FROM customers a
USING customers b
WHERE a.ctid < b.ctid
AND a.CustomerKey = b.CustomerKey;

DELETE FROM products a
USING products b
WHERE a.ctid < b.ctid
AND a.ProductKey = b.ProductKey;
-- Customers
UPDATE customers
SET Gender = 'Unknown'
WHERE Gender IS NULL;

UPDATE customers
SET City = 'Unknown'
WHERE City IS NULL;

-- Products
UPDATE products
SET Brand = 'Unknown'
WHERE Brand IS NULL;

UPDATE customers
SET Name = TRIM(Name),
    City = TRIM(City),
    Country = TRIM(Country);

UPDATE products
SET ProductName = TRIM(ProductName),
    Brand = TRIM(Brand);
	
DELETE FROM sales
WHERE Quantity <= 0;

DELETE FROM products
WHERE UnitPriceUSD <= 0;

ALTER TABLE sales
ADD COLUMN SalesAmount NUMERIC(10,2);
UPDATE sales s
SET SalesAmount = Quantity * p.UnitPriceUSD
FROM products p
WHERE s.ProductKey = p.ProductKey;

ALTER TABLE sales
ADD COLUMN CostAmount NUMERIC(10,2);
UPDATE sales s
SET CostAmount = Quantity * p.UnitCostUSD
FROM products p
WHERE s.ProductKey = p.ProductKey;

ALTER TABLE sales
ADD COLUMN Profit NUMERIC(10,2);
UPDATE sales
SET Profit = SalesAmount - CostAmount;

ALTER TABLE customers
ADD COLUMN Age INT;
UPDATE customers
SET Age = DATE_PART('year', AGE(CURRENT_DATE, Birthday));
CREATE VIEW final_sales_data AS
SELECT 
    s.OrderNumber,
    s.OrderDate,
    s.DeliveryDate,
    c.Name,
    c.Gender,
    c.Age,
    c.City,
    c.Country,
    p.ProductName,
    p.Brand,
    p.Category,
    s.Quantity,
    s.SalesAmount,
    s.CostAmount,
    s.Profit
FROM sales s
JOIN customers c ON s.CustomerKey = c.CustomerKey
JOIN products p ON s.ProductKey = p.ProductKey;

ALTER TABLE sales
ADD COLUMN DeliveryDays INT;
UPDATE sales
SET DeliveryDays = DeliveryDate - OrderDate;

ALTER TABLE sales
ADD COLUMN ProfitMargin NUMERIC(5,2);
UPDATE sales
SET ProfitMargin = (Profit / SalesAmount) * 100;

ALTER TABLE customers
ADD COLUMN AgeGroup VARCHAR(20);
UPDATE customers
SET AgeGroup = 
CASE 
    WHEN Age < 25 THEN 'Young'
    WHEN Age BETWEEN 25 AND 50 THEN 'Adult'
    ELSE 'Senior'
END;

SELECT * FROM final_sales_data;