CREATE TABLE Region 
( 
  RegionID  NUMERIC NOT NULL, 
  RegionDescription  CHAR(50) NOT NULL, 
CONSTRAINT PK_Region 
  PRIMARY KEY (RegionID)
) ;

CREATE TABLE Territories 
( 
  TerritoryID  VARCHAR(20) NOT NULL, 
  TerritoryDescription  CHAR(50) NOT NULL, 
  RegionID  NUMERIC NOT NULL, 
CONSTRAINT PK_Territories 
  PRIMARY KEY (TerritoryID), 
CONSTRAINT FK_Territories_Region FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
) ;

CREATE TABLE Categories 
( 
  CategoryID  NUMERIC NOT NULL, 
  CategoryName  VARCHAR(15) NOT NULL, 
  Description  VARCHAR(300),
  Picture  VARCHAR(300),  
  --Picture  LONG RAW, 
CONSTRAINT PK_Categories 
  PRIMARY KEY (CategoryID)
) ;

CREATE  INDEX CategoryName ON Categories(CategoryName);

CREATE TABLE Suppliers 
( 
  SupplierID  NUMERIC NOT NULL, 
  CompanyName  VARCHAR(40) NOT NULL, 
  ContactName  VARCHAR(30), 
  ContactTitle  VARCHAR(30), 
  Address  VARCHAR(60), 
  City  VARCHAR(15), 
  Region  VARCHAR(15), 
  PostalCode  VARCHAR(10), 
  Country  VARCHAR(15), 
  Phone  VARCHAR(24), 
  Fax  VARCHAR(24), 
  HomePage  VARCHAR(200), 
CONSTRAINT PK_Suppliers 
  PRIMARY KEY (SupplierID)
) ;

CREATE  INDEX CompanyName1 ON Suppliers(CompanyName);

CREATE  INDEX PostalCode2 ON Suppliers(PostalCode);


CREATE TABLE Products 
( 
  ProductID  NUMERIC NOT NULL, 
  ProductName  VARCHAR(40) NOT NULL, 
  SupplierID  NUMERIC, 
  CategoryID  NUMERIC, 
  QuantityPerUnit  VARCHAR(20), 
  UnitPrice  NUMERIC, 
  UnitsInStock  NUMERIC, 
  UnitsOnOrder  NUMERIC, 
  ReorderLevel  NUMERIC, 
  Discontinued  NUMERIC(1) NOT NULL, 
CONSTRAINT PK_Products 
  PRIMARY KEY (ProductID), 
CONSTRAINT CK_Products_UnitPrice   CHECK ((UnitPrice >= 0)), 
CONSTRAINT CK_ReorderLevel   CHECK ((ReorderLevel >= 0)), 
CONSTRAINT CK_UnitsInStock   CHECK ((UnitsInStock >= 0)), 
CONSTRAINT CK_UnitsOnOrder   CHECK ((UnitsOnOrder >= 0)), 
CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID), 
CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
) ;

 CREATE  INDEX CategoriesProducts ON Products(CategoryID);

 CREATE  INDEX ProductName ON Products(ProductName);

 CREATE  INDEX SupplierID ON Products(SupplierID);


CREATE TABLE Shippers 
( 
  ShipperID  NUMERIC NOT NULL, 
  CompanyName  VARCHAR(40) NOT NULL, 
  Phone  VARCHAR(24), 
CONSTRAINT PK_Shippers 
  PRIMARY KEY (ShipperID)
) ;

CREATE TABLE Customers 
( 
  CustomerID  CHAR(5) NOT NULL, 
  CompanyName  VARCHAR(40) NOT NULL, 
  ContactName  VARCHAR(30), 
  ContactTitle  VARCHAR(30), 
  Address  VARCHAR(60), 
  City  VARCHAR(15), 
  Region  VARCHAR(15), 
  PostalCode  VARCHAR(10), 
  Country  VARCHAR(15), 
  Phone  VARCHAR(24), 
  Fax  VARCHAR(24), 
CONSTRAINT PK_Customers 
  PRIMARY KEY (CustomerID)
) ;

 CREATE  INDEX City ON Customers(City);

 CREATE  INDEX CompanyName ON Customers(CompanyName);

 CREATE  INDEX PostalCode1 ON Customers(PostalCode);

 CREATE  INDEX Region ON Customers(Region);
 

CREATE TABLE Employees 
( 
  EmployeeID  NUMERIC NOT NULL, 
  LastName  VARCHAR(20) NOT NULL, 
  FirstName  VARCHAR(10) NOT NULL, 
  Title  VARCHAR(30), 
  TitleOfCourtesy  VARCHAR(25), 
  BirthDate  DATE, 
  HireDate  DATE, 
  Address  VARCHAR(60), 
  City  VARCHAR(15), 
  Region  VARCHAR(15), 
  PostalCode  VARCHAR(10), 
  Country  VARCHAR(15), 
  HomePhone  VARCHAR(24), 
  Extension  VARCHAR(4), 
  Photo  VARCHAR(300), 
  --Photo  LONG RAW, 
  Notes  VARCHAR(600), 
  ReportsTo  NUMERIC, 
  PhotoPath  VARCHAR(255), 
CONSTRAINT PK_Employees 
  PRIMARY KEY (EmployeeID), 
CONSTRAINT FK_Employees_Employees FOREIGN KEY (ReportsTo) REFERENCES Employees(EmployeeID)
) ;


 CREATE  INDEX LastName ON Employees(LastName);

 CREATE  INDEX PostalCode ON Employees(PostalCode);


CREATE TABLE EmployeeTerritories 
( 
  EmployeeID  NUMERIC NOT NULL, 
  TerritoryID  VARCHAR(20) NOT NULL, 
CONSTRAINT PK_EmpTerritories 
  PRIMARY KEY (EmployeeID, TerritoryID), 
CONSTRAINT FK_EmpTerri_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID), 
CONSTRAINT FK_EmpTerri_Territories FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID)
) ;


CREATE TABLE CustomerDemographics 
( 
  CustomerTypeID  CHAR(10) NOT NULL, 
  CustomerDesc  LONG, 
CONSTRAINT PK_CustomerDemographics 
  PRIMARY KEY (CustomerTypeID)
) ;

 

CREATE TABLE CustomerCustomerDemo 
( 
  CustomerID  CHAR(5) NOT NULL, 
  CustomerTypeID  CHAR(10) NOT NULL, 
CONSTRAINT PK_CustomerDemo 
  PRIMARY KEY (CustomerID, CustomerTypeID), 
CONSTRAINT FK_CustomerDemo FOREIGN KEY (CustomerTypeID) REFERENCES CustomerDemographics(CustomerTypeID), 
CONSTRAINT FK_CustomerDemo_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
) ;



CREATE TABLE Orders 
( 
  OrderID  NUMERIC NOT NULL, 
  CustomerID  CHAR(5), 
  EmployeeID  NUMERIC, 
  TerritoryID  VARCHAR(20), 
  OrderDate  DATE, 
  RequiredDate  DATE, 
  ShippedDate  DATE, 
  ShipVia  NUMERIC, 
  Freight  NUMERIC, 
  ShipName  VARCHAR(40), 
  ShipAddress  VARCHAR(60), 
  ShipCity  VARCHAR(15), 
  ShipRegion  VARCHAR(15), 
  ShipPostalCode  VARCHAR(10), 
  ShipCountry  VARCHAR(15), 
CONSTRAINT PK_Orders 
  PRIMARY KEY (OrderID), 
CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), 
CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID), 
CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID),
CONSTRAINT FK_Orders_Territories FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID)
); 
 

CREATE  INDEX CustomerID ON Orders(CustomerID);

 CREATE  INDEX EmployeeID ON Orders(EmployeeID);

 CREATE  INDEX OrderDate ON Orders(OrderDate);

 CREATE  INDEX ShippedDate ON Orders(ShippedDate);

 CREATE  INDEX ShippersOrders ON Orders(ShipVia);

 CREATE  INDEX ShipPostalCode ON Orders(ShipPostalCode);


CREATE TABLE OrderDetails 
( 
  OrderID  NUMERIC NOT NULL, 
  ProductID  NUMERIC NOT NULL, 
  UnitPrice  NUMERIC NOT NULL, 
  Quantity  NUMERIC NOT NULL, 
  Discount  NUMERIC NOT NULL, 
CONSTRAINT PK_Order_Details 
  PRIMARY KEY (OrderID, ProductID), 
CONSTRAINT CK_Discount   CHECK ((Discount >= 0 and Discount <= 1)), 
CONSTRAINT CK_Quantity   CHECK ((Quantity > 0)), 
CONSTRAINT CK_UnitPrice   CHECK ((UnitPrice >= 0)), 
CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), 
CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


 CREATE  INDEX OrderID ON OrderDetails(OrderID);

 CREATE  INDEX ProductID ON OrderDetails(ProductID);

create synonym "Order Details" for Order_Details;

create view  Customer_and_Suppliers_by_City  AS
SELECT City, CompanyName, ContactName, 'Customers' TableFrom
FROM Customers
UNION 
SELECT City, CompanyName, ContactName, 'Suppliers'
FROM Suppliers;
--ORDER BY City, CompanyName
--------------JAVIER CASTILLI ACA--------------
create synonym "Customer and Suppliers by City" for Customer_and_Suppliers_by_City;

create view Alphabetical_list_of_products AS
SELECT Products.*, Categories.CategoryName
FROM Categories, Products
WHERE Categories.CategoryID = Products.CategoryID
  and (((Products.Discontinued)=0));

create synonym "Alphabetical list of products" for Alphabetical_list_of_products;

create view Current_Product_List AS
SELECT ProductID, ProductName
FROM Products 
WHERE (((Discontinued)=0));
#NOMBRE?

create synonym "Current Product List" for Current_Product_List;

create view Orders_Qry AS
SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, 
    Orders.ShippedDate, Orders.ShipVia, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, 
    Orders.ShipRegion, Orders.ShipPostalCode, Orders.ShipCountry, 
    Customers.CompanyName, Customers.Address, Customers.City, Customers.Region, Customers.PostalCode, Customers.Country
FROM Customers,Orders
where Customers.CustomerID = Orders.CustomerID;

create synonym "Orders Qry" for Orders_Qry;

create view Products_Above_Average_Price AS
SELECT Products.ProductName, Products.UnitPrice
FROM Products
WHERE Products.UnitPrice>(SELECT AVG(UnitPrice) From Products);
#NOMBRE?

create synonym "Products Above Average Price" for Products_Above_Average_Price;

create view Products_by_Category AS
SELECT Categories.CategoryName, Products.ProductName, Products.QuantityPerUnit, Products.UnitsInStock, Products.Discontinued
FROM Categories, Products
WHERE Categories.CategoryID = Products.CategoryID
 and Products.Discontinued <> 1;
--ORDER BY Categories.CategoryName, Products.ProductName

create synonym "Products by Category" for Products_by_Category;

create or replace view Quarterly_Orders AS
SELECT DISTINCT Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country
FROM Customers, Orders 
WHERE Customers.CustomerID = Orders.CustomerID
  and to_date(Orders.OrderDate, 'MM/DD/YYYY') BETWEEN to_date('19970101', 'YYYYMMDD') And to_date('19971231', 'YYYYMMDD');

  create synonym "Quarterly Orders" for Quarterly_Orders;

create view Invoices AS
SELECT Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipRegion, Orders.ShipPostalCode, 
    Orders.ShipCountry, Orders.CustomerID, Customers.CompanyName AS CustomerName, Customers.Address, Customers.City, 
    Customers.Region, Customers.PostalCode, Customers.Country, 
    (FirstName||' '||LastName) AS Salesperson, 
    Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Shippers.CompanyName As ShipperName, 
    OrderDetails.ProductID, Products.ProductName, OrderDetails.UnitPrice, OrderDetails.Quantity, 
    OrderDetails.Discount, 
    OrderDetails.UnitPrice*Quantity*(1-Discount)/100 *100  AS ExtendedPrice, Orders.Freight
FROM     Shippers, Products, Employees, Customers, Orders, OrderDetails
where Customers.CustomerID = Orders.CustomerID
  and Employees.EmployeeID = Orders.EmployeeID
  and Orders.OrderID = OrderDetails.OrderID
  and Products.ProductID = OrderDetails.ProductID
  and Shippers.ShipperID = Orders.ShipVia;


create view Order_Details_Extended AS
SELECT OrderDetails.OrderID, OrderDetails.ProductID, Products.ProductName, 
    OrderDetails.UnitPrice, OrderDetails.Quantity, OrderDetails.Discount, 
    OrderDetails.UnitPrice*Quantity*(1-Discount)/100 * 100 AS ExtendedPrice
FROM Products, OrderDetails 
where Products.ProductID = OrderDetails.ProductID;
#NOMBRE?

create synonym "Order Details Extended" for OrderDetails_Extended;

create view Order_Subtotals AS
SELECT OrderDetails.OrderID, Sum(OrderDetails.UnitPrice*Quantity*(1-Discount)/100*100) AS Subtotal
FROM OrderDetails
GROUP BY OrderDetails.OrderID;

create synonym "Order Subtotals" for Order_Subtotals;

create or replace view Product_Sales_for_1997 AS
SELECT Categories.CategoryName, Products.ProductName, 
Sum(OrderDetails.UnitPrice*Quantity*(1-Discount)/100*100) AS ProductSales
FROM Categories , Products, OrderDetails, Orders
where Categories.CategoryID = Products.CategoryID
and      Orders.OrderID = OrderDetails.OrderID 
and      Products.ProductID = OrderDetails.ProductID
and   to_date(Orders.ShippedDate, 'MM/DD/YYYY') Between to_date('19970101', 'YYYYMMDD') And to_date('19971231', 'YYYYMMDD')
GROUP BY Categories.CategoryName, Products.ProductName;

create synonym "Product Sales for 1997" for Product_Sales_for_1997;

create view Category_Sales_for_1997 AS
SELECT Product_Sales_for_1997.CategoryName, Sum(Product_Sales_for_1997.ProductSales) AS CategorySales
FROM Product_Sales_for_1997
GROUP BY Product_Sales_for_1997.CategoryName;

create synonym "Category Sales for 1997" for Category_Sales_for_1997;

create or replace view Sales_by_Category AS
SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductName, 
    Sum(Order_Details_Extended.ExtendedPrice) AS ProductSales
FROM     Categories, Products, Order_Details_Extended, Orders
where  Orders.OrderID = Order_Details_Extended.OrderID 
and    Products.ProductID = Order_Details_Extended.ProductID 
and   Categories.CategoryID = Products.CategoryID
and   to_date(Orders.OrderDate, 'MM/DD/YYYY') BETWEEN to_date('19970101', 'YYYYMMDD') And to_date('19971231', 'YYYYMMDD')
GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName;
#NOMBRE?

create synonym "Sales by Category" for Sales_by_Category;

create or replace view Sales_Totals_by_Amount AS
SELECT Order_Subtotals.Subtotal AS SaleAmount, Orders.OrderID, Customers.CompanyName, Orders.ShippedDate
FROM     Customers,  Order_Subtotals, Orders
where Orders.OrderID = Order_Subtotals.OrderID 
and  Customers.CustomerID = Orders.CustomerID
and (Order_Subtotals.Subtotal >2500) AND (to_date(Orders.ShippedDate, 'MM/DD/YYYY') BETWEEN to_date('19970101', 'YYYYMMDD') And to_date('19971231', 'YYYYMMDD'));

create synonym "Sales Totals by Amount" for Sales_Totals_by_Amount;

create view Summary_of_Sales_by_Quarter AS
SELECT Orders.ShippedDate, Orders.OrderID, Order_Subtotals.Subtotal
FROM Orders, Order_Subtotals 
where Orders.OrderID = Order_Subtotals.OrderID
and Orders.ShippedDate IS NOT NULL;
#NOMBRE?

create synonym "Summary of Sales by Quarter" for Summary_of_Sales_by_Quarter;

create view Summary_of_Sales_by_Year AS
SELECT Orders.ShippedDate, Orders.OrderID, Order_Subtotals.Subtotal
FROM Orders, Order_Subtotals 
where Orders.OrderID = Order_Subtotals.OrderID
and Orders.ShippedDate IS NOT NULL;


create synonym "Summary of Sales by Year" for Summary_of_Sales_by_Year;