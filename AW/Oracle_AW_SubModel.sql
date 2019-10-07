--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      DATA MODEL
--
-- Date Created : Saturday, September 28, 2019 23:21:21
-- Target DBMS : Oracle 12c
--

-- 
-- TABLE: Address 
--

CREATE TABLE Address(
    AddressID          NUMBER(38, 0)    NOT NULL,
    AddressLine1       NVARCHAR2(60)    NOT NULL,
    AddressLine2       NVARCHAR2(60),
    City               NVARCHAR2(30)    NOT NULL,
    StateProvinceID    NUMBER(38, 0)    NOT NULL,
    PostalCode         NVARCHAR2(15)    NOT NULL,
    SpatialLocation    CHAR(10),
    rowguid            RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate       TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Address_AddressID PRIMARY KEY (AddressID)
)
;



-- 
-- TABLE: AddressType 
--

CREATE TABLE AddressType(
    AddressTypeID    NUMBER(38, 0)    NOT NULL,
    Name             NVARCHAR2(50)    NOT NULL,
    rowguid          RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_AddressType_AddressTypeID PRIMARY KEY (AddressTypeID)
)
;



-- 
-- TABLE: AWBuildVersion 
--

CREATE TABLE AWBuildVersion(
    SystemInformationID    NUMBER(3, 0)     NOT NULL,
    "Database Version"     NVARCHAR2(25)    NOT NULL,
    VersionDate            TIMESTAMP(6)     NOT NULL,
    ModifiedDate           TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_AWBuildVersion_SystemInformationID PRIMARY KEY (SystemInformationID)
)
;



-- 
-- TABLE: BillOfMaterials 
--

CREATE TABLE BillOfMaterials(
    BillOfMaterialsID    NUMBER(38, 0)    NOT NULL,
    ProductAssemblyID    NUMBER(38, 0),
    ComponentID          NUMBER(38, 0)    NOT NULL,
    StartDate            TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    EndDate              TIMESTAMP(6),
    UnitMeasureCode      NCHAR(3)         NOT NULL,
    BOMLevel             SMALLINT         NOT NULL,
    PerAssemblyQty       NUMBER(8, 2)     DEFAULT (1.00) NOT NULL
                         CONSTRAINT CK_BillOfMaterials_PerAssemblyQty CHECK (([PerAssemblyQty]>=(1.00))),
    ModifiedDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_BillOfMaterials_BillOfMaterialsID PRIMARY KEY (BillOfMaterialsID)
)
;



-- 
-- TABLE: BusinessEntity 
--

CREATE TABLE BusinessEntity(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_BusinessEntity_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: BusinessEntityAddress 
--

CREATE TABLE BusinessEntityAddress(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    AddressID           NUMBER(38, 0)    NOT NULL,
    AddressTypeID       NUMBER(38, 0)    NOT NULL,
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID PRIMARY KEY (BusinessEntityID, AddressID, AddressTypeID)
)
;



-- 
-- TABLE: BusinessEntityContact 
--

CREATE TABLE BusinessEntityContact(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    PersonID            NUMBER(38, 0)    NOT NULL,
    ContactTypeID       NUMBER(38, 0)    NOT NULL,
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID PRIMARY KEY (BusinessEntityID, PersonID, ContactTypeID)
)
;



-- 
-- TABLE: ContactType 
--

CREATE TABLE ContactType(
    ContactTypeID    NUMBER(38, 0)    NOT NULL,
    Name             NVARCHAR2(50)    NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ContactType_ContactTypeID PRIMARY KEY (ContactTypeID)
)
;



-- 
-- TABLE: CountryRegion 
--

CREATE TABLE CountryRegion(
    CountryRegionCode    NVARCHAR2(3)     NOT NULL,
    Name                 NVARCHAR2(50)    NOT NULL,
    ModifiedDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_CountryRegion_CountryRegionCode PRIMARY KEY (CountryRegionCode)
)
;



-- 
-- TABLE: CountryRegionCurrency 
--

CREATE TABLE CountryRegionCurrency(
    CountryRegionCode    NVARCHAR2(3)    NOT NULL,
    CurrencyCode         NCHAR(3)        NOT NULL,
    ModifiedDate         TIMESTAMP(6)    DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode PRIMARY KEY (CountryRegionCode, CurrencyCode)
)
;



-- 
-- TABLE: CreditCard 
--

CREATE TABLE CreditCard(
    CreditCardID    NUMBER(38, 0)    NOT NULL,
    CardType        NVARCHAR2(50)    NOT NULL,
    CardNumber      NVARCHAR2(25)    NOT NULL,
    ExpMonth        NUMBER(3, 0)     NOT NULL,
    ExpYear         SMALLINT         NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_CreditCard_CreditCardID PRIMARY KEY (CreditCardID)
)
;



-- 
-- TABLE: Culture 
--

CREATE TABLE Culture(
    CultureID       NCHAR(6)         NOT NULL,
    Name            NVARCHAR2(50)    NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Culture_CultureID PRIMARY KEY (CultureID)
)
;



-- 
-- TABLE: Currency 
--

CREATE TABLE Currency(
    CurrencyCode    NCHAR(3)         NOT NULL,
    Name            NVARCHAR2(50)    NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Currency_CurrencyCode PRIMARY KEY (CurrencyCode)
)
;



-- 
-- TABLE: CurrencyRate 
--

CREATE TABLE CurrencyRate(
    CurrencyRateID      NUMBER(38, 0)    NOT NULL,
    CurrencyRateDate    TIMESTAMP(6)     NOT NULL,
    FromCurrencyCode    NCHAR(3)         NOT NULL,
    ToCurrencyCode      NCHAR(3)         NOT NULL,
    AverageRate         NUMBER(19, 4)    NOT NULL,
    EndOfDayRate        NUMBER(19, 4)    NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_CurrencyRate_CurrencyRateID PRIMARY KEY (CurrencyRateID)
)
;



-- 
-- TABLE: Customer 
--

CREATE TABLE Customer(
    CustomerID       NUMBER(38, 0)    NOT NULL,
    PersonID         NUMBER(38, 0),
    StoreID          NUMBER(38, 0),
    TerritoryID      NUMBER(38, 0),
    AccountNumber    VARCHAR2(10)     NOT NULL,
    rowguid          RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Customer_CustomerID PRIMARY KEY (CustomerID)
)
;



-- 
-- TABLE: DatabaseLog 
--

CREATE TABLE DatabaseLog(
    DatabaseLogID    NUMBER(38, 0)    NOT NULL,
    PostTime         TIMESTAMP(6)     NOT NULL,
    DatabaseUser     CHAR(10)         NOT NULL,
    Event            CHAR(10)         NOT NULL,
    Schema           CHAR(10),
    Object           CHAR(10),
    TSQL             NVARCHAR2(18)    NOT NULL,
    XmlEvent         SYS.XMLType      NOT NULL,
    CONSTRAINT PK_DatabaseLog_DatabaseLogID PRIMARY KEY (DatabaseLogID)
)
;



-- 
-- TABLE: Department 
--

CREATE TABLE Department(
    DepartmentID    SMALLINT         NOT NULL,
    Name            NVARCHAR2(50)    NOT NULL,
    GroupName       NVARCHAR2(50)    NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Department_DepartmentID PRIMARY KEY (DepartmentID)
)
;



-- 
-- TABLE: Document 
--

CREATE TABLE Document(
    DocumentNode       CHAR(10)          NOT NULL,
    DocumentLevel      SMALLINT,
    Title              NVARCHAR2(50)     NOT NULL,
    Owner              NUMBER(38, 0)     NOT NULL,
    FolderFlag         NUMBER(1, 0)      DEFAULT (0) NOT NULL,
    FileName           NVARCHAR2(400)    NOT NULL,
    FileExtension      NVARCHAR2(8)      NOT NULL,
    Revision           NCHAR(5)          NOT NULL,
    ChangeNumber       NUMBER(38, 0)     DEFAULT (0) NOT NULL,
    Status             NUMBER(3, 0)      NOT NULL
                       CONSTRAINT CK_Document_Status CHECK (([Status]>=(1) AND [Status]<=(3))),
    DocumentSummary    NVARCHAR2(18),
    Document           BLOB,
    rowguid            RAW(16)           DEFAULT (newid()) NOT NULL,
    ModifiedDate       TIMESTAMP(6)      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Document_DocumentNode PRIMARY KEY (DocumentNode)
)
;



-- 
-- TABLE: EmailAddress 
--

CREATE TABLE EmailAddress(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    EmailAddressID      NUMBER(38, 0)    NOT NULL,
    EmailAddress        NVARCHAR2(50),
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_EmailAddress_BusinessEntityID_EmailAddressID PRIMARY KEY (BusinessEntityID, EmailAddressID)
)
;



-- 
-- TABLE: Employee 
--

CREATE TABLE Employee(
    BusinessEntityID     NUMBER(38, 0)     NOT NULL,
    NationalIDNumber     NVARCHAR2(15)     NOT NULL,
    LoginID              NVARCHAR2(256)    NOT NULL,
    OrganizationNode     CHAR(10),
    OrganizationLevel    SMALLINT,
    JobTitle             NVARCHAR2(50)     NOT NULL,
    BirthDate            DATE              NOT NULL
                         CONSTRAINT CK_Employee_BirthDate CHECK (([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate()))),
    MaritalStatus        NCHAR(1)          NOT NULL
                         CONSTRAINT CK_Employee_MaritalStatus CHECK ((upper([MaritalStatus])='S' OR upper([MaritalStatus])='M')),
    Gender               NCHAR(1)          NOT NULL
                         CONSTRAINT CK_Employee_Gender CHECK ((upper([Gender])='F' OR upper([Gender])='M')),
    HireDate             DATE              NOT NULL
                         CONSTRAINT CK_Employee_HireDate CHECK (([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate()))),
    SalariedFlag         NUMBER(1, 0)      DEFAULT (1) NOT NULL,
    VacationHours        SMALLINT          DEFAULT ((0)) NOT NULL
                         CONSTRAINT CK_Employee_VacationHours CHECK (([VacationHours]>=(-40) AND [VacationHours]<=(240))),
    SickLeaveHours       SMALLINT          DEFAULT ((0)) NOT NULL
                         CONSTRAINT CK_Employee_SickLeaveHours CHECK (([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120))),
    CurrentFlag          NUMBER(1, 0)      DEFAULT (1) NOT NULL,
    rowguid              RAW(16)           DEFAULT (newid()) NOT NULL,
    ModifiedDate         TIMESTAMP(6)      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Employee_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: EmployeeDepartmentHistory 
--

CREATE TABLE EmployeeDepartmentHistory(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    DepartmentID        SMALLINT         NOT NULL,
    ShiftID             NUMBER(3, 0)     NOT NULL,
    StartDate           DATE             NOT NULL,
    EndDate             DATE,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID PRIMARY KEY (BusinessEntityID, DepartmentID, ShiftID, StartDate)
)
;



-- 
-- TABLE: EmployeePayHistory 
--

CREATE TABLE EmployeePayHistory(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    RateChangeDate      TIMESTAMP(6)     NOT NULL,
    Rate                NUMBER(19, 4)    NOT NULL
                        CONSTRAINT CK_EmployeePayHistory_Rate CHECK (([Rate]>=(6.50) AND [Rate]<=(200.00))),
    PayFrequency        NUMBER(3, 0)     NOT NULL
                        CONSTRAINT CK_EmployeePayHistory_PayFrequency CHECK (([PayFrequency]=(2) OR [PayFrequency]=(1))),
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_EmployeePayHistory_BusinessEntityID_RateChangeDate PRIMARY KEY (BusinessEntityID, RateChangeDate)
)
;



-- 
-- TABLE: ErrorLog 
--

CREATE TABLE ErrorLog(
    ErrorLogID        NUMBER(38, 0)      NOT NULL,
    ErrorTime         TIMESTAMP(6)       DEFAULT (getdate()) NOT NULL,
    UserName          CHAR(10)           NOT NULL,
    ErrorNumber       NUMBER(38, 0)      NOT NULL,
    ErrorSeverity     NUMBER(38, 0),
    ErrorState        NUMBER(38, 0),
    ErrorProcedure    NVARCHAR2(126),
    ErrorLine         NUMBER(38, 0),
    ErrorMessage      NVARCHAR2(4000)    NOT NULL,
    CONSTRAINT PK_ErrorLog_ErrorLogID PRIMARY KEY (ErrorLogID)
)
;



-- 
-- TABLE: Illustration 
--

CREATE TABLE Illustration(
    IllustrationID    NUMBER(38, 0)    NOT NULL,
    Diagram           SYS.XMLType,
    ModifiedDate      TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Illustration_IllustrationID PRIMARY KEY (IllustrationID)
)
;



-- 
-- TABLE: JobCandidate 
--

CREATE TABLE JobCandidate(
    JobCandidateID      NUMBER(38, 0)    NOT NULL,
    BusinessEntityID    NUMBER(38, 0),
    Resume              SYS.XMLType,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_JobCandidate_JobCandidateID PRIMARY KEY (JobCandidateID)
)
;



-- 
-- TABLE: Location 
--

CREATE TABLE Location(
    LocationID      SMALLINT         NOT NULL,
    Name            NVARCHAR2(50)    NOT NULL,
    CostRate        NUMBER(10, 2)    DEFAULT (0.00) NOT NULL
                    CONSTRAINT CK_Location_CostRate CHECK (([CostRate]>=(0.00))),
    Availability    NUMBER(8, 2)     DEFAULT (0.00) NOT NULL
                    CONSTRAINT CK_Location_Availability CHECK (([Availability]>=(0.00))),
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Location_LocationID PRIMARY KEY (LocationID)
)
;



-- 
-- TABLE: Password 
--

CREATE TABLE Password(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    PasswordHash        VARCHAR2(128)    NOT NULL,
    PasswordSalt        VARCHAR2(10)     NOT NULL,
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Password_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: Person 
--

CREATE TABLE Person(
    BusinessEntityID         NUMBER(38, 0)    NOT NULL,
    PersonType               NCHAR(2)         NOT NULL
                             CONSTRAINT CK_Person_PersonType CHECK (([PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC'))),
    NameStyle                NUMBER(1, 0)     DEFAULT (0) NOT NULL,
    Title                    NVARCHAR2(8),
    FirstName                NVARCHAR2(50)    NOT NULL,
    MiddleName               NVARCHAR2(50),
    LastName                 NVARCHAR2(50)    NOT NULL,
    Suffix                   NVARCHAR2(10),
    EmailPromotion           NUMBER(38, 0)    DEFAULT (0) NOT NULL
                             CONSTRAINT CK_Person_EmailPromotion CHECK (([EmailPromotion]>=(0) AND [EmailPromotion]<=(2))),
    AdditionalContactInfo    SYS.XMLType,
    Demographics             SYS.XMLType,
    rowguid                  RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Person_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: PersonCreditCard 
--

CREATE TABLE PersonCreditCard(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    CreditCardID        NUMBER(38, 0)    NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_PersonCreditCard_BusinessEntityID_CreditCardID PRIMARY KEY (BusinessEntityID, CreditCardID)
)
;



-- 
-- TABLE: PersonPhone 
--

CREATE TABLE PersonPhone(
    BusinessEntityID     NUMBER(38, 0)    NOT NULL,
    PhoneNumber          NVARCHAR2(25)    NOT NULL,
    PhoneNumberTypeID    NUMBER(38, 0)    NOT NULL,
    ModifiedDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID PRIMARY KEY (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)
)
;



-- 
-- TABLE: PhoneNumberType 
--

CREATE TABLE PhoneNumberType(
    PhoneNumberTypeID    NUMBER(38, 0)    NOT NULL,
    Name                 NVARCHAR2(50)    NOT NULL,
    ModifiedDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_PhoneNumberType_PhoneNumberTypeID PRIMARY KEY (PhoneNumberTypeID)
)
;



-- 
-- TABLE: Product 
--

CREATE TABLE Product(
    ProductID                NUMBER(38, 0)    NOT NULL,
    Name                     NVARCHAR2(50)    NOT NULL,
    ProductNumber            NVARCHAR2(25)    NOT NULL,
    MakeFlag                 NUMBER(1, 0)     DEFAULT (1) NOT NULL,
    FinishedGoodsFlag        NUMBER(1, 0)     DEFAULT (1) NOT NULL,
    Color                    NVARCHAR2(15),
    SafetyStockLevel         SMALLINT         NOT NULL
                             CONSTRAINT CK_Product_SafetyStockLevel CHECK (([SafetyStockLevel]>(0))),
    ReorderPoint             SMALLINT         NOT NULL
                             CONSTRAINT CK_Product_ReorderPoint CHECK (([ReorderPoint]>(0))),
    StandardCost             NUMBER(19, 4)    NOT NULL
                             CONSTRAINT CK_Product_StandardCost CHECK (([StandardCost]>=(0.00))),
    ListPrice                NUMBER(19, 4)    NOT NULL
                             CONSTRAINT CK_Product_ListPrice CHECK (([ListPrice]>=(0.00))),
    Size                     NVARCHAR2(5),
    SizeUnitMeasureCode      NCHAR(3),
    WeightUnitMeasureCode    NCHAR(3),
    Weight                   NUMBER(8, 2)     
                             CONSTRAINT CK_Product_Weight CHECK (([Weight]>(0.00))),
    DaysToManufacture        NUMBER(38, 0)    NOT NULL
                             CONSTRAINT CK_Product_DaysToManufacture CHECK (([DaysToManufacture]>=(0))),
    ProductLine              NCHAR(2)         
                             CONSTRAINT CK_Product_ProductLine CHECK ((upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL)),
    Class                    NCHAR(2)         
                             CONSTRAINT CK_Product_Class CHECK ((upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL)),
    Style                    NCHAR(2)         
                             CONSTRAINT CK_Product_Style CHECK ((upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL)),
    ProductSubcategoryID     NUMBER(38, 0),
    ProductModelID           NUMBER(38, 0),
    SellStartDate            TIMESTAMP(6)     NOT NULL,
    SellEndDate              TIMESTAMP(6),
    DiscontinuedDate         TIMESTAMP(6),
    rowguid                  RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Product_ProductID PRIMARY KEY (ProductID)
)
;



-- 
-- TABLE: ProductCategory 
--

CREATE TABLE ProductCategory(
    ProductCategoryID    NUMBER(38, 0)    NOT NULL,
    Name                 NVARCHAR2(50)    NOT NULL,
    rowguid              RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductCategory_ProductCategoryID PRIMARY KEY (ProductCategoryID)
)
;



-- 
-- TABLE: ProductCostHistory 
--

CREATE TABLE ProductCostHistory(
    ProductID       NUMBER(38, 0)    NOT NULL,
    StartDate       TIMESTAMP(6)     NOT NULL,
    EndDate         TIMESTAMP(6),
    StandardCost    NUMBER(19, 4)    NOT NULL
                    CONSTRAINT CK_ProductCostHistory_StandardCost CHECK (([StandardCost]>=(0.00))),
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductCostHistory_ProductID_StartDate PRIMARY KEY (ProductID, StartDate)
)
;



-- 
-- TABLE: ProductDescription 
--

CREATE TABLE ProductDescription(
    ProductDescriptionID    NUMBER(38, 0)     NOT NULL,
    Description             NVARCHAR2(400)    NOT NULL,
    rowguid                 RAW(16)           DEFAULT (newid()) NOT NULL,
    ModifiedDate            TIMESTAMP(6)      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductDescription_ProductDescriptionID PRIMARY KEY (ProductDescriptionID)
)
;



-- 
-- TABLE: ProductDocument 
--

CREATE TABLE ProductDocument(
    ProductID       NUMBER(38, 0)    NOT NULL,
    DocumentNode    CHAR(10)         NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductDocument_ProductID_DocumentNode PRIMARY KEY (ProductID, DocumentNode)
)
;



-- 
-- TABLE: ProductInventory 
--

CREATE TABLE ProductInventory(
    ProductID       NUMBER(38, 0)    NOT NULL,
    LocationID      SMALLINT         NOT NULL,
    Shelf           NVARCHAR2(10)    NOT NULL
                    CONSTRAINT CK_ProductInventory_Shelf CHECK (([Shelf] like '[A-Za-z]' OR [Shelf]='N/A')),
    Bin             NUMBER(3, 0)     NOT NULL
                    CONSTRAINT CK_ProductInventory_Bin CHECK (([Bin]>=(0) AND [Bin]<=(100))),
    Quantity        SMALLINT         DEFAULT ((0)) NOT NULL,
    rowguid         RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductInventory_ProductID_LocationID PRIMARY KEY (ProductID, LocationID)
)
;



-- 
-- TABLE: ProductListPriceHistory 
--

CREATE TABLE ProductListPriceHistory(
    ProductID       NUMBER(38, 0)    NOT NULL,
    StartDate       TIMESTAMP(6)     NOT NULL,
    EndDate         TIMESTAMP(6),
    ListPrice       NUMBER(19, 4)    NOT NULL
                    CONSTRAINT CK_ProductListPriceHistory_ListPrice CHECK (([ListPrice]>(0.00))),
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductListPriceHistory_ProductID_StartDate PRIMARY KEY (ProductID, StartDate)
)
;



-- 
-- TABLE: ProductModel 
--

CREATE TABLE ProductModel(
    ProductModelID        NUMBER(38, 0)    NOT NULL,
    Name                  NVARCHAR2(50)    NOT NULL,
    CatalogDescription    SYS.XMLType,
    Instructions          SYS.XMLType,
    rowguid               RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate          TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductModel_ProductModelID PRIMARY KEY (ProductModelID)
)
;



-- 
-- TABLE: ProductModelIllustration 
--

CREATE TABLE ProductModelIllustration(
    ProductModelID    NUMBER(38, 0)    NOT NULL,
    IllustrationID    NUMBER(38, 0)    NOT NULL,
    ModifiedDate      TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductModelIllustration_ProductModelID_IllustrationID PRIMARY KEY (ProductModelID, IllustrationID)
)
;



-- 
-- TABLE: ProductModelProductDescriptionCulture 
--

CREATE TABLE ProductModelProductDescriptionCulture(
    ProductModelID          NUMBER(38, 0)    NOT NULL,
    ProductDescriptionID    NUMBER(38, 0)    NOT NULL,
    CultureID               NCHAR(6)         NOT NULL,
    ModifiedDate            TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID PRIMARY KEY (ProductModelID, ProductDescriptionID, CultureID)
)
;



-- 
-- TABLE: ProductPhoto 
--

CREATE TABLE ProductPhoto(
    ProductPhotoID            NUMBER(38, 0)    NOT NULL,
    ThumbNailPhoto            BLOB,
    ThumbnailPhotoFileName    NVARCHAR2(50),
    LargePhoto                BLOB,
    LargePhotoFileName        NVARCHAR2(50),
    ModifiedDate              TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductPhoto_ProductPhotoID PRIMARY KEY (ProductPhotoID)
)
;



-- 
-- TABLE: ProductProductPhoto 
--

CREATE TABLE ProductProductPhoto(
    ProductID         NUMBER(38, 0)    NOT NULL,
    ProductPhotoID    NUMBER(38, 0)    NOT NULL,
    Primary           NUMBER(1, 0)     DEFAULT (0) NOT NULL,
    ModifiedDate      TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductProductPhoto_ProductID_ProductPhotoID PRIMARY KEY (ProductID, ProductPhotoID)
)
;



-- 
-- TABLE: ProductReview 
--

CREATE TABLE ProductReview(
    ProductReviewID    NUMBER(38, 0)      NOT NULL,
    ProductID          NUMBER(38, 0)      NOT NULL,
    ReviewerName       NVARCHAR2(50)      NOT NULL,
    ReviewDate         TIMESTAMP(6)       DEFAULT (getdate()) NOT NULL,
    EmailAddress       NVARCHAR2(50)      NOT NULL,
    Rating             NUMBER(38, 0)      NOT NULL
                       CONSTRAINT CK_ProductReview_Rating CHECK (([Rating]>=(1) AND [Rating]<=(5))),
    Comments           NVARCHAR2(3850),
    ModifiedDate       TIMESTAMP(6)       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductReview_ProductReviewID PRIMARY KEY (ProductReviewID)
)
;



-- 
-- TABLE: ProductSubcategory 
--

CREATE TABLE ProductSubcategory(
    ProductSubcategoryID    NUMBER(38, 0)    NOT NULL,
    ProductCategoryID       NUMBER(38, 0)    NOT NULL,
    Name                    NVARCHAR2(50)    NOT NULL,
    rowguid                 RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate            TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductSubcategory_ProductSubcategoryID PRIMARY KEY (ProductSubcategoryID)
)
;



-- 
-- TABLE: ProductVendor 
--

CREATE TABLE ProductVendor(
    ProductID           NUMBER(38, 0)    NOT NULL,
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    AverageLeadTime     NUMBER(38, 0)    NOT NULL
                        CONSTRAINT CK_ProductVendor_AverageLeadTime CHECK (([AverageLeadTime]>=(1))),
    StandardPrice       NUMBER(19, 4)    NOT NULL
                        CONSTRAINT CK_ProductVendor_StandardPrice CHECK (([StandardPrice]>(0.00))),
    LastReceiptCost     NUMBER(19, 4)    
                        CONSTRAINT CK_ProductVendor_LastReceiptCost CHECK (([LastReceiptCost]>(0.00))),
    LastReceiptDate     TIMESTAMP(6),
    MinOrderQty         NUMBER(38, 0)    NOT NULL
                        CONSTRAINT CK_ProductVendor_MinOrderQty CHECK (([MinOrderQty]>=(1))),
    MaxOrderQty         NUMBER(38, 0)    NOT NULL
                        CONSTRAINT CK_ProductVendor_MaxOrderQty CHECK (([MaxOrderQty]>=(1))),
    OnOrderQty          NUMBER(38, 0)    
                        CONSTRAINT CK_ProductVendor_OnOrderQty CHECK (([OnOrderQty]>=(0))),
    UnitMeasureCode     NCHAR(3)         NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ProductVendor_ProductID_BusinessEntityID PRIMARY KEY (ProductID, BusinessEntityID)
)
;



-- 
-- TABLE: PurchaseOrderDetail 
--

CREATE TABLE PurchaseOrderDetail(
    PurchaseOrderID          NUMBER(38, 0)    NOT NULL,
    PurchaseOrderDetailID    NUMBER(38, 0)    NOT NULL,
    DueDate                  TIMESTAMP(6)     NOT NULL,
    OrderQty                 SMALLINT         NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_OrderQty CHECK (([OrderQty]>(0))),
    ProductID                NUMBER(38, 0)    NOT NULL,
    UnitPrice                NUMBER(19, 4)    NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_UnitPrice CHECK (([UnitPrice]>=(0.00))),
    LineTotal                NUMBER(19, 4)    NOT NULL,
    ReceivedQty              NUMBER(8, 2)     NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_ReceivedQty CHECK (([ReceivedQty]>=(0.00))),
    RejectedQty              NUMBER(8, 2)     NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_RejectedQty CHECK (([RejectedQty]>=(0.00))),
    StockedQty               NUMBER(9, 2)     NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID PRIMARY KEY (PurchaseOrderID, PurchaseOrderDetailID)
)
;



-- 
-- TABLE: PurchaseOrderHeader 
--

CREATE TABLE PurchaseOrderHeader(
    PurchaseOrderID    NUMBER(38, 0)    NOT NULL,
    RevisionNumber     NUMBER(3, 0)     DEFAULT (0) NOT NULL,
    Status             NUMBER(3, 0)     DEFAULT (1) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_Status CHECK (([Status]>=(1) AND [Status]<=(4))),
    EmployeeID         NUMBER(38, 0)    NOT NULL,
    VendorID           NUMBER(38, 0)    NOT NULL,
    ShipMethodID       NUMBER(38, 0)    NOT NULL,
    OrderDate          TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    ShipDate           TIMESTAMP(6),
    SubTotal           NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_SubTotal CHECK (([SubTotal]>=(0.00))),
    TaxAmt             NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_TaxAmt CHECK (([TaxAmt]>=(0.00))),
    Freight            NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_Freight CHECK (([Freight]>=(0.00))),
    TotalDue           NUMBER(19, 4)    NOT NULL,
    ModifiedDate       TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_PurchaseOrderHeader_PurchaseOrderID PRIMARY KEY (PurchaseOrderID)
)
;



-- 
-- TABLE: SalesOrderDetail 
--

CREATE TABLE SalesOrderDetail(
    SalesOrderID             NUMBER(38, 0)    NOT NULL,
    SalesOrderDetailID       NUMBER(38, 0)    NOT NULL,
    CarrierTrackingNumber    NVARCHAR2(25),
    OrderQty                 SMALLINT         NOT NULL
                             CONSTRAINT CK_SalesOrderDetail_OrderQty CHECK (([OrderQty]>(0))),
    ProductID                NUMBER(38, 0)    NOT NULL,
    SpecialOfferID           NUMBER(38, 0)    NOT NULL,
    UnitPrice                NUMBER(19, 4)    NOT NULL
                             CONSTRAINT CK_SalesOrderDetail_UnitPrice CHECK (([UnitPrice]>=(0.00))),
    UnitPriceDiscount        NUMBER(19, 4)    DEFAULT (0.0) NOT NULL
                             CONSTRAINT CK_SalesOrderDetail_UnitPriceDiscount CHECK (([UnitPriceDiscount]>=(0.00))),
    LineTotal                NUMBER(38, 6)    NOT NULL,
    rowguid                  RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID PRIMARY KEY (SalesOrderID, SalesOrderDetailID)
)
;



-- 
-- TABLE: SalesOrderHeader 
--

CREATE TABLE SalesOrderHeader(
    SalesOrderID              NUMBER(38, 0)     NOT NULL,
    RevisionNumber            NUMBER(3, 0)      DEFAULT (0) NOT NULL,
    OrderDate                 TIMESTAMP(6)      DEFAULT (getdate()) NOT NULL,
    DueDate                   TIMESTAMP(6)      NOT NULL,
    ShipDate                  TIMESTAMP(6),
    Status                    NUMBER(3, 0)      DEFAULT (1) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_Status CHECK (([Status]>=(0) AND [Status]<=(8))),
    OnlineOrderFlag           NUMBER(1, 0)      DEFAULT (1) NOT NULL,
    SalesOrderNumber          NVARCHAR2(25)     NOT NULL,
    PurchaseOrderNumber       NVARCHAR2(25),
    AccountNumber             NVARCHAR2(15),
    CustomerID                NUMBER(38, 0)     NOT NULL,
    SalesPersonID             NUMBER(38, 0),
    TerritoryID               NUMBER(38, 0),
    BillToAddressID           NUMBER(38, 0)     NOT NULL,
    ShipToAddressID           NUMBER(38, 0)     NOT NULL,
    ShipMethodID              NUMBER(38, 0)     NOT NULL,
    CreditCardID              NUMBER(38, 0),
    CreditCardApprovalCode    VARCHAR2(15),
    CurrencyRateID            NUMBER(38, 0),
    SubTotal                  NUMBER(19, 4)     DEFAULT (0.00) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_SubTotal CHECK (([SubTotal]>=(0.00))),
    TaxAmt                    NUMBER(19, 4)     DEFAULT (0.00) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_TaxAmt CHECK (([TaxAmt]>=(0.00))),
    Freight                   NUMBER(19, 4)     DEFAULT (0.00) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_Freight CHECK (([Freight]>=(0.00))),
    TotalDue                  NUMBER(19, 4)     NOT NULL,
    Comment                   NVARCHAR2(128),
    rowguid                   RAW(16)           DEFAULT (newid()) NOT NULL,
    ModifiedDate              TIMESTAMP(6)      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesOrderHeader_SalesOrderID PRIMARY KEY (SalesOrderID)
)
;



-- 
-- TABLE: SalesOrderHeaderSalesReason 
--

CREATE TABLE SalesOrderHeaderSalesReason(
    SalesOrderID     NUMBER(38, 0)    NOT NULL,
    SalesReasonID    NUMBER(38, 0)    NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID PRIMARY KEY (SalesOrderID, SalesReasonID)
)
;



-- 
-- TABLE: SalesPerson 
--

CREATE TABLE SalesPerson(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    TerritoryID         NUMBER(38, 0),
    SalesQuota          NUMBER(19, 4)    
                        CONSTRAINT CK_SalesPerson_SalesQuota CHECK (([SalesQuota]>(0.00))),
    Bonus               NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                        CONSTRAINT CK_SalesPerson_Bonus CHECK (([Bonus]>=(0.00))),
    CommissionPct       NUMBER(10, 2)    DEFAULT (0.00) NOT NULL
                        CONSTRAINT CK_SalesPerson_CommissionPct CHECK (([CommissionPct]>=(0.00))),
    SalesYTD            NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                        CONSTRAINT CK_SalesPerson_SalesYTD CHECK (([SalesYTD]>=(0.00))),
    SalesLastYear       NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                        CONSTRAINT CK_SalesPerson_SalesLastYear CHECK (([SalesLastYear]>=(0.00))),
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesPerson_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: SalesPersonQuotaHistory 
--

CREATE TABLE SalesPersonQuotaHistory(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    QuotaDate           TIMESTAMP(6)     NOT NULL,
    SalesQuota          NUMBER(19, 4)    NOT NULL
                        CONSTRAINT CK_SalesPersonQuotaHistory_SalesQuota CHECK (([SalesQuota]>(0.00))),
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate PRIMARY KEY (BusinessEntityID, QuotaDate)
)
;



-- 
-- TABLE: SalesReason 
--

CREATE TABLE SalesReason(
    SalesReasonID    NUMBER(38, 0)    NOT NULL,
    Name             NVARCHAR2(50)    NOT NULL,
    ReasonType       NVARCHAR2(50)    NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesReason_SalesReasonID PRIMARY KEY (SalesReasonID)
)
;



-- 
-- TABLE: SalesTaxRate 
--

CREATE TABLE SalesTaxRate(
    SalesTaxRateID     NUMBER(38, 0)    NOT NULL,
    StateProvinceID    NUMBER(38, 0)    NOT NULL,
    TaxType            NUMBER(3, 0)     NOT NULL
                       CONSTRAINT CK_SalesTaxRate_TaxType CHECK (([TaxType]>=(1) AND [TaxType]<=(3))),
    TaxRate            NUMBER(10, 2)    DEFAULT (0.00) NOT NULL,
    Name               NVARCHAR2(50)    NOT NULL,
    rowguid            RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate       TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesTaxRate_SalesTaxRateID PRIMARY KEY (SalesTaxRateID)
)
;



-- 
-- TABLE: SalesTerritory 
--

CREATE TABLE SalesTerritory(
    TerritoryID          NUMBER(38, 0)    NOT NULL,
    Name                 NVARCHAR2(50)    NOT NULL,
    CountryRegionCode    NVARCHAR2(3)     NOT NULL,
    Group                NVARCHAR2(50)    NOT NULL,
    SalesYTD             NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                         CONSTRAINT CK_SalesTerritory_SalesYTD CHECK (([SalesYTD]>=(0.00))),
    SalesLastYear        NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                         CONSTRAINT CK_SalesTerritory_SalesLastYear CHECK (([SalesLastYear]>=(0.00))),
    CostYTD              NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                         CONSTRAINT CK_SalesTerritory_CostYTD CHECK (([CostYTD]>=(0.00))),
    CostLastYear         NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                         CONSTRAINT CK_SalesTerritory_CostLastYear CHECK (([CostLastYear]>=(0.00))),
    rowguid              RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesTerritory_TerritoryID PRIMARY KEY (TerritoryID)
)
;



-- 
-- TABLE: SalesTerritoryHistory 
--

CREATE TABLE SalesTerritoryHistory(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    TerritoryID         NUMBER(38, 0)    NOT NULL,
    StartDate           TIMESTAMP(6)     NOT NULL,
    EndDate             TIMESTAMP(6),
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID PRIMARY KEY (BusinessEntityID, TerritoryID, StartDate)
)
;



-- 
-- TABLE: ScrapReason 
--

CREATE TABLE ScrapReason(
    ScrapReasonID    SMALLINT         NOT NULL,
    Name             NVARCHAR2(50)    NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ScrapReason_ScrapReasonID PRIMARY KEY (ScrapReasonID)
)
;



-- 
-- TABLE: Shift 
--

CREATE TABLE Shift(
    ShiftID         NUMBER(3, 0)     NOT NULL,
    Name            NVARCHAR2(50)    NOT NULL,
    StartTime       DATE             NOT NULL,
    EndTime         DATE             NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Shift_ShiftID PRIMARY KEY (ShiftID)
)
;



-- 
-- TABLE: ShipMethod 
--

CREATE TABLE ShipMethod(
    ShipMethodID    NUMBER(38, 0)    NOT NULL,
    Name            NVARCHAR2(50)    NOT NULL,
    ShipBase        NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                    CONSTRAINT CK_ShipMethod_ShipBase CHECK (([ShipBase]>(0.00))),
    ShipRate        NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                    CONSTRAINT CK_ShipMethod_ShipRate CHECK (([ShipRate]>(0.00))),
    rowguid         RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ShipMethod_ShipMethodID PRIMARY KEY (ShipMethodID)
)
;



-- 
-- TABLE: ShoppingCartItem 
--

CREATE TABLE ShoppingCartItem(
    ShoppingCartItemID    NUMBER(38, 0)    NOT NULL,
    ShoppingCartID        NVARCHAR2(50)    NOT NULL,
    Quantity              NUMBER(38, 0)    DEFAULT (1) NOT NULL
                          CONSTRAINT CK_ShoppingCartItem_Quantity CHECK (([Quantity]>=(1))),
    ProductID             NUMBER(38, 0)    NOT NULL,
    DateCreated           TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    ModifiedDate          TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_ShoppingCartItem_ShoppingCartItemID PRIMARY KEY (ShoppingCartItemID)
)
;



-- 
-- TABLE: SpecialOffer 
--

CREATE TABLE SpecialOffer(
    SpecialOfferID    NUMBER(38, 0)     NOT NULL,
    Description       NVARCHAR2(255)    NOT NULL,
    DiscountPct       NUMBER(10, 2)     DEFAULT (0.00) NOT NULL
                      CONSTRAINT CK_SpecialOffer_DiscountPct CHECK (([DiscountPct]>=(0.00))),
    Type              NVARCHAR2(50)     NOT NULL,
    Category          NVARCHAR2(50)     NOT NULL,
    StartDate         TIMESTAMP(6)      NOT NULL,
    EndDate           TIMESTAMP(6)      NOT NULL,
    MinQty            NUMBER(38, 0)     DEFAULT (0) NOT NULL
                      CONSTRAINT CK_SpecialOffer_MinQty CHECK (([MinQty]>=(0))),
    MaxQty            NUMBER(38, 0)     
                      CONSTRAINT CK_SpecialOffer_MaxQty CHECK (([MaxQty]>=(0))),
    rowguid           RAW(16)           DEFAULT (newid()) NOT NULL,
    ModifiedDate      TIMESTAMP(6)      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SpecialOffer_SpecialOfferID PRIMARY KEY (SpecialOfferID)
)
;



-- 
-- TABLE: SpecialOfferProduct 
--

CREATE TABLE SpecialOfferProduct(
    SpecialOfferID    NUMBER(38, 0)    NOT NULL,
    ProductID         NUMBER(38, 0)    NOT NULL,
    rowguid           RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate      TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_SpecialOfferProduct_SpecialOfferID_ProductID PRIMARY KEY (SpecialOfferID, ProductID)
)
;



-- 
-- TABLE: StateProvince 
--

CREATE TABLE StateProvince(
    StateProvinceID            NUMBER(38, 0)    NOT NULL,
    StateProvinceCode          NCHAR(3)         NOT NULL,
    CountryRegionCode          NVARCHAR2(3)     NOT NULL,
    IsOnlyStateProvinceFlag    NUMBER(1, 0)     DEFAULT (1) NOT NULL,
    Name                       NVARCHAR2(50)    NOT NULL,
    TerritoryID                NUMBER(38, 0)    NOT NULL,
    rowguid                    RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate               TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_StateProvince_StateProvinceID PRIMARY KEY (StateProvinceID)
)
;



-- 
-- TABLE: Store 
--

CREATE TABLE Store(
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    Name                NVARCHAR2(50)    NOT NULL,
    SalesPersonID       NUMBER(38, 0),
    Demographics        SYS.XMLType,
    rowguid             RAW(16)          DEFAULT (newid()) NOT NULL,
    ModifiedDate        TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Store_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: TransactionHistory 
--

CREATE TABLE TransactionHistory(
    TransactionID           NUMBER(38, 0)    NOT NULL,
    ProductID               NUMBER(38, 0)    NOT NULL,
    ReferenceOrderID        NUMBER(38, 0)    NOT NULL,
    ReferenceOrderLineID    NUMBER(38, 0)    DEFAULT (0) NOT NULL,
    TransactionDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    TransactionType         NCHAR(1)         NOT NULL
                            CONSTRAINT CK_TransactionHistory_TransactionType CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    Quantity                NUMBER(38, 0)    NOT NULL,
    ActualCost              NUMBER(19, 4)    NOT NULL,
    ModifiedDate            TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_TransactionHistory_TransactionID PRIMARY KEY (TransactionID)
)
;



-- 
-- TABLE: TransactionHistoryArchive 
--

CREATE TABLE TransactionHistoryArchive(
    TransactionID           NUMBER(38, 0)    NOT NULL,
    ProductID               NUMBER(38, 0)    NOT NULL,
    ReferenceOrderID        NUMBER(38, 0)    NOT NULL,
    ReferenceOrderLineID    NUMBER(38, 0)    DEFAULT (0) NOT NULL,
    TransactionDate         TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    TransactionType         NCHAR(1)         NOT NULL
                            CONSTRAINT CK_TransactionHistoryArchive_TransactionType CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    Quantity                NUMBER(38, 0)    NOT NULL,
    ActualCost              NUMBER(19, 4)    NOT NULL,
    ModifiedDate            TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_TransactionHistoryArchive_TransactionID PRIMARY KEY (TransactionID)
)
;



-- 
-- TABLE: UnitMeasure 
--

CREATE TABLE UnitMeasure(
    UnitMeasureCode    NCHAR(3)         NOT NULL,
    Name               NVARCHAR2(50)    NOT NULL,
    ModifiedDate       TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_UnitMeasure_UnitMeasureCode PRIMARY KEY (UnitMeasureCode)
)
;



-- 
-- TABLE: Vendor 
--

CREATE TABLE Vendor(
    BusinessEntityID           NUMBER(38, 0)      NOT NULL,
    AccountNumber              NVARCHAR2(15)      NOT NULL,
    Name                       NVARCHAR2(50)      NOT NULL,
    CreditRating               NUMBER(3, 0)       NOT NULL
                               CONSTRAINT CK_Vendor_CreditRating CHECK (([CreditRating]>=(1) AND [CreditRating]<=(5))),
    PreferredVendorStatus      NUMBER(1, 0)       DEFAULT (1) NOT NULL,
    ActiveFlag                 NUMBER(1, 0)       DEFAULT (1) NOT NULL,
    PurchasingWebServiceURL    NVARCHAR2(1024),
    ModifiedDate               TIMESTAMP(6)       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Vendor_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: WorkOrder 
--

CREATE TABLE WorkOrder(
    WorkOrderID      NUMBER(38, 0)    NOT NULL,
    ProductID        NUMBER(38, 0)    NOT NULL,
    OrderQty         NUMBER(38, 0)    NOT NULL
                     CONSTRAINT CK_WorkOrder_OrderQty CHECK (([OrderQty]>(0))),
    StockedQty       NUMBER(38, 0)    NOT NULL,
    ScrappedQty      SMALLINT         NOT NULL
                     CONSTRAINT CK_WorkOrder_ScrappedQty CHECK (([ScrappedQty]>=(0))),
    StartDate        TIMESTAMP(6)     NOT NULL,
    EndDate          TIMESTAMP(6),
    DueDate          TIMESTAMP(6)     NOT NULL,
    ScrapReasonID    SMALLINT,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_WorkOrder_WorkOrderID PRIMARY KEY (WorkOrderID)
)
;



-- 
-- TABLE: WorkOrderRouting 
--

CREATE TABLE WorkOrderRouting(
    WorkOrderID           NUMBER(38, 0)    NOT NULL,
    ProductID             NUMBER(38, 0)    NOT NULL,
    OperationSequence     SMALLINT         NOT NULL,
    LocationID            SMALLINT         NOT NULL,
    ScheduledStartDate    TIMESTAMP(6)     NOT NULL,
    ScheduledEndDate      TIMESTAMP(6)     NOT NULL,
    ActualStartDate       TIMESTAMP(6),
    ActualEndDate         TIMESTAMP(6),
    ActualResourceHrs     NUMBER(9, 4)     
                          CONSTRAINT CK_WorkOrderRouting_ActualResourceHrs CHECK (([ActualResourceHrs]>=(0.0000))),
    PlannedCost           NUMBER(19, 4)    NOT NULL
                          CONSTRAINT CK_WorkOrderRouting_PlannedCost CHECK (([PlannedCost]>(0.00))),
    ActualCost            NUMBER(19, 4)    
                          CONSTRAINT CK_WorkOrderRouting_ActualCost CHECK (([ActualCost]>(0.00))),
    ModifiedDate          TIMESTAMP(6)     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence PRIMARY KEY (WorkOrderID, ProductID, OperationSequence)
)
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


