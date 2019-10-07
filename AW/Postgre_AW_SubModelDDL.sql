--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      DATA MODEL
--
-- Date Created : Saturday, September 28, 2019 23:24:14
-- Target DBMS : PostgreSQL 9.x
--

-- 
-- TABLE: "Address" 
--

CREATE TABLE "Address"(
    "AddressID"        int4           NOT NULL,
    "AddressLine1"     varchar(60)    NOT NULL,
    "AddressLine2"     varchar(60),
    "City"             varchar(30)    NOT NULL,
    "StateProvinceID"  int4           NOT NULL,
    "PostalCode"       varchar(15)    NOT NULL,
    "SpatialLocation"  char(10),
    rowguid            uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"     timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Address_AddressID" PRIMARY KEY ("AddressID")
)
;



-- 
-- TABLE: "AddressType" 
--

CREATE TABLE "AddressType"(
    "AddressTypeID"  int4           NOT NULL,
    "Name"           varchar(50)    NOT NULL,
    rowguid          uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"   timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY ("AddressTypeID")
)
;



-- 
-- TABLE: "AWBuildVersion" 
--

CREATE TABLE "AWBuildVersion"(
    "SystemInformationID"  int2           NOT NULL,
    "Database Version"     varchar(25)    NOT NULL,
    "VersionDate"          timestamp      NOT NULL,
    "ModifiedDate"         timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_AWBuildVersion_SystemInformationID" PRIMARY KEY ("SystemInformationID")
)
;



-- 
-- TABLE: "BillOfMaterials" 
--

CREATE TABLE "BillOfMaterials"(
    "BillOfMaterialsID"  int4             NOT NULL,
    "ProductAssemblyID"  int4,
    "ComponentID"        int4             NOT NULL,
    "StartDate"          timestamp        DEFAULT (getdate()) NOT NULL,
    "EndDate"            timestamp,
    "UnitMeasureCode"    char(3)          NOT NULL,
    "BOMLevel"           int2             NOT NULL,
    "PerAssemblyQty"     decimal(8, 2)    DEFAULT (1.00) NOT NULL
                         CHECK (([PerAssemblyQty]>=(1.00))),
    "ModifiedDate"       timestamp        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY ("BillOfMaterialsID")
)
;



-- 
-- TABLE: "BusinessEntity" 
--

CREATE TABLE "BusinessEntity"(
    "BusinessEntityID"  int4         NOT NULL,
    rowguid             uuid         DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
)
;



-- 
-- TABLE: "BusinessEntityAddress" 
--

CREATE TABLE "BusinessEntityAddress"(
    "BusinessEntityID"  int4         NOT NULL,
    "AddressID"         int4         NOT NULL,
    "AddressTypeID"     int4         NOT NULL,
    rowguid             uuid         DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID" PRIMARY KEY ("BusinessEntityID", "AddressID", "AddressTypeID")
)
;



-- 
-- TABLE: "BusinessEntityContact" 
--

CREATE TABLE "BusinessEntityContact"(
    "BusinessEntityID"  int4         NOT NULL,
    "PersonID"          int4         NOT NULL,
    "ContactTypeID"     int4         NOT NULL,
    rowguid             uuid         DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID" PRIMARY KEY ("BusinessEntityID", "PersonID", "ContactTypeID")
)
;



-- 
-- TABLE: "ContactType" 
--

CREATE TABLE "ContactType"(
    "ContactTypeID"  int4           NOT NULL,
    "Name"           varchar(50)    NOT NULL,
    "ModifiedDate"   timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY ("ContactTypeID")
)
;



-- 
-- TABLE: "CountryRegion" 
--

CREATE TABLE "CountryRegion"(
    "CountryRegionCode"  varchar(3)     NOT NULL,
    "Name"               varchar(50)    NOT NULL,
    "ModifiedDate"       timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY ("CountryRegionCode")
)
;



-- 
-- TABLE: "CountryRegionCurrency" 
--

CREATE TABLE "CountryRegionCurrency"(
    "CountryRegionCode"  varchar(3)    NOT NULL,
    "CurrencyCode"       char(3)       NOT NULL,
    "ModifiedDate"       timestamp     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY ("CountryRegionCode", "CurrencyCode")
)
;



-- 
-- TABLE: "CreditCard" 
--

CREATE TABLE "CreditCard"(
    "CreditCardID"  int4           NOT NULL,
    "CardType"      varchar(50)    NOT NULL,
    "CardNumber"    varchar(25)    NOT NULL,
    "ExpMonth"      int2           NOT NULL,
    "ExpYear"       int2           NOT NULL,
    "ModifiedDate"  timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY ("CreditCardID")
)
;



-- 
-- TABLE: "Culture" 
--

CREATE TABLE "Culture"(
    "CultureID"     char(6)        NOT NULL,
    "Name"          varchar(50)    NOT NULL,
    "ModifiedDate"  timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY ("CultureID")
)
;



-- 
-- TABLE: "Currency" 
--

CREATE TABLE "Currency"(
    "CurrencyCode"  char(3)        NOT NULL,
    "Name"          varchar(50)    NOT NULL,
    "ModifiedDate"  timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY ("CurrencyCode")
)
;



-- 
-- TABLE: "CurrencyRate" 
--

CREATE TABLE "CurrencyRate"(
    "CurrencyRateID"    int4         NOT NULL,
    "CurrencyRateDate"  timestamp    NOT NULL,
    "FromCurrencyCode"  char(3)      NOT NULL,
    "ToCurrencyCode"    char(3)      NOT NULL,
    "AverageRate"       money        NOT NULL,
    "EndOfDayRate"      money        NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY ("CurrencyRateID")
)
;



-- 
-- TABLE: "Customer" 
--

CREATE TABLE "Customer"(
    "CustomerID"     int4           NOT NULL,
    "PersonID"       int4,
    "StoreID"        int4,
    "TerritoryID"    int4,
    "AccountNumber"  varchar(10)    NOT NULL,
    rowguid          uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"   timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY ("CustomerID")
)
;



-- 
-- TABLE: "DatabaseLog" 
--

CREATE TABLE "DatabaseLog"(
    "DatabaseLogID"  int4             NOT NULL,
    "PostTime"       timestamp        NOT NULL,
    "DatabaseUser"   char(10)         NOT NULL,
    "Event"          char(10)         NOT NULL,
    "Schema"         char(10),
    "Object"         char(10),
    "TSQL"           varchar(4000)    NOT NULL,
    "XmlEvent"       xml              NOT NULL,
    CONSTRAINT "PK_DatabaseLog_DatabaseLogID" PRIMARY KEY ("DatabaseLogID")
)
;



-- 
-- TABLE: "Department" 
--

CREATE TABLE "Department"(
    "DepartmentID"  int2           NOT NULL,
    "Name"          varchar(50)    NOT NULL,
    "GroupName"     varchar(50)    NOT NULL,
    "ModifiedDate"  timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY ("DepartmentID")
)
;



-- 
-- TABLE: "Document" 
--

CREATE TABLE "Document"(
    "DocumentNode"     char(10)         NOT NULL,
    "DocumentLevel"    int2,
    "Title"            varchar(50)      NOT NULL,
    "Owner"            int4             NOT NULL,
    "FolderFlag"       boolean          DEFAULT ((0)) NOT NULL,
    "FileName"         varchar(400)     NOT NULL,
    "FileExtension"    varchar(8)       NOT NULL,
    "Revision"         char(5)          NOT NULL,
    "ChangeNumber"     int4             DEFAULT (0) NOT NULL,
    "Status"           int2             NOT NULL
                       CHECK (([Status]>=(1) AND [Status]<=(3))),
    "DocumentSummary"  varchar(4000),
    "Document"         bytea,
    rowguid            uuid             DEFAULT (newid()) NOT NULL,
    "ModifiedDate"     timestamp        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY ("DocumentNode")
)
;



-- 
-- TABLE: "EmailAddress" 
--

CREATE TABLE "EmailAddress"(
    "BusinessEntityID"  int4           NOT NULL,
    "EmailAddressID"    int4           NOT NULL,
    "EmailAddress"      varchar(50),
    rowguid             uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY ("BusinessEntityID", "EmailAddressID")
)
;



-- 
-- TABLE: "Employee" 
--

CREATE TABLE "Employee"(
    "BusinessEntityID"   int4            NOT NULL,
    "NationalIDNumber"   varchar(15)     NOT NULL,
    "LoginID"            varchar(256)    NOT NULL,
    "OrganizationNode"   char(10),
    "OrganizationLevel"  int2,
    "JobTitle"           varchar(50)     NOT NULL,
    "BirthDate"          date            NOT NULL
                         CHECK (([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate()))),
    "MaritalStatus"      char(1)         NOT NULL
                         CHECK ((upper([MaritalStatus])='S' OR upper([MaritalStatus])='M')),
    "Gender"             char(1)         NOT NULL
                         CHECK ((upper([Gender])='F' OR upper([Gender])='M')),
    "HireDate"           date            NOT NULL
                         CHECK (([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate()))),
    "SalariedFlag"       boolean         DEFAULT ((1)) NOT NULL,
    "VacationHours"      int2            DEFAULT (0) NOT NULL
                         CHECK (([VacationHours]>=(-40) AND [VacationHours]<=(240))),
    "SickLeaveHours"     int2            DEFAULT (0) NOT NULL
                         CHECK (([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120))),
    "CurrentFlag"        boolean         DEFAULT ((1)) NOT NULL,
    rowguid              uuid            DEFAULT (newid()) NOT NULL,
    "ModifiedDate"       timestamp       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Employee_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
)
;



-- 
-- TABLE: "EmployeeDepartmentHistory" 
--

CREATE TABLE "EmployeeDepartmentHistory"(
    "BusinessEntityID"  int4         NOT NULL,
    "DepartmentID"      int2         NOT NULL,
    "ShiftID"           int2         NOT NULL,
    "StartDate"         date         NOT NULL,
    "EndDate"           date,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID" PRIMARY KEY ("BusinessEntityID", "DepartmentID", "ShiftID", "StartDate")
)
;



-- 
-- TABLE: "EmployeePayHistory" 
--

CREATE TABLE "EmployeePayHistory"(
    "BusinessEntityID"  int4         NOT NULL,
    "RateChangeDate"    timestamp    NOT NULL,
    "Rate"              money        NOT NULL
                        CHECK (([Rate]>=(6.50) AND [Rate]<=(200.00))),
    "PayFrequency"      int2         NOT NULL
                        CHECK (([PayFrequency]=(2) OR [PayFrequency]=(1))),
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY ("BusinessEntityID", "RateChangeDate")
)
;



-- 
-- TABLE: "ErrorLog" 
--

CREATE TABLE "ErrorLog"(
    "ErrorLogID"      int4             NOT NULL,
    "ErrorTime"       timestamp        DEFAULT (getdate()) NOT NULL,
    "UserName"        char(10)         NOT NULL,
    "ErrorNumber"     int4             NOT NULL,
    "ErrorSeverity"   int4,
    "ErrorState"      int4,
    "ErrorProcedure"  varchar(126),
    "ErrorLine"       int4,
    "ErrorMessage"    varchar(4000)    NOT NULL,
    CONSTRAINT "PK_ErrorLog_ErrorLogID" PRIMARY KEY ("ErrorLogID")
)
;



-- 
-- TABLE: "Illustration" 
--

CREATE TABLE "Illustration"(
    "IllustrationID"  int4         NOT NULL,
    "Diagram"         xml,
    "ModifiedDate"    timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY ("IllustrationID")
)
;



-- 
-- TABLE: "JobCandidate" 
--

CREATE TABLE "JobCandidate"(
    "JobCandidateID"    int4         NOT NULL,
    "BusinessEntityID"  int4,
    "Resume"            xml,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY ("JobCandidateID")
)
;



-- 
-- TABLE: "Location" 
--

CREATE TABLE "Location"(
    "LocationID"    int2              NOT NULL,
    "Name"          varchar(50)       NOT NULL,
    "CostRate"      numeric(10, 1)    DEFAULT (0.00) NOT NULL
                    CHECK (([CostRate]>=(0.00))),
    "Availability"  decimal(8, 2)     DEFAULT (0.00) NOT NULL
                    CHECK (([Availability]>=(0.00))),
    "ModifiedDate"  timestamp         DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Location_LocationID" PRIMARY KEY ("LocationID")
)
;



-- 
-- TABLE: "Password" 
--

CREATE TABLE "Password"(
    "BusinessEntityID"  int4            NOT NULL,
    "PasswordHash"      varchar(128)    NOT NULL,
    "PasswordSalt"      varchar(10)     NOT NULL,
    rowguid             uuid            DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
)
;



-- 
-- TABLE: "Person" 
--

CREATE TABLE "Person"(
    "BusinessEntityID"       int4           NOT NULL,
    "PersonType"             char(2)        NOT NULL
                             CHECK (([PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC'))),
    "NameStyle"              boolean        DEFAULT ((0)) NOT NULL,
    "Title"                  varchar(8),
    "FirstName"              varchar(50)    NOT NULL,
    "MiddleName"             varchar(50),
    "LastName"               varchar(50)    NOT NULL,
    "Suffix"                 varchar(10),
    "EmailPromotion"         int4           DEFAULT (0) NOT NULL
                             CHECK (([EmailPromotion]>=(0) AND [EmailPromotion]<=(2))),
    "AdditionalContactInfo"  xml,
    "Demographics"           xml,
    rowguid                  uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"           timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
)
;



-- 
-- TABLE: "PersonCreditCard" 
--

CREATE TABLE "PersonCreditCard"(
    "BusinessEntityID"  int4         NOT NULL,
    "CreditCardID"      int4         NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY ("BusinessEntityID", "CreditCardID")
)
;



-- 
-- TABLE: "PersonPhone" 
--

CREATE TABLE "PersonPhone"(
    "BusinessEntityID"   int4           NOT NULL,
    "PhoneNumber"        varchar(25)    NOT NULL,
    "PhoneNumberTypeID"  int4           NOT NULL,
    "ModifiedDate"       timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID" PRIMARY KEY ("BusinessEntityID", "PhoneNumber", "PhoneNumberTypeID")
)
;



-- 
-- TABLE: "PhoneNumberType" 
--

CREATE TABLE "PhoneNumberType"(
    "PhoneNumberTypeID"  int4           NOT NULL,
    "Name"               varchar(50)    NOT NULL,
    "ModifiedDate"       timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY ("PhoneNumberTypeID")
)
;



-- 
-- TABLE: "Product" 
--

CREATE TABLE "Product"(
    "ProductID"              int4             NOT NULL,
    "Name"                   varchar(50)      NOT NULL,
    "ProductNumber"          varchar(25)      NOT NULL,
    "MakeFlag"               boolean          DEFAULT ((1)) NOT NULL,
    "FinishedGoodsFlag"      boolean          DEFAULT ((1)) NOT NULL,
    "Color"                  varchar(15),
    "SafetyStockLevel"       int2             NOT NULL
                             CHECK (([SafetyStockLevel]>(0))),
    "ReorderPoint"           int2             NOT NULL
                             CHECK (([ReorderPoint]>(0))),
    "StandardCost"           money            NOT NULL
                             CHECK (([StandardCost]>=(0.00))),
    "ListPrice"              money            NOT NULL
                             CHECK (([ListPrice]>=(0.00))),
    "Size"                   varchar(5),
    "SizeUnitMeasureCode"    char(3),
    "WeightUnitMeasureCode"  char(3),
    "Weight"                 decimal(8, 2)    
                             CHECK (([Weight]>(0.00))),
    "DaysToManufacture"      int4             NOT NULL
                             CHECK (([DaysToManufacture]>=(0))),
    "ProductLine"            char(2)          
                             CHECK ((upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL)),
    "Class"                  char(2)          
                             CHECK ((upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL)),
    "Style"                  char(2)          
                             CHECK ((upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL)),
    "ProductSubcategoryID"   int4,
    "ProductModelID"         int4,
    "SellStartDate"          timestamp        NOT NULL,
    "SellEndDate"            timestamp,
    "DiscontinuedDate"       timestamp,
    rowguid                  uuid             DEFAULT (newid()) NOT NULL,
    "ModifiedDate"           timestamp        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Product_ProductID" PRIMARY KEY ("ProductID")
)
;



-- 
-- TABLE: "ProductCategory" 
--

CREATE TABLE "ProductCategory"(
    "ProductCategoryID"  int4           NOT NULL,
    "Name"               varchar(50)    NOT NULL,
    rowguid              uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"       timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY ("ProductCategoryID")
)
;



-- 
-- TABLE: "ProductCostHistory" 
--

CREATE TABLE "ProductCostHistory"(
    "ProductID"     int4         NOT NULL,
    "StartDate"     timestamp    NOT NULL,
    "EndDate"       timestamp,
    "StandardCost"  money        NOT NULL
                    CHECK (([StandardCost]>=(0.00))),
    "ModifiedDate"  timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY ("ProductID", "StartDate")
)
;



-- 
-- TABLE: "ProductDescription" 
--

CREATE TABLE "ProductDescription"(
    "ProductDescriptionID"  int4            NOT NULL,
    "Description"           varchar(400)    NOT NULL,
    rowguid                 uuid            DEFAULT (newid()) NOT NULL,
    "ModifiedDate"          timestamp       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY ("ProductDescriptionID")
)
;



-- 
-- TABLE: "ProductDocument" 
--

CREATE TABLE "ProductDocument"(
    "ProductID"     int4         NOT NULL,
    "DocumentNode"  char(10)     NOT NULL,
    "ModifiedDate"  timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY ("ProductID", "DocumentNode")
)
;



-- 
-- TABLE: "ProductInventory" 
--

CREATE TABLE "ProductInventory"(
    "ProductID"     int4           NOT NULL,
    "LocationID"    int2           NOT NULL,
    "Shelf"         varchar(10)    NOT NULL
                    CHECK (([Shelf] like '[A-Za-z]' OR [Shelf]='N/A')),
    "Bin"           int2           NOT NULL
                    CHECK (([Bin]>=(0) AND [Bin]<=(100))),
    "Quantity"      int2           DEFAULT (0) NOT NULL,
    rowguid         uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"  timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY ("ProductID", "LocationID")
)
;



-- 
-- TABLE: "ProductListPriceHistory" 
--

CREATE TABLE "ProductListPriceHistory"(
    "ProductID"     int4         NOT NULL,
    "StartDate"     timestamp    NOT NULL,
    "EndDate"       timestamp,
    "ListPrice"     money        NOT NULL
                    CHECK (([ListPrice]>(0.00))),
    "ModifiedDate"  timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY ("ProductID", "StartDate")
)
;



-- 
-- TABLE: "ProductModel" 
--

CREATE TABLE "ProductModel"(
    "ProductModelID"      int4           NOT NULL,
    "Name"                varchar(50)    NOT NULL,
    "CatalogDescription"  xml,
    "Instructions"        xml,
    rowguid               uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"        timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY ("ProductModelID")
)
;



-- 
-- TABLE: "ProductModelIllustration" 
--

CREATE TABLE "ProductModelIllustration"(
    "ProductModelID"  int4         NOT NULL,
    "IllustrationID"  int4         NOT NULL,
    "ModifiedDate"    timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY ("ProductModelID", "IllustrationID")
)
;



-- 
-- TABLE: "ProductModelProductDescriptionCulture" 
--

CREATE TABLE "ProductModelProductDescriptionCulture"(
    "ProductModelID"        int4         NOT NULL,
    "ProductDescriptionID"  int4         NOT NULL,
    "CultureID"             char(6)      NOT NULL,
    "ModifiedDate"          timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID" PRIMARY KEY ("ProductModelID", "ProductDescriptionID", "CultureID")
)
;



-- 
-- TABLE: "ProductPhoto" 
--

CREATE TABLE "ProductPhoto"(
    "ProductPhotoID"          int4           NOT NULL,
    "ThumbNailPhoto"          bytea,
    "ThumbnailPhotoFileName"  varchar(50),
    "LargePhoto"              bytea,
    "LargePhotoFileName"      varchar(50),
    "ModifiedDate"            timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY ("ProductPhotoID")
)
;



-- 
-- TABLE: "ProductProductPhoto" 
--

CREATE TABLE "ProductProductPhoto"(
    "ProductID"       int4         NOT NULL,
    "ProductPhotoID"  int4         NOT NULL,
    "Primary"         boolean      DEFAULT ((0)) NOT NULL,
    "ModifiedDate"    timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY ("ProductID", "ProductPhotoID")
)
;



-- 
-- TABLE: "ProductReview" 
--

CREATE TABLE "ProductReview"(
    "ProductReviewID"  int4             NOT NULL,
    "ProductID"        int4             NOT NULL,
    "ReviewerName"     varchar(50)      NOT NULL,
    "ReviewDate"       timestamp        DEFAULT (getdate()) NOT NULL,
    "EmailAddress"     varchar(50)      NOT NULL,
    "Rating"           int4             NOT NULL
                       CHECK (([Rating]>=(1) AND [Rating]<=(5))),
    "Comments"         varchar(3850),
    "ModifiedDate"     timestamp        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY ("ProductReviewID")
)
;



-- 
-- TABLE: "ProductSubcategory" 
--

CREATE TABLE "ProductSubcategory"(
    "ProductSubcategoryID"  int4           NOT NULL,
    "ProductCategoryID"     int4           NOT NULL,
    "Name"                  varchar(50)    NOT NULL,
    rowguid                 uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"          timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY ("ProductSubcategoryID")
)
;



-- 
-- TABLE: "ProductVendor" 
--

CREATE TABLE "ProductVendor"(
    "ProductID"         int4         NOT NULL,
    "BusinessEntityID"  int4         NOT NULL,
    "AverageLeadTime"   int4         NOT NULL
                        CHECK (([AverageLeadTime]>=(1))),
    "StandardPrice"     money        NOT NULL
                        CHECK (([StandardPrice]>(0.00))),
    "LastReceiptCost"   money        
                        CHECK (([LastReceiptCost]>(0.00))),
    "LastReceiptDate"   timestamp,
    "MinOrderQty"       int4         NOT NULL
                        CHECK (([MinOrderQty]>=(1))),
    "MaxOrderQty"       int4         NOT NULL
                        CHECK (([MaxOrderQty]>=(1))),
    "OnOrderQty"        int4         
                        CHECK (([OnOrderQty]>=(0))),
    "UnitMeasureCode"   char(3)      NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY ("ProductID", "BusinessEntityID")
)
;



-- 
-- TABLE: "PurchaseOrderDetail" 
--

CREATE TABLE "PurchaseOrderDetail"(
    "PurchaseOrderID"        int4             NOT NULL,
    "PurchaseOrderDetailID"  int4             NOT NULL,
    "DueDate"                timestamp        NOT NULL,
    "OrderQty"               int2             NOT NULL
                             CHECK (([OrderQty]>(0))),
    "ProductID"              int4             NOT NULL,
    "UnitPrice"              money            NOT NULL
                             CHECK (([UnitPrice]>=(0.00))),
    "LineTotal"              money            NOT NULL,
    "ReceivedQty"            decimal(8, 2)    NOT NULL
                             CHECK (([ReceivedQty]>=(0.00))),
    "RejectedQty"            decimal(8, 2)    NOT NULL
                             CHECK (([RejectedQty]>=(0.00))),
    "StockedQty"             decimal(9, 2)    NOT NULL,
    "ModifiedDate"           timestamp        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY ("PurchaseOrderID", "PurchaseOrderDetailID")
)
;



-- 
-- TABLE: "PurchaseOrderHeader" 
--

CREATE TABLE "PurchaseOrderHeader"(
    "PurchaseOrderID"  int4         NOT NULL,
    "RevisionNumber"   int2         DEFAULT (0) NOT NULL,
    "Status"           int2         DEFAULT (1) NOT NULL
                       CHECK (([Status]>=(1) AND [Status]<=(4))),
    "EmployeeID"       int4         NOT NULL,
    "VendorID"         int4         NOT NULL,
    "ShipMethodID"     int4         NOT NULL,
    "OrderDate"        timestamp    DEFAULT (getdate()) NOT NULL,
    "ShipDate"         timestamp,
    "SubTotal"         money        DEFAULT ((0.00)) NOT NULL
                       CHECK (([SubTotal]>=(0.00))),
    "TaxAmt"           money        DEFAULT ((0.00)) NOT NULL
                       CHECK (([TaxAmt]>=(0.00))),
    "Freight"          money        DEFAULT ((0.00)) NOT NULL
                       CHECK (([Freight]>=(0.00))),
    "TotalDue"         money        NOT NULL,
    "ModifiedDate"     timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY ("PurchaseOrderID")
)
;



-- 
-- TABLE: "SalesOrderDetail" 
--

CREATE TABLE "SalesOrderDetail"(
    "SalesOrderID"           int4              NOT NULL,
    "SalesOrderDetailID"     int4              NOT NULL,
    "CarrierTrackingNumber"  varchar(25),
    "OrderQty"               int2              NOT NULL
                             CHECK (([OrderQty]>(0))),
    "ProductID"              int4              NOT NULL,
    "SpecialOfferID"         int4              NOT NULL,
    "UnitPrice"              money             NOT NULL
                             CHECK (([UnitPrice]>=(0.00))),
    "UnitPriceDiscount"      money             DEFAULT ((0.0)) NOT NULL
                             CHECK (([UnitPriceDiscount]>=(0.00))),
    "LineTotal"              numeric(38, 6)    NOT NULL,
    rowguid                  uuid              DEFAULT (newid()) NOT NULL,
    "ModifiedDate"           timestamp         DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY ("SalesOrderID", "SalesOrderDetailID")
)
;



-- 
-- TABLE: "SalesOrderHeader" 
--

CREATE TABLE "SalesOrderHeader"(
    "SalesOrderID"            int4            NOT NULL,
    "RevisionNumber"          int2            DEFAULT (0) NOT NULL,
    "OrderDate"               timestamp       DEFAULT (getdate()) NOT NULL,
    "DueDate"                 timestamp       NOT NULL,
    "ShipDate"                timestamp,
    "Status"                  int2            DEFAULT (1) NOT NULL
                              CHECK (([Status]>=(0) AND [Status]<=(8))),
    "OnlineOrderFlag"         boolean         DEFAULT ((1)) NOT NULL,
    "SalesOrderNumber"        varchar(25)     NOT NULL,
    "PurchaseOrderNumber"     varchar(25),
    "AccountNumber"           varchar(15),
    "CustomerID"              int4            NOT NULL,
    "SalesPersonID"           int4,
    "TerritoryID"             int4,
    "BillToAddressID"         int4            NOT NULL,
    "ShipToAddressID"         int4            NOT NULL,
    "ShipMethodID"            int4            NOT NULL,
    "CreditCardID"            int4,
    "CreditCardApprovalCode"  varchar(15),
    "CurrencyRateID"          int4,
    "SubTotal"                money           DEFAULT ((0.00)) NOT NULL
                              CHECK (([SubTotal]>=(0.00))),
    "TaxAmt"                  money           DEFAULT ((0.00)) NOT NULL
                              CHECK (([TaxAmt]>=(0.00))),
    "Freight"                 money           DEFAULT ((0.00)) NOT NULL
                              CHECK (([Freight]>=(0.00))),
    "TotalDue"                money           NOT NULL,
    "Comment"                 varchar(128),
    rowguid                   uuid            DEFAULT (newid()) NOT NULL,
    "ModifiedDate"            timestamp       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY ("SalesOrderID")
)
;



-- 
-- TABLE: "SalesOrderHeaderSalesReason" 
--

CREATE TABLE "SalesOrderHeaderSalesReason"(
    "SalesOrderID"   int4         NOT NULL,
    "SalesReasonID"  int4         NOT NULL,
    "ModifiedDate"   timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY ("SalesOrderID", "SalesReasonID")
)
;



-- 
-- TABLE: "SalesPerson" 
--

CREATE TABLE "SalesPerson"(
    "BusinessEntityID"  int4              NOT NULL,
    "TerritoryID"       int4,
    "SalesQuota"        money             
                        CHECK (([SalesQuota]>(0.00))),
    "Bonus"             money             DEFAULT ((0.00)) NOT NULL
                        CHECK (([Bonus]>=(0.00))),
    "CommissionPct"     numeric(10, 1)    DEFAULT (0.00) NOT NULL
                        CHECK (([CommissionPct]>=(0.00))),
    "SalesYTD"          money             DEFAULT ((0.00)) NOT NULL
                        CHECK (([SalesYTD]>=(0.00))),
    "SalesLastYear"     money             DEFAULT ((0.00)) NOT NULL
                        CHECK (([SalesLastYear]>=(0.00))),
    rowguid             uuid              DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp         DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
)
;



-- 
-- TABLE: "SalesPersonQuotaHistory" 
--

CREATE TABLE "SalesPersonQuotaHistory"(
    "BusinessEntityID"  int4         NOT NULL,
    "QuotaDate"         timestamp    NOT NULL,
    "SalesQuota"        money        NOT NULL
                        CHECK (([SalesQuota]>(0.00))),
    rowguid             uuid         DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY ("BusinessEntityID", "QuotaDate")
)
;



-- 
-- TABLE: "SalesReason" 
--

CREATE TABLE "SalesReason"(
    "SalesReasonID"  int4           NOT NULL,
    "Name"           varchar(50)    NOT NULL,
    "ReasonType"     varchar(50)    NOT NULL,
    "ModifiedDate"   timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY ("SalesReasonID")
)
;



-- 
-- TABLE: "SalesTaxRate" 
--

CREATE TABLE "SalesTaxRate"(
    "SalesTaxRateID"   int4              NOT NULL,
    "StateProvinceID"  int4              NOT NULL,
    "TaxType"          int2              NOT NULL
                       CHECK (([TaxType]>=(1) AND [TaxType]<=(3))),
    "TaxRate"          numeric(10, 1)    DEFAULT (0.00) NOT NULL,
    "Name"             varchar(50)       NOT NULL,
    rowguid            uuid              DEFAULT (newid()) NOT NULL,
    "ModifiedDate"     timestamp         DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY ("SalesTaxRateID")
)
;



-- 
-- TABLE: "SalesTerritory" 
--

CREATE TABLE "SalesTerritory"(
    "TerritoryID"        int4           NOT NULL,
    "Name"               varchar(50)    NOT NULL,
    "CountryRegionCode"  varchar(3)     NOT NULL,
    "Group"              varchar(50)    NOT NULL,
    "SalesYTD"           money          DEFAULT ((0.00)) NOT NULL
                         CHECK (([SalesYTD]>=(0.00))),
    "SalesLastYear"      money          DEFAULT ((0.00)) NOT NULL
                         CHECK (([SalesLastYear]>=(0.00))),
    "CostYTD"            money          DEFAULT ((0.00)) NOT NULL
                         CHECK (([CostYTD]>=(0.00))),
    "CostLastYear"       money          DEFAULT ((0.00)) NOT NULL
                         CHECK (([CostLastYear]>=(0.00))),
    rowguid              uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"       timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY ("TerritoryID")
)
;



-- 
-- TABLE: "SalesTerritoryHistory" 
--

CREATE TABLE "SalesTerritoryHistory"(
    "BusinessEntityID"  int4         NOT NULL,
    "TerritoryID"       int4         NOT NULL,
    "StartDate"         timestamp    NOT NULL,
    "EndDate"           timestamp,
    rowguid             uuid         DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY ("BusinessEntityID", "TerritoryID", "StartDate")
)
;



-- 
-- TABLE: "ScrapReason" 
--

CREATE TABLE "ScrapReason"(
    "ScrapReasonID"  int2           NOT NULL,
    "Name"           varchar(50)    NOT NULL,
    "ModifiedDate"   timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY ("ScrapReasonID")
)
;



-- 
-- TABLE: "Shift" 
--

CREATE TABLE "Shift"(
    "ShiftID"       int2           NOT NULL,
    "Name"          varchar(50)    NOT NULL,
    "StartTime"     time           NOT NULL,
    "EndTime"       time           NOT NULL,
    "ModifiedDate"  timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY ("ShiftID")
)
;



-- 
-- TABLE: "ShipMethod" 
--

CREATE TABLE "ShipMethod"(
    "ShipMethodID"  int4           NOT NULL,
    "Name"          varchar(50)    NOT NULL,
    "ShipBase"      money          DEFAULT ((0.00)) NOT NULL
                    CHECK (([ShipBase]>(0.00))),
    "ShipRate"      money          DEFAULT ((0.00)) NOT NULL
                    CHECK (([ShipRate]>(0.00))),
    rowguid         uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"  timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY ("ShipMethodID")
)
;



-- 
-- TABLE: "ShoppingCartItem" 
--

CREATE TABLE "ShoppingCartItem"(
    "ShoppingCartItemID"  int4           NOT NULL,
    "ShoppingCartID"      varchar(50)    NOT NULL,
    "Quantity"            int4           DEFAULT (1) NOT NULL
                          CHECK (([Quantity]>=(1))),
    "ProductID"           int4           NOT NULL,
    "DateCreated"         timestamp      DEFAULT (getdate()) NOT NULL,
    "ModifiedDate"        timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY ("ShoppingCartItemID")
)
;



-- 
-- TABLE: "SpecialOffer" 
--

CREATE TABLE "SpecialOffer"(
    "SpecialOfferID"  int4              NOT NULL,
    "Description"     varchar(255)      NOT NULL,
    "DiscountPct"     numeric(10, 1)    DEFAULT (0.00) NOT NULL
                      CHECK (([DiscountPct]>=(0.00))),
    "Type"            varchar(50)       NOT NULL,
    "Category"        varchar(50)       NOT NULL,
    "StartDate"       timestamp         NOT NULL,
    "EndDate"         timestamp         NOT NULL,
    "MinQty"          int4              DEFAULT (0) NOT NULL
                      CHECK (([MinQty]>=(0))),
    "MaxQty"          int4              
                      CHECK (([MaxQty]>=(0))),
    rowguid           uuid              DEFAULT (newid()) NOT NULL,
    "ModifiedDate"    timestamp         DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY ("SpecialOfferID")
)
;



-- 
-- TABLE: "SpecialOfferProduct" 
--

CREATE TABLE "SpecialOfferProduct"(
    "SpecialOfferID"  int4         NOT NULL,
    "ProductID"       int4         NOT NULL,
    rowguid           uuid         DEFAULT (newid()) NOT NULL,
    "ModifiedDate"    timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY ("SpecialOfferID", "ProductID")
)
;



-- 
-- TABLE: "StateProvince" 
--

CREATE TABLE "StateProvince"(
    "StateProvinceID"          int4           NOT NULL,
    "StateProvinceCode"        char(3)        NOT NULL,
    "CountryRegionCode"        varchar(3)     NOT NULL,
    "IsOnlyStateProvinceFlag"  boolean        DEFAULT ((1)) NOT NULL,
    "Name"                     varchar(50)    NOT NULL,
    "TerritoryID"              int4           NOT NULL,
    rowguid                    uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"             timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY ("StateProvinceID")
)
;



-- 
-- TABLE: "Store" 
--

CREATE TABLE "Store"(
    "BusinessEntityID"  int4           NOT NULL,
    "Name"              varchar(50)    NOT NULL,
    "SalesPersonID"     int4,
    "Demographics"      xml,
    rowguid             uuid           DEFAULT (newid()) NOT NULL,
    "ModifiedDate"      timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
)
;



-- 
-- TABLE: "TransactionHistory" 
--

CREATE TABLE "TransactionHistory"(
    "TransactionID"         int4         NOT NULL,
    "ProductID"             int4         NOT NULL,
    "ReferenceOrderID"      int4         NOT NULL,
    "ReferenceOrderLineID"  int4         DEFAULT (0) NOT NULL,
    "TransactionDate"       timestamp    DEFAULT (getdate()) NOT NULL,
    "TransactionType"       char(1)      NOT NULL
                            CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    "Quantity"              int4         NOT NULL,
    "ActualCost"            money        NOT NULL,
    "ModifiedDate"          timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY ("TransactionID")
)
;



-- 
-- TABLE: "TransactionHistoryArchive" 
--

CREATE TABLE "TransactionHistoryArchive"(
    "TransactionID"         int4         NOT NULL,
    "ProductID"             int4         NOT NULL,
    "ReferenceOrderID"      int4         NOT NULL,
    "ReferenceOrderLineID"  int4         DEFAULT (0) NOT NULL,
    "TransactionDate"       timestamp    DEFAULT (getdate()) NOT NULL,
    "TransactionType"       char(1)      NOT NULL
                            CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    "Quantity"              int4         NOT NULL,
    "ActualCost"            money        NOT NULL,
    "ModifiedDate"          timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY ("TransactionID")
)
;



-- 
-- TABLE: "UnitMeasure" 
--

CREATE TABLE "UnitMeasure"(
    "UnitMeasureCode"  char(3)        NOT NULL,
    "Name"             varchar(50)    NOT NULL,
    "ModifiedDate"     timestamp      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY ("UnitMeasureCode")
)
;



-- 
-- TABLE: "Vendor" 
--

CREATE TABLE "Vendor"(
    "BusinessEntityID"         int4             NOT NULL,
    "AccountNumber"            varchar(15)      NOT NULL,
    "Name"                     varchar(50)      NOT NULL,
    "CreditRating"             int2             NOT NULL
                               CHECK (([CreditRating]>=(1) AND [CreditRating]<=(5))),
    "PreferredVendorStatus"    boolean          DEFAULT ((1)) NOT NULL,
    "ActiveFlag"               boolean          DEFAULT ((1)) NOT NULL,
    "PurchasingWebServiceURL"  varchar(1024),
    "ModifiedDate"             timestamp        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
)
;



-- 
-- TABLE: "WorkOrder" 
--

CREATE TABLE "WorkOrder"(
    "WorkOrderID"    int4         NOT NULL,
    "ProductID"      int4         NOT NULL,
    "OrderQty"       int4         NOT NULL
                     CHECK (([OrderQty]>(0))),
    "StockedQty"     int4         NOT NULL,
    "ScrappedQty"    int2         NOT NULL
                     CHECK (([ScrappedQty]>=(0))),
    "StartDate"      timestamp    NOT NULL,
    "EndDate"        timestamp,
    "DueDate"        timestamp    NOT NULL,
    "ScrapReasonID"  int2,
    "ModifiedDate"   timestamp    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY ("WorkOrderID")
)
;



-- 
-- TABLE: "WorkOrderRouting" 
--

CREATE TABLE "WorkOrderRouting"(
    "WorkOrderID"         int4             NOT NULL,
    "ProductID"           int4             NOT NULL,
    "OperationSequence"   int2             NOT NULL,
    "LocationID"          int2             NOT NULL,
    "ScheduledStartDate"  timestamp        NOT NULL,
    "ScheduledEndDate"    timestamp        NOT NULL,
    "ActualStartDate"     timestamp,
    "ActualEndDate"       timestamp,
    "ActualResourceHrs"   decimal(9, 4)    
                          CHECK (([ActualResourceHrs]>=(0.0000))),
    "PlannedCost"         money            NOT NULL
                          CHECK (([PlannedCost]>(0.00))),
    "ActualCost"          money            
                          CHECK (([ActualCost]>(0.00))),
    "ModifiedDate"        timestamp        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY ("WorkOrderID", "ProductID", "OperationSequence")
)
;



-- 
-- TABLE: "Address" 
--

ALTER TABLE "Address" ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" 
    FOREIGN KEY ("StateProvinceID")
    REFERENCES "StateProvince"("StateProvinceID")
;


-- 
-- TABLE: "BillOfMaterials" 
--

ALTER TABLE "BillOfMaterials" ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" 
    FOREIGN KEY ("ComponentID")
    REFERENCES "Product"("ProductID")
;

ALTER TABLE "BillOfMaterials" ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" 
    FOREIGN KEY ("ProductAssemblyID")
    REFERENCES "Product"("ProductID")
;

ALTER TABLE "BillOfMaterials" ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" 
    FOREIGN KEY ("UnitMeasureCode")
    REFERENCES "UnitMeasure"("UnitMeasureCode")
;


-- 
-- TABLE: "BusinessEntityAddress" 
--

ALTER TABLE "BusinessEntityAddress" ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" 
    FOREIGN KEY ("AddressID")
    REFERENCES "Address"("AddressID")
;

ALTER TABLE "BusinessEntityAddress" ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" 
    FOREIGN KEY ("AddressTypeID")
    REFERENCES "AddressType"("AddressTypeID")
;

ALTER TABLE "BusinessEntityAddress" ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "BusinessEntity"("BusinessEntityID")
;


-- 
-- TABLE: "BusinessEntityContact" 
--

ALTER TABLE "BusinessEntityContact" ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "BusinessEntity"("BusinessEntityID")
;

ALTER TABLE "BusinessEntityContact" ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" 
    FOREIGN KEY ("ContactTypeID")
    REFERENCES "ContactType"("ContactTypeID")
;

ALTER TABLE "BusinessEntityContact" ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" 
    FOREIGN KEY ("PersonID")
    REFERENCES "Person"("BusinessEntityID")
;


-- 
-- TABLE: "CountryRegionCurrency" 
--

ALTER TABLE "CountryRegionCurrency" ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" 
    FOREIGN KEY ("CountryRegionCode")
    REFERENCES "CountryRegion"("CountryRegionCode")
;

ALTER TABLE "CountryRegionCurrency" ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" 
    FOREIGN KEY ("CurrencyCode")
    REFERENCES "Currency"("CurrencyCode")
;


-- 
-- TABLE: "CurrencyRate" 
--

ALTER TABLE "CurrencyRate" ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" 
    FOREIGN KEY ("FromCurrencyCode")
    REFERENCES "Currency"("CurrencyCode")
;

ALTER TABLE "CurrencyRate" ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" 
    FOREIGN KEY ("ToCurrencyCode")
    REFERENCES "Currency"("CurrencyCode")
;


-- 
-- TABLE: "Customer" 
--

ALTER TABLE "Customer" ADD CONSTRAINT "FK_Customer_Person_PersonID" 
    FOREIGN KEY ("PersonID")
    REFERENCES "Person"("BusinessEntityID")
;

ALTER TABLE "Customer" ADD CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" 
    FOREIGN KEY ("TerritoryID")
    REFERENCES "SalesTerritory"("TerritoryID")
;

ALTER TABLE "Customer" ADD CONSTRAINT "FK_Customer_Store_StoreID" 
    FOREIGN KEY ("StoreID")
    REFERENCES "Store"("BusinessEntityID")
;


-- 
-- TABLE: "Document" 
--

ALTER TABLE "Document" ADD CONSTRAINT "FK_Document_Employee_Owner" 
    FOREIGN KEY ("Owner")
    REFERENCES "Employee"("BusinessEntityID")
;


-- 
-- TABLE: "EmailAddress" 
--

ALTER TABLE "EmailAddress" ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Person"("BusinessEntityID")
;


-- 
-- TABLE: "Employee" 
--

ALTER TABLE "Employee" ADD CONSTRAINT "FK_Employee_Person_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Person"("BusinessEntityID")
;


-- 
-- TABLE: "EmployeeDepartmentHistory" 
--

ALTER TABLE "EmployeeDepartmentHistory" ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" 
    FOREIGN KEY ("DepartmentID")
    REFERENCES "Department"("DepartmentID")
;

ALTER TABLE "EmployeeDepartmentHistory" ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Employee_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Employee"("BusinessEntityID")
;

ALTER TABLE "EmployeeDepartmentHistory" ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" 
    FOREIGN KEY ("ShiftID")
    REFERENCES "Shift"("ShiftID")
;


-- 
-- TABLE: "EmployeePayHistory" 
--

ALTER TABLE "EmployeePayHistory" ADD CONSTRAINT "FK_EmployeePayHistory_Employee_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Employee"("BusinessEntityID")
;


-- 
-- TABLE: "JobCandidate" 
--

ALTER TABLE "JobCandidate" ADD CONSTRAINT "FK_JobCandidate_Employee_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Employee"("BusinessEntityID")
;


-- 
-- TABLE: "Password" 
--

ALTER TABLE "Password" ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Person"("BusinessEntityID")
;


-- 
-- TABLE: "Person" 
--

ALTER TABLE "Person" ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "BusinessEntity"("BusinessEntityID")
;


-- 
-- TABLE: "PersonCreditCard" 
--

ALTER TABLE "PersonCreditCard" ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" 
    FOREIGN KEY ("CreditCardID")
    REFERENCES "CreditCard"("CreditCardID")
;

ALTER TABLE "PersonCreditCard" ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Person"("BusinessEntityID")
;


-- 
-- TABLE: "PersonPhone" 
--

ALTER TABLE "PersonPhone" ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Person"("BusinessEntityID")
;

ALTER TABLE "PersonPhone" ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" 
    FOREIGN KEY ("PhoneNumberTypeID")
    REFERENCES "PhoneNumberType"("PhoneNumberTypeID")
;


-- 
-- TABLE: "Product" 
--

ALTER TABLE "Product" ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" 
    FOREIGN KEY ("ProductModelID")
    REFERENCES "ProductModel"("ProductModelID")
;

ALTER TABLE "Product" ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" 
    FOREIGN KEY ("ProductSubcategoryID")
    REFERENCES "ProductSubcategory"("ProductSubcategoryID")
;

ALTER TABLE "Product" ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" 
    FOREIGN KEY ("SizeUnitMeasureCode")
    REFERENCES "UnitMeasure"("UnitMeasureCode")
;

ALTER TABLE "Product" ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" 
    FOREIGN KEY ("WeightUnitMeasureCode")
    REFERENCES "UnitMeasure"("UnitMeasureCode")
;


-- 
-- TABLE: "ProductCostHistory" 
--

ALTER TABLE "ProductCostHistory" ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;


-- 
-- TABLE: "ProductDocument" 
--

ALTER TABLE "ProductDocument" ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" 
    FOREIGN KEY ("DocumentNode")
    REFERENCES "Document"("DocumentNode")
;

ALTER TABLE "ProductDocument" ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;


-- 
-- TABLE: "ProductInventory" 
--

ALTER TABLE "ProductInventory" ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" 
    FOREIGN KEY ("LocationID")
    REFERENCES "Location"("LocationID")
;

ALTER TABLE "ProductInventory" ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;


-- 
-- TABLE: "ProductListPriceHistory" 
--

ALTER TABLE "ProductListPriceHistory" ADD CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;


-- 
-- TABLE: "ProductModelIllustration" 
--

ALTER TABLE "ProductModelIllustration" ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" 
    FOREIGN KEY ("IllustrationID")
    REFERENCES "Illustration"("IllustrationID")
;

ALTER TABLE "ProductModelIllustration" ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" 
    FOREIGN KEY ("ProductModelID")
    REFERENCES "ProductModel"("ProductModelID")
;


-- 
-- TABLE: "ProductModelProductDescriptionCulture" 
--

ALTER TABLE "ProductModelProductDescriptionCulture" ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" 
    FOREIGN KEY ("CultureID")
    REFERENCES "Culture"("CultureID")
;

ALTER TABLE "ProductModelProductDescriptionCulture" ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID" 
    FOREIGN KEY ("ProductDescriptionID")
    REFERENCES "ProductDescription"("ProductDescriptionID")
;

ALTER TABLE "ProductModelProductDescriptionCulture" ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID" 
    FOREIGN KEY ("ProductModelID")
    REFERENCES "ProductModel"("ProductModelID")
;


-- 
-- TABLE: "ProductProductPhoto" 
--

ALTER TABLE "ProductProductPhoto" ADD CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;

ALTER TABLE "ProductProductPhoto" ADD CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" 
    FOREIGN KEY ("ProductPhotoID")
    REFERENCES "ProductPhoto"("ProductPhotoID")
;


-- 
-- TABLE: "ProductReview" 
--

ALTER TABLE "ProductReview" ADD CONSTRAINT "FK_ProductReview_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;


-- 
-- TABLE: "ProductSubcategory" 
--

ALTER TABLE "ProductSubcategory" ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" 
    FOREIGN KEY ("ProductCategoryID")
    REFERENCES "ProductCategory"("ProductCategoryID")
;


-- 
-- TABLE: "ProductVendor" 
--

ALTER TABLE "ProductVendor" ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;

ALTER TABLE "ProductVendor" ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" 
    FOREIGN KEY ("UnitMeasureCode")
    REFERENCES "UnitMeasure"("UnitMeasureCode")
;

ALTER TABLE "ProductVendor" ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Vendor"("BusinessEntityID")
;


-- 
-- TABLE: "PurchaseOrderDetail" 
--

ALTER TABLE "PurchaseOrderDetail" ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;

ALTER TABLE "PurchaseOrderDetail" ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" 
    FOREIGN KEY ("PurchaseOrderID")
    REFERENCES "PurchaseOrderHeader"("PurchaseOrderID")
;


-- 
-- TABLE: "PurchaseOrderHeader" 
--

ALTER TABLE "PurchaseOrderHeader" ADD CONSTRAINT "FK_PurchaseOrderHeader_Employee_EmployeeID" 
    FOREIGN KEY ("EmployeeID")
    REFERENCES "Employee"("BusinessEntityID")
;

ALTER TABLE "PurchaseOrderHeader" ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" 
    FOREIGN KEY ("ShipMethodID")
    REFERENCES "ShipMethod"("ShipMethodID")
;

ALTER TABLE "PurchaseOrderHeader" ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" 
    FOREIGN KEY ("VendorID")
    REFERENCES "Vendor"("BusinessEntityID")
;


-- 
-- TABLE: "SalesOrderDetail" 
--

ALTER TABLE "SalesOrderDetail" ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" 
    FOREIGN KEY ("SalesOrderID")
    REFERENCES "SalesOrderHeader"("SalesOrderID") ON DELETE CASCADE
;

ALTER TABLE "SalesOrderDetail" ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" 
    FOREIGN KEY ("SpecialOfferID", "ProductID")
    REFERENCES "SpecialOfferProduct"("SpecialOfferID", "ProductID")
;


-- 
-- TABLE: "SalesOrderHeader" 
--

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" 
    FOREIGN KEY ("BillToAddressID")
    REFERENCES "Address"("AddressID")
;

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" 
    FOREIGN KEY ("ShipToAddressID")
    REFERENCES "Address"("AddressID")
;

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" 
    FOREIGN KEY ("CreditCardID")
    REFERENCES "CreditCard"("CreditCardID")
;

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" 
    FOREIGN KEY ("CurrencyRateID")
    REFERENCES "CurrencyRate"("CurrencyRateID")
;

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" 
    FOREIGN KEY ("CustomerID")
    REFERENCES "Customer"("CustomerID")
;

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" 
    FOREIGN KEY ("SalesPersonID")
    REFERENCES "SalesPerson"("BusinessEntityID")
;

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" 
    FOREIGN KEY ("TerritoryID")
    REFERENCES "SalesTerritory"("TerritoryID")
;

ALTER TABLE "SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" 
    FOREIGN KEY ("ShipMethodID")
    REFERENCES "ShipMethod"("ShipMethodID")
;


-- 
-- TABLE: "SalesOrderHeaderSalesReason" 
--

ALTER TABLE "SalesOrderHeaderSalesReason" ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" 
    FOREIGN KEY ("SalesOrderID")
    REFERENCES "SalesOrderHeader"("SalesOrderID") ON DELETE CASCADE
;

ALTER TABLE "SalesOrderHeaderSalesReason" ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" 
    FOREIGN KEY ("SalesReasonID")
    REFERENCES "SalesReason"("SalesReasonID")
;


-- 
-- TABLE: "SalesPerson" 
--

ALTER TABLE "SalesPerson" ADD CONSTRAINT "FK_SalesPerson_Employee_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "Employee"("BusinessEntityID")
;

ALTER TABLE "SalesPerson" ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" 
    FOREIGN KEY ("TerritoryID")
    REFERENCES "SalesTerritory"("TerritoryID")
;


-- 
-- TABLE: "SalesPersonQuotaHistory" 
--

ALTER TABLE "SalesPersonQuotaHistory" ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "SalesPerson"("BusinessEntityID")
;


-- 
-- TABLE: "SalesTaxRate" 
--

ALTER TABLE "SalesTaxRate" ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" 
    FOREIGN KEY ("StateProvinceID")
    REFERENCES "StateProvince"("StateProvinceID")
;


-- 
-- TABLE: "SalesTerritory" 
--

ALTER TABLE "SalesTerritory" ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" 
    FOREIGN KEY ("CountryRegionCode")
    REFERENCES "CountryRegion"("CountryRegionCode")
;


-- 
-- TABLE: "SalesTerritoryHistory" 
--

ALTER TABLE "SalesTerritoryHistory" ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "SalesPerson"("BusinessEntityID")
;

ALTER TABLE "SalesTerritoryHistory" ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" 
    FOREIGN KEY ("TerritoryID")
    REFERENCES "SalesTerritory"("TerritoryID")
;


-- 
-- TABLE: "ShoppingCartItem" 
--

ALTER TABLE "ShoppingCartItem" ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;


-- 
-- TABLE: "SpecialOfferProduct" 
--

ALTER TABLE "SpecialOfferProduct" ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;

ALTER TABLE "SpecialOfferProduct" ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" 
    FOREIGN KEY ("SpecialOfferID")
    REFERENCES "SpecialOffer"("SpecialOfferID")
;


-- 
-- TABLE: "StateProvince" 
--

ALTER TABLE "StateProvince" ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" 
    FOREIGN KEY ("CountryRegionCode")
    REFERENCES "CountryRegion"("CountryRegionCode")
;

ALTER TABLE "StateProvince" ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" 
    FOREIGN KEY ("TerritoryID")
    REFERENCES "SalesTerritory"("TerritoryID")
;


-- 
-- TABLE: "Store" 
--

ALTER TABLE "Store" ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "BusinessEntity"("BusinessEntityID")
;

ALTER TABLE "Store" ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" 
    FOREIGN KEY ("SalesPersonID")
    REFERENCES "SalesPerson"("BusinessEntityID")
;


-- 
-- TABLE: "TransactionHistory" 
--

ALTER TABLE "TransactionHistory" ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;


-- 
-- TABLE: "Vendor" 
--

ALTER TABLE "Vendor" ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" 
    FOREIGN KEY ("BusinessEntityID")
    REFERENCES "BusinessEntity"("BusinessEntityID")
;


-- 
-- TABLE: "WorkOrder" 
--

ALTER TABLE "WorkOrder" ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" 
    FOREIGN KEY ("ProductID")
    REFERENCES "Product"("ProductID")
;

ALTER TABLE "WorkOrder" ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" 
    FOREIGN KEY ("ScrapReasonID")
    REFERENCES "ScrapReason"("ScrapReasonID")
;


-- 
-- TABLE: "WorkOrderRouting" 
--

ALTER TABLE "WorkOrderRouting" ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" 
    FOREIGN KEY ("LocationID")
    REFERENCES "Location"("LocationID")
;

ALTER TABLE "WorkOrderRouting" ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" 
    FOREIGN KEY ("WorkOrderID")
    REFERENCES "WorkOrder"("WorkOrderID")
;


