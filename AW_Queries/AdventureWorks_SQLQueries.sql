/*1.Ranked order of Vendors by purchase amount $ */

SELECT poh.VendorID,SUM(poh.TotalDue) AS PurchaseAmount,v.NAME AS VendorNames,
RANK () OVER (ORDER BY Sum(poh.TotalDue)DESC) AS "Rank Numbers",
CONCAT('$', SUM(poh.TotalDue) ) AS PurchaseAmountinDollar
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.PurchaseOrderDetail pod ON poh.PurchaseOrderID= pod.PurchaseOrderID
INNER JOIN Purchasing.ProductVendor pv ON pod.ProductID= pv.ProductID
INNER JOIN Purchasing.Vendor v ON pv.BusinessEntityID=v.BusinessEntityID
GROUP BY poh.VendorID,v.Name
order by PurchaseAmount desc;


/*2.Ranked order of products purchased by amount $ 
•	By Category
•	By SubCategory
•	By ProductModel(Top 20)
•	By Product(Top 20)
*/

select top 20 poh.VendorID,
pm.Name ProductModel, 
pc.Name as ProductCategory,
psc.Name as ProductSubcategory,
p.Name AS ProductName,
SUM(poh.TotalDue) AS PurchaseAmount, v.Name AS VendorNames,
RANK () OVER (ORDER BY Sum(poh.TotalDue)DESC) AS "Rank Numbers",
CONCAT('$', SUM(poh.TotalDue) ) AS PurchaseAmountinDollar
from Purchasing.PurchaseOrderHeader poh
inner join Purchasing.PurchaseOrderDetail pod on poh.PurchaseOrderID= pod.PurchaseOrderID
inner join Purchasing.ProductVendor pv on pod.ProductID= pv.ProductID
inner join Purchasing.Vendor v on pv.BusinessEntityID=v.BusinessEntityID
inner join Production.Product p on p.ProductID =pv.ProductID
inner join Production.ProductSubcategory psc on p.ProductSubcategoryID = p.ProductSubcategoryID
inner join Production.ProductCategory pc on psc.ProductCategoryID = pc.ProductCategoryID
inner join Production.ProductModel pm on pm.ProductModelID = p.ProductModelID
GROUP BY poh.VendorID,v.Name,pm.Name,p.Name,psc.Name,pc.Name;

/*3.List of employees who purchased products with phone, email & address  */

SELECT p.BusinessEntityID,
sp.StateProvinceID,
cr.CountryRegionCode,
ea.EmailAddress,
pp.PhoneNumber
FROM Person.Person p
full outer JOIN Person.BusinessEntity be ON p.BusinessEntityID = be.BusinessEntityID
full outer JOIN Person.BusinessEntityAddress bea ON be.BusinessEntityID = bea.BusinessEntityID
full outer JOIN Person.Address a ON bea.AddressID = a.AddressID
full outer JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
full outer JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
full outer JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
full outer join Person.PersonPhone pp ON p.BusinessEntityID = pp.BusinessEntityID
full outer Join Sales.SalesOrderHeader soh ON a.AddressID = soh.BillToAddressID
full outer join Sales.Customer sc on p.BusinessEntityID = sc.PersonID
WHERE p.PersonType = 'EM';

/*4. List of employees who purchased products with pay rate & raises (SCD) */

SELECT e.LoginID, eph.Rate,eph.PayFrequency,eph.ModifiedDate
FROM HumanResources.EmployeePayHistory eph
INNER JOIN HumanResources.Employee e ON e.BusinessEntityID = eph.BusinessEntityID
INNER JOIN Purchasing.PurchaseOrderHeader poh ON e.BusinessEntityID = poh.EmployeeID
INNER JOIN Purchasing.PurchaseOrderDetail pod ON pod.PurchaseOrderID = poh.PurchaseOrderID
GROUP BY e.LoginID,eph.Rate,eph.PayFrequency,eph.ModifiedDate
ORDER BY eph.Rate DESC;

/*5. List of purchasing vendor contacts with vendor name, phone, email & address  */

select purchaseohead.VendorID,vwc.FirstName,vwc.LastName,vwc.EmailAddress,vwc.PhoneNumber from purchasing.vVendorWithAddresses  vwa inner join purchasing.PurchaseOrderHeader purchaseohead
on vwa.BusinessEntityID = purchaseohead.VendorID
inner join purchasing.vVendorWithContacts vwc on vwc.BusinessEntityID = purchaseohead.VendorID
group by purchaseohead.VendorID,vwc.FirstName,vwc.LastName,vwc.EmailAddress,vwc.PhoneNumber;

/*6. List of product prices by product order by product and SCD effective ascending */

select ProductID, Name as ProductName, StandardCost,ModifiedDate, ListPrice
from Production.Product
group by ProductID,Name, StandardCost, ModifiedDate, ListPrice
order by ProductID, ModifiedDate;

/*7.List of standard costs by product order by product and SCD effective ascending  */

SELECT pch.ProductID,pch.StandardCost, pch.ModifiedDate,pch.StartDate,pch.EndDate
FROM Production.ProductCostHistory AS pch
JOIN Sales.SalesOrderDetail AS sod
ON pch.ProductID=sod.ProductID
RIGHT JOIN Production.TransactionHistory AS th
ON sod.ProductID=th.ProductID
WHERE pch.ProductID IS NOT NULL
GROUP BY pch.ProductID,pch.StandardCost, pch.ModifiedDate,pch.StartDate,pch.EndDate
ORDER BY pch.ModifiedDate;




