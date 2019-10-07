--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      ChinookPM_Oracle.DM1
--
-- Date Created : Wednesday, September 25, 2019 21:15:37
-- Target DBMS : Oracle 12c
--

-- 
-- TABLE: Album 
--

CREATE TABLE Album(
    AlbumId     NUMBER(38, 0)     NOT NULL,
    Title       NVARCHAR2(160)    NOT NULL,
    ArtistId    NUMBER(38, 0)     NOT NULL,
    CONSTRAINT PK_Album PRIMARY KEY (AlbumId)
)
;



-- 
-- TABLE: Artist 
--

CREATE TABLE Artist(
    ArtistId    NUMBER(38, 0)     NOT NULL,
    Name        NVARCHAR2(120),
    CONSTRAINT PK_Artist PRIMARY KEY (ArtistId)
)
;



-- 
-- TABLE: Customer 
--

CREATE TABLE Customer(
    CustomerId       NUMBER(38, 0)    NOT NULL,
    FirstName        NVARCHAR2(40)    NOT NULL,
    LastName         NVARCHAR2(20)    NOT NULL,
    Company          NVARCHAR2(80),
    Phone            NVARCHAR2(24),
    Fax              NVARCHAR2(24),
    Email            NVARCHAR2(60)    NOT NULL,
    SupportRepId     NUMBER(38, 0),
    LocationId_sk    NUMBER(38, 0),
    CONSTRAINT PK_Customer PRIMARY KEY (CustomerId)
)
;



-- 
-- TABLE: DateDim 
--

CREATE TABLE DateDim(
    DateKey_sk        NUMBER(38, 0)    NOT NULL,
    Date_nk           DATE             NOT NULL,
    State             VARCHAR2(18)     NOT NULL,
    Day               NUMBER(3, 0)     NOT NULL,
    WeekDay           NUMBER(3, 0)     NOT NULL,
    PostalCode        VARCHAR2(10)     NOT NULL,
    DayOfMonth        NUMBER(3, 0)     NOT NULL,
    DayOfYear         SMALLINT         NOT NULL,
    WeekOfMonth       NUMBER(3, 0)     NOT NULL,
    WeekOfYear        NUMBER(3, 0)     NOT NULL,
    Month             NUMBER(3, 0)     NOT NULL,
    MonthName         VARCHAR2(10)     NOT NULL,
    Year              NUMBER(38, 0)    NOT NULL,
    MMYYYY            CHAR(6)          NOT NULL,
    IsWeekend         NUMBER(1, 0),
    Quarter           NUMBER(3, 0),
    QuarterOfMonth    NUMBER(3, 0),
    QuarterOfYear     NUMBER(3, 0)     NOT NULL,
    CONSTRAINT PK_Invoice_1_1 PRIMARY KEY (DateKey_sk)
)
;



-- 
-- TABLE: Employee 
--

CREATE TABLE Employee(
    EmployeeId       NUMBER(38, 0)    NOT NULL,
    LastName         NVARCHAR2(20)    NOT NULL,
    FirstName        NVARCHAR2(20)    NOT NULL,
    Title            NVARCHAR2(30),
    ReportsTo        NUMBER(38, 0),
    BirthDate        TIMESTAMP(6),
    HireDate         TIMESTAMP(6),
    Phone            NVARCHAR2(24),
    Fax              NVARCHAR2(24),
    Email            NVARCHAR2(60),
    LocationId_sk    NUMBER(38, 0),
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeId)
)
;



-- 
-- TABLE: Genre 
--

CREATE TABLE Genre(
    GenreId    NUMBER(38, 0)     NOT NULL,
    Name       NVARCHAR2(120),
    CONSTRAINT PK_Genre PRIMARY KEY (GenreId)
)
;



-- 
-- TABLE: Invoice 
--

CREATE TABLE Invoice(
    InvoiceId        NUMBER(38, 0)    NOT NULL,
    CustomerId       NUMBER(38, 0)    NOT NULL,
    InvoiceDate      TIMESTAMP(6)     NOT NULL,
    LocationId_sk    NUMBER(38, 0),
    CONSTRAINT PK_Invoice PRIMARY KEY (InvoiceId)
)
;



-- 
-- TABLE: Location 
--

CREATE TABLE Location(
    LocationId_sk    NUMBER(38, 0)    NOT NULL,
    Country          VARCHAR2(18)     NOT NULL,
    State            VARCHAR2(18)     NOT NULL,
    City             NVARCHAR2(70),
    Address          NVARCHAR2(40),
    PostalCode       NVARCHAR2(10),
    CONSTRAINT PK_Invoice_1 PRIMARY KEY (LocationId_sk)
)
;



-- 
-- TABLE: MediaType 
--

CREATE TABLE MediaType(
    MediaTypeId    NUMBER(38, 0)     NOT NULL,
    Name           NVARCHAR2(120),
    CONSTRAINT PK_MediaType PRIMARY KEY (MediaTypeId)
)
;



-- 
-- TABLE: Playlist 
--

CREATE TABLE Playlist(
    PlaylistId    NUMBER(38, 0)     NOT NULL,
    Name          NVARCHAR2(120),
    CONSTRAINT PK_Playlist PRIMARY KEY (PlaylistId)
)
;



-- 
-- TABLE: Track_fact 
--

CREATE TABLE Track_fact(
    TrackId         NUMBER(38, 0)     NOT NULL,
    DateKey_sk      NUMBER(38, 0)     NOT NULL,
    Quantity        NUMBER(10, 0)     NOT NULL,
    Total           NUMBER(10, 0)     NOT NULL,
    Name            NVARCHAR2(200)    NOT NULL,
    AlbumId         NUMBER(38, 0),
    MediaTypeId     NUMBER(38, 0)     NOT NULL,
    GenreId         NUMBER(38, 0),
    Composer        NVARCHAR2(220),
    Milliseconds    NUMBER(38, 0)     NOT NULL,
    Bytes           NUMBER(38, 0),
    UnitPrice       NUMBER(10, 2)     NOT NULL,
    PlaylistId      NUMBER(38, 0)     NOT NULL,
    InvoiceId       NUMBER(38, 0)     NOT NULL,
    CustomerId      NUMBER(38, 0)     NOT NULL,
    EmployeeId      NUMBER(38, 0),
    CONSTRAINT PK_Track PRIMARY KEY (TrackId)
)
;



-- 
-- TABLE: Album 
--

ALTER TABLE Album ADD CONSTRAINT FK_AlbumArtistId 
    FOREIGN KEY (ArtistId)
    REFERENCES Artist(ArtistId)
;


-- 
-- TABLE: Customer 
--

ALTER TABLE Customer ADD CONSTRAINT RefLocation14 
    FOREIGN KEY (LocationId_sk)
    REFERENCES Location(LocationId_sk)
;

ALTER TABLE Customer ADD CONSTRAINT FK_CustomerSupportRepId 
    FOREIGN KEY (SupportRepId)
    REFERENCES Employee(EmployeeId)
;


-- 
-- TABLE: Employee 
--

ALTER TABLE Employee ADD CONSTRAINT RefLocation13 
    FOREIGN KEY (LocationId_sk)
    REFERENCES Location(LocationId_sk)
;

ALTER TABLE Employee ADD CONSTRAINT FK_EmployeeReportsTo 
    FOREIGN KEY (ReportsTo)
    REFERENCES Employee(EmployeeId)
;


-- 
-- TABLE: Invoice 
--

ALTER TABLE Invoice ADD CONSTRAINT RefLocation15 
    FOREIGN KEY (LocationId_sk)
    REFERENCES Location(LocationId_sk)
;

ALTER TABLE Invoice ADD CONSTRAINT FK_InvoiceCustomerId 
    FOREIGN KEY (CustomerId)
    REFERENCES Customer(CustomerId)
;


-- 
-- TABLE: Track_fact 
--

ALTER TABLE Track_fact ADD CONSTRAINT RefDateDim12 
    FOREIGN KEY (DateKey_sk)
    REFERENCES DateDim(DateKey_sk)
;

ALTER TABLE Track_fact ADD CONSTRAINT RefPlaylist16 
    FOREIGN KEY (PlaylistId)
    REFERENCES Playlist(PlaylistId)
;

ALTER TABLE Track_fact ADD CONSTRAINT RefInvoice17 
    FOREIGN KEY (InvoiceId)
    REFERENCES Invoice(InvoiceId)
;

ALTER TABLE Track_fact ADD CONSTRAINT RefCustomer18 
    FOREIGN KEY (CustomerId)
    REFERENCES Customer(CustomerId)
;

ALTER TABLE Track_fact ADD CONSTRAINT RefEmployee19 
    FOREIGN KEY (EmployeeId)
    REFERENCES Employee(EmployeeId)
;

ALTER TABLE Track_fact ADD CONSTRAINT FK_TrackAlbumId 
    FOREIGN KEY (AlbumId)
    REFERENCES Album(AlbumId)
;

ALTER TABLE Track_fact ADD CONSTRAINT FK_TrackGenreId 
    FOREIGN KEY (GenreId)
    REFERENCES Genre(GenreId)
;

ALTER TABLE Track_fact ADD CONSTRAINT FK_TrackMediaTypeId 
    FOREIGN KEY (MediaTypeId)
    REFERENCES MediaType(MediaTypeId)
;


