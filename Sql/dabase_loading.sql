create database maven_toys;
use maven_toys;


CREATE TABLE sales (
    sale_id INT,
    date VARCHAR(20),
    store_id INT,
    product_id INT,
    units INT
);

LOAD DATA LOCAL INFILE 'D:/Downloads/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


CREATE TABLE dates (
    date_col DATE
);
LOAD DATA LOCAL INFILE 'D:/Downloads/calendar3.csv'
INTO TABLE dates
IGNORE 1 ROWS
(@d)
SET date_col = STR_TO_DATE(@d,'%d-%m-%Y');