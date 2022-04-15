Use library5
GO

CREATE TABLE PUBLISHER(
	ID_publisher INT PRIMARY KEY,
	Name varchar(50) not null,
	Phone INT,
	Email varchar(50),
	Address varchar(100),
) 

GO

CREATE TABLE BOOKS(
	ID_Book INT PRIMARY KEY,
	Name	varchar(50) not null,
	ID_publisher INT  not null,
	Type	varchar(20),
	Description TEXT,
	Update_day DATE,
	N_books INT not null default 0,
	price int not null,
	foreign key(ID_publisher) References PUBLISHER(ID_publisher)
	ON UPDATE CASCADE
	ON DELETE SET NULL

)

GO

CREATE TABLE A_BOOK(
	ID_Abook	INT PRIMARY KEY,
	ID_Book		INT not null,
	Pos_shelf	varchar(10),
	Pos_row		char(10),
	Pos_column	char(10),
	Current_status_B char(10),
	Check_borrow bit not null default 1,
	foreign key(ID_Book) References BOOKS(ID_Book)
	ON UPDATE CASCADE
	ON DELETE SET NULL
)

GO 

CREATE TABLE AUTHOR(
	ID_author INT PRIMARY KEY,
	Name varchar(50),
	Phone INT,
	Address varchar(70)
)

GO

CREATE TABLE AUTHOR_BOOKS(
	ID_Book INT ,
	ID_Author INT,
	foreign key(ID_Book) References BOOKS(ID_Book),
	foreign key(ID_Author) References AUTHOR(ID_Author),
)

GO

CREATE TABLE READER(
	ID_rd INT PRIMARY KEY,
	Name varchar(50),
	Birthday datetime,
	Gender Varchar(10),
	CCCD int,
	Phone int,
	Address Varchar(300),
	N_books_br int not null default 0
	
)

GO

CREATE TABLE Borrow_book(
     ID_rd int not null,
	 ID_Abook int unique not null,
     Borrowed_date datetime default (getdate()) not null,
	 Estimated_date datetime not null default (dateadd(week,2,getdate())),
	 Primary key (ID_Abook, ID_rd),
	 foreign key( ID_Abook) References A_BooK( ID_Abook),
	 foreign key(ID_rd) References READER(ID_rd),
	 ON UPDATE CASCADE
)

GO

CREATE TABLE Return_book(
	 ID_rd int not null,
	 ID_Abook int unique not null,
	 Returned_date datetime default (getdate())  not null,
	 Extra_fee int default 0,
	 Current_status bit not null,
	 Loss_book bit not null,
	 foreign key( ID_Abook, ID_rd) References Borrow_book( ID_Abook, ID_rd)
	 ON UPDATE CASCADE
	 ON DELETE SET NULL

)