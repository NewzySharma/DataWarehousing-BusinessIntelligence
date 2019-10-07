--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      DATA MODEL
--
-- Date Created : Saturday, September 28, 2019 23:23:00
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Address 
--

CREATE TABLE Address(
    AddressID          INT                     AUTO_INCREMENT,
    AddressLine1       NATIONAL VARCHAR(60)    NOT NULL,
    AddressLine2       NATIONAL VARCHAR(60),
    City               NATIONAL VARCHAR(30)    NOT NULL,
    StateProvinceID    INT                     NOT NULL,
    PostalCode         NATIONAL VARCHAR(15)    NOT NULL,
    SpatialLocation    CHAR(10),
    rowguid            BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate       DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (AddressID)
)ENGINE=MYISAM
;



-- 
-- TABLE: AddressType 
--

CREATE TABLE AddressType(
    AddressTypeID    INT                     AUTO_INCREMENT,
    Name             NATIONAL VARCHAR(50)    NOT NULL,
    rowguid          BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate     DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (AddressTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: AWBuildVersion 
--

CREATE TABLE AWBuildVersion(
    SystemInformationID    TINYINT                 AUTO_INCREMENT,
    `Database Version`     NATIONAL VARCHAR(25)    NOT NULL,
    VersionDate            DATETIME                NOT NULL,
    ModifiedDate           DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SystemInformationID)
)ENGINE=MYISAM
;



-- 
-- TABLE: BillOfMaterials 
--

CREATE TABLE BillOfMaterials(
    BillOfMaterialsID    INT                 AUTO_INCREMENT,
    ProductAssemblyID    INT,
    ComponentID          INT                 NOT NULL,
    StartDate            DATETIME            DEFAULT (getdate()) NOT NULL,
    EndDate              DATETIME,
    UnitMeasureCode      NATIONAL CHAR(3)    NOT NULL,
    BOMLevel             SMALLINT            NOT NULL,
    PerAssemblyQty       DECIMAL(8, 2)       DEFAULT (1.00) NOT NULL
                         CHECK (([PerAssemblyQty]>=(1.00))),
    ModifiedDate         DATETIME            DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BillOfMaterialsID)
)ENGINE=MYISAM
;



-- 
-- TABLE: BusinessEntity 
--

CREATE TABLE BusinessEntity(
    BusinessEntityID    INT           AUTO_INCREMENT,
    rowguid             BINARY(16)    DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: BusinessEntityAddress 
--

CREATE TABLE BusinessEntityAddress(
    BusinessEntityID    INT           NOT NULL,
    AddressID           INT           NOT NULL,
    AddressTypeID       INT           NOT NULL,
    rowguid             BINARY(16)    DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, AddressID, AddressTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: BusinessEntityContact 
--

CREATE TABLE BusinessEntityContact(
    BusinessEntityID    INT           NOT NULL,
    PersonID            INT           NOT NULL,
    ContactTypeID       INT           NOT NULL,
    rowguid             BINARY(16)    DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, PersonID, ContactTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ContactType 
--

CREATE TABLE ContactType(
    ContactTypeID    INT                     AUTO_INCREMENT,
    Name             NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate     DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ContactTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: CountryRegion 
--

CREATE TABLE CountryRegion(
    CountryRegionCode    NATIONAL VARCHAR(3)     NOT NULL,
    Name                 NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate         DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (CountryRegionCode)
)ENGINE=MYISAM
;



-- 
-- TABLE: CountryRegionCurrency 
--

CREATE TABLE CountryRegionCurrency(
    CountryRegionCode    NATIONAL VARCHAR(3)    NOT NULL,
    CurrencyCode         NATIONAL CHAR(3)       NOT NULL,
    ModifiedDate         DATETIME               DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (CountryRegionCode, CurrencyCode)
)ENGINE=MYISAM
;



-- 
-- TABLE: CreditCard 
--

CREATE TABLE CreditCard(
    CreditCardID    INT                     AUTO_INCREMENT,
    CardType        NATIONAL VARCHAR(50)    NOT NULL,
    CardNumber      NATIONAL VARCHAR(25)    NOT NULL,
    ExpMonth        TINYINT                 NOT NULL,
    ExpYear         SMALLINT                NOT NULL,
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (CreditCardID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Culture 
--

CREATE TABLE Culture(
    CultureID       NATIONAL CHAR(6)        NOT NULL,
    Name            NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (CultureID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Currency 
--

CREATE TABLE Currency(
    CurrencyCode    NATIONAL CHAR(3)        NOT NULL,
    Name            NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (CurrencyCode)
)ENGINE=MYISAM
;



-- 
-- TABLE: CurrencyRate 
--

CREATE TABLE CurrencyRate(
    CurrencyRateID      INT                 AUTO_INCREMENT,
    CurrencyRateDate    DATETIME            NOT NULL,
    FromCurrencyCode    NATIONAL CHAR(3)    NOT NULL,
    ToCurrencyCode      NATIONAL CHAR(3)    NOT NULL,
    AverageRate         DECIMAL(19, 4)      NOT NULL,
    EndOfDayRate        DECIMAL(19, 4)      NOT NULL,
    ModifiedDate        DATETIME            DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (CurrencyRateID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Customer 
--

CREATE TABLE Customer(
    CustomerID       INT            AUTO_INCREMENT,
    PersonID         INT,
    StoreID          INT,
    TerritoryID      INT,
    AccountNumber    VARCHAR(10)    NOT NULL,
    rowguid          BINARY(16)     DEFAULT (newid()) NOT NULL,
    ModifiedDate     DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (CustomerID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DatabaseLog 
--

CREATE TABLE DatabaseLog(
    DatabaseLogID    INT                     AUTO_INCREMENT,
    PostTime         DATETIME                NOT NULL,
    DatabaseUser     CHAR(10)                NOT NULL,
    Event            CHAR(10)                NOT NULL,
    Schema           CHAR(10),
    Object           CHAR(10),
    TSQL             NATIONAL VARCHAR(18)    NOT NULL,
    XmlEvent         LONGBLOB                NOT NULL,
    PRIMARY KEY (DatabaseLogID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Department 
--

CREATE TABLE Department(
    DepartmentID    SMALLINT                AUTO_INCREMENT,
    Name            NATIONAL VARCHAR(50)    NOT NULL,
    GroupName       NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (DepartmentID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Document 
--

CREATE TABLE Document(
    DocumentNode       CHAR(10)                 NOT NULL,
    DocumentLevel      SMALLINT,
    Title              NATIONAL VARCHAR(50)     NOT NULL,
    Owner              INT                      NOT NULL,
    FolderFlag         BIT(1)                   DEFAULT ((0)) NOT NULL,
    FileName           NATIONAL VARCHAR(400)    NOT NULL,
    FileExtension      NATIONAL VARCHAR(8)      NOT NULL,
    Revision           NATIONAL CHAR(5)         NOT NULL,
    ChangeNumber       INT                      DEFAULT (0) NOT NULL,
    Status             TINYINT                  NOT NULL
                       CHECK (([Status]>=(1) AND [Status]<=(3))),
    DocumentSummary    NATIONAL VARCHAR(18),
    Document           VARBINARY(4000),
    rowguid            BINARY(16)               DEFAULT (newid()) NOT NULL,
    ModifiedDate       DATETIME                 DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (DocumentNode)
)ENGINE=MYISAM
;



-- 
-- TABLE: EmailAddress 
--

CREATE TABLE EmailAddress(
    BusinessEntityID    INT                     NOT NULL,
    EmailAddressID      INT                     AUTO_INCREMENT,
    EmailAddress        NATIONAL VARCHAR(50),
    rowguid             BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, EmailAddressID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Employee 
--

CREATE TABLE Employee(
    BusinessEntityID     INT                      NOT NULL,
    NationalIDNumber     NATIONAL VARCHAR(15)     NOT NULL,
    LoginID              NATIONAL VARCHAR(256)    NOT NULL,
    OrganizationNode     CHAR(10),
    OrganizationLevel    SMALLINT,
    JobTitle             NATIONAL VARCHAR(50)     NOT NULL,
    BirthDate            DATE                     NOT NULL
                         CHECK (([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate()))),
    MaritalStatus        NATIONAL CHAR(1)         NOT NULL
                         CHECK ((upper([MaritalStatus])='S' OR upper([MaritalStatus])='M')),
    Gender               NATIONAL CHAR(1)         NOT NULL
                         CHECK ((upper([Gender])='F' OR upper([Gender])='M')),
    HireDate             DATE                     NOT NULL
                         CHECK (([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate()))),
    SalariedFlag         BIT(1)                   DEFAULT ((1)) NOT NULL,
    VacationHours        SMALLINT                 DEFAULT (0) NOT NULL
                         CHECK (([VacationHours]>=(-40) AND [VacationHours]<=(240))),
    SickLeaveHours       SMALLINT                 DEFAULT (0) NOT NULL
                         CHECK (([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120))),
    CurrentFlag          BIT(1)                   DEFAULT ((1)) NOT NULL,
    rowguid              BINARY(16)               DEFAULT (newid()) NOT NULL,
    ModifiedDate         DATETIME                 DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: EmployeeDepartmentHistory 
--

CREATE TABLE EmployeeDepartmentHistory(
    BusinessEntityID    INT         NOT NULL,
    DepartmentID        SMALLINT    NOT NULL,
    ShiftID             TINYINT     NOT NULL,
    StartDate           DATE        NOT NULL,
    EndDate             DATE,
    ModifiedDate        DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, DepartmentID, ShiftID, StartDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: EmployeePayHistory 
--

CREATE TABLE EmployeePayHistory(
    BusinessEntityID    INT               NOT NULL,
    RateChangeDate      DATETIME          NOT NULL,
    Rate                DECIMAL(19, 4)    NOT NULL
                        CHECK (([Rate]>=(6.50) AND [Rate]<=(200.00))),
    PayFrequency        TINYINT           NOT NULL
                        CHECK (([PayFrequency]=(2) OR [PayFrequency]=(1))),
    ModifiedDate        DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, RateChangeDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: ErrorLog 
--

CREATE TABLE ErrorLog(
    ErrorLogID        INT                       AUTO_INCREMENT,
    ErrorTime         DATETIME                  DEFAULT (getdate()) NOT NULL,
    UserName          CHAR(10)                  NOT NULL,
    ErrorNumber       INT                       NOT NULL,
    ErrorSeverity     INT,
    ErrorState        INT,
    ErrorProcedure    NATIONAL VARCHAR(126),
    ErrorLine         INT,
    ErrorMessage      NATIONAL VARCHAR(4000)    NOT NULL,
    PRIMARY KEY (ErrorLogID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Illustration 
--

CREATE TABLE Illustration(
    IllustrationID    INT         AUTO_INCREMENT,
    Diagram           LONGBLOB,
    ModifiedDate      DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (IllustrationID)
)ENGINE=MYISAM
;



-- 
-- TABLE: JobCandidate 
--

CREATE TABLE JobCandidate(
    JobCandidateID      INT         AUTO_INCREMENT,
    BusinessEntityID    INT,
    Resume              LONGBLOB,
    ModifiedDate        DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (JobCandidateID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Location 
--

CREATE TABLE Location(
    LocationID      SMALLINT                AUTO_INCREMENT,
    Name            NATIONAL VARCHAR(50)    NOT NULL,
    CostRate        DECIMAL(7, 2)           DEFAULT (0.00) NOT NULL
                    CHECK (([CostRate]>=(0.00))),
    Availability    DECIMAL(8, 2)           DEFAULT (0.00) NOT NULL
                    CHECK (([Availability]>=(0.00))),
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (LocationID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Password 
--

CREATE TABLE Password(
    BusinessEntityID    INT             NOT NULL,
    PasswordHash        VARCHAR(128)    NOT NULL,
    PasswordSalt        VARCHAR(10)     NOT NULL,
    rowguid             BINARY(16)      DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME        DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Person 
--

CREATE TABLE Person(
    BusinessEntityID         INT                     NOT NULL,
    PersonType               NATIONAL CHAR(2)        NOT NULL
                             CHECK (([PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC'))),
    NameStyle                BIT(1)                  DEFAULT ((0)) NOT NULL,
    Title                    NATIONAL VARCHAR(8),
    FirstName                NATIONAL VARCHAR(50)    NOT NULL,
    MiddleName               NATIONAL VARCHAR(50),
    LastName                 NATIONAL VARCHAR(50)    NOT NULL,
    Suffix                   NATIONAL VARCHAR(10),
    EmailPromotion           INT                     DEFAULT (0) NOT NULL
                             CHECK (([EmailPromotion]>=(0) AND [EmailPromotion]<=(2))),
    AdditionalContactInfo    LONGBLOB,
    Demographics             LONGBLOB,
    rowguid                  BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate             DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: PersonCreditCard 
--

CREATE TABLE PersonCreditCard(
    BusinessEntityID    INT         NOT NULL,
    CreditCardID        INT         NOT NULL,
    ModifiedDate        DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, CreditCardID)
)ENGINE=MYISAM
;



-- 
-- TABLE: PersonPhone 
--

CREATE TABLE PersonPhone(
    BusinessEntityID     INT                     NOT NULL,
    PhoneNumber          NATIONAL VARCHAR(25)    NOT NULL,
    PhoneNumberTypeID    INT                     NOT NULL,
    ModifiedDate         DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: PhoneNumberType 
--

CREATE TABLE PhoneNumberType(
    PhoneNumberTypeID    INT                     AUTO_INCREMENT,
    Name                 NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate         DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (PhoneNumberTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Product 
--

CREATE TABLE Product(
    ProductID                INT                     AUTO_INCREMENT,
    Name                     NATIONAL VARCHAR(50)    NOT NULL,
    ProductNumber            NATIONAL VARCHAR(25)    NOT NULL,
    MakeFlag                 BIT(1)                  DEFAULT ((1)) NOT NULL,
    FinishedGoodsFlag        BIT(1)                  DEFAULT ((1)) NOT NULL,
    Color                    NATIONAL VARCHAR(15),
    SafetyStockLevel         SMALLINT                NOT NULL
                             CHECK (([SafetyStockLevel]>(0))),
    ReorderPoint             SMALLINT                NOT NULL
                             CHECK (([ReorderPoint]>(0))),
    StandardCost             DECIMAL(19, 4)          NOT NULL
                             CHECK (([StandardCost]>=(0.00))),
    ListPrice                DECIMAL(19, 4)          NOT NULL
                             CHECK (([ListPrice]>=(0.00))),
    Size                     NATIONAL VARCHAR(5),
    SizeUnitMeasureCode      NATIONAL CHAR(3),
    WeightUnitMeasureCode    NATIONAL CHAR(3),
    Weight                   DECIMAL(8, 2)           
                             CHECK (([Weight]>(0.00))),
    DaysToManufacture        INT                     NOT NULL
                             CHECK (([DaysToManufacture]>=(0))),
    ProductLine              NATIONAL CHAR(2)        
                             CHECK ((upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL)),
    Class                    NATIONAL CHAR(2)        
                             CHECK ((upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL)),
    Style                    NATIONAL CHAR(2)        
                             CHECK ((upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL)),
    ProductSubcategoryID     INT,
    ProductModelID           INT,
    SellStartDate            DATETIME                NOT NULL,
    SellEndDate              DATETIME,
    DiscontinuedDate         DATETIME,
    rowguid                  BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate             DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductCategory 
--

CREATE TABLE ProductCategory(
    ProductCategoryID    INT                     AUTO_INCREMENT,
    Name                 NATIONAL VARCHAR(50)    NOT NULL,
    rowguid              BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate         DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductCategoryID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductCostHistory 
--

CREATE TABLE ProductCostHistory(
    ProductID       INT               NOT NULL,
    StartDate       DATETIME          NOT NULL,
    EndDate         DATETIME,
    StandardCost    DECIMAL(19, 4)    NOT NULL
                    CHECK (([StandardCost]>=(0.00))),
    ModifiedDate    DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductID, StartDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductDescription 
--

CREATE TABLE ProductDescription(
    ProductDescriptionID    INT                      AUTO_INCREMENT,
    Description             NATIONAL VARCHAR(400)    NOT NULL,
    rowguid                 BINARY(16)               DEFAULT (newid()) NOT NULL,
    ModifiedDate            DATETIME                 DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductDescriptionID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductDocument 
--

CREATE TABLE ProductDocument(
    ProductID       INT         NOT NULL,
    DocumentNode    CHAR(10)    NOT NULL,
    ModifiedDate    DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductID, DocumentNode)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductInventory 
--

CREATE TABLE ProductInventory(
    ProductID       INT                     NOT NULL,
    LocationID      SMALLINT                NOT NULL,
    Shelf           NATIONAL VARCHAR(10)    NOT NULL
                    CHECK (([Shelf] like '[A-Za-z]' OR [Shelf]='N/A')),
    Bin             TINYINT                 NOT NULL
                    CHECK (([Bin]>=(0) AND [Bin]<=(100))),
    Quantity        SMALLINT                DEFAULT (0) NOT NULL,
    rowguid         BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductID, LocationID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductListPriceHistory 
--

CREATE TABLE ProductListPriceHistory(
    ProductID       INT               NOT NULL,
    StartDate       DATETIME          NOT NULL,
    EndDate         DATETIME,
    ListPrice       DECIMAL(19, 4)    NOT NULL
                    CHECK (([ListPrice]>(0.00))),
    ModifiedDate    DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductID, StartDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductModel 
--

CREATE TABLE ProductModel(
    ProductModelID        INT                     AUTO_INCREMENT,
    Name                  NATIONAL VARCHAR(50)    NOT NULL,
    CatalogDescription    LONGBLOB,
    Instructions          LONGBLOB,
    rowguid               BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate          DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductModelID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductModelIllustration 
--

CREATE TABLE ProductModelIllustration(
    ProductModelID    INT         NOT NULL,
    IllustrationID    INT         NOT NULL,
    ModifiedDate      DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductModelID, IllustrationID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductModelProductDescriptionCulture 
--

CREATE TABLE ProductModelProductDescriptionCulture(
    ProductModelID          INT                 NOT NULL,
    ProductDescriptionID    INT                 NOT NULL,
    CultureID               NATIONAL CHAR(6)    NOT NULL,
    ModifiedDate            DATETIME            DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductModelID, ProductDescriptionID, CultureID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductPhoto 
--

CREATE TABLE ProductPhoto(
    ProductPhotoID            INT                     AUTO_INCREMENT,
    ThumbNailPhoto            VARBINARY(4000),
    ThumbnailPhotoFileName    NATIONAL VARCHAR(50),
    LargePhoto                VARBINARY(4000),
    LargePhotoFileName        NATIONAL VARCHAR(50),
    ModifiedDate              DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductPhotoID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductProductPhoto 
--

CREATE TABLE ProductProductPhoto(
    ProductID         INT         NOT NULL,
    ProductPhotoID    INT         NOT NULL,
    Primary           BIT(1)      DEFAULT ((0)) NOT NULL,
    ModifiedDate      DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductID, ProductPhotoID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductReview 
--

CREATE TABLE ProductReview(
    ProductReviewID    INT                       AUTO_INCREMENT,
    ProductID          INT                       NOT NULL,
    ReviewerName       NATIONAL VARCHAR(50)      NOT NULL,
    ReviewDate         DATETIME                  DEFAULT (getdate()) NOT NULL,
    EmailAddress       NATIONAL VARCHAR(50)      NOT NULL,
    Rating             INT                       NOT NULL
                       CHECK (([Rating]>=(1) AND [Rating]<=(5))),
    Comments           NATIONAL VARCHAR(3850),
    ModifiedDate       DATETIME                  DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductReviewID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductSubcategory 
--

CREATE TABLE ProductSubcategory(
    ProductSubcategoryID    INT                     AUTO_INCREMENT,
    ProductCategoryID       INT                     NOT NULL,
    Name                    NATIONAL VARCHAR(50)    NOT NULL,
    rowguid                 BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate            DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductSubcategoryID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductVendor 
--

CREATE TABLE ProductVendor(
    ProductID           INT                 NOT NULL,
    BusinessEntityID    INT                 NOT NULL,
    AverageLeadTime     INT                 NOT NULL
                        CHECK (([AverageLeadTime]>=(1))),
    StandardPrice       DECIMAL(19, 4)      NOT NULL
                        CHECK (([StandardPrice]>(0.00))),
    LastReceiptCost     DECIMAL(19, 4)      
                        CHECK (([LastReceiptCost]>(0.00))),
    LastReceiptDate     DATETIME,
    MinOrderQty         INT                 NOT NULL
                        CHECK (([MinOrderQty]>=(1))),
    MaxOrderQty         INT                 NOT NULL
                        CHECK (([MaxOrderQty]>=(1))),
    OnOrderQty          INT                 
                        CHECK (([OnOrderQty]>=(0))),
    UnitMeasureCode     NATIONAL CHAR(3)    NOT NULL,
    ModifiedDate        DATETIME            DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ProductID, BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: PurchaseOrderDetail 
--

CREATE TABLE PurchaseOrderDetail(
    PurchaseOrderID          INT               NOT NULL,
    PurchaseOrderDetailID    INT               AUTO_INCREMENT,
    DueDate                  DATETIME          NOT NULL,
    OrderQty                 SMALLINT          NOT NULL
                             CHECK (([OrderQty]>(0))),
    ProductID                INT               NOT NULL,
    UnitPrice                DECIMAL(19, 4)    NOT NULL
                             CHECK (([UnitPrice]>=(0.00))),
    LineTotal                DECIMAL(19, 4)    NOT NULL,
    ReceivedQty              DECIMAL(8, 2)     NOT NULL
                             CHECK (([ReceivedQty]>=(0.00))),
    RejectedQty              DECIMAL(8, 2)     NOT NULL
                             CHECK (([RejectedQty]>=(0.00))),
    StockedQty               DECIMAL(9, 2)     NOT NULL,
    ModifiedDate             DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (PurchaseOrderID, PurchaseOrderDetailID)
)ENGINE=MYISAM
;



-- 
-- TABLE: PurchaseOrderHeader 
--

CREATE TABLE PurchaseOrderHeader(
    PurchaseOrderID    INT               AUTO_INCREMENT,
    RevisionNumber     TINYINT           DEFAULT (0) NOT NULL,
    Status             TINYINT           DEFAULT (1) NOT NULL
                       CHECK (([Status]>=(1) AND [Status]<=(4))),
    EmployeeID         INT               NOT NULL,
    VendorID           INT               NOT NULL,
    ShipMethodID       INT               NOT NULL,
    OrderDate          DATETIME          DEFAULT (getdate()) NOT NULL,
    ShipDate           DATETIME,
    SubTotal           DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                       CHECK (([SubTotal]>=(0.00))),
    TaxAmt             DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                       CHECK (([TaxAmt]>=(0.00))),
    Freight            DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                       CHECK (([Freight]>=(0.00))),
    TotalDue           DECIMAL(19, 4)    NOT NULL,
    ModifiedDate       DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (PurchaseOrderID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesOrderDetail 
--

CREATE TABLE SalesOrderDetail(
    SalesOrderID             INT                     NOT NULL,
    SalesOrderDetailID       INT                     AUTO_INCREMENT,
    CarrierTrackingNumber    NATIONAL VARCHAR(25),
    OrderQty                 SMALLINT                NOT NULL
                             CHECK (([OrderQty]>(0))),
    ProductID                INT                     NOT NULL,
    SpecialOfferID           INT                     NOT NULL,
    UnitPrice                DECIMAL(19, 4)          NOT NULL
                             CHECK (([UnitPrice]>=(0.00))),
    UnitPriceDiscount        DECIMAL(19, 4)          DEFAULT (0.0) NOT NULL
                             CHECK (([UnitPriceDiscount]>=(0.00))),
    LineTotal                DECIMAL(38, 6)          NOT NULL,
    rowguid                  BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate             DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SalesOrderID, SalesOrderDetailID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesOrderHeader 
--

CREATE TABLE SalesOrderHeader(
    SalesOrderID              INT                      AUTO_INCREMENT,
    RevisionNumber            TINYINT                  DEFAULT (0) NOT NULL,
    OrderDate                 DATETIME                 DEFAULT (getdate()) NOT NULL,
    DueDate                   DATETIME                 NOT NULL,
    ShipDate                  DATETIME,
    Status                    TINYINT                  DEFAULT (1) NOT NULL
                              CHECK (([Status]>=(0) AND [Status]<=(8))),
    OnlineOrderFlag           BIT(1)                   DEFAULT ((1)) NOT NULL,
    SalesOrderNumber          NATIONAL VARCHAR(25)     NOT NULL,
    PurchaseOrderNumber       NATIONAL VARCHAR(25),
    AccountNumber             NATIONAL VARCHAR(15),
    CustomerID                INT                      NOT NULL,
    SalesPersonID             INT,
    TerritoryID               INT,
    BillToAddressID           INT                      NOT NULL,
    ShipToAddressID           INT                      NOT NULL,
    ShipMethodID              INT                      NOT NULL,
    CreditCardID              INT,
    CreditCardApprovalCode    VARCHAR(15),
    CurrencyRateID            INT,
    SubTotal                  DECIMAL(19, 4)           DEFAULT (0.00) NOT NULL
                              CHECK (([SubTotal]>=(0.00))),
    TaxAmt                    DECIMAL(19, 4)           DEFAULT (0.00) NOT NULL
                              CHECK (([TaxAmt]>=(0.00))),
    Freight                   DECIMAL(19, 4)           DEFAULT (0.00) NOT NULL
                              CHECK (([Freight]>=(0.00))),
    TotalDue                  DECIMAL(19, 4)           NOT NULL,
    Comment                   NATIONAL VARCHAR(128),
    rowguid                   BINARY(16)               DEFAULT (newid()) NOT NULL,
    ModifiedDate              DATETIME                 DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SalesOrderID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesOrderHeaderSalesReason 
--

CREATE TABLE SalesOrderHeaderSalesReason(
    SalesOrderID     INT         NOT NULL,
    SalesReasonID    INT         NOT NULL,
    ModifiedDate     DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SalesOrderID, SalesReasonID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesPerson 
--

CREATE TABLE SalesPerson(
    BusinessEntityID    INT               NOT NULL,
    TerritoryID         INT,
    SalesQuota          DECIMAL(19, 4)    
                        CHECK (([SalesQuota]>(0.00))),
    Bonus               DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                        CHECK (([Bonus]>=(0.00))),
    CommissionPct       DECIMAL(7, 2)     DEFAULT (0.00) NOT NULL
                        CHECK (([CommissionPct]>=(0.00))),
    SalesYTD            DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                        CHECK (([SalesYTD]>=(0.00))),
    SalesLastYear       DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                        CHECK (([SalesLastYear]>=(0.00))),
    rowguid             BINARY(16)        DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesPersonQuotaHistory 
--

CREATE TABLE SalesPersonQuotaHistory(
    BusinessEntityID    INT               NOT NULL,
    QuotaDate           DATETIME          NOT NULL,
    SalesQuota          DECIMAL(19, 4)    NOT NULL
                        CHECK (([SalesQuota]>(0.00))),
    rowguid             BINARY(16)        DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, QuotaDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesReason 
--

CREATE TABLE SalesReason(
    SalesReasonID    INT                     AUTO_INCREMENT,
    Name             NATIONAL VARCHAR(50)    NOT NULL,
    ReasonType       NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate     DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SalesReasonID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesTaxRate 
--

CREATE TABLE SalesTaxRate(
    SalesTaxRateID     INT                     AUTO_INCREMENT,
    StateProvinceID    INT                     NOT NULL,
    TaxType            TINYINT                 NOT NULL
                       CHECK (([TaxType]>=(1) AND [TaxType]<=(3))),
    TaxRate            DECIMAL(7, 2)           DEFAULT (0.00) NOT NULL,
    Name               NATIONAL VARCHAR(50)    NOT NULL,
    rowguid            BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate       DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SalesTaxRateID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesTerritory 
--

CREATE TABLE SalesTerritory(
    TerritoryID          INT                     AUTO_INCREMENT,
    Name                 NATIONAL VARCHAR(50)    NOT NULL,
    CountryRegionCode    NATIONAL VARCHAR(3)     NOT NULL,
    Group                NATIONAL VARCHAR(50)    NOT NULL,
    SalesYTD             DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                         CHECK (([SalesYTD]>=(0.00))),
    SalesLastYear        DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                         CHECK (([SalesLastYear]>=(0.00))),
    CostYTD              DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                         CHECK (([CostYTD]>=(0.00))),
    CostLastYear         DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                         CHECK (([CostLastYear]>=(0.00))),
    rowguid              BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate         DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (TerritoryID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesTerritoryHistory 
--

CREATE TABLE SalesTerritoryHistory(
    BusinessEntityID    INT           NOT NULL,
    TerritoryID         INT           NOT NULL,
    StartDate           DATETIME      NOT NULL,
    EndDate             DATETIME,
    rowguid             BINARY(16)    DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID, TerritoryID, StartDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: ScrapReason 
--

CREATE TABLE ScrapReason(
    ScrapReasonID    SMALLINT                AUTO_INCREMENT,
    Name             NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate     DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ScrapReasonID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Shift 
--

CREATE TABLE Shift(
    ShiftID         TINYINT                 AUTO_INCREMENT,
    Name            NATIONAL VARCHAR(50)    NOT NULL,
    StartTime       TIME                    NOT NULL,
    EndTime         TIME                    NOT NULL,
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ShiftID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ShipMethod 
--

CREATE TABLE ShipMethod(
    ShipMethodID    INT                     AUTO_INCREMENT,
    Name            NATIONAL VARCHAR(50)    NOT NULL,
    ShipBase        DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                    CHECK (([ShipBase]>(0.00))),
    ShipRate        DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                    CHECK (([ShipRate]>(0.00))),
    rowguid         BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate    DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ShipMethodID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ShoppingCartItem 
--

CREATE TABLE ShoppingCartItem(
    ShoppingCartItemID    INT                     AUTO_INCREMENT,
    ShoppingCartID        NATIONAL VARCHAR(50)    NOT NULL,
    Quantity              INT                     DEFAULT (1) NOT NULL
                          CHECK (([Quantity]>=(1))),
    ProductID             INT                     NOT NULL,
    DateCreated           DATETIME                DEFAULT (getdate()) NOT NULL,
    ModifiedDate          DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (ShoppingCartItemID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SpecialOffer 
--

CREATE TABLE SpecialOffer(
    SpecialOfferID    INT                      AUTO_INCREMENT,
    Description       NATIONAL VARCHAR(255)    NOT NULL,
    DiscountPct       DECIMAL(7, 2)            DEFAULT (0.00) NOT NULL
                      CHECK (([DiscountPct]>=(0.00))),
    Type              NATIONAL VARCHAR(50)     NOT NULL,
    Category          NATIONAL VARCHAR(50)     NOT NULL,
    StartDate         DATETIME                 NOT NULL,
    EndDate           DATETIME                 NOT NULL,
    MinQty            INT                      DEFAULT (0) NOT NULL
                      CHECK (([MinQty]>=(0))),
    MaxQty            INT                      
                      CHECK (([MaxQty]>=(0))),
    rowguid           BINARY(16)               DEFAULT (newid()) NOT NULL,
    ModifiedDate      DATETIME                 DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SpecialOfferID)
)ENGINE=MYISAM
;



-- 
-- TABLE: SpecialOfferProduct 
--

CREATE TABLE SpecialOfferProduct(
    SpecialOfferID    INT           NOT NULL,
    ProductID         INT           NOT NULL,
    rowguid           BINARY(16)    DEFAULT (newid()) NOT NULL,
    ModifiedDate      DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (SpecialOfferID, ProductID)
)ENGINE=MYISAM
;



-- 
-- TABLE: StateProvince 
--

CREATE TABLE StateProvince(
    StateProvinceID            INT                     AUTO_INCREMENT,
    StateProvinceCode          NATIONAL CHAR(3)        NOT NULL,
    CountryRegionCode          NATIONAL VARCHAR(3)     NOT NULL,
    IsOnlyStateProvinceFlag    BIT(1)                  DEFAULT ((1)) NOT NULL,
    Name                       NATIONAL VARCHAR(50)    NOT NULL,
    TerritoryID                INT                     NOT NULL,
    rowguid                    BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate               DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (StateProvinceID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Store 
--

CREATE TABLE Store(
    BusinessEntityID    INT                     NOT NULL,
    Name                NATIONAL VARCHAR(50)    NOT NULL,
    SalesPersonID       INT,
    Demographics        LONGBLOB,
    rowguid             BINARY(16)              DEFAULT (newid()) NOT NULL,
    ModifiedDate        DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: TransactionHistory 
--

CREATE TABLE TransactionHistory(
    TransactionID           INT                 AUTO_INCREMENT,
    ProductID               INT                 NOT NULL,
    ReferenceOrderID        INT                 NOT NULL,
    ReferenceOrderLineID    INT                 DEFAULT (0) NOT NULL,
    TransactionDate         DATETIME            DEFAULT (getdate()) NOT NULL,
    TransactionType         NATIONAL CHAR(1)    NOT NULL
                            CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    Quantity                INT                 NOT NULL,
    ActualCost              DECIMAL(19, 4)      NOT NULL,
    ModifiedDate            DATETIME            DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (TransactionID)
)ENGINE=MYISAM
;



-- 
-- TABLE: TransactionHistoryArchive 
--

CREATE TABLE TransactionHistoryArchive(
    TransactionID           INT                 NOT NULL,
    ProductID               INT                 NOT NULL,
    ReferenceOrderID        INT                 NOT NULL,
    ReferenceOrderLineID    INT                 DEFAULT (0) NOT NULL,
    TransactionDate         DATETIME            DEFAULT (getdate()) NOT NULL,
    TransactionType         NATIONAL CHAR(1)    NOT NULL
                            CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    Quantity                INT                 NOT NULL,
    ActualCost              DECIMAL(19, 4)      NOT NULL,
    ModifiedDate            DATETIME            DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (TransactionID)
)ENGINE=MYISAM
;



-- 
-- TABLE: UnitMeasure 
--

CREATE TABLE UnitMeasure(
    UnitMeasureCode    NATIONAL CHAR(3)        NOT NULL,
    Name               NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate       DATETIME                DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (UnitMeasureCode)
)ENGINE=MYISAM
;



-- 
-- TABLE: Vendor 
--

CREATE TABLE Vendor(
    BusinessEntityID           INT                       NOT NULL,
    AccountNumber              NATIONAL VARCHAR(15)      NOT NULL,
    Name                       NATIONAL VARCHAR(50)      NOT NULL,
    CreditRating               TINYINT                   NOT NULL
                               CHECK (([CreditRating]>=(1) AND [CreditRating]<=(5))),
    PreferredVendorStatus      BIT(1)                    DEFAULT ((1)) NOT NULL,
    ActiveFlag                 BIT(1)                    DEFAULT ((1)) NOT NULL,
    PurchasingWebServiceURL    NATIONAL VARCHAR(1024),
    ModifiedDate               DATETIME                  DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: WorkOrder 
--

CREATE TABLE WorkOrder(
    WorkOrderID      INT         AUTO_INCREMENT,
    ProductID        INT         NOT NULL,
    OrderQty         INT         NOT NULL
                     CHECK (([OrderQty]>(0))),
    StockedQty       INT         NOT NULL,
    ScrappedQty      SMALLINT    NOT NULL
                     CHECK (([ScrappedQty]>=(0))),
    StartDate        DATETIME    NOT NULL,
    EndDate          DATETIME,
    DueDate          DATETIME    NOT NULL,
    ScrapReasonID    SMALLINT,
    ModifiedDate     DATETIME    DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (WorkOrderID)
)ENGINE=MYISAM
;



-- 
-- TABLE: WorkOrderRouting 
--

CREATE TABLE WorkOrderRouting(
    WorkOrderID           INT               NOT NULL,
    ProductID             INT               NOT NULL,
    OperationSequence     SMALLINT          NOT NULL,
    LocationID            SMALLINT          NOT NULL,
    ScheduledStartDate    DATETIME          NOT NULL,
    ScheduledEndDate      DATETIME          NOT NULL,
    ActualStartDate       DATETIME,
    ActualEndDate         DATETIME,
    ActualResourceHrs     DECIMAL(9, 4)     
                          CHECK (([ActualResourceHrs]>=(0.0000))),
    PlannedCost           DECIMAL(19, 4)    NOT NULL
                          CHECK (([PlannedCost]>(0.00))),
    ActualCost            DECIMAL(19, 4)    
                          CHECK (([ActualCost]>(0.00))),
    ModifiedDate          DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY (WorkOrderID, ProductID, OperationSequence)
)ENGINE=MYISAM
;



-- 
-- TABLE: Address 
--

ALTER TABLE Address ADD CONSTRAINT FK_Address_StateProvince_StateProvinceID 
    FOREIGN KEY (StateProvinceID)
    REFERENCES StateProvince(StateProvinceID)
;


-- 
-- TABLE: BillOfMaterials 
--

ALTER TABLE BillOfMaterials ADD CONSTRAINT FK_BillOfMaterials_Product_ComponentID 
    FOREIGN KEY (ComponentID)
    REFERENCES Product(ProductID)
;

ALTER TABLE BillOfMaterials ADD CONSTRAINT FK_BillOfMaterials_Product_ProductAssemblyID 
    FOREIGN KEY (ProductAssemblyID)
    REFERENCES Product(ProductID)
;

ALTER TABLE BillOfMaterials ADD CONSTRAINT FK_BillOfMaterials_UnitMeasure_UnitMeasureCode 
    FOREIGN KEY (UnitMeasureCode)
    REFERENCES UnitMeasure(UnitMeasureCode)
;


-- 
-- TABLE: BusinessEntityAddress 
--

ALTER TABLE BusinessEntityAddress ADD CONSTRAINT FK_BusinessEntityAddress_Address_AddressID 
    FOREIGN KEY (AddressID)
    REFERENCES Address(AddressID)
;

ALTER TABLE BusinessEntityAddress ADD CONSTRAINT FK_BusinessEntityAddress_AddressType_AddressTypeID 
    FOREIGN KEY (AddressTypeID)
    REFERENCES AddressType(AddressTypeID)
;

ALTER TABLE BusinessEntityAddress ADD CONSTRAINT FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES BusinessEntity(BusinessEntityID)
;


-- 
-- TABLE: BusinessEntityContact 
--

ALTER TABLE BusinessEntityContact ADD CONSTRAINT FK_BusinessEntityContact_BusinessEntity_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES BusinessEntity(BusinessEntityID)
;

ALTER TABLE BusinessEntityContact ADD CONSTRAINT FK_BusinessEntityContact_ContactType_ContactTypeID 
    FOREIGN KEY (ContactTypeID)
    REFERENCES ContactType(ContactTypeID)
;

ALTER TABLE BusinessEntityContact ADD CONSTRAINT FK_BusinessEntityContact_Person_PersonID 
    FOREIGN KEY (PersonID)
    REFERENCES Person(BusinessEntityID)
;


-- 
-- TABLE: CountryRegionCurrency 
--

ALTER TABLE CountryRegionCurrency ADD CONSTRAINT FK_CountryRegionCurrency_CountryRegion_CountryRegionCode 
    FOREIGN KEY (CountryRegionCode)
    REFERENCES CountryRegion(CountryRegionCode)
;

ALTER TABLE CountryRegionCurrency ADD CONSTRAINT FK_CountryRegionCurrency_Currency_CurrencyCode 
    FOREIGN KEY (CurrencyCode)
    REFERENCES Currency(CurrencyCode)
;


-- 
-- TABLE: CurrencyRate 
--

ALTER TABLE CurrencyRate ADD CONSTRAINT FK_CurrencyRate_Currency_FromCurrencyCode 
    FOREIGN KEY (FromCurrencyCode)
    REFERENCES Currency(CurrencyCode)
;

ALTER TABLE CurrencyRate ADD CONSTRAINT FK_CurrencyRate_Currency_ToCurrencyCode 
    FOREIGN KEY (ToCurrencyCode)
    REFERENCES Currency(CurrencyCode)
;


-- 
-- TABLE: Customer 
--

ALTER TABLE Customer ADD CONSTRAINT FK_Customer_Person_PersonID 
    FOREIGN KEY (PersonID)
    REFERENCES Person(BusinessEntityID)
;

ALTER TABLE Customer ADD CONSTRAINT FK_Customer_SalesTerritory_TerritoryID 
    FOREIGN KEY (TerritoryID)
    REFERENCES SalesTerritory(TerritoryID)
;

ALTER TABLE Customer ADD CONSTRAINT FK_Customer_Store_StoreID 
    FOREIGN KEY (StoreID)
    REFERENCES Store(BusinessEntityID)
;


-- 
-- TABLE: Document 
--

ALTER TABLE Document ADD CONSTRAINT FK_Document_Employee_Owner 
    FOREIGN KEY (Owner)
    REFERENCES Employee(BusinessEntityID)
;


-- 
-- TABLE: EmailAddress 
--

ALTER TABLE EmailAddress ADD CONSTRAINT FK_EmailAddress_Person_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Person(BusinessEntityID)
;


-- 
-- TABLE: Employee 
--

ALTER TABLE Employee ADD CONSTRAINT FK_Employee_Person_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Person(BusinessEntityID)
;


-- 
-- TABLE: EmployeeDepartmentHistory 
--

ALTER TABLE EmployeeDepartmentHistory ADD CONSTRAINT FK_EmployeeDepartmentHistory_Department_DepartmentID 
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
;

ALTER TABLE EmployeeDepartmentHistory ADD CONSTRAINT FK_EmployeeDepartmentHistory_Employee_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Employee(BusinessEntityID)
;

ALTER TABLE EmployeeDepartmentHistory ADD CONSTRAINT FK_EmployeeDepartmentHistory_Shift_ShiftID 
    FOREIGN KEY (ShiftID)
    REFERENCES Shift(ShiftID)
;


-- 
-- TABLE: EmployeePayHistory 
--

ALTER TABLE EmployeePayHistory ADD CONSTRAINT FK_EmployeePayHistory_Employee_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Employee(BusinessEntityID)
;


-- 
-- TABLE: JobCandidate 
--

ALTER TABLE JobCandidate ADD CONSTRAINT FK_JobCandidate_Employee_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Employee(BusinessEntityID)
;


-- 
-- TABLE: Password 
--

ALTER TABLE Password ADD CONSTRAINT FK_Password_Person_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Person(BusinessEntityID)
;


-- 
-- TABLE: Person 
--

ALTER TABLE Person ADD CONSTRAINT FK_Person_BusinessEntity_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES BusinessEntity(BusinessEntityID)
;


-- 
-- TABLE: PersonCreditCard 
--

ALTER TABLE PersonCreditCard ADD CONSTRAINT FK_PersonCreditCard_CreditCard_CreditCardID 
    FOREIGN KEY (CreditCardID)
    REFERENCES CreditCard(CreditCardID)
;

ALTER TABLE PersonCreditCard ADD CONSTRAINT FK_PersonCreditCard_Person_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Person(BusinessEntityID)
;


-- 
-- TABLE: PersonPhone 
--

ALTER TABLE PersonPhone ADD CONSTRAINT FK_PersonPhone_Person_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Person(BusinessEntityID)
;

ALTER TABLE PersonPhone ADD CONSTRAINT FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID 
    FOREIGN KEY (PhoneNumberTypeID)
    REFERENCES PhoneNumberType(PhoneNumberTypeID)
;


-- 
-- TABLE: Product 
--

ALTER TABLE Product ADD CONSTRAINT FK_Product_ProductModel_ProductModelID 
    FOREIGN KEY (ProductModelID)
    REFERENCES ProductModel(ProductModelID)
;

ALTER TABLE Product ADD CONSTRAINT FK_Product_ProductSubcategory_ProductSubcategoryID 
    FOREIGN KEY (ProductSubcategoryID)
    REFERENCES ProductSubcategory(ProductSubcategoryID)
;

ALTER TABLE Product ADD CONSTRAINT FK_Product_UnitMeasure_SizeUnitMeasureCode 
    FOREIGN KEY (SizeUnitMeasureCode)
    REFERENCES UnitMeasure(UnitMeasureCode)
;

ALTER TABLE Product ADD CONSTRAINT FK_Product_UnitMeasure_WeightUnitMeasureCode 
    FOREIGN KEY (WeightUnitMeasureCode)
    REFERENCES UnitMeasure(UnitMeasureCode)
;


-- 
-- TABLE: ProductCostHistory 
--

ALTER TABLE ProductCostHistory ADD CONSTRAINT FK_ProductCostHistory_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: ProductDocument 
--

ALTER TABLE ProductDocument ADD CONSTRAINT FK_ProductDocument_Document_DocumentNode 
    FOREIGN KEY (DocumentNode)
    REFERENCES Document(DocumentNode)
;

ALTER TABLE ProductDocument ADD CONSTRAINT FK_ProductDocument_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: ProductInventory 
--

ALTER TABLE ProductInventory ADD CONSTRAINT FK_ProductInventory_Location_LocationID 
    FOREIGN KEY (LocationID)
    REFERENCES Location(LocationID)
;

ALTER TABLE ProductInventory ADD CONSTRAINT FK_ProductInventory_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: ProductListPriceHistory 
--

ALTER TABLE ProductListPriceHistory ADD CONSTRAINT FK_ProductListPriceHistory_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: ProductModelIllustration 
--

ALTER TABLE ProductModelIllustration ADD CONSTRAINT FK_ProductModelIllustration_Illustration_IllustrationID 
    FOREIGN KEY (IllustrationID)
    REFERENCES Illustration(IllustrationID)
;

ALTER TABLE ProductModelIllustration ADD CONSTRAINT FK_ProductModelIllustration_ProductModel_ProductModelID 
    FOREIGN KEY (ProductModelID)
    REFERENCES ProductModel(ProductModelID)
;


-- 
-- TABLE: ProductModelProductDescriptionCulture 
--

ALTER TABLE ProductModelProductDescriptionCulture ADD CONSTRAINT FK_ProductModelProductDescriptionCulture_Culture_CultureID 
    FOREIGN KEY (CultureID)
    REFERENCES Culture(CultureID)
;

ALTER TABLE ProductModelProductDescriptionCulture ADD CONSTRAINT FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID 
    FOREIGN KEY (ProductDescriptionID)
    REFERENCES ProductDescription(ProductDescriptionID)
;

ALTER TABLE ProductModelProductDescriptionCulture ADD CONSTRAINT FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID 
    FOREIGN KEY (ProductModelID)
    REFERENCES ProductModel(ProductModelID)
;


-- 
-- TABLE: ProductProductPhoto 
--

ALTER TABLE ProductProductPhoto ADD CONSTRAINT FK_ProductProductPhoto_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;

ALTER TABLE ProductProductPhoto ADD CONSTRAINT FK_ProductProductPhoto_ProductPhoto_ProductPhotoID 
    FOREIGN KEY (ProductPhotoID)
    REFERENCES ProductPhoto(ProductPhotoID)
;


-- 
-- TABLE: ProductReview 
--

ALTER TABLE ProductReview ADD CONSTRAINT FK_ProductReview_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: ProductSubcategory 
--

ALTER TABLE ProductSubcategory ADD CONSTRAINT FK_ProductSubcategory_ProductCategory_ProductCategoryID 
    FOREIGN KEY (ProductCategoryID)
    REFERENCES ProductCategory(ProductCategoryID)
;


-- 
-- TABLE: ProductVendor 
--

ALTER TABLE ProductVendor ADD CONSTRAINT FK_ProductVendor_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;

ALTER TABLE ProductVendor ADD CONSTRAINT FK_ProductVendor_UnitMeasure_UnitMeasureCode 
    FOREIGN KEY (UnitMeasureCode)
    REFERENCES UnitMeasure(UnitMeasureCode)
;

ALTER TABLE ProductVendor ADD CONSTRAINT FK_ProductVendor_Vendor_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Vendor(BusinessEntityID)
;


-- 
-- TABLE: PurchaseOrderDetail 
--

ALTER TABLE PurchaseOrderDetail ADD CONSTRAINT FK_PurchaseOrderDetail_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;

ALTER TABLE PurchaseOrderDetail ADD CONSTRAINT FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID 
    FOREIGN KEY (PurchaseOrderID)
    REFERENCES PurchaseOrderHeader(PurchaseOrderID)
;


-- 
-- TABLE: PurchaseOrderHeader 
--

ALTER TABLE PurchaseOrderHeader ADD CONSTRAINT FK_PurchaseOrderHeader_Employee_EmployeeID 
    FOREIGN KEY (EmployeeID)
    REFERENCES Employee(BusinessEntityID)
;

ALTER TABLE PurchaseOrderHeader ADD CONSTRAINT FK_PurchaseOrderHeader_ShipMethod_ShipMethodID 
    FOREIGN KEY (ShipMethodID)
    REFERENCES ShipMethod(ShipMethodID)
;

ALTER TABLE PurchaseOrderHeader ADD CONSTRAINT FK_PurchaseOrderHeader_Vendor_VendorID 
    FOREIGN KEY (VendorID)
    REFERENCES Vendor(BusinessEntityID)
;


-- 
-- TABLE: SalesOrderDetail 
--

ALTER TABLE SalesOrderDetail ADD CONSTRAINT FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID 
    FOREIGN KEY (SalesOrderID)
    REFERENCES SalesOrderHeader(SalesOrderID) ON DELETE CASCADE
;

ALTER TABLE SalesOrderDetail ADD CONSTRAINT FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID 
    FOREIGN KEY (SpecialOfferID, ProductID)
    REFERENCES SpecialOfferProduct(SpecialOfferID, ProductID)
;


-- 
-- TABLE: SalesOrderHeader 
--

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_Address_BillToAddressID 
    FOREIGN KEY (BillToAddressID)
    REFERENCES Address(AddressID)
;

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_Address_ShipToAddressID 
    FOREIGN KEY (ShipToAddressID)
    REFERENCES Address(AddressID)
;

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_CreditCard_CreditCardID 
    FOREIGN KEY (CreditCardID)
    REFERENCES CreditCard(CreditCardID)
;

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_CurrencyRate_CurrencyRateID 
    FOREIGN KEY (CurrencyRateID)
    REFERENCES CurrencyRate(CurrencyRateID)
;

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_Customer_CustomerID 
    FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
;

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_SalesPerson_SalesPersonID 
    FOREIGN KEY (SalesPersonID)
    REFERENCES SalesPerson(BusinessEntityID)
;

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_SalesTerritory_TerritoryID 
    FOREIGN KEY (TerritoryID)
    REFERENCES SalesTerritory(TerritoryID)
;

ALTER TABLE SalesOrderHeader ADD CONSTRAINT FK_SalesOrderHeader_ShipMethod_ShipMethodID 
    FOREIGN KEY (ShipMethodID)
    REFERENCES ShipMethod(ShipMethodID)
;


-- 
-- TABLE: SalesOrderHeaderSalesReason 
--

ALTER TABLE SalesOrderHeaderSalesReason ADD CONSTRAINT FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID 
    FOREIGN KEY (SalesOrderID)
    REFERENCES SalesOrderHeader(SalesOrderID) ON DELETE CASCADE
;

ALTER TABLE SalesOrderHeaderSalesReason ADD CONSTRAINT FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID 
    FOREIGN KEY (SalesReasonID)
    REFERENCES SalesReason(SalesReasonID)
;


-- 
-- TABLE: SalesPerson 
--

ALTER TABLE SalesPerson ADD CONSTRAINT FK_SalesPerson_Employee_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Employee(BusinessEntityID)
;

ALTER TABLE SalesPerson ADD CONSTRAINT FK_SalesPerson_SalesTerritory_TerritoryID 
    FOREIGN KEY (TerritoryID)
    REFERENCES SalesTerritory(TerritoryID)
;


-- 
-- TABLE: SalesPersonQuotaHistory 
--

ALTER TABLE SalesPersonQuotaHistory ADD CONSTRAINT FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES SalesPerson(BusinessEntityID)
;


-- 
-- TABLE: SalesTaxRate 
--

ALTER TABLE SalesTaxRate ADD CONSTRAINT FK_SalesTaxRate_StateProvince_StateProvinceID 
    FOREIGN KEY (StateProvinceID)
    REFERENCES StateProvince(StateProvinceID)
;


-- 
-- TABLE: SalesTerritory 
--

ALTER TABLE SalesTerritory ADD CONSTRAINT FK_SalesTerritory_CountryRegion_CountryRegionCode 
    FOREIGN KEY (CountryRegionCode)
    REFERENCES CountryRegion(CountryRegionCode)
;


-- 
-- TABLE: SalesTerritoryHistory 
--

ALTER TABLE SalesTerritoryHistory ADD CONSTRAINT FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES SalesPerson(BusinessEntityID)
;

ALTER TABLE SalesTerritoryHistory ADD CONSTRAINT FK_SalesTerritoryHistory_SalesTerritory_TerritoryID 
    FOREIGN KEY (TerritoryID)
    REFERENCES SalesTerritory(TerritoryID)
;


-- 
-- TABLE: ShoppingCartItem 
--

ALTER TABLE ShoppingCartItem ADD CONSTRAINT FK_ShoppingCartItem_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: SpecialOfferProduct 
--

ALTER TABLE SpecialOfferProduct ADD CONSTRAINT FK_SpecialOfferProduct_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;

ALTER TABLE SpecialOfferProduct ADD CONSTRAINT FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID 
    FOREIGN KEY (SpecialOfferID)
    REFERENCES SpecialOffer(SpecialOfferID)
;


-- 
-- TABLE: StateProvince 
--

ALTER TABLE StateProvince ADD CONSTRAINT FK_StateProvince_CountryRegion_CountryRegionCode 
    FOREIGN KEY (CountryRegionCode)
    REFERENCES CountryRegion(CountryRegionCode)
;

ALTER TABLE StateProvince ADD CONSTRAINT FK_StateProvince_SalesTerritory_TerritoryID 
    FOREIGN KEY (TerritoryID)
    REFERENCES SalesTerritory(TerritoryID)
;


-- 
-- TABLE: Store 
--

ALTER TABLE Store ADD CONSTRAINT FK_Store_BusinessEntity_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES BusinessEntity(BusinessEntityID)
;

ALTER TABLE Store ADD CONSTRAINT FK_Store_SalesPerson_SalesPersonID 
    FOREIGN KEY (SalesPersonID)
    REFERENCES SalesPerson(BusinessEntityID)
;


-- 
-- TABLE: TransactionHistory 
--

ALTER TABLE TransactionHistory ADD CONSTRAINT FK_TransactionHistory_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: Vendor 
--

ALTER TABLE Vendor ADD CONSTRAINT FK_Vendor_BusinessEntity_BusinessEntityID 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES BusinessEntity(BusinessEntityID)
;


-- 
-- TABLE: WorkOrder 
--

ALTER TABLE WorkOrder ADD CONSTRAINT FK_WorkOrder_Product_ProductID 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;

ALTER TABLE WorkOrder ADD CONSTRAINT FK_WorkOrder_ScrapReason_ScrapReasonID 
    FOREIGN KEY (ScrapReasonID)
    REFERENCES ScrapReason(ScrapReasonID)
;


-- 
-- TABLE: WorkOrderRouting 
--

ALTER TABLE WorkOrderRouting ADD CONSTRAINT FK_WorkOrderRouting_Location_LocationID 
    FOREIGN KEY (LocationID)
    REFERENCES Location(LocationID)
;

ALTER TABLE WorkOrderRouting ADD CONSTRAINT FK_WorkOrderRouting_WorkOrder_WorkOrderID 
    FOREIGN KEY (WorkOrderID)
    REFERENCES WorkOrder(WorkOrderID)
;


