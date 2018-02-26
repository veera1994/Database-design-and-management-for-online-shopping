--Database design for online shopping management design.

CREATE DATABASE Team7;
GO

USE Team7; 

--***************************************************************************************************
-- Create tables
CREATE TABLE Customer
(
CustomerID int NOT NULL PRIMARY KEY,
FIRSTNAME varchar(40),
LASTNAME varchar(40),
Street varchar(40),
City varchar(40),
State varchar(40),
Zipcode varchar(40),
Email varchar(40),
Phone varchar(40),
Membership varchar(40), 
Password varchar(40)
)

CREATE TABLE ShoppingCart
(
CartID int NOT NULL PRIMARY KEY,
ProductName varchar(40) NOT NULL,
ItemQty int NOT NULL,
DateAdded datetime,
UnitPrice money NOT NULL,
CustomerID int NOT NULL

CONSTRAINT fk_cucomerid
	FOREIGN KEY (CustomerID)
	REFERENCES Customer(CustomerID)
)

CREATE TABLE Orders
(
 OrderID int NOT NULL PRIMARY KEY,
 TrackingNumber int NOT NULL,
 ShippingAgency varchar(40) NOT NULL,
 Promotions varchar(40),
 ProviderID int NOT NULL,
 ModifiedDate datetime,
 ProductID int NOT NULL,
 CartID int NOT NULL,

 CONSTRAINT fk_cartid
	FOREIGN KEY (CartID)
	REFERENCES ShoppingCart(CartID)
)

CREATE TABLE dbo.Payment
(
PaymentID int NOT NULL,
OrderID int NOT NULL,
Date datetime,
PaymenType varchar(40),
CardNum varchar(40),
SecurityCode int,
BillingStreet varchar(40),
BillingCity varchar(40),
BillingState varchar(40),
BillingZipcode varchar(40)

CONSTRAINT pk_PaymentOrder 
	PRIMARY KEY CLUSTERED (PaymentID, OrderID)
CONSTRAINT fk_OrderID 
	FOREIGN KEY(OrderID)
	REFERENCES Orders(OrderID)
)

CREATE TABLE dbo.Refund
(
RefundID int NOT NULL,
OrderID INT NOT NULL,
ProductID INT 

CONSTRAINT pk_RefundOrder 
	PRIMARY KEY CLUSTERED (RefundID, OrderID)
CONSTRAINT fk_OrderID_1
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID)
)

CREATE TABLE dbo.Product
(ProductID INT NOT NULL CONSTRAINT PK_Product PRIMARY KEY, 
ProductName VARCHAR(40) NOT NULL,
Color NVARCHAR(15) NOT NULL,
Size NVARCHAR(10) NOT NULL,
TotalStock INT NOT NULL,
Weight DECIMAL(8,2) NOT NULL,
AvailabilityFlag BIT NOT NULL,
ProductCategory VARCHAR(20) NOT NULL,
Description NVARCHAR(400) NOT NULL,
Image VARBINARY(MAX) NOT NULL,
ProductReviewID INT NOT NULL);

--connect to Customer and product
CREATE TABLE dbo.ProductReview
(ProductReviewID INT NOT NULL,
ProductID INT NOT NULL CONSTRAINT FK_ProductReview_Product FOREIGN KEY
	REFERENCES dbo.Product(ProductID),
CustomerID INT NOT NULL CONSTRAINT FK_ProductReview_Customer Foreign Key
	REFERENCES dbo.Customer(CustomerID),
OrderID INT NOT NULL,
ProductRating INT NOT NULL,
ProductReview NVARCHAR(4000),
CONSTRAINT PK_ProductReview PRIMARY KEY CLUSTERED(ProductReviewID, ProductID, CustomerID));

--connect to Order and Product
CREATE TABLE dbo.OrderLine
(ProductID INT NOT NULL CONSTRAINT FK_OrderLine_Product FOREIGN KEY
    REFERENCES dbo.Product(ProductID),
OrderID INT NOT NULL CONSTRAINT FK_ProductReview_Order FOREIGN KEY
	REFERENCES dbo.ORDERs(OrderID),
UnitPrice MONEY NOT NULL,
OrderQty SMALLINT NOT NULL,
Constraint PK_ProductReview_1 PRIMARY KEY CLUSTERED(ProductID, OrderID));

CREATE TABLE dbo.Supplier
(
SupplierID INT NOT NULL CONSTRAINT PK_Product_2 PRIMARY KEY, 
CompanyName VARCHAR (40) NOT NULL,
SupplierLicense INT NOT NULL,
SupplierStreet  VARCHAR (40) NOT NULL, 
SupplierCity  VARCHAR (40) NOT NULL,
SupplierState  VARCHAR (40) NOT NULL,
SupplierZipCode  VARCHAR (40) NOT NULL,
SupplierEmail  VARCHAR (40) NOT NULL,
SupplierPhone  VARCHAR (40) NOT NULL,
SupplierFax  VARCHAR (40) NOT NULL
);

--Connect to Customer and Supplier
CREATE TABLE dbo.SupplierReviewOnCustomer
(CustomerReviewID INT NOT NULL,
CustomerID INT NOT NULL CONSTRAINT FK_SupplierReviewOnCustomer_Customer FOREIGN KEY
	REFERENCES dbo.Customer(CustomerID),
SupplierID INT NOT NULL CONSTRAINT FK_SupplierReviewOnCustomer_Supplier FOREIGN KEY
	REFERENCES dbo.Supplier(SupplierID),
RatingOnCustomer INT NOT NULL,
ReviewOnCustomer NVARCHAR(4000),
CONSTRAINT PK_SupplierReviewOnCustomer PRIMARY KEY CLUSTERED(CustomerReviewID, CustomerID, SupplierID));


CREATE TABLE dbo.ShippingInfo
(
TrackingNumber INT NOT NULL CONSTRAINT PK_Product_1 PRIMARY KEY, 
ShuppingAgenncy VARCHAR(40) NOT NULL,
WarehouseID INT NOT NULL,
SupplierID INT NOT NULL,
TotalStock INT NOT NULL,
ArrrivalTime Date NOT NULL,
ShippingStatus VARCHAR(20) NOT NULL,
OrderID INT NOT NULL,
ProductID INT NOT NULL

CONSTRAINT fk_orderid_2
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),
CONSTRAINT fk_Productid_1
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID)
	);



CREATE TABLE dbo.Warehouse
(
WarehouseID INT NOT NULL CONSTRAINT PK_Product_3 PRIMARY KEY, 
WarehouseStreet  VARCHAR (40) NOT NULL, 
WarehouseCity  VARCHAR (40) NOT NULL,
WarehouseState VARCHAR (40) NOT NULL,
WarehouseZipCode  VARCHAR (40) NOT NULL,
WarehouseCategory VARCHAR (40) NOT NULL,
WarehouseCapacity VARCHAR (40) NOT NULL,
Proximity AS CASE
		when Warehouse.warehousestate = 'MA' then 'Near'
		when warehouse.wareHousestate = 'NY' then 'Near'
		when warehouse.wareHousestate = 'CT' then 'Near'
		when warehouse.wareHousestate = 'TX' then 'Far'
		when warehouse.wareHousestate = 'CA' then 'Far'
		when warehouse.wareHousestate = 'IL' then 'Far'
		ELSE 'Unknown'
   end
);

CREATE TABLE dbo.SupplierWarehouseLine
(
SupplierID INT NOT NULL CONSTRAINT FK_SupplierWarehouseLine_Supplier FOREIGN KEY
    REFERENCES dbo.Supplier(SupplierID),
WarehouseID INT NOT NULL CONSTRAINT FK_SupplierWarehouseLine_Warehouse FOREIGN KEY
	REFERENCES dbo.Warehouse(WarehouseID),
ProductID int NOT NULL

Constraint PK_ProductReview_2 PRIMARY KEY CLUSTERED(SupplierID, WarehouseID),
CONSTRAINT fk_Productid_4
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID)
	);


--***************************************************************************************************
-- INSERT VALUES
INSERT dbo.Customer
	VALUES (1,'Sophia','Smith','1 Washington Street', 'Boston', 'MA','02115',
	'sophia@gmail.com','7811234567','Student Membership','password1'),
	 (2,'Emma','Johnson','10 Mountain Ave', 'Malden', 'MA','02148'
	,'Emma@gmail.com','222222222','Student Membership','password2'),
	 (3,'Olivia','Williams','19 Huntington Ave', 'Boston', 'MA','02115'
	,'Olivia@gmail.com','7813333333','Business Membership','password3'),
	 (4,'Ava','Jones','360 Huntington Ave', 'Boston', 'MA','02115'
	,'Ava@gmail.com','6174444444','Personal Membership','password4'),
	 (5,'Mia','Brown','30 Central Street', 'NY', 'NY', '02000'
	,'mia@gmail.com','5555555555','Business Membership','password5'),
	 (6,'Jack','Davis','33 Spring Street', 'Queen', 'NY','06666'
	,'jack@gmail.com','6666666666','Personal Membership','password6'),
	 (7,'Aiden','Lee','10 Washington Street', 'Bay', 'CA','07777'
	,'aiden@gmail.com','7777777777','Student Membership','password7'),
	 (8,'Lucas','John','99 Leaf Street', 'Carson', 'CA','08888'
	,'lucas@gmail.com','8888888888','Business Membership','password8'),
	 (9,'Noah','Smith','80 Summer Ave', 'Houston', 'TX','09999'
	,'Noah@gmail.com','9999999999','Student Membership','password9'),
	 (10,'Andrew','Wiggins','11 Star Street', 'Boston', 'MA','02115'
	,'andrew@gmail.com','7810000000','Business Membership','password10')

INSERT ShoppingCart
	Values (1,'Delsey Luggage',2,'20170101',300,1),
	(2,'Cycling Bike',1,'20170102',500,2),
	(3,'Wireless Speaker',1,'20160408',60,4),
	(4,'LUENX Sunglasses',3,'20170810',20,4),
	(5,'Stanzino Cocktail Dress',2,'20170304',35,5),
	(6,'LCD Mini Projector',5,'20160322',120,6),
	(7,'Repel Windproof Travel Umbrella',1,'20160302',15,7),
	(8,'Makeup Brushes',1,'20161212',20,8),
	(9,'USB Cabel',1,'20160607',13,9),
	(10,'Westcott Titanium Bonded Scissors',2,'20160909',5,8),
	(11,'USB Cabel',1,'20160909',7.5,8)

INSERT Orders
	Values(1,1,'UPS',null,2,'20170102',1,1),
	(2,2,'USPS',null,4,'20170102',10,2),
	(3,3,'USPS',null,1,'20160409',3,3),
	(4,4,'Fedex','Free shipping',3,'20170810',5,4),
	(5,5,'USPS','Free shipping',1,'20170305',1,5),
	(6,6,'UPS',null,5,'20160325',5,6),
	(7,7,'USPS','Free shipping',1,'20160303',9,7),
	(8,8,'Fedex','$5 off',1,'20161212',3,8),
	(9,9,'USPS',null,1,'20160607',1,9),
	(10,10,'UPS',null,4,'20160909',4,10)

INSERT Payment
	Values(1,1,'20170103','Credit card','111111111','111','1 Washington Street', 'Boston', 'MA','02115'),
	(2,2,'20170103','Credit card','222222222',222,'10 Mountain Ave', 'Malden', 'MA','02148'),
	(3,3,'20160410','Credit card','333333333',333,'19 Huntington Ave', 'Boston', 'MA','02115'),
	(4,4,'20170811','Debit card','444444444',444,'360 Huntington Ave', 'Boston', 'MA','02115'),
	(5,5,'20170305','Credit card','555555555',555,'30 Central Street', 'NY', 'NY', '02000'),
	(6,6,'20160326','Debit card','666666666',666,'33 Spring Street', 'Queen', 'NY','06666'),
	(7,7,'20160304','Gift card','777777777',777,'10 Washington Street', 'Bay', 'CA','07777'),
	(8,8,'20161213','Credit card','888888888',888,'99 Leaf Street', 'Carson', 'CA','08888'),
	(9,9,'20160608','Credit card','999999999',999,'80 Summer Ave', 'Houston', 'TX','09999'),
	(10,10,'20160910','Credit card','000000000',123,'11 Star Street', 'Boston', 'MA','02115')
	
INSERT Refund
	Values(1,3,3),
	(2,8,3),
	(3,10,4)

INSERT dbo.Supplier
Values
(1,'Zoom',123567,'Wellington','Boston','MA',02130,'zoom@gmail.com',6176627282,6627282),
(2,'Flash',123576,'Nonnatum','Boston','MA',02530,'Flash@gmail.com',6176627676,6627676),
(3,'Superman',132567,'SouthHuntington','Boston','MA',03130,'Superman@gmail.com',6172667282,2667282),
(4,'Batman',123657,'Foresthill','Boston','MA',02310,'Batman@gmail.com',6176627852,6628632),
(5,'Hulk',174057,'Malden','Newyork','NY',05473,'Hulk@gmail.com',6176662392,18237632),
(6,'Ironman',952657,'Arlington','Dallas','TX',20310,'Ironman@gmail.com',8765627852,8765632),
(7,'Daredevil',765357,'Dudely','Boston','MA',02650,'dd@gmail.com',617686852,6688732),
(8,'Venom',085257,'LongWood','LosAngles','CA',76410,'Venom@gmail.com',964627852,9646632),
(9,'Spiderman',120735,'Roxbury','Hartford','CT',73510,'Spiderman@gmail.com',9576287852,9372632),
(10,'Wonderwoman',857857,'Hufflesworth','Boston','MA',02450,'Wonderwoman@gmail.com',7615627852,9187632);


INSERT dbo.Product
	VALUES (1,'Delsey Luggage', 'red', '25 inches', 50, '8.6', 1, 
	'Travel','Lightweight and Durable: Made of 100% Polycarbonate, which is a material that is extremely resilient to cracking or breaking, with a deep metallic finish', 0, 0010),
	(2,'Cycling Bike', 'white', '60 inches', 30, '95.2', 1, 
	'Sports','Adjustable, no-slip handlebars with rubberized grips, adjustable fore and aft seat slider, water bottle holder on frame, one motion emergency stop', 0, 0011),
	(3,'Wireless Speaker', 'black', '2 inches', 80, '0.71', 1, 
	'Travel','Feel the power of EXTRA BASS', 0, 0012),
	(4,'LUENX Sunglasses', 'purple', '7 inches', 20, '0.6', 1, 
	'Jewelry','metal frame, plastic lens', 0, 0013),
	(5,'Stanzino Cocktail Dress', 'blue', '8 inches', 50, '1', 1, 
	'Clothing','Constructed from 100% polyester, our flirty lace party dress offers you a flexible fit that caresses your curves without having to worry about the puckering of a zipper.', 0, 0014),
	(6,'LCD Mini Projector', 'black', '7 incheses', 5, '2.2', 1, 
	'Electronics','Upgraded LED light technology - more bright than other projectors Updated fan 
	Sound and System - the fan noise is lower than other basic LED projectors', 0, 0015),
	(7,'Repel Windproof Travel Umbrella', 'red', '11 inches', 15, '1', 1, 
	'Travel','Automatic Open/Close, Compact, and Lightweight, perfect for travel and storage in purses, backpacks, luggage, and more', 0, 0016),
	(8,'Makeup Brushes', 'black', '2 inches', 6, '7.2', 1, 
	'Beauty','Lightweight and Durable: Made of 100% Polycarbonate, which is a material that is extremely resilient to cracking or breaking, with a deep metallic finish', 0, 0017),
	(9,'USB Cabel', 'grey', '2.6 inches', 50, '3.7', 1, 
	'Electronics','Transfer speed up to 5 Gbps, 3A Fast Charger, Data Transfer and Power Charging 2 in 1 USB-C Cable', 0, 0018),
	(10,'Westcott Titanium Bonded Scissors', 'grey', '8', 6, '6.1', 1, 
	'Arts','The original Titanium Bonded scissors, blades are 3X harder than steel and stays sharper longer', 0, 0019)

INSERT dbo.ProductReview
	VALUES (1,1,1,1,5, null),(2,2,2,2,5,null ),(3,3,3,3,5,null ),
	(4,4,4,4,5,null ),(5,5,5,5,5,null ),(6,6,6,6,5,null),(7,7,7,7,5,null),
	(8,8,8,8,5,null ),(9,9,9,9,5,null ),(10,10,10,10,5,null )

INSERT dbo.OrderLine
	VALUES (1,1,300,1),
	(2,2,500,1),
	(3,3,60,1),
	(4,4,20,1),
	(5,5,35,2),
	(6,6,120,1),
	(7,7,15,3),
	(8,8,20,2),
	(9,9,13,5),
	(10,10,5,1)

INSERT dbo.SupplierReviewOnCustomer
	VALUES (1,1,1,5,null),(2,2,2,5,null),(3,3,3,5,null),(4,4,4,5,null),(5,5,5,5,null),
	(6,6,6,5,null),(7,7,7,5,null),(8,8,8,5,null),(9,9,9,5,null),(10,10,10,5,null)

INSERT dbo.Warehouse
Values 
(1,'47th','Newtown','MA',02187,'Household',1000),
(2,'66th','Oldtown','MA',02178,'Household',1500),
(3,'109th','Hartford','CT',03187,'Electronics',1800),
(4,'118th','Weirdworld','CT',03887,'Household',6000),
(5,'457th','Niceworld','NY',04187,'Sports',2000),
(6,'654th','Badworld','CA',99887,'Clothing',10000),
(7,'744th','Badworld','CA',99187,'Household',9000),
(8,'56th','Besttown','MI',88187,'Electronics',100000),
(9,'98th','Toptown','IL',97187,'Sports',1700),
(10,'974th','Downtown','MA',02817,'Household',9000);

INSERT dbo.ShippingInfo
Values
(1,'UPS',5,3,1,'20170105','Shipped',1,1),
(2,'USPS',4,2,1,'20170106','Shipping',2,10),
(3,'USPS',3,1,1,'20160411','Delivered',3,3),
(4,'Fedex',2,4,1,'20170815','Shipping',4,5),
(5,'USPS',1,5,1,'20170310','Shipping',5,1),
(6,'UPS',6,6,1,'20160330','Delivered',6,5),
(7,'USPS',7,7,1,'20160310','Shipped',7,9),
(8,'Fedex',8,8,1,'20161220','Delivered',8,3),
(9,'USPS',9,9,1,'20160610','Delivered',9,1),
(10,'UPS',10,10,1,'20160915','Shipped',10,4);

--***************************************************************************************************
-- Create view
CREATE VIEW CustomerOrder
AS
SELECT TOP 100 PERCENT c.CustomerID, o.OrderID, o.ProductID, l.UnitPrice, OrderQty
FROM dbo.ShoppingCart c
JOIN dbo.Orders o
ON c.CartID=o.CartID
JOIN dbo.OrderLine l
ON o.ProductID=l.ProductID
ORDER BY c.CustomerID

CREATE VIEW ReviewonProduct
AS
SELECT TOP 100 PERCENT r.CustomerID, ProductRating, ProductReview, ProductName
FROM dbo.Customer r
JOIN dbo.ProductReview w
ON r.CustomerID = w.CustomerID
JOIN dbo.Product t
ON w.ProductID=t.ProductID
ORDER BY r.CustomerID

--***************************************************************************************************
-- Check Constraints
-- Create a function to check whether a product has ever had a poor rating
-- Function will return a number greater than 0 if a product has had a rating below '3'

CREATE FUNCTION CheckRating (@PName varchar(30))
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(ProductID) 
          FROM ProductReview
          WHERE ProductID = @PName
          AND ProductRating < 3;
   RETURN @Count;
END;

-- Add table-level CHECK constraint based on the new function for the Orders table
ALTER TABLE Orders ADD CONSTRAINT BanBadProduct CHECK (dbo.CheckRating(ProductID) = 0);

-- Put some data in the new tables
INSERT INTO ProductReview (ProductReviewID, ProductID, CustomerID, OrderID, 
			ProductRating, ProductReview)
VALUES (11, 3, 5, 11, 2, 'Bad'),
       (12, 5, 8, 12, 5, 'Good');

-- Ban bad product
INSERT INTO Orders (OrderID, TrackingNumber, ShippingAgency, Promotions, ProviderID,
					ModifiedDate, ProductID, CartID)
VALUES (20, 200,'USPS',null,5,'20170801',3,9);
-- Allow good product
INSERT INTO Orders (OrderID, TrackingNumber, ShippingAgency, Promotions, ProviderID,
					ModifiedDate, ProductID, CartID)
VALUES (21, 201,'USPS',null,9,'20170801',6,3);


--***************************************************************************************************
-- Column encryption
-- Create a table to hold results
CREATE TABLE TempNames
(
CustomerID int PRIMARY KEY,
FirstName nvarchar(40),
LastName nvarchar(40),
EncFirstName varbinary(200),
EncLastName varbinary(200)
);
-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'Team7 Test Certificate',
EXPIRY_DATE = '2026-10-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;

-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

/* Populate temp table with 10 encrypted names from the Customer table */
INSERT
INTO TempNames
(
CustomerID,
EncFirstName,
EncLastName
)
SELECT TOP(10) CustomerID,
EncryptByKey(Key_GUID(N'TestSymmetricKey'), FirstName),
EncryptByKey(Key_GUID(N'TestSymmetricKey'), LastName)
FROM Customer
ORDER BY CustomerID;

-- Update the temp table with decrypted names
UPDATE TempNames
SET FirstName = DecryptByKey(EncFirstName),
LastName = DecryptByKey(EncLastName);

-- Show the results
SELECT CustomerID,
FirstName,
LastName,
EncFirstName,
EncLastName
FROM TempNames;

-- Close the symmetric key
CLOSE SYMMETRIC KEY TestSymmetricKey;

-- Drop the symmetric key
DROP SYMMETRIC KEY TestSymmetricKey;

-- Drop the certificate
DROP CERTIFICATE TestCertificate;

--Drop the DMK
DROP MASTER KEY;

--***************************************************************************************************
--computed column 

--1
SELECT ShoppingCart.CustomerID,Orders.OrderID,ShippingInfo.TrackingNumber,
ShippingInfo.ShippingStatus
     
FROM Orders
JOIN ShoppingCart
ON ShoppingCart.CartID = Orders.CartID
JOIN ShippingInfo
ON ShippingInfo.TrackingNumber=Orders.TrackingNumber

Order by CustomerID

-- 2
CREATE PROCEDURE dbo.RetrieveTrackingnumberonly1
@TrackingNumber INT
AS
BEGIN
   Declare @requestedresult table (ShippingAgency varchar(10),ArrivalTime varchar(10),
   ShippingStatus varchar(10),SupplierID int, Suppliername varchar (10), WarehouseID int,
   WareHouseCity varchar (10), OrderID int,ProductID int)
  
   select
   ShippingInfo.ShuppingAgenncy,ShippingInfo.ArrrivalTime,
   ShippingInfo.ShippingStatus,Supplier.SupplierID,Supplier.CompanyName,
   Warehouse.WarehouseID,Warehouse.WarehouseCity,OrderLine.OrderID,OrderLine.ProductID
   FROM ShippingInfo
   INNER JOIN OrderLine
   ON ShippingInfo.OrderID= OrderLine.OrderID
   INNER JOIN Supplier
   ON Supplier.SupplierID=ShippingInfo.SupplierID
   INNER JOIN Warehouse
   ON Warehouse.WarehouseID=ShippingInfo.WarehouseID
   where TrackingNumber=@TrackingNumber

   ORDER BY Supplier.SupplierID;
END


exec dbo.RetrieveTrackingnumberonly1 @trackingNumber= 2	

--3
CREATE FUNCTION dbo.CustSale
(@CustomerID int)
RETURNS MONEY
AS BEGIN
	DECLARE @TotalPrice MONEY
	SELECT @TotalPrice= SUM(UnitPrice * ItemQty)
	   FROM ShoppingCart
	   WHERE CustomerID=@CustomerID
	RETURN @TotalPrice
END

SELECT dbo.CustSale(4);

DROP FUNCTION dbo.CustSale;

--4

CREATE PROCEDURE OrderRetrieve  
 @orderID INT
 AS 
BEGIN 
 DECLARE @requestedresult TABLE (CustomerID int,LastName varchar(10), Membership  varchar(10), ProductName varchar (10), 
Price int, QTY int, ShippingAgency Varchar(10), SHIPPINGSTAT varchar(10), ArrivalTime date)
SELECT ShoppingCart.CustomerID,
Customer.LASTNAME,Customer.Membership,Product.ProductName,
OrderLine.UnitPrice,OrderLine.OrderQty,shippinginfo.ShuppingAgenncy,ShippingInfo.ShippingStatus,ShippingInfo.ArrrivalTime
from Orders
inner join ShoppingCart
on ShoppingCart.CartID=Orders.CartID
inner join Customer
on ShoppingCart.CustomerID=Customer.CustomerID
inner join OrderLine 
on OrderLine.OrderID=Orders.OrderID
inner join Product
on OrderLine.ProductID=Product.ProductID
inner join ShippingInfo
on ShippingInfo.OrderID=OrderLine.OrderID
 WHERE Orders.orderId= @orderID
 ORDER BY CustomerID desc
 end

 exec OrderRetrieve  @orderID =1

--5

--6
select * from dbo.ShippingInfo


CREATE FUNCTION dbo.GetDateRange
(@StartDate date, @NumberOfDays int)
RETURNS @DateList TABLE (Position int, DateValue date)
AS BEGIN
 DECLARE @Counter int = 0;
 WHILE (@Counter < @NumberOfDays)
 BEGIN
 INSERT INTO @DateList
 VALUES(@Counter + 1,
 DATEADD(day,@Counter,@StartDate));
 SET @Counter += 1;
 END
 RETURN;
END
GO
SELECT * FROM dbo.GetDateRange('2016-08-15',14);


--***************************************************************************************************
-- Trigger
--1
/* If there's not enough items in Warehouse, don't allow customer to purchse. */
CREATE TRIGGER TR_CheckStock
ON dbo.Warehouse
AFTER INSERT AS 
BEGIN
   DECLARE @Count int;
   SELECT @Count = WarehouseCapacity - OrderQty
      FROM OrderLine l
	  JOIN ShippingInfo i
      ON l.OrderID = i.OrderID
      JOIN Warehouse h
      ON i.WarehouseID = h. WarehouseID;
   IF @Count < 0 
      BEGIN
	     Rollback;
      END
END;

--2
CREATE TABLE Warehouse_Audit
(WarehouseID INT ,
WarehouseStreet  VARCHAR (40) NOT NULL, 
WarehouseCity  VARCHAR (40) NOT NULL,
WarehouseState VARCHAR (40) NOT NULL,
WarehouseZipCode  VARCHAR (40) NOT NULL,
WarehouseCategory VARCHAR (40) NOT NULL,
WarehouseCapacity int,
Audit_Action varchar(100),
Audit_Timestamp datetime
)

CREATE TRIGGER trgInsteadOfDelete ON dbo.warehouse
INSTEAD OF DELETE
AS
	declare @WarehouseID int;
	declare @WarehouseStreet  VARCHAR (40)
declare @WarehouseCity  VARCHAR (40)
Declare @WarehouseState VARCHAR (40)
Declare @WarehouseZipCode  VARCHAR (40)
Declare @WarehouseCategory VARCHAR (40)
Declare @WarehouseCapacity int
	
	select @WarehouseID from deleted 
	select @WarehouseStreet from deleted 
	select @WarehouseCity from deleted 
	select @WarehouseState from deleted
	select @WarehouseZipCode from deleted
	select @WarehouseCategory From deleted
	select @WarehouseCapacity from deleted
	BEGIN
		if(@WarehouseCapacity>1200)
		begin
			RAISERROR('Cannot delete warehouse capacity > 1500',16,1);
			ROLLBACK;
		end
		else
		begin
			delete from dbo.Warehouse where WarehouseID=@WarehouseID;
			COMMIT;
			insert into Warehouse_Audit(WarehouseID,WarehouseStreet,WarehouseCity,WarehouseState,WarehouseZipCode,WarehouseCategory,WarehouseCapacity,Audit_Action,Audit_Timestamp)
			values(@WarehouseID,@WarehouseStreet,@WarehouseCity,@WarehouseState,@WarehouseZipCode,@WarehouseCategory,@WarehouseCapacity,'Deleted -- Instead Of Delete Trigger.',getdate());
			PRINT 'Record Deleted -- Instead Of Delete Trigger.'
		end
	END
GO