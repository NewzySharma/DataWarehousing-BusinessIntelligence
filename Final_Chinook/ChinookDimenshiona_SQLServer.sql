/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      ChinookPM_SQLServer.DM1
 *
 * Date Created : Wednesday, September 25, 2019 21:09:31
 * Target DBMS : Microsoft SQL Server 2017
 */

/* 
 * TABLE: Album 
 */

CREATE TABLE Album(
    AlbumId     int              NOT NULL,
    Title       nvarchar(160)    NOT NULL,
    ArtistId    int              NOT NULL,
    CONSTRAINT PK_Album PRIMARY KEY NONCLUSTERED (AlbumId)
)
go



IF OBJECT_ID('Album') IS NOT NULL
    PRINT '<<< CREATED TABLE Album >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Album >>>'
go

/* 
 * TABLE: Artist 
 */

CREATE TABLE Artist(
    ArtistId    int              NOT NULL,
    Name        nvarchar(120)    NULL,
    CONSTRAINT PK_Artist PRIMARY KEY NONCLUSTERED (ArtistId)
)
go



IF OBJECT_ID('Artist') IS NOT NULL
    PRINT '<<< CREATED TABLE Artist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Artist >>>'
go

/* 
 * TABLE: Customer 
 */

CREATE TABLE Customer(
    CustomerId       int             NOT NULL,
    FirstName        nvarchar(40)    NOT NULL,
    LastName         nvarchar(20)    NOT NULL,
    Company          nvarchar(80)    NULL,
    Phone            nvarchar(24)    NULL,
    Fax              nvarchar(24)    NULL,
    Email            nvarchar(60)    NOT NULL,
    SupportRepId     int             NULL,
    LocationId_sk    int             NULL,
    CONSTRAINT PK_Customer PRIMARY KEY NONCLUSTERED (CustomerId)
)
go



IF OBJECT_ID('Customer') IS NOT NULL
    PRINT '<<< CREATED TABLE Customer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Customer >>>'
go

/* 
 * TABLE: DateDim 
 */

CREATE TABLE DateDim(
    DateKey_sk        int            NOT NULL,
    Date_nk           date           NOT NULL,
    State             varchar(18)    NOT NULL,
    Day               tinyint        NOT NULL,
    WeekDay           tinyint        NOT NULL,
    PostalCode        varchar(10)    NOT NULL,
    DayOfMonth        tinyint        NOT NULL,
    DayOfYear         smallint       NOT NULL,
    WeekOfMonth       tinyint        NOT NULL,
    WeekOfYear        tinyint        NOT NULL,
    Month             tinyint        NOT NULL,
    MonthName         varchar(10)    NOT NULL,
    Year              int            NOT NULL,
    MMYYYY            char(6)        NOT NULL,
    IsWeekend         bit            NULL,
    Quarter           tinyint        NULL,
    QuarterOfMonth    tinyint        NULL,
    QuarterOfYear     tinyint        NOT NULL,
    CONSTRAINT PK_Invoice_1_1 PRIMARY KEY NONCLUSTERED (DateKey_sk)
)
go



IF OBJECT_ID('DateDim') IS NOT NULL
    PRINT '<<< CREATED TABLE DateDim >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DateDim >>>'
go

/* 
 * TABLE: Employee 
 */

CREATE TABLE Employee(
    EmployeeId       int             NOT NULL,
    LastName         nvarchar(20)    NOT NULL,
    FirstName        nvarchar(20)    NOT NULL,
    Title            nvarchar(30)    NULL,
    ReportsTo        int             NULL,
    BirthDate        datetime        NULL,
    HireDate         datetime        NULL,
    Phone            nvarchar(24)    NULL,
    Fax              nvarchar(24)    NULL,
    Email            nvarchar(60)    NULL,
    LocationId_sk    int             NULL,
    CONSTRAINT PK_Employee PRIMARY KEY NONCLUSTERED (EmployeeId)
)
go



IF OBJECT_ID('Employee') IS NOT NULL
    PRINT '<<< CREATED TABLE Employee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Employee >>>'
go

/* 
 * TABLE: Genre 
 */

CREATE TABLE Genre(
    GenreId    int              NOT NULL,
    Name       nvarchar(120)    NULL,
    CONSTRAINT PK_Genre PRIMARY KEY NONCLUSTERED (GenreId)
)
go



IF OBJECT_ID('Genre') IS NOT NULL
    PRINT '<<< CREATED TABLE Genre >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Genre >>>'
go

/* 
 * TABLE: Invoice 
 */

CREATE TABLE Invoice(
    InvoiceId        int         NOT NULL,
    CustomerId       int         NOT NULL,
    InvoiceDate      datetime    NOT NULL,
    LocationId_sk    int         NULL,
    CONSTRAINT PK_Invoice PRIMARY KEY NONCLUSTERED (InvoiceId)
)
go



IF OBJECT_ID('Invoice') IS NOT NULL
    PRINT '<<< CREATED TABLE Invoice >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Invoice >>>'
go

/* 
 * TABLE: Location 
 */

CREATE TABLE Location(
    LocationId_sk    int             NOT NULL,
    Country          varchar(18)     NOT NULL,
    State            varchar(18)     NOT NULL,
    City             nvarchar(70)    NULL,
    Address          nvarchar(40)    NULL,
    PostalCode       nvarchar(10)    NULL,
    CONSTRAINT PK_Invoice_1 PRIMARY KEY NONCLUSTERED (LocationId_sk)
)
go



IF OBJECT_ID('Location') IS NOT NULL
    PRINT '<<< CREATED TABLE Location >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Location >>>'
go

/* 
 * TABLE: MediaType 
 */

CREATE TABLE MediaType(
    MediaTypeId    int              NOT NULL,
    Name           nvarchar(120)    NULL,
    CONSTRAINT PK_MediaType PRIMARY KEY NONCLUSTERED (MediaTypeId)
)
go



IF OBJECT_ID('MediaType') IS NOT NULL
    PRINT '<<< CREATED TABLE MediaType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MediaType >>>'
go

/* 
 * TABLE: Playlist 
 */

CREATE TABLE Playlist(
    PlaylistId    int              NOT NULL,
    Name          nvarchar(120)    NULL,
    CONSTRAINT PK_Playlist PRIMARY KEY NONCLUSTERED (PlaylistId)
)
go



IF OBJECT_ID('Playlist') IS NOT NULL
    PRINT '<<< CREATED TABLE Playlist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Playlist >>>'
go

/* 
 * TABLE: Track_fact 
 */

CREATE TABLE Track_fact(
    TrackId         int               NOT NULL,
    DateKey_sk      int               NOT NULL,
    Quantity        numeric(10, 0)    NOT NULL,
    Total           numeric(10, 0)    NOT NULL,
    Name            nvarchar(200)     NOT NULL,
    AlbumId         int               NULL,
    MediaTypeId     int               NOT NULL,
    GenreId         int               NULL,
    Composer        nvarchar(220)     NULL,
    Milliseconds    int               NOT NULL,
    Bytes           int               NULL,
    UnitPrice       numeric(10, 2)    NOT NULL,
    PlaylistId      int               NOT NULL,
    InvoiceId       int               NOT NULL,
    CustomerId      int               NOT NULL,
    EmployeeId      int               NULL,
    CONSTRAINT PK_Track PRIMARY KEY NONCLUSTERED (TrackId)
)
go



IF OBJECT_ID('Track_fact') IS NOT NULL
    PRINT '<<< CREATED TABLE Track_fact >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Track_fact >>>'
go

/* 
 * TABLE: Album 
 */

ALTER TABLE Album ADD CONSTRAINT FK_AlbumArtistId 
    FOREIGN KEY (ArtistId)
    REFERENCES Artist(ArtistId)
go


/* 
 * TABLE: Customer 
 */

ALTER TABLE Customer ADD CONSTRAINT RefLocation14 
    FOREIGN KEY (LocationId_sk)
    REFERENCES Location(LocationId_sk)
go

ALTER TABLE Customer ADD CONSTRAINT FK_CustomerSupportRepId 
    FOREIGN KEY (SupportRepId)
    REFERENCES Employee(EmployeeId)
go


/* 
 * TABLE: Employee 
 */

ALTER TABLE Employee ADD CONSTRAINT RefLocation13 
    FOREIGN KEY (LocationId_sk)
    REFERENCES Location(LocationId_sk)
go

ALTER TABLE Employee ADD CONSTRAINT FK_EmployeeReportsTo 
    FOREIGN KEY (ReportsTo)
    REFERENCES Employee(EmployeeId)
go


/* 
 * TABLE: Invoice 
 */

ALTER TABLE Invoice ADD CONSTRAINT RefLocation15 
    FOREIGN KEY (LocationId_sk)
    REFERENCES Location(LocationId_sk)
go

ALTER TABLE Invoice ADD CONSTRAINT FK_InvoiceCustomerId 
    FOREIGN KEY (CustomerId)
    REFERENCES Customer(CustomerId)
go


/* 
 * TABLE: Track_fact 
 */

ALTER TABLE Track_fact ADD CONSTRAINT RefDateDim12 
    FOREIGN KEY (DateKey_sk)
    REFERENCES DateDim(DateKey_sk)
go

ALTER TABLE Track_fact ADD CONSTRAINT RefPlaylist16 
    FOREIGN KEY (PlaylistId)
    REFERENCES Playlist(PlaylistId)
go

ALTER TABLE Track_fact ADD CONSTRAINT RefInvoice17 
    FOREIGN KEY (InvoiceId)
    REFERENCES Invoice(InvoiceId)
go

ALTER TABLE Track_fact ADD CONSTRAINT RefCustomer18 
    FOREIGN KEY (CustomerId)
    REFERENCES Customer(CustomerId)
go

ALTER TABLE Track_fact ADD CONSTRAINT RefEmployee19 
    FOREIGN KEY (EmployeeId)
    REFERENCES Employee(EmployeeId)
go

ALTER TABLE Track_fact ADD CONSTRAINT FK_TrackAlbumId 
    FOREIGN KEY (AlbumId)
    REFERENCES Album(AlbumId)
go

ALTER TABLE Track_fact ADD CONSTRAINT FK_TrackGenreId 
    FOREIGN KEY (GenreId)
    REFERENCES Genre(GenreId)
go

ALTER TABLE Track_fact ADD CONSTRAINT FK_TrackMediaTypeId 
    FOREIGN KEY (MediaTypeId)
    REFERENCES MediaType(MediaTypeId)
go


