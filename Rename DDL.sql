-- DROP DATABASE Rename
CREATE  DATABASE Rename;

use Rename;

-- Create User table
CREATE TABLE User_T (
UserID INT NOT NULL PRIMARY KEY,
UserName VARCHAR(25) NOT NULL,
Email VARCHAR(25) NOT NULL,
[Address] VARCHAR(100) NOT NULL,
[Password] VARCHAR(25) NOT NULL,
PUserType Varchar(1) NOT NULL, CHECK(PUserType IN ('Y','N')),
SUserType Varchar(1) NOT NULL, CHECK(PUserType IN ('Y','N')),
AUSerType Varchar(1) NOT NULL, CHECK(PUserType IN ('Y','N')),
);


-- Create Purchaser table
CREATE TABLE Purchaser_T (
PurchaserID INT NOT NULL PRIMARY KEY,
-- UserType VARCHAR(10) DEFAULT 'Purchaser = Y' NOT NULL,
ApparelSize VARCHAR(10),
ShoesSize DECIMAL(5,2),
CONSTRAINT Purchaser_FK FOREIGN KEY  (PurchaserID) REFERENCES User_T(UserID)
);

-- Create Seller table
CREATE TABLE Seller_T (
SellerID INT NOT NULL PRIMARY KEY,
-- VARCHAR(10) DEFAULT 'Seller = Y' NOT NULL,
PaypalAccount VARCHAR(50),
PassedAuthentication VARCHAR(10),
CONSTRAINT Seller_FK  FOREIGN KEY (SellerID) REFERENCES User_T(UserID)
);

-- Create Admin table
CREATE TABLE Admin_T (
AdminID INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES [User_T](UserID),
-- UserType VARCHAR(10) DEFAULT 'Purchaser = Y' NOT NULL,
PaypalAccount VARCHAR(50),
CONSTRAINT Admin_FK FOREIGN KEY  (AdminID) REFERENCES User_T(UserID)
);


-- Create Card table
CREATE TABLE Card_T (
CardNumber INT NOT NULL PRIMARY KEY,
[Type] VARCHAR(25) NOT NULL CHECK([Type] IN ('VISA','Master','American Express','JCB','UnionPay')),
CardHolderName VARCHAR(25) NOT NULL,
BillAddress VARCHAR(100) NOT NULL,
PurchaserID INT NOT NULL,
CONSTRAINT  Card_T_FK FOREIGN KEY (PurchaserID) references Purchaser_T(PurchaserID)
);


-- Create Favorite table
CREATE TABLE Favorite_T (
FavoriteID INT NOT NULL PRIMARY KEY,
PurchaserID INT NOT NULL,
ProductID INT NOT NULL,
ExpectedPrice INT NOT NULL,
CONSTRAINT Favorite_T_FK1 FOREIGN KEY (PurchaserID) REFERENCES Purchaser_T (PurchaserID),
CONSTRAINT  Favorite_T_FK2 FOREIGN KEY(ProductID) REFERENCES Product_T(ProductID)
);

-- SELECT * FROM Favorite_T



DROP TABLE Order_T;
-- Create Order table
CREATE TABLE Order_T (
OrderID INT IDENTITY(3001,1) NOT NULL PRIMARY KEY,
PurchaserID INT NOT NULL,
ProductID INT NOT NULL,
[Date] DATE NOT NULL,
[Status] VARCHAR(25) CHECK([Status] IN ('Finished','Pending','Shipped')) default 'Pending',
Price INT NOT NULL, 
CONSTRAINT Order_T_FK1 FOREIGN KEY (PurchaserID) REFERENCES Purchaser_T (PurchaserID),
CONSTRAINT  Order_T_FK2 FOREIGN KEY(ProductID) REFERENCES Product_T(ProductID)
);



-- SELECT * FROM Order_T


-- DROP TABLE Product_T

-- create product table
CREATE TABLE Product_T(
	ProductID int not null,
	SellerID int not null,
	ProductDescription varchar(100),
	Color varchar(20),
	Brand varchar(20),
	RetailPrice int,
	ReleaseDate date,
	ProductType varchar(10) CONSTRAINT ProductType_CHK CHECK (ProductType IN ('Apparel','Shoes','Accessory')),
	ProductQuantity int,
	SalePrice int,
CONSTRAINT Product_T_PK PRIMARY KEY (ProductID),
CONSTRAINT Product_T_FK FOREIGN KEY(SellerID) references Seller_T(SellerID));
-- SELECT * FROM Product_T


-- create Shipment table
CREATE TABLE Shipment_T(
	ShipmentID int not null,
	OrderID int not null,
	ShipmentDate date,
	ExpectedArrival date,
	Origin varchar(20),
	Destination varchar(20),
	[Weight] decimal(4,2),
    [Status] INT CHECK([Status] IN (1,0)) default 0,
CONSTRAINT Shipment_T_PK PRIMARY KEY (ShipmentID),
CONSTRAINT Shipment_T_FK FOREIGN KEY(OrderID) references Order_T(OrderID));

-- SELECT * FROM Shipment_T;



-- create Apparel table
CREATE TABLE Apparel_T(
 [ApparelID] INT NOT NULL PRIMARY KEY,
 [ApparelSize] VARCHAR(5) NULL,
 [Characteristics] VARCHAR(80) NULL,
 [ApparelType] VARCHAR(50) NULL,
 CONSTRAINT Apparel_FK FOREIGN KEY (ApparelID) REFERENCES Product_T(ProductID));


-- SELECT * FROM Apparel_T

-- create Shoes table
CREATE TABLE Shoes_T(
 [ShoesID] INT NOT NULL PRIMARY KEY,
 [ShoesSize] VARCHAR(20) NULL,
 [SizeType] VARCHAR(50) NULL,
 [ShoesType] VARCHAR(50) NULL,
CONSTRAINT Shoes_FK FOREIGN KEY (ShoesID) REFERENCES Product_T(ProductID)
); 


-- SELECT * FROM Shoes_T

-- create Accessory table
CREATE TABLE Accessory_T(
 [AccessoryID] INT NOT NULL PRIMARY KEY,
 [AccessoryType] VARCHAR(50) NULL,
CONSTRAINT Accesory_FK FOREIGN KEY (AccessoryID) REFERENCES Product_T(ProductID)
);

-- SELECT * FROM Accessory_T






--CREATE PROCEDURE

/*
Change User's Address
*/

ALTER PROCEDURE ChangeAddress @UserID INT, @NewAddress VARCHAR(50)

AS
BEGIN

    UPDATE User_T
    SET [Address] = @NewAddress
    WHERE UserID = @UserID

END

SELECT * FROM User_T

EXEC ChangeAddress 0001,'GuangDong'



/*
Input an UserID get all orders the user have.
*/
CREATE PROCEDURE GetAllUserOrder @UserID INT

AS
BEGIN

SELECT *
FROM Order_T
WHERE PurchaserID = @UserID

END

EXEC GetAllUserOrder 0013


/*
Create a procedure to add a product into certain order
*/
ALTER procedure AddToOrder 
(
    @UserID INT, @ProductID int 
)
AS
BEGIN
DECLARE @Price INT

    SELECT @Price = SalePrice FROM Product_T p WHERE p.ProductID =  @ProductID
    INSERT INTO Order_T 
    VALUES (@UserID,@ProductID,GETDATE(),default,@Price)


END


exec AddToOrder 0020,2713;

SELECT * FROM Order_T 




/*
Input SizeType output All shoes with that SizeType
*/

CREATE PROCEDURE GetAllShoes @SizeType varchar(50) AS 
BEGIN 

  SELECT [ShoesID], ShoesSize, SizeType,ShoesType 
  FROM Shoes_T
  WHERE SizeType = @SizeType
    
END;

EXEC GetAllShoes 'Kids'


/*
Find the Most Expensive Product in Product Table
*/

ALTER PROCEDURE  GetExpensiveProduct AS
DECLARE @TheMostExpensiveProduct int
BEGIN 

  SELECT @TheMostExpensiveProduct = MAX(SalePrice) FROM Product_T;

  SELECT ProductID, SellerID, ProductDescription,SalePrice 
  FROM Product_T
  WHERE SalePrice = @TheMostExpensiveProduct
    
END;

   
EXEC GetExpensiveProduct 





--CREATE VIEW

CREATE VIEW User_V AS
	SELECT UserID,Email,PUserType,SUserType,AUSerType FROM User_T;

CREATE VIEW Order_V AS
	SELECT OrderID,ProductID,[Status] FROM Order_T;

CREATE VIEW Product_V AS
	SELECT ProductID,SellerID,Brand,ProductType,SalePrice FROM Product_T;


select *from User_V;
select *from Order_V;
select *from Product_V;





-- CREATE TRIGGER


/*
This trigger captures changes on User table
*/

--Create UserAudit table
CREATE TABLE [dbo].[UserAudit] (
UserID INT NOT NULL PRIMARY KEY,
UserName VARCHAR(25) NOT NULL,
Email VARCHAR(25) NOT NULL,
[Address] VARCHAR(100) NOT NULL,
[Password] VARCHAR(25) NOT NULL,
PUserType Varchar(1) NOT NULL, CHECK(PUserType IN ('Y','N')),
SUserType Varchar(1) NOT NULL, CHECK(PUserType IN ('Y','N')),
AUSerType Varchar(1) NOT NULL, CHECK(PUserType IN ('Y','N')),
[Action] char(1),
[ActionDate] datetime
)

CREATE TRIGGER UserUpdateHistory
   ON  dbo.User_T
  FOR UPDATE
AS 
BEGIN
declare @action char(1)
SET @action = 'U'

		INSERT INTO  UserAudit ( 
			  UserID, UserName, Email, [Address], [Password], PUserType, SUserType, AUserType,[Action],[ActionDate]
			  )
		  SELECT UserID, UserName, Email, [Address], [Password], PUserType, SUserType, AUserType,@action,GETDATE()
		    FROM DELETED
END



SELECT * FROM User_T
SELECT * FROM UserAudit

UPDATE User_T SET UserName = 'DAXIONG'
WHERE UserID = 0001


/*
After insertion of a new shipment, update order status from 'Pending' to "shipped"
*/

CREATE TRIGGER OrderUpdatePTS ON Shipment_T
AFTER  INSERT

AS
BEGIN

UPDATE Order_T 
SET [Status] = 'Shipped'
FROM Order_T t
WHERE t.OrderID = (SELECT OrderID FROM inserted)

END

SELECT * FROM Shipment_T
SELECT * FROM Order_T

DELETE From Shipment_T WHERE ShipmentID= 1107
INSERT INTO Shipment_T VALUES(1107,3016,'2020-03-24','2020-03-27','Beijing','Boston',1.11,0);

/*
 After shipment status changed to 1, update order status from"Shipped" to "Finished"
*/

ALTER TRIGGER OrderUpdateSTF ON Shipment_T 
AFTER  UPDATE

AS
BEGIN

UPDATE Order_T 
SET [Status] = 'Finished'
FROM Order_T t
WHERE t.OrderID = (SELECT OrderID FROM deleted)

END

SELECT * FROM Shipment_T
SELECT * FROM Order_T

UPDATE Shipment_T SET [Status] =1  WHERE OrderID= 3017 




--CREATE FUNCTION

/*
Input UserID output User's Address
*/

CREATE FUNCTION GetUserAddress
(
	@UserID int

)
RETURNS varchar(100)
AS
BEGIN
    DECLARE @UserAddress varchar(100)
 
    SELECT @UserAddress = u.Address
    FROM User_T u 
    WHERE u.UserID = @UserID
 
RETURN @UserAddress

END


SELECT dbo.GetUserAddress(0001)




/* 
Input CardHolderName output Card Type + Card Number
*/

ALTER FUNCTION GetCardInformation
(
	@CardHolderName VARCHAR(25)

)
RETURNS varchar(100)
AS
BEGIN
DECLARE @CardInformation varchar(100)
 
SELECT @CardInformation = c.[Type] + ' ' + CONVERT(VARCHAR,c.CardNumber)  from Card_T c 
WHERE c.CardHolderName = @CardHolderName 

RETURN @CardInformation 

END
GO

SELECT dbo.GetCardInformation('Guowei') AS CardInformation




-- Column Data Encryption


use Rename;
go
--Modify the User_T table by adding e_Password columns

alter table User_T add e_Password  varbinary(400)
/* variable binary  allow use of characters set outside your current character set
   data will be in hexadecimal format
   real security comes from the encryption algorithm used*/
go

--Create a master key for the database. 
create MASTER KEY
ENCRYPTION BY PASSWORD = 'KwokwaiChiang123';

-- very that master key exists
SELECT name KeyName,
  symmetric_key_id KeyID,
  key_length KeyLength,
  algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

go
--Create a self signed certificate and name it UserPass
CREATE CERTIFICATE UserPass  
   WITH SUBJECT = 'User Sample Password';  
GO  


--Create a symmetric key  with AES 256 algorithm using the certificate
-- as encryption/decryption method

CREATE SYMMETRIC KEY UserPass_SM 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE UserPass;  
GO  

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY UserPass_SM  
   DECRYPTION BY CERTIFICATE UserPass;  

-- Encrypt the value in column Password  with symmetric  key, and default everyone with
-- a password of UserPass_SM  
UPDATE dbo.User_T set e_Password = EncryptByKey(Key_GUID('UserPass_SM'), CONVERT(varbinary(500), [Password]))
GO 

-- First open the symmetric key with which to decrypt the data.  
OPEN SYMMETRIC KEY UserPass_SM  
   DECRYPTION BY CERTIFICATE UserPass;  
 
   
SELECT *, 
    CONVERT(varchar, DecryptByKey([e_Password]))   
    AS 'Decrypted password'  
    FROM dbo.User_T;  
GO  



-- Non-clustered indexes

CREATE NONCLUSTERED INDEX IX_Email ON User_T(Email ASC);

CREATE NONCLUSTERED INDEX IX_Date ON Order_T([Date] ASC)

CREATE NONCLUSTERED INDEX TX_Brand ON Product_T(Brand ASC);

CREATE NONCLUSTERED INDEX TX_Destination ON Shipment_T(Destination ASC);