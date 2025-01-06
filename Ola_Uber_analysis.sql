# 1 Retrieve all customers who have a rating greater than 4:

select * from customer
where Rating > 4;

# 2 Find the total number of trips taken by a particular customer:

select c.Name,count(t.Trip_ID) as Total_No_Of_Trips
from customer as c JOIN trips as t
ON c.Customer_ID = t.Customer_ID
group by c.Name;

# 3 Find the number of trips completed by each driver:

select d.driver_ID, d.Name, count(t.trip_ID) 
from driver as d Left JOIN trips as t
On d.Driver_ID = t.Driver_ID
group by d.driver_ID;

# 4 Update the model of a vehicle given its VEHICLE_ID:
update vehicle
set Model =' Tata Harrier' 
where Vehicle_ID = 19;

# 5 Find the total fare collected for all trips by a particular driver:

select d.driver_ID, d.Name, sum(t.fare) as Toatal_fare
from driver as d Join trips as t
ON d.Driver_Id = t.Driver_ID
group by d.Driver_ID;

# 6 List all customers who have taken more than 2 trips:

select c.Customer_ID, c.Name, count(t.trip_ID) as Total_Trips
from customer as c JOIN trips as t
On c.customer_ID = t.customer_ID
group by c.customer_ID
having count(t.trip_ID) >= 2;

# 7 Find the average rating of all drivers:

select Name, Avg(Rating) as Avg_Rating
from driver
group by Name;

# 8 Retrieve all trips that used a particular payment mode:

SELECT * FROM TRIPS WHERE PAYMENT_MODE = 'Credit Card';

# 9 Find the total distance covered by all trips:

SELECT SUM(DISTANCE) as Total_Distance FROM TRIPS;

# 10 List all drivers who have not taken any trips:

select * from driver 
where driver_ID NOT IN (select distinct Driver_ID from trips);

# 11 Find the total number of customers in each city:

select City,count(*) As Total_Customers from Customer_Address
group by city;

# 12 List all trips that were completed successfully:

select * from trips
where Status ='Completed';

# 13 Find the highest fare collected for a single trip:

select Trip_ID, Max(fare) from trips
group by Trip_ID
order by  fare desc
limit 1;

# 14 Retrieve the details of all trips taken in a specific year:

select * from trips
where Start_Date_Time Between'2024-01-01' And '2024-12-12';

# 15 Find the total number of trips made by each vehicle:

select v.Model,count(t.Trip_ID) as Total_trips
from vehicle as v JOIN trips as t
ON v.vehicle_ID = t.vehicle_ID
group by v.Model
order by Total_trips desc ;

# 16 List all trips that were not completed successfully.

select * from trips
where Status ='Pending';

# 17 Find the average fare of all trips.

select Trip_ID, avg(Fare) 
from trips
group by Trip_Id
order by fare asc;

# 18 List all customers who have not taken any trips.

select c.customer_Id, c.Name
from customer as c Left Join trips as t
ON c.customer_Id = t.Customer_ID
where trip_ID is NULL;

# 19 Find the total number of trips made using each payment mode:

select Payment_mode,count(Trip_ID) as Toatl_trips
from trips
group by Payment_mode;

# 20 Retrieve all customers who have a specific text in their coupon:

SELECT * FROM CUSTOMER 
WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM TRIPS 
WHERE COUPON_ID IN (SELECT COUPON_ID
 FROM COUPONS WHERE TEXT LIKE 'DISCOUNT%'));
 
 # 21 Find the average fare for trips completed by a specific driver:

select d.Name, avg(t.Fare) as Avg_fare
from driver as d JOIN trips as t
On d.Driver_ID = t.Driver_ID
group by d.Name;

# 22 Retrieve the details of trips that lasted more than 1 hour.

SELECT T.TRIP_ID, T.CUSTOMER_ID, TIMESTAMPDIFF(MINUTE, T.START_DATE_TIME, T.END_DATE_TIME) AS DURATION_MINUTES
FROM TRIPS T
WHERE TIMESTAMPDIFF(HOUR, T.START_DATE_TIME, T.END_DATE_TIME) > 1;

# 23 Find customers who have traveled the most distance.

SELECT C.NAME, SUM(T.DISTANCE) AS TOTAL_DISTANCE
FROM CUSTOMER C
JOIN TRIPS T ON C.CUSTOMER_ID = T.CUSTOMER_ID
GROUP BY C.NAME
ORDER BY TOTAL_DISTANCE DESC
LIMIT 1; 

# 24 Retrieve all trips with customer and driver names, along with the vehicle model used.

SELECT T.TRIP_ID, C.NAME AS CUSTOMER_NAME, D.NAME AS DRIVER_NAME, V.MODEL AS VEHICLE_MODEL, T.FARE
FROM TRIPS T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN DRIVER D ON T.DRIVER_ID = D.DRIVER_ID
JOIN VEHICLE V ON T.VEHICLE_ID = V.VEHICLE_ID;

# 25 Retrieve the details of trips where the driver and customer are from the same city.

SELECT T.TRIP_ID, C.NAME AS CUSTOMER_NAME, D.NAME AS DRIVER_NAME, CA.CITY AS CITY
FROM TRIPS T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN CUSTOMER_ADDRESS CA ON C.CUSTOMER_ID = CA.CUSTOMER_ID
JOIN DRIVER D ON T.DRIVER_ID = D.DRIVER_ID
JOIN DRIVER_ADDRESS DA ON D.DRIVER_ID = DA.DRIVER_ID
WHERE CA.CITY = DA.CITY;

# 26 Retrieve all trips where the customer has used a coupon, including coupon details and driver information.

SELECT T.TRIP_ID, C.NAME AS CUSTOMER_NAME, CO.TEXT AS COUPON_TEXT, CO.VALUE AS DISCOUNT, D.NAME AS DRIVER_NAME
FROM TRIPS T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN COUPONS CO ON T.COUPON_ID = CO.COUPON_ID
JOIN DRIVER D ON T.DRIVER_ID = D.DRIVER_ID
WHERE T.COUPON_ID IS NOT NULL;

# 27 Retrieve drivers who have driven vehicles older than 5 years.

SELECT DISTINCT D.NAME AS DRIVER_NAME, V.MODEL AS VEHICLE_MODEL, V.YEAR
FROM DRIVER D
JOIN TRIPS T ON D.DRIVER_ID = T.DRIVER_ID
JOIN VEHICLE V ON T.VEHICLE_ID = V.VEHICLE_ID
WHERE YEAR(V.YEAR) <= YEAR(CURDATE()) - 5;

# 28 Identify the top 3 customers in terms of total spending.

SELECT C.NAME AS CUSTOMER_NAME, SUM(T.FARE) AS TOTAL_SPENDING
FROM CUSTOMER C
JOIN TRIPS T ON C.CUSTOMER_ID = T.CUSTOMER_ID
GROUP BY C.NAME
ORDER BY TOTAL_SPENDING DESC
LIMIT 3;

# 29 Retrieve trips with driver and customer details where the fare exceeds the average fare.

SELECT T.TRIP_ID, C.NAME AS CUSTOMER_NAME, D.NAME AS DRIVER_NAME, T.FARE
FROM TRIPS T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN DRIVER D ON T.DRIVER_ID = D.DRIVER_ID
WHERE T.FARE > (SELECT AVG(FARE) FROM TRIPS);

# 30  Retrieve the details of trips with customers from states where drivers have never been. 

SELECT T.TRIP_ID, C.NAME AS CUSTOMER_NAME, CA.STATE AS CUSTOMER_STATE
FROM TRIPS T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN CUSTOMER_ADDRESS CA ON C.CUSTOMER_ID = CA.CUSTOMER_ID
WHERE CA.STATE NOT IN (
    SELECT DA.STATE
    FROM DRIVER_ADDRESS DA
);




###################################################################################################################################

# add-on SQl Queries with solutions for the ola uber database analysis.

#1 Insert a new customer into the CUSTOMER table.

INSERT INTO CUSTOMER (CUSTOMER_ID, NAME, EMAIL, DOB, RATING) VALUES
(6, 'Adesh', 'Adesh@gmail.com', '2001-07-25', 3);

#2 Update the email of a customer given their CUSTOMER_ID:

update Customer
set Email = 'neha123@gmail.com'
where Customer_ID = 1;

#3 Delete a driver from the DRIVER table given their DRIVER_ID:

delete from Driver
where Driver_ID = 104;

#4 Retrieve all customers who have a rating greater than 4:

select * from customer
where Rating > 4;

#5 Find the total number of trips taken by a particular customer:

select c.Name,count(t.Trip_ID) as Total_No_Of_Trips
from customer as c JOIN trips as t
ON c.Customer_ID = t.Customer_ID
group by c.Name;

#6 List all the vehicles that are categorized as 'SUV':

select model, Category from vehicle
where category = 'SUV';

# 7 Retrieve the details of all trips made using a particular coupon:

select * from trips
where coupon_ID = 3;


# 8 Find the number of trips completed by each driver:

select d.driver_ID, d.Name, count(t.trip_ID) 
from driver as d Left JOIN trips as t
On d.Driver_ID = t.Driver_ID
group by d.driver_ID;

# 9 Insert a new entry into the PAYMENT_INFO table:

INSERT INTO PAYMENT_INFO (PAYMENT_ID, PAYMENT_MODE) VALUES (6, 'Net Banking');

# 10 Update the model of a vehicle given its VEHICLE_ID:

update vehicle
set Model =' Tata Harrier' 
where Vehicle_ID = 15;

#11 Delete a coupon from the COUPONS table given its COUPON_ID: ***

delete from coupons
where coupon_ID =5;

# 12 Retrieve all drivers who have a rating less than 3:

select Name , Rating from driver
where rating < 3;

# 13 Find the total fare collected for all trips by a particular driver:

select d.driver_ID, d.Name, sum(t.fare) as Toatal_fare
from driver as d Join trips as t
ON d.Driver_Id = t.Driver_ID
group by d.Driver_ID;

#14 List all customers who have taken more than 5 trips:

select c.Customer_ID, c.Name, count(t.trip_ID) as Total_Trips
from customer as c JOIN trips as t
On c.customer_ID = t.customer_ID
group by c.customer_ID
having count(t.trip_ID) > 5;

# 15 Retrieve the contact details of a customer given their CUSTOMER_ID:

SELECT * FROM CUSTOMER_CONTACT WHERE CUSTOMER_ID = 1;

#16 Insert a new address for a customer into the CUSTOMER_ADDRESS table:

update Customer_address
set Address_Line1 ='345 MG Road Pune'
where Customer_ID = 5;

# 17 Update the landmark of a driver’s address given their DRIVER_ADDRESS_ID:

UPDATE DRIVER_ADDRESS SET LANDMARK = 'Near Kesnand Phata' WHERE DRIVER_ADDRESS_ID = 1;

#18 Delete an address from the DRIVER_ADDRESS table given its DRIVER_ADDRESS_ID:

DELETE FROM DRIVER_ADDRESS WHERE DRIVER_ADDRESS_ID = 4;

#19 Retrieve all trips that started from a specific location:

select * from trips where
start_location = 'Mumbai';

#20 Find the average rating of all drivers:

select Name, Avg(Rating) as Avg_Rating
from driver
group by Name;

#21 Insert a new driver into the DRIVER table:

INSERT INTO DRIVER (DRIVER_ID, NAME, EMAIL, DOB, RATING) VALUES (106, 'Nikhil', 'Nikhil@gmail.com', '1992-04-18', 3);

# 22 Update the state of a customer’s address given their CUSTOMER_ADDRESS_ID:

update customer_address
set STATE ='J&K'
where CUSTOMER_ADDRESS_ID = 5;

# 23 Delete a customer’s contact from the CUSTOMER_CONTACT table given its CUSTOMER_CONTACT_ID:

DELETE FROM CUSTOMER_CONTACT WHERE CUSTOMER_CONTACT_ID = 1;

# 24 Retrieve all trips that used a particular payment mode:

SELECT * FROM TRIPS WHERE PAYMENT_MODE = 'Credit Card';

#25 Find the total distance covered by all trips:

SELECT SUM(DISTANCE) as Total_Distance FROM TRIPS;

#26 List all drivers who have not taken any trips:

select * from driver where driver_ID NOT IN (select distinct Driver_ID from trips);

# OR
select distinct d.* from driver as d Left Join Trips as t 
ON d.driver_ID  = t.Driver_ID
where trip_ID  IS NULL;

# 27 Retrieve the details of all vehicles manufactured after 2015:

select * from Vehicle
where year > 2015-01-01;

#28 Insert a new coupon into the COUPONS table:

INSERT INTO COUPONS (COUPON_ID, TEXT, VALUE, VALIDITY, START_DATE) VALUES (6, 'DISCOUNT60', '60%', 180, '2024-06-01');

# 29 Update the validity of a coupon given its COUPON_ID:

use ola_uber;
update coupons
set Validity = '35' where COUPON_ID = 4;


# 30 Delete a vehicle from the VEHICLE table given its VEHICLE_ID:***

delete from Vehicle
where VEHICLE_ID = 15;

#31 Retrieve all customers who were born after 1990:

select * from customer
where DOB >1990-12-12;

#32 Find the total number of customers in each city:

select City,count(*) As Total_Customers from Customer_Address
group by city;

# 33 List all trips that were completed successfully:

select * from trips
where Status ='Completed';

#34 Retrieve the email addresses of all drivers:

select Name,Email 
From driver;

#35 Insert a new contact for a driver into the DRIVER_CONTACT table:

update driver_Contact
set Contact ='7258354289'
where Driver_Contact_ID = 1;

# 36 Update the city of a customer’s address given their CUSTOMER_ADDRESS_ID:

update Customer_address
set CITY ='Pune'
where  CUSTOMER_ADDRESS_ID = 3;

# 37 Delete a trip from the TRIPS table given its TRIP_ID:

delete from trips
where TRIP_ID = 1005;

# 38 Retrieve all trips that ended at a specific location:

select * from trips
where End_Location ='Pune';

#39 Find the highest fare collected for a single trip:

select Trip_ID, Max(fare) from trips
group by Trip_ID
order by  fare desc
limit 1;

#40 List all customers who have a rating of 5:

select* from customer
where Rating ='5';

# 41 Retrieve the details of all trips taken in a specific year:

select * from trips
where Start_Date_Time Between'2024-01-01' And '2024-12-12';

# 42 Insert a new trip into the TRIPS table:***

INSERT INTO TRIPS (TRIP_ID, CUSTOMER_ID, DRIVER_ID, VEHICLE_ID, PAYMENT_ID, FARE, STATUS, DISTANCE, START_LOCATION, END_LOCATION, START_DATE_TIME, END_DATE_TIME, COUPON_ID, PAYMENT_MODE, OTP) VALUES 
(1006, 6, 106, 16, 1116, 3000, 'Completed', 60, 'Pune', 'Lonawala', '2024-07-01 08:00:00', '2024-07-01 12:00:00', 6, 'Net Banking', 1617);

# 43 Update the start location of a trip given its TRIP_ID:

update trips
set Start_Location ='Kerla'
where Trip_Id =1003;

# 44 Delete a payment mode from the PAYMENT_INFO table given its PAYMENT_ID:

delete from PAYMENT_INFO
where Payment_ID= 6;

# 45 Retrieve all drivers who were born before 1980:

select * from driver 
where DOB <1980-01-01;

#46 Find the total number of trips made by each vehicle:

select v.Model,count(t.Trip_ID) as Total_trips
from vehicle as v JOIN trips as t
ON v.vehicle_ID = t.vehicle_ID
group by v.Model;

#47 List all vehicles that have traveled more than 10000 KM:

select * from vehicle
where KM >10000;

# 48 Retrieve the names of all customers:

select Name from customer;

# 49 Insert a new address for a driver into the DRIVER_ADDRESS table:

INSERT INTO DRIVER_ADDRESS (DRIVER_ADDRESS_ID, DRIVER_ID, ADDRESS_LINE1, ADDRESS_LINE2, ADDRESS_LINE3, LANDMARK, PINCODE, CITY, STATE) VALUES
 (4, 104, 'Wagholi', 'kesnand phata', 'BUS depot', 'Nagar Road', 123456, 'City', 'Maharashtra');

# 50 Update the color of a vehicle given its VEHICLE_ID:

update Vehicle
set Color = 'Yellow'
where Vehicle_Id = 13;

# 51 Delete a driver’s contact from the DRIVER_CONTACT table given its DRIVER_CONTACT_ID.

delete from Driver_contact
where DRIVER_CONTACT_ID = 5;

# 52 Retrieve all trips that used a specific coupon.

select * from trips 
where coupon_ID = 3;

# 53 Find the total number of drivers in each state.

select State, count(Driver_ID) As Total_No_Of_drivers
from Driver_address
group by State;

# 54 List all trips that were not completed successfully.

select * from trips
where Status ='Not Completed';

# 55 Retrieve the contact details of all drivers.

select d.Name, dc.Driver_Contact_ID, dc.Contact 
from driver as d JOIN Driver_Contact as dc
ON d.Driver_ID= dc.Driver_ID;

# 56 Insert a new customer contact into the CUSTOMER_CONTACT table.

INSERT INTO Customer_Contact (Customer_Contact_ID, Customer_ID, Contact) VALUES 
(6,6, 987863569);

# 57 Update the pin code of a customer’s address given their CUSTOMER_ADDRESS_ID.

update Customer_Address
set Pincode = '411033'
where CUSTOMER_ADDRESS_ID =3;

# 58 Delete a customer’s address from the CUSTOMER_ADDRESS table given its CUSTOMER_ADDRESS_ID.

delete from Customer_Address 
where CUSTOMER_ADDRESS_ID = 6;

# 59 Retrieve all trips that have a fare greater than 500.

select * from trips 
where Fare > 500;

#60 Find the average fare of all trips.

select Trip_ID, avg(Fare) 
from trips
group by Trip_Id
order by fare asc;

# 61 List all customers who have not taken any trips.

select c.customer_Id, c.Name
from customer as c Left Join trips as t
ON c.customer_Id = t.Customer_ID
where trip_ID is NULL;

# 62 Retrieve the details of all vehicles of a specific model.

select * from vehicle
where MODEL ='Tata Nexon';

# 63 Insert a new vehicle into the VEHICLE table:


INSERT INTO Vehicle (Vehicle_ID, Model, Year, Category, Color, KM) VALUES 
(16,'Tata Nexon', '2022-10-25', 'SUV', 'Black', 25000);

# 64 Update the category of a vehicle given its VEHICLE_ID:

update vehicle 
set category ='MVP' where Vehicle_ID = 15;

# 65 Delete a customer from the CUSTOMER table given their CUSTOMER_ID:

delete from Customer where Customer_Id =5;

# 66 Retrieve all trips that started in a specific city:

select * from trips
where Start_location = 'Mumbai';

# 67 Find the total number of trips made using each payment mode:

select Payment_mode,count(Trip_ID) as Toatl_trips
from trips
group by Payment_mode;

# 68 List all drivers who have a rating of 4 or higher:

select * from driver
where Rating >= 4;

# 69 Retrieve the email addresses of all customers:

select Name, Email from customer;

# 70 Insert a new trip for a customer into the TRIPS table:

INSERT INTO Trips (Trip_ID, Customer_ID, Driver_ID, Vehicle_ID, Payment_ID, Fare, Status, Distance, Start_Location, End_Location, Start_Date_Time, End_Date_Time, Coupon_ID, Payment_Mode, OTP) VALUES 
(1005, 5, 105, 15, 1115, 900, 'Completed', 30, 'Ahmedabad', 'Vadodara', '2024-06-30 05:30:00', '2024-06-30 08:00:00', 5, 'Debit card', 3456);

# 71 Update the end location of a trip given its TRIP_ID:

update trips
set END_location = 'TamilNadu'
where Trip_ID = 1003;

# 72 Delete a driver’s address from the DRIVER_ADDRESS table given its DRIVER_ADDRESS_ID:

DELETE FROM DRIVER_ADDRESS WHERE DRIVER_ADDRESS_ID = 5;

# 73 Retrieve all trips that covered a distance greater than 50 KM:

select * from trips 
where Distance > 50;

# 74 Find the average rating of all customers:

select avg(Rating) from customer;

# 75 List all trips that started and ended in the same location:

select * from trips
where Start_Location = End_Location;

# 76 Retrieve the contact details of a customer given their contact number:

SELECT * FROM CUSTOMER_CONTACT WHERE CONTACT = '8765432109';

# 77 Insert a new entry into the CUSTOMER table:

INSERT INTO CUSTOMER (CUSTOMER_ID, NAME, EMAIL, DOB, RATING) VALUES
 (7, 'Mayur', 'Mayur@gmail.com', '2001-09-23', 5);
 
 # 78 Update the rating of a driver given their DRIVER_ID:

UPDATE DRIVER SET RATING = 4 WHERE DRIVER_ID = 1;

# 79 Delete a trip from the TRIPS table given its TRIP_ID:

DELETE FROM TRIPS WHERE TRIP_ID = 1;

# 80 Retrieve all drivers who live in a specific state:

SELECT * FROM DRIVER_ADDRESS WHERE STATE = 'Maharashtra';

# 81 Find the total fare collected by each payment mode:

SELECT PAYMENT_MODE, SUM(FARE) as Total_Fare
 FROM TRIPS GROUP BY PAYMENT_MODE;
 
 # 82 List all vehicles of a specific color:

select * from vehicle 
where Color ='Black';

# 83 Retrieve the details of all trips taken by a specific driver:

SELECT * FROM TRIPS WHERE DRIVER_ID = 103;

# 84 Insert a new coupon into the COUPONS table:

INSERT INTO COUPONS (COUPON_ID, TEXT, VALUE, VALIDITY, START_DATE) VALUES 
(7, 'DISCOUNT70', '70%', 210, '2024-07-01');

# 85 Update the start date of a coupon given its COUPON_ID:

UPDATE COUPONS SET START_DATE = '2024-08-01' WHERE COUPON_ID = 5;

# 86 Delete a vehicle from the VEHICLE table given its VEHICLE_ID:***

delete from vehicle
where Vehicle_ID = 11;

# 87 Retrieve all customers who live in a specific city:

SELECT * FROM CUSTOMER_ADDRESS WHERE CITY = 'Pune';

# 88 Find the total number of trips made by each customer:

select Customer_ID, count(trip_ID) AS Total_Trips
from trips
group by trip_ID;

# OR
SELECT CUSTOMER_ID, COUNT(*) as Total_Trips FROM TRIPS GROUP BY CUSTOMER_ID;

# 89 List all trips that used a specific payment mode:

SELECT * FROM TRIPS WHERE PAYMENT_MODE = 'Debit Card';

# 90 Retrieve the names of all drivers:

select Name from driver;

# 91 Insert a new entry into the DRIVER table:

INSERT INTO DRIVER (DRIVER_ID, NAME, EMAIL, DOB, RATING) VALUES
 (107, 'Satish', 'satish@gmail.com', '1990-05-06', 3);

# 92 Update the email of a customer given their CUSTOMER_ID:

update customer
set Email = 'Adesh123@gmail.com'
where CUSTOMER_ID = 6;

# 93 Delete a customer’s contact from the CUSTOMER_CONTACT table given its CUSTOMER_CONTACT_ID:

DELETE FROM CUSTOMER_CONTACT WHERE CUSTOMER_CONTACT_ID = 1;

# 94 Retrieve all trips that were completed within a specific time range:

SELECT * FROM TRIPS
 WHERE START_DATE_TIME BETWEEN '2024-01-01' AND '2024-06-30';

# 95 Find the average distance covered by all trips:

select avg(distance) from trips;

# 96 List all drivers who have taken more than 10 trips:

SELECT DRIVER_ID, COUNT(*) as Total_Trips
 FROM TRIPS GROUP BY DRIVER_ID HAVING COUNT(*) > 10;
 
 # 97 Retrieve the details of all trips made using a specific vehicle:

select * from trips 
where Vehicle_Id = 11;

# 98 Insert a new entry into the VEHICLE table:

INSERT INTO VEHICLE (VEHICLE_ID, MODEL, CATEGORY, YEAR, COLOR, KM) VALUES 
(17, 'Thar', 'SUV', '2022-01-01', 'Mat Grey', 30000);

# 99 Update the year of a vehicle given its VEHICLE_ID:

UPDATE VEHICLE SET YEAR = '2024-01-01' WHERE VEHICLE_ID = 11;

# 100 Delete a driver from the DRIVER table given their DRIVER_ID:

 DELETE FROM DRIVER WHERE DRIVER_ID = 106;
 
# 101 Retrieve all customers who have a specific text in their coupon:

SELECT * FROM CUSTOMER 
WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM TRIPS 
WHERE COUPON_ID IN (SELECT COUPON_ID
 FROM COUPONS WHERE TEXT LIKE 'DISCOUNT%'));

# OR 
select c.Customer_ID, c.Name, c.Email,cp.Text
from customer as c Left Join trips as t
On c.Customer_ID = t.Customer_ID
Join coupons as cp
On t.Coupon_ID = cp.coupon_ID
Having Text LIKE 'DISCOUNT%';


# 102 Find the total number of trips completed by each vehicle in a specific year:

select vehicle_ID,count(Trip_ID) as Total_trips from trips
where Start_Date_Time between '2024-01-01' AND '2024-12-12'
group by vehicle_ID;

# 103 List all customers who have taken trips starting or ending in a specific location:

select * from customer as c
JOIN trips as t
ON c.Customer_ID = t.Customer_ID
where Start_Location = 'Mumbai' OR End_Location = 'Pune';

# 104 Retrieve the contact details of all customers who have not taken any trips:

SELECT * FROM CUSTOMER_CONTACT 
WHERE CUSTOMER_ID NOT IN (SELECT DISTINCT CUSTOMER_ID FROM TRIPS);

# 105 Insert a new driver contact into the DRIVER_CONTACT table:

INSERT INTO DRIVER_CONTACT (DRIVER_CONTACT_ID, DRIVER_ID, CONTACT) VALUES 
(5, 105, '9876543211');

# 106 Update the address of a driver given their DRIVER_ADDRESS_ID:

UPDATE DRIVER_ADDRESS 
SET ADDRESS_LINE1 = 'Pune-Nagar,Wagholi'
 WHERE DRIVER_ADDRESS_ID = 104; 
 
 # 107 Delete a customer’s address from the CUSTOMER_ADDRESS table given its CUSTOMER_ADDRESS_ID:

DELETE FROM CUSTOMER_ADDRESS 
WHERE CUSTOMER_ADDRESS_ID = 5;

# 108 Retrieve all trips that started in a specific city and ended in another specific city:

SELECT * FROM TRIPS
 WHERE START_LOCATION = 'Delhi' AND END_LOCATION = 'Agra';

# 109 Find the total number of customers with a rating less than 3:

select * from customer
where Rating < 3;

# 110 List all trips that were completed successfully and had a fare greater than 700:

select * from trips
where Status= 'Completed' AND Fare > 700;

# 111 Retrieve the details of all vehicles that have traveled less than 50,000 KM:

select * from vehicle
where KM < 50000;

# 112 Insert a new payment mode into the PAYMENT_INFO table:

INSERT INTO PAYMENT_INFO (PAYMENT_ID, PAYMENT_MODE) VALUES (1116, 'UPI');

# 113 Update the validity of a coupon given its COUPON_ID:

UPDATE COUPONS
 SET VALIDITY = 220 WHERE COUPON_ID = 1;
 
 # 114 Delete a vehicle from the VEHICLE table given its VEHICLE_ID:

DELETE FROM VEHICLE WHERE VEHICLE_ID = 1;

# 115 Retrieve all trips that used a specific payment mode and coupon.

SELECT * FROM TRIPS
WHERE PAYMENT_MODE = 'Debit card' AND COUPON_ID = 3;

#116 Retrieve the names of all drivers who live in 'Mumbai':

select d.Name, da.City
from driver as d JOIN Driver_address as da
On d.Driver_ID = da.Driver_ID
having da.City = 'Pune';

#117 Find the total number of customers in each state:

select state,count(*) as total_Customers
from Customer_Address
group by state;

# 118 List all trips that started and ended in different cities:

select * from trips
where Start_Location != End_location;

# 119 Retrieve the details of the longest trip taken by distance:

select * from trips
order by Distance desc
limit 1;

# 120 Insert a new driver contact into the DRIVER_CONTACT table:

INSERT INTO DRIVER_CONTACT (Driver_Contact_ID, Driver_ID, Contact)
VALUES (6, 106, '9876543210');

# 121 Update the rating of a customer given their CUSTOMER_ID:

update customer
set Rating = 1
where Customer_ID = 1;

# 122 Delete a coupon from the COUPONS table given its TEXT:

delete from coupons 
where Text = 'Discount60';

# 123 Retrieve all customers who have not updated their contact details:

select c.Customer_ID, c.Name
from customer as c Left Join Customer_Contact as cc
ON c.Customer_ID = cc.Customer_ID
where cc.Contact IS NULL;

 # 124 Find the total number of trips taken in each month of the current year:*********************

select month(Start_Date_Time) AS  Month ,count(*) As Total_trips from trips
where year(Start_Date_Time) = year(now())
group by month(Start_Date_Time);

use ola_uber;

#125 List all drivers who have taken trips with a fare greater than 1000:

select d. Name ,t.fare
from driver as d Join trips as t
On d.Driver_Id = t.Driver_ID
where t.Fare > 600;

# 126 Retrieve the names of all customers who live in 'Delhi':

select c.Name ,ca.City from customer as c 
Join Customer_Address as ca
On c.Customer_ID = ca.Customer_ID
where ca.City ='Delhi';

# 127 Insert a new entry into the CUSTOMER table for a customer without an email address:

INSERT INTO CUSTOMER (CUSTOMER_ID, NAME, EMAIL, DOB, RATING) VALUES
(8, 'sahil', '', '1999-05-12', 3);

# 128 Update the email of a driver given their DRIVER_ID:

update driver 
set Email = 'Karan123@gmail.com'
where Driver_ID = 103;

# 129 Delete a customer from the CUSTOMER table who has not taken any trips:

delete from customer
where customer_ID Not in( select distinct Customer_ID from Trips);

# 130 Retrieve all trips that were paid using 'Credit Card':

select * from trips
where Payment_Mode = 'credit card';

# 131 Find the average fare for trips completed by a specific driver:

select d.Name, avg(t.Fare) as Avg_fare
from driver as d JOIN trips as t
On d.Driver_ID = t.Driver_ID
group by d.Name;

# for specific Driver
SELECT Driver_ID, AVG(Fare) as Average_Fare
FROM TRIPS
WHERE Driver_ID = 101
GROUP BY Driver_ID;

# 132 List all vehicles that have not been used in any trips:

select v.* from vehicle as v
Left Join trips as t
On v.Vehicle_Id = t.Vehicle_ID
where t.trip_ID IS NULL; 

# 133 Retrieve the details of the most recent trip taken:

select * from trips
order by Start_Date_Time desc
limit 1;

# 134 Insert a new address for a driver into the DRIVER_ADDRESS table:

INSERT INTO DRIVER_ADDRESS (Driver_Address_ID, Driver_ID, Address_Line1, City, State, Pincode)
VALUES (5, 105, '123 New Street', 'Kolkata', 'West Bengal', 700001);

# 135 Update the category of a vehicle given its model:

update vehicle
set category ='HatchBack'
where Model ='Thar';

# 136 Delete a customer’s contact from the CUSTOMER_CONTACT table given their contact number:

delete from Customer_Contact
where Contact ='7654321098';

#137 Retrieve all trips that have a distance less than 10 KM:

select * from trips 
where Distance < 20;

# 138 Find the total number of customers who have a rating of 3 or higher:

select count(Customer_ID) as Total_Customers
from customer
where Rating >=3;

# 139 List all drivers who have a contact number starting with '987':

select d.* from driver as d
JOIN Driver_contact as dc
ON d.driver_ID = dc.driver_ID
where dc.Contact LIKE '987%';

#140 Retrieve the details of all trips taken during a specific month:

select * from trips
where month(Start_Date_Time) = 6;

# 141 Insert a new coupon into the COUPONS table with a specific start date:

INSERT INTO COUPONS (Coupon_ID, Text, Value,Validity, Start_Date)
VALUES (8, 'SUMMER2023', '10%','90', '2023-06-01');

# 142 Update the start date of a coupon given its TEXT:

update coupons
set Start_date ='2024-02-01'
where text= 'NEWYEAR2024';

#143 Delete a vehicle from the VEHICLE table that has traveled more than 200,000 KM:

delete from vehicle 
where KM > 2000000;

# 144 Retrieve all customers who live in 'Chennai' and have a rating greater than 4:

select c.* from customer as c
JOIN customer_Address as ca
On c.Customer_ID = ca.Customer_ID
where ca.City =' Chennai' AND c.Rating > '4';

# 145 Find the total fare collected for all trips using a specific vehicle:

select vehicle_ID, sum(Fare) 
from trips
where vehicle_ID = 12;

#146 List all trips that started from a specific landmark:

select * from trips
where Start_location ='Mumbai';

# 147 Retrieve the names and email addresses of all drivers who have a rating of 4:

select Name,Email from driver
where Rating = 4;

 #148 Insert a new entry into the PAYMENT_INFO table for 'Digital Wallet':

INSERT INTO PAYMENT_INFO (Payment_ID, Payment_Mode)
VALUES (1117, 'Digital Wallet');

#149 Update the model and category of a vehicle given its VEHICLE_ID:

update vehicle
set Model = 'Pajero', Category ='SUV'
where Vehicle_ID = 11;

# 150 Delete a customer’s address from the CUSTOMER_ADDRESS table given their PINCODE:

DELETE FROM CUSTOMER_ADDRESS
WHERE Pincode = 400003;

# 151 Retrieve all trips that ended in 'Bangalore' and used a specific payment mode:

select * from trips
where End_Location = 'Mysore' And Payment_Mode= 'credit card';

#152.Find the total number of trips taken by customers who have a rating less than 3.

SELECT COUNT(*) FROM Trips AS T
JOIN Customer AS C ON T.Customer_ID = C.Customer_ID
WHERE C.Rating < 3;

#153.List all drivers who have an address in 'Pune'.

SELECT D.* FROM Driver AS D
JOIN Driver_Address AS DA 
ON D.Driver_ID = DA.Driver_ID
WHERE DA.CITY = 'Pune';

#154.Retrieve the details of all trips taken by a specific customer within a date range.

SELECT * FROM Trips
WHERE Customer_ID = 1
AND Start_Date_Time BETWEEN '2024-01-01' AND '2024-12-31';

#155.Insert a new trip into the TRIPS table with a specific coupon.

INSERT INTO Trips (Trip_ID, Customer_ID, Driver_ID, Vehicle_ID, Payment_ID, Fare, Status, Distance, Start_Location, End_Location, Start_Date_Time, End_Date_Time, Coupon_ID, Payment_Mode, OTP)
VALUES (1008, 6, 101, 11, 1111, 600, 'Completed', 20, 'Mumbai', 'Pune', '2021-07-01 08:00:00', '2021-07-01 10:00:00', 1, 'Cash', 1111);

#156.Update the end date and time of a trip given its TRIP_ID.

UPDATE Trips
SET End_Date_Time = '2024-06-20 11:30:30'
WHERE Trip_ID = 1002;

#157.Delete a payment mode from the PAYMENT_INFO table that is no longer used.

DELETE FROM Payment_INFO
WHERE Payment_ID = 1117; 

#158.Retrieve all trips that have an OTP ending in '1234'.
SELECT * FROM Trips
WHERE OTP = 1234;

#159.Find the average distance covered by trips in a specific year.

SELECT Avg(Distance) FROM Trips
WHERE YEAR(Start_Date_Time) = 2024;

#160.List all customers who have not updated their address details.

SELECT C.* FROM Customer AS C
JOIN Customer_Address AS CA
ON C.Customer_ID = CA.Customer_ID
WHERE CA.Address_LINE2 IS NULL;

#161.Retrieve the details of all vehicles that are 'Red' and have traveled less than 50,000 KM.

SELECT * FROM Vehicle
WHERE Color = 'Red' AND KM < 50000;

#162.Insert a new customer address into the CUSTOMER_ADDRESS table for a customer who lives in 'Goa'.

INSERT INTO Customer_Address (Customer_Address_ID, Customer_ID, Address_LINE1, Address_LINE2, Address_LINE3, Landmark, PINCODE, CITY, STATE)
VALUES (7, 7, 'Church Gate', 'Line2', 'Line3', 'Near Church', 403001, 'Goa City', 'Goa');

# 163 Update the contact number of a driver given their DRIVER_CONTACT_ID:

update Driver_Contact
set Contact ='9865743754'
where DRIVER_CONTACT_ID ='5';

# 164 Delete a customer from the CUSTOMER table who has a rating less than 2:

delete from customer
where Rating < 2;

# 165 Retrieve all trips that were completed within the last month:***

select * from trips
where Start_Date_time >= month(now()) - 1;

# 166 Find the total fare collected by each driver in a specific month:

select Driver_ID, sum(fare)
from trips
where month(Start_Date_time) = 6
group by Driver_ID;

#167 List all vehicles that are 'SUV' and were manufactured in '2020':

SELECT *
FROM VEHICLE
WHERE Category = 'SUV' AND YEAR(Year) = 2021;

# 168 Retrieve the names of all customers who have taken a trip with a fare greater than 500:

SELECT c.Name
FROM CUSTOMER c
JOIN TRIPS t ON c.Customer_ID = t.Customer_ID
WHERE t.Fare > 500;

# 169 Insert a new address for a customer into the CUSTOMER_ADDRESS table for a customer who lives in 'Delhi':

INSERT INTO CUSTOMER_ADDRESS (Customer_Address_ID, Customer_ID, Address_Line1, City, State, Pincode)
VALUES (8, 8, '456 Main Street', 'Delhi', 'Delhi', 110001);

# 170 Update the start and end location of a trip given its TRIP_ID:

UPDATE TRIPS
SET Start_Location = 'London', End_Location = ' Southampton'
WHERE Trip_ID = 1005;

# 171 Delete a driver’s contact from the DRIVER_CONTACT table given their contact number:

DELETE FROM DRIVER_CONTACT
WHERE Contact = '9876543210';

# 172 Retrieve all trips that started and ended on the same date:

select * from trips
where Start_date_time = End_Date_Time;

# 173 Find the total number of trips taken by each customer in a specific month:

select customer_ID, count(*)  as Total_trips 
from trips
where month(Start_date_Time)= 6
group by customer_ID;

# 174 List all drivers who have taken more than 5 trips in the last week:

select d.Driver_ID,d.Name, count(t.Trip_ID) as Trips
from driver as d Join trips as t
On d.driver_Id = t.Driver_ID
where t.Start_Date_Time >= now() - interval 1 week
group by d.driver_ID, d.Name
Having count(t.trip_Id) > 5;

# 175 Retrieve the details of all trips taken by a specific driver within a date range:

SELECT *
FROM TRIPS
WHERE Driver_ID = 105 AND Start_Date_time BETWEEN '2024-01-01' AND '2024-12-31';

# 176 Insert a new driver address into the DRIVER_ADDRESS table for a driver who lives in 'Kolkata':

INSERT INTO DRIVER_ADDRESS (Driver_Address_ID, Driver_ID, Address_Line1, City, State, Pincode)
VALUES (6, 106, '789 Park Street', 'Kolkata', 'West Bengal', 700001);

# 180 Update the model of a vehicle given its VEHICLE_ID and new model name:

UPDATE VEHICLE
SET Model = 'Kia Seltos'
WHERE Vehicle_ID = 17;

# 181 Delete a customer’s address from the CUSTOMER_ADDRESS table given their CITY:

DELETE FROM CUSTOMER_ADDRESS
WHERE City = 'Mumbai';

# 182 Retrieve all trips that used a specific coupon and payment mode:

select * from trips
where coupon_Id ='3' AND Payment_Mode ='Debit card';

# 183 Find the average rating of customers who have taken more than 10 trips:

SELECT AVG(c.Rating) as Average_Rating
FROM CUSTOMER c
WHERE c.Customer_ID IN (SELECT Customer_ID FROM TRIPS GROUP BY Customer_ID HAVING COUNT(Trip_ID) > 10);

# 184 List all drivers who have not updated their address details:

SELECT d.*
FROM DRIVER d
LEFT JOIN DRIVER_ADDRESS da ON d.Driver_ID = da.Driver_ID
WHERE da.Address_Line1 IS NULL;

# 185 Retrieve the details of all trips taken by customers who live in 'Hyderabad':

select t.* from trips t
join Customer_address as ca 
on t.customer_ID = ca.customer_ID 
where ca.City = 'mumbai';

# 186 Insert a new entry into the CUSTOMER_CONTACT table for a customer with a specific contact number:

INSERT INTO CUSTOMER_CONTACT (Customer_Contact_ID, Customer_ID, Contact)
VALUES (1, 1, '9876543210');

# 189 Update the start date of a coupon given its COUPON_ID and new start date:

UPDATE COUPONS
SET Start_Date = '2023-07-01'
WHERE Coupon_ID = 1;

# 190 Delete a vehicle from the VEHICLE table given its model and color:

DELETE FROM VEHICLE
WHERE Model = 'Tata nexon' AND Color = 'black';

# 191 Retrieve all customers who live in 'Bangalore' and have a rating less than 3:

select c.* from customer as c
JOIN Customer_address as ca
on c.Customer_ID = ca.Customer_Id
where ca.City = 'Ahmedabad' AND c.Rating < 3;

# 192 Find the total fare collected for all trips completed in a specific year:

SELECT SUM(Fare) as Total_Fare
FROM TRIPS
WHERE YEAR(Start_Date_Time) = 2024;

# 193 List all trips that started from a specific location and ended in 'Mumbai':

SELECT *
FROM TRIPS
WHERE Start_Location = 'pune' AND End_Location = 'Mumbai';

# 194 Retrieve the names and contact numbers of all drivers who have a rating less than 4:

SELECT d.Name, dc.Contact
FROM DRIVER d
JOIN DRIVER_CONTACT dc ON d.Driver_ID = dc.Driver_ID
WHERE d.Rating < 4;

# 195 Insert a new payment mode into the PAYMENT_INFO table for 'UPI':

INSERT INTO PAYMENT_INFO (Payment_ID, Payment_Mode)
VALUES ('1117', 'Cash');

# 196 Update the year and color of a vehicle given its VEHICLE_ID:

UPDATE VEHICLE
SET Year = '2020-01-01', Color = 'Blue'
WHERE Vehicle_ID = 16;

# 197 Delete a customer’s contact from the CUSTOMER_CONTACT table given their CUSTOMER_ID and contact number:

DELETE FROM CUSTOMER_CONTACT
WHERE Customer_ID = 1 AND Contact_Number = '9876543210';

# 198 Retrieve all trips that ended in 'Pune' and were completed successfully:

select * from trips 
where End_Location = 'Pune' AND Status = 'Completed';

# 199 Find the total number of trips taken by customers who live in 'Delhi':

select count(t.Trip_ID) as total_trips 
from trips as t JOIN customer_address as ca
On t.Customer_ID = ca.Customer_ID
where ca.city =' delhi';

# 200 List all drivers who have taken trips that started and ended in different cities:

SELECT d.*
FROM DRIVER d
JOIN TRIPS t ON d.Driver_ID = t.Driver_ID
WHERE t.Start_Location <> t.End_Location;

# 201 Retrieve the details of the shortest trip taken by distance:

select * from trips 
order by Distance asc
limit 1;

# 202 Insert a new entry into the DRIVER table for a driver who was born in '1995':

INSERT INTO DRIVER (Driver_ID, Name, DOB, Rating, Email)
VALUES (108, 'Pratik', '1995-01-01', 5, 'Pratik@gmail.com');

# 203 Update the email of a customer given their NAME:

update customer
set Email ='sneha123@gmail.com'
where Name =' sneha';

# 204 Delete a customer from the CUSTOMER table who has a rating of 1:

DELETE FROM CUSTOMER
WHERE Rating = 1;

# 205 Retrieve all trips that were paid using 'Debit Card':

SELECT *
FROM TRIPS
WHERE Payment_Mode = 'Debit Card';

#206 Find the average fare for trips taken by customers who live in 'Mumbai':

SELECT AVG(Fare) as Average_Fare
FROM TRIPS t
JOIN CUSTOMER_ADDRESS ca ON t.Customer_ID = ca.Customer_ID
WHERE ca.City = 'Mumbai';

# 207 List all vehicles that have been used in more than 20 trips:

SELECT v.* FROM VEHICLE v
JOIN TRIPS t ON v.Vehicle_ID = t.Vehicle_ID
GROUP BY v.Vehicle_ID
HAVING COUNT(t.Trip_ID) > 20;

# 208 Retrieve the details of the first trip taken by a specific customer:

select * from trips
where Customer_ID = 1
order by Start_Date_Time asc
limit 1;

# 209 Insert a new address for a driver into the DRIVER_ADDRESS table for a driver who lives in 'Chennai':

INSERT INTO DRIVER_ADDRESS (Driver_Address_ID, Driver_ID, Address_Line1, City, State, Pincode)
VALUES (7, 107, '123 Mount Road', 'Chennai', 'Tamil Nadu', 600001);

# 210 Update the category of a vehicle given its model and new category:

UPDATE VEHICLE
SET Category = 'MINI SUV'
WHERE Model = 'Kia Seltos';

# 211 Retrieve all trips that have a fare between 100 and 500:

select * from trips 
where Fare between 100 AND 500;

# 212 Find the total number of customers who have not taken any trips in the last month:****************

use ola_uber;

select Count(Customer_ID)  AS Total_Customers from trips
where abs(timestampdiff( day, now(),start_Date_Time)) <= 30 AND trip_ID IS NULL
group by customer_ID;

# 213 List all drivers who have a contact number ending in '1234':
select d.* from driver as d
JOIN driver_Contact as dc
ON d.driver_Id= dc.driver_ID
where dc.Contact like '%5678';

# 214 Retrieve the details of all trips taken in a specific month and year:

select * from trips
where month(Start_Date_Time) = 6 AND YEAR(Start_Date_Time) = 2024;

# 215 Insert a new coupon into the COUPONS table with a specific value and validity:

INSERT INTO COUPONS (Coupon_ID, Text, Value, Validity, Start_Date)
VALUES (9, 'Hangama', '50%', '120', '2023-07-01');

# 216 Update the validity of a coupon given its TEXT and new validity period:

update coupons
set Validity ='150'
where Text ='DISCOUNT60';

# 217 Delete a vehicle from the VEHICLE table that has a specific color and year:

delete from vehicle
where Color ='Yellow' AND year ='2021-02-02';

# 218 Retrieve all customers who live in 'Hyderabad' and have taken more than 3 trips:

select c.* from  customer as c 
JOIN customer_address as ca 
ON c.Customer_ID = ca.Customer_ID
JOIN trips as t
ON c.Customer_ID = t.Customer_ID
where ca.City ='Hyderabad' 
group by Customer_ID
Having count(t.Trip_ID) > 3;

# 219 Find the total fare collected for all trips that used a specific payment mode and coupon.

select sum(fare)  
from trips
where Payment_Mode ='Cash' AND Coupon_ID ='1';


#220 Retrieve the names of all customers who have not updated their contact details.

select c.Name from customer as c
LEFT JOIN Customer_Contact as cc
ON c.Customer_ID = cc.Customer_ID
where cc.CUSTOMER_ID IS NULL;


#221 Find the total number of drivers who have not taken any trips in the last year.******************************

select Count(d.DRIVER_ID) AS Total_Driver from driver as d 
left join trips as t
on d.driver_ID = t.driver_Id
AND abs(timestampdiff(day, now(), Start_Date_Time)) <= 365 
where t.trip_Id IS NULL;

#222 List all trips that were completed in less than 30 minutes.
select * from trips
where timestampdiff(minute ,Start_Date_Time, End_Date_Time) < 30;


#223 Retrieve the details of the trip with the highest fare.

select * from trips
order by fare desc
limit 1;

# second highest fare

select * from trips
order by fare desc
limit 1
offset 1;

# 224 Insert a new payment mode into the PAYMENT_INFO table for 'Cryptocurrency'.

INSERT INTO PAYMENT_INFO (Payment_ID,Payment_Mode)
VALUES (1118,'Cryptocurrency');

#225 Update the rating of a driver given their DRIVER_ID.

update Driver
set Rating ='5'
where Driver_ID = 104;

# 226 Delete a coupon from the COUPONS table given its VALUE.
delete from coupons
where Value ='10%';

# 227 Retrieve all drivers who have not updated their address details.

SELECT d.Name 
FROM DRIVER d
LEFT JOIN DRIVER_ADDRESS da ON d.Driver_ID = da.Driver_ID
WHERE da.Driver_ID IS NULL;


#228 Find the total number of trips taken in each city.

select Start_Location as City , count(Trip_ID) as Total_Trips 
from trips
group by Start_Location;

#229 List all trips that started and ended in the same city.

select * from trips
where Start_Location = End_Location;
 
#230 Retrieve the names of all customers who have taken trips with a fare less than 100.

select c.Name from customer as c
JOIN trips as t
On c.Customer_ID = t.Customer_ID
where t.fare < 100;

#231 Insert a new entry into the CUSTOMER table for a customer without a rating.

INSERT INTO CUSTOMER (Customer_ID, Name, Email, DOB)
VALUES (9, 'Tushar', 'Tushar@gmail.com', '2001-12-12');

#232 Update the email of a customer given their EMAIL.

update customer
set email ='neha@gmail.com'
where email='neha123@gmail.com';

#233 Delete a driver from the DRIVER table who has not taken any trips.

DELETE FROM DRIVER 
WHERE DRIVER_ID NOT IN (SELECT DISTINCT Driver_ID FROM TRIPS);

#234 Retrieve all trips that were paid using 'Net Banking'.

select * from trips
where Payment_Mode = 'Net Banking';

#235 Find the average distance covered in trips completed by a specific vehicle.

select Vehicle_ID, avg(distance) as Total_Distance
from trips 
where Vehicle_ID = 15;


 #236 List all vehicles that have been used in trips with a fare greater than 1000.
 
 select Distinct v.* from Vehicle as v
 join trips as t 
 ON v.Vehicle_ID = t.vehicle_ID
 where t.fare > 1000;
 
 # 237 Retrieve the details of the first trip taken.
 select * from trips
 order by Start_Date_Time asc
 limit 1;
 
# 238 Insert a new contact for a customer into the CUSTOMER_CONTACT table.

INSERT INTO CUSTOMER_CONTACT (Customer_Contact_ID, Customer_ID, Contact)
VALUES (7, 7, '3658736543');


# 239 Update the color of a vehicle given its model.

update vehicle
set color = 'red'
where model = 'pajero';

# 240 Delete a driver’s address from the DRIVER_ADDRESS table given their PINCODE.

DELETE FROM DRIVER_ADDRESS 
WHERE PINCODE = 600042;

# 241 Retrieve all trips that have a fare between 500 and 1000.

select * from  trips 
where fare between 500 AND 1000;

#242 Find the total number of customers who have a rating of 4 or higher.

select count(Customer_ID) As customer
from customer
where Rating >= 4;

# 245 List all trips that started from a specific city and ended in another city.

SELECT * 
FROM TRIPS 
WHERE Start_Location = 'Delhi' AND End_Location = 'agra';


# 246 Retrieve the names and email addresses of all customers who have a rating less than 3.

select Name , Email from customer 
where Rating < 3;

# 247 Insert a new address into the CUSTOMER_ADDRESS table for a customer who lives in 'Pune'.

INSERT INTO CUSTOMER_ADDRESS (Customer_Address_ID, Customer_ID, Address_LINE1, CITY, STATE, PINCODE)
VALUES (9, 9, 'Kalewadi Phata', 'Pune', 'Maharashtra', 411036);


# 249 Update the start date of a coupon given its VALUE.

update coupons 
set Start_Date = '2022-08-12'
where Value = ' 25%';

# 250 Delete a customer’s contact from the CUSTOMER_CONTACT table given their contact number.

DELETE FROM CUSTOMER_CONTACT 
WHERE Contact= '987863569';

# 251 Retrieve all customers who live in 'Delhi' and have a rating greater than 5.

select c.* from customer as c
JOIN Customer_Address as ca
ON c.Customer_ID = ca.Customer_ID
where ca.City = 'delhi' AND c.Rating > 5;

# 252 Find the total fare collected by each driver in the last month.*************************************

select d.Driver_ID, d.Name ,Sum(t.Fare) from driver as d 
Join  trips as t
On d.Driver_ID = t.Driver_ID
where abs(timestampdiff(day, now(),Start_Date_Time)) <= 30
group by d.Driver_ID;

use ola_uber;


# 253 List all trips that ended at a specific landmark.

select * from trips 
where End_Location  ='Pune';

# 254 Retrieve the names of all drivers who have taken trips with a distance greater than 20 KM.

select d.Name, t.Distance from driver as d
JOIN  trips as t
where t.Distance > 20;

# 255 Insert a new entry into the PAYMENT_INFO table for 'PayPal'.

INSERT INTO PAYMENT_INFO (Payment_ID,Payment_Mode)
VALUES (1119,'PayPal');

# 256 Update the model and color of a vehicle given its VEHICLE_ID.

update vehicle
set  Model = 'MG HECTOR' ,color = 'white'
where Vehicle_ID = 16;

# 257 Delete a driver’s address from the DRIVER_ADDRESS table given their CITY.

DELETE FROM DRIVER_ADDRESS 
WHERE CITY = 'city';

# 258 Retrieve all trips that started in 'Bangalore' and ended in 'Chennai'.

select * from trips 
where Start_Location = 'Bangalore' And End_Location ='chennai';

#259 Find the total number of trips taken by each vehicle in the last month.***************************

SELECT Vehicle_ID, COUNT(*) AS Total_Trips
FROM TRIPS 
WHERE abs(timestampdiff( day, now(), Start_Date_Time)) <= 30
GROUP BY Vehicle_ID;


#260 List all trips that used a specific payment mode and coupon.

SELECT * 
FROM TRIPS 
WHERE Payment_Mode = 'Cash' AND Coupon_ID = 1;


# 261 Retrieve the names of all customers who have taken more than 5 trips in the last year.***************

select c.Name ,Count(t.Trip_ID) from customer as c
JOIN trips as t
ON c.customer_ID = t.customer_ID
where year(t.Start_Date_Time ) >= now() - 1 AND year(Start_Date_Time) = year(now())
group by c.Name
having Count(t.trip_ID) > 5;

#262 Insert a new driver into the DRIVER table for a driver without an email address.

INSERT INTO DRIVER (Driver_ID, Name, DOB, Rating)
VALUES (109, 'Navin', '1992-07-04', 4);

# 263 Update the email of a customer given their NAME and new email address.

update customer
set Email ='neha@gmail.com'
where Name =' Neha';

# 264 Delete a customer from the CUSTOMER table who has not updated their contact details.

DELETE FROM CUSTOMER 
WHERE Customer_ID NOT IN (
SELECT Customer_ID 
FROM CUSTOMER_CONTACT
);

# 265 Retrieve all trips that ended in 'Hyderabad' and used 'UPI'.

SELECT * FROM TRIPS 
WHERE End_Location = 'Hyderabad' AND Payment_Mode = 'UPI';

# 266 Find the average fare for trips taken by drivers who have a rating less than 4.

select d.Name, avg(t.fare) as avg_fare from driver as d
JOIN trips as t
ON d.Driver_ID = t.Driver_ID
where d.Rating < 4
group by d.Name;

#267 List all vehicles that have traveled less than 50,000 KM and were manufactured after 2018.

select * from vehicle 
where KM < 50000 AND year > '2018-01-01';

# 268 Retrieve the details of all trips taken by customers who live in 'Pune'.

select t.* from trips as t
JOIN customer_Address as ca
ON ca.customer_ID = t.customer_ID
where ca.City = 'Pune';

# 269 Insert a new address into the CUSTOMER_ADDRESS table for a customer who lives in 'Kolkata'.

INSERT INTO CUSTOMER_ADDRESS (Customer_Address_ID, Customer_ID, Address_LINE1, CITY, STATE, PINCODE)
VALUES (10, 10, 'Hawda Bridge', 'Kolkata', 'West Bengal', 611022);

# 270 Update the contact number of a customer given their CUSTOMER_CONTACT_ID.

UPDATE CUSTOMER_CONTACT 
SET Contact= '874946889'
WHERE CUSTOMER_CONTACT_ID = 4;

# 271 Delete a driver’s contact from the DRIVER_CONTACT table given their contact number.

DELETE FROM DRIVER_CONTACT 
WHERE Contact = '6543210987';

# 272 Retrieve all trips that have an OTP starting with '123'.

SELECT * 
FROM TRIPS 
WHERE OTP LIKE '123%';

# 273 Find the total fare collected for all trips taken by a specific customer.

SELECT SUM(Fare) AS Total_Fare
FROM TRIPS 
WHERE Customer_ID = 5;

# 274 List all customers who have a contact number ending in '5678'.

select c.Name , cc.contact from customer as c
JOIN customer_Contact as cc
On c.Customer_ID = cc.Customer_ID
where cc.contact LIKE '%876';


# 275 Retrieve the details of the first trip taken by a specific driver.

select d.* from driver as d
JOIN trips as t
ON d.Driver_Id = t.Driver_ID
where d.Driver_ID = 104
order by Start_Date_TIME ASC;


# 276 Insert a new payment mode into the PAYMENT_INFO table for 'Apple Pay'.

use Ola_Uber;
INSERT INTO PAYMENT_INFO (Payment_ID,Payment_Mode)
VALUES (1120,'Apple Pay');


#277 Update the rating of a driver given their NAME.

update driver
set Rating =' 4'
where Name = 'Nikhil';

#278 Delete a customer’s address from the CUSTOMER_ADDRESS table given their ADDRESS_LINE1.

DELETE FROM CUSTOMER_ADDRESS 
WHERE Address_LINE1 = '789 MG Road';


# 279 Retrieve all trips that were completed successfully and used a specific payment mode.

SELECT * FROM TRIPS 
WHERE Status = 'Completed' AND Payment_Mode = 'Net Banking';


# 280 Find the average distance covered in trips taken by a specific customer.

select Avg(distance) from trips
where Customer_ID = 4; 


# 281 List all drivers who have a contact number starting with '98765'.

select * from driver_Contact
where Contact LIKE' 98765';

#282 Retrieve the details of the most recent trip taken by a specific customer.

select * from trips
where Customer_ID = 3
order by Start_Date_Time desc
limit 1;

# 283 Insert a new entry into the DRIVER_ADDRESS table for a driver who lives in 'Pune'.

INSERT INTO DRIVER_ADDRESS (Driver_Address_ID, Driver_ID, Address_LINE1, CITY, STATE, PINCODE)
VALUES (8, 108, 'Rahu-Walki Road', 'Pune', 'Maharashtra', 412207);


# 284 Update the model of a vehicle given its model and new model name.

UPDATE VEHICLE 
SET Model = 'pajero'
WHERE Model = 'fortuner';

# 285 Delete a customer’s address from the CUSTOMER_ADDRESS table given their CUSTOMER_ID.

DELETE FROM CUSTOMER_ADDRESS 
WHERE Customer_ID = 3;


# 286 Retrieve all trips that started in 'Hyderabad' and ended in 'Bangalore'.

SELECT * 
FROM TRIPS 
WHERE Start_Location = 'Hyderabad' AND End_Location = 'Bangalore';


# 287 Find the total number of trips taken by each driver in the last year.

SELECT Driver_ID, COUNT(*) AS Total_Trips
FROM TRIPS 
WHERE Start_Date_Time >= now() - INTERVAL 1 YEAR
GROUP BY Driver_ID;

# 288 List all trips that used a specific payment mode and have a fare greater than 500.

SELECT * 
FROM TRIPS 
WHERE Payment_Mode = 'Cash' AND Fare > 500;


#289 Retrieve the names of all customers who have taken more than 10 trips in the last month.******************************

select c.Name from customer as c
JOIN trips as t
on c.customer_ID = t.customer_ID
where month(Start_Date_Time) >= now() - 1 AND month(Start_Date_Time) = year(now())
group by c.Name
having count(t.Trip_ID) > 10;


#290 Insert a new contact into the CUSTOMER_CONTACT table for a customer without a contact number.

INSERT INTO CUSTOMER_CONTACT (Customer_Contact_ID, Customer_ID, Contact)
VALUES (8, 8, '123987650');


# 291 Update the start and end date of a coupon given its COUPON_ID.

UPDATE COUPONS 
SET Start_Date = '2023-12-17'
WHERE COUPON_ID = 'FESTIVAL2024';


# 292 Delete a driver’s address from the DRIVER_ADDRESS table given their CITY and STATE.
DELETE FROM DRIVER_ADDRESS 
WHERE CITY = 'city' AND STATE = 'Maharashtra';


# find the no trips taken by driver who has completed the trip in shortest duration

SELECT COUNT(*) AS Total_Trips
FROM TRIPS
WHERE Driver_ID = (
    SELECT Driver_ID
    FROM TRIPS
    ORDER BY TIMESTAMPDIFF(MINUTE, Start_Date_Time, End_Date_Time) ASC
    LIMIT 1
);

# 293 Retrieve all trips that have a fare less than 500 and used 'Credit Card'.

select * from trips 
where fare < 500 AND Payment_Mode = 'Credit card';

# 294 Find the total fare collected for all trips taken by drivers who have a rating greater than 4.

select d.Driver_ID, sum(t.fare) as total_fare
from trips t JOIN driver as d
On d.driver_ID = t.Driver_ID
where d.Rating > 4
group by t.Trip_ID;

# 295 List all customers who live in 'Mumbai' and have a rating greater than 4.
SELECT c.Name 
FROM CUSTOMER c
JOIN CUSTOMER_ADDRESS ca ON c.Customer_ID = ca.Customer_ID
WHERE ca.CITY = 'Mumbai' AND c.Rating > 4;


# 296 Retrieve the details of all trips taken by drivers who have a rating less than 3.
SELECT t.*
FROM TRIPS t
JOIN DRIVER d ON t.Driver_ID = d.Driver_ID
WHERE d.Rating < 3;


# 297 Insert a new entry into the PAYMENT_INFO table for 'Google Pay'.

INSERT INTO PAYMENT_INFO(Payment_ID,Payment_Mode)
VALUES (1122,'Google Pay');


#298 Update the email of a driver given their EMAIL and new email address.
UPDATE DRIVER 
SET Email = 'Rahul123@gmail.com'
WHERE Email = 'rahul@gmail.com';

# 299 Delete a customer’s address from the CUSTOMER_ADDRESS table given their PINCODE and CITY.

DELETE FROM CUSTOMER_ADDRESS 
WHERE PINCODE = '411033' AND CITY = 'Pune';

# 300 Retrieve all trips that started and ended on the same day.

SELECT * FROM TRIPS 
WHERE DATE(Start_Date_Time) = DATE(End_Date_Time);

# 301 Find the total number of trips taken by each customer in the last year.********************************

select Customer_ID, count(trip_ID) as Total_trips from trips
where Year(Start_Date_Time) = now() - 1 AND year(Start_Date_time) = year(now()) 
group by Trip_ID;

# 302 List all drivers who have not taken any trips in the last month.***************************************

SELECT d.Driver_ID, d.Name
FROM DRIVER d LEFT JOIN TRIPS t 
ON d.Driver_ID = t.Driver_ID 
where abs(timestampdiff(day, now(), Start_date_Time)) <= 30
 having d.Driver_ID IS NULL;

 
 use ola_uber;

# 303 Retrieve the details of the trip with the lowest fare.

select * from trips 
order by  fare asc
limit 1;

# 304 Insert a new address into the DRIVER_ADDRESS table for a driver who lives in 'Hyderabad'.

INSERT INTO DRIVER_ADDRESS (Driver_Address_ID, Driver_ID, Address_LINE1, CITY, STATE, PINCODE)
VALUES (9, 109, 'char minar road', 'Hyderabad', 'Telangana', 766980);

# 305 Update the rating of a customer given their NAME and new rating.

UPDATE CUSTOMER 
SET Rating = 3
WHERE Name = 'Neha';

# 306 Delete a customer’s contact from the CUSTOMER_CONTACT table given their CUSTOMER_ID and contact number.
DELETE FROM CUSTOMER_CONTACT 
WHERE Customer_ID = 4 AND Contact_Number = '874946889';


# 307 Retrieve all trips that were paid using 'Google Pay'.

SELECT * 
FROM TRIPS 
WHERE Payment_Mode = 'Google Pay';


# 308 Find the average fare for trips taken by customers who live in 'Delhi'.

select ca.CUSTOMER_ID, avg(t.fare) as Avg_Fare
from customer_Address as ca JOIN trips as t
ON ca.Customer_ID= t.CUSTOMER_ID
where ca.city =' Delhi'
group by ca.customer_ID;

#309 List all vehicles that have traveled more than 100,000 KM and were manufactured before 2015.
SELECT * 
FROM VEHICLE 
WHERE KM > 100000 AND Year < 2015;


# 310 Retrieve the details of all trips taken by customers who live in 'Chennai'.
SELECT t.*
FROM TRIPS t
JOIN CUSTOMER c ON t.Customer_ID = c.Customer_ID
JOIN CUSTOMER_ADDRESS ca ON c.Customer_ID = ca.Customer_ID
WHERE ca.CITY = 'Chennai';


# 311 Insert a new address into the DRIVER_ADDRESS table for a driver who lives in 'Delhi'.

INSERT INTO DRIVER_ADDRESS (Driver_Address_ID, Driver_ID, Address_LINE1, CITY, STATE, PINCODE)
VALUES (10, 110, 'Fort Road', 'Delhi', 'Delhi', 411022);

# 312 Update the contact number of a driver given their DRIVER_CONTACT_ID and new contact number.

UPDATE DRIVER_CONTACT 
SET Contact = '456789876'
WHERE DRIVER_CONTACT_ID = 5;

# 313 Delete a customer’s address from the CUSTOMER_ADDRESS table given their CITY and STATE.
DELETE FROM CUSTOMER_ADDRESS 
WHERE CITY = 'Mysore' AND STATE = 'Tamilnadu';


# 314 Retrieve all trips that used a specific coupon and have a fare less than 1000.

SELECT * 
FROM TRIPS 
WHERE Coupon_ID = '5' AND Fare < 1000;

#315 Find the total fare collected for all trips taken by customers who have a rating less than 3.
SELECT c.Customer_ID, SUM(t.Fare) AS Total_Fare
FROM CUSTOMER c
JOIN TRIPS t ON c.Customer_ID = t.Customer_ID
WHERE c.Rating < 3
GROUP BY c.Customer_ID;


# 316 List all customers who have a contact number starting with '12345'.

SELECT DISTINCT c.Name
FROM CUSTOMER c
JOIN CUSTOMER_CONTACT cc ON c.Customer_ID = cc.Customer_ID
WHERE cc.Contact LIKE '12345%';

# 317 Retrieve the details of the most recent trip taken by a specific driver.

SELECT * FROM TRIPS 
WHERE Driver_ID = '103'
ORDER BY Start_Date_Time DESC 
LIMIT 1;

# 318 Insert a new entry into the PAYMENT_INFO table for 'Samsung Pay'.

INSERT INTO PAYMENT_INFO (Payment_ID,Payment_Mode)
VALUES (1121,'Samsung Pay');

# 319 Update the year and category of a vehicle given its VEHICLE_ID and new details.

UPDATE VEHICLE 
SET Year = '2020-08-07', Category = 'TRUCK'
WHERE VEHICLE_ID = 11;

use ola_uber;
# 320 Delete a driver’s address from the DRIVER_ADDRESS table given their ADDRESS_LINE1 and PINCODE.

DELETE FROM DRIVER_ADDRESS 
WHERE Address_LINE1 = 'Wagholi' AND PINCODE = 123456;

# 321 Retrieve all trips that ended in 'Delhi' and were completed in less than an hour.

SELECT * 
FROM TRIPS 
WHERE End_Location = 'Delhi' AND TIMESTAMPDIFF(MINUTE, Start_Date_Time, End_Date_Time) < 60;

# 322 Find the total fare collected for all trips taken by customers who have taken more than 5 trips.

SELECT c.Customer_ID, SUM(t.Fare) AS Total_Fare
FROM CUSTOMER c JOIN TRIPS t 
ON c.Customer_ID = t.Customer_ID
GROUP BY c.Customer_ID
HAVING COUNT(t.Trip_ID) > 5;

