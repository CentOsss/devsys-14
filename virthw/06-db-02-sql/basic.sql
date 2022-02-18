
CREATE TABLE test_table(id INT, name VARCHAR(255), age DATE);
CREATE INDEX my_indx ON test_table(name);
CREATE TABLE habits(date DATE, count INT, habit VARCHAR(255));
CREATE INDEX habit ON habits(habit);
ALTER TABLE test_table DROP age;
ALTER TABLE test_table ADD CityBer VARCHAR (20) null ;
ALTER TABLE test_table DROP COLUMN Address;
DROP INDEX habit ;


CREATE TABLE Products
(
    Id SERIAL PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INTEGER DEFAULT 0,
    Price NUMERIC
);
 
INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES
('iPhone X', 'Apple', 3, 36000),
('iPhone 8', 'Apple', 2, 41000),
('Galaxy S9', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Desire 12', 'HTC', 5, 28000);


SELECT * FROM PRODUCTS P  ;

SELECT ProductCount, Manufacturer, Price
FROM Products
WHERE Manufacturer = 'Samsung'
AND price > 46000 
OR Manufacturer = 'Apple';

SELECT DISTINCT Manufacturer FROM Products;

SELECT ProductName , ProductCount FROM PRODUCTS P 
ORDER BY ProductCount ASC ;



drop database test_db;



