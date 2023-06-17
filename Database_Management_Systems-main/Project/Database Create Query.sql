-- - Date : 09-JAN-90 (DD-MON-YY)
CREATE TABLE LOGIN(
    userId VARCHAR2(10),
    userName VARCHAR2(30),
    passwd VARCHAR2(20),
    accountType VARCHAR2(8) CONSTRAINT CK_LOGIN_AccountType CHECK(accountType IN ('Staff','Member')),
    accountStatus NUMBER CONSTRAINT CK_LOGIN_AccountStatus CHECK(accountStatus IN(1,0)), -- - 0 for unblock, 1 for block
    CONSTRAINT PK_LOGIN_UserID PRIMARY KEY(userId)
);

CREATE TABLE ADDRESS(
    MemberID VARCHAR2(10),
    Street VARCHAR2(10),
    City VARCHAR2(10),
    Pincode NUMBER(10),
    CONSTRAINT Pk_ADDRESS_MemberID PRIMARY KEY(MemberID) 
);


CREATE TABLE MEMBER (
    MemberID VARCHAR2(10) CONSTRAINT PK_MEMBER_MemberID PRIMARY KEY,
    memberName VARCHAR2(30) CONSTRAINT NN_MEMBER_MemberName NOT NULL,
    dob DATE,
    phoneNo NUMBER(10),
    mailid VARCHAR2(30) CONSTRAINT NN_MEMBER_MailID NOT NULL,
    membershipStatus NUMBER CONSTRAINT CK_MEMBER_MembershipStatus CHECK(membershipStatus IN (0, 1)),-- - 0 for normal, 1 for Pro.
    CONSTRAINT FK_MEMBERtoADDRESS_MemberID FOREIGN KEY (MemberID) REFERENCES ADDRESS(MemberID),
    CONSTRAINT FK_MEMBERtoLOGIN_MemberID FOREIGN KEY (MemberID) REFERENCES LOGIN(userId)
);


CREATE TABLE STAFF(
    StaffID VARCHAR2(10) CONSTRAINT PK_STAFF_MemberID PRIMARY KEY,
    staffName VARCHAR2(30) CONSTRAINT NN_STAFF_MemberName NOT NULL,
    phoneNo NUMBER(10),
    mailid VARCHAR2(30) CONSTRAINT NN_STAFF_MailID NOT NULL,
    position VARCHAR2(10),
    salary NUMBER(10),
    dateofjoin DATE,
    CONSTRAINT FK_STAFF_StaffID FOREIGN KEY (StaffID) REFERENCES LOGIN(userId)
);


CREATE TABLE BOOKS(
    BookID VARCHAR2(10) CONSTRAINT PK_BOOKS_BookID PRIMARY KEY,
    title VARCHAR2(30) CONSTRAINT NN_BOOKS_Title NOT NULL,
    author VARCHAR2(30) CONSTRAINT NN_BOOKS_Author NOT NULL,
    desciption VARCHAR2(150),
    isbn NUMBER(10) CONSTRAINT NN_BOOKS_ISBN NOT NULL,
    publisher VARCHAR2(30),
    publisherDate DATE,
    lang VARCHAR2(20) CONSTRAINT NN_BOOKS_Language NOT NULL,
    availabilityStatus NUMBER CONSTRAINT CK_BOOKS_AvailabilityStatus CHECK(availabilityStatus IN (0, 1))-- - 0 for available, 1 for not available.
);

CREATE TABLE STAFF_TRANSACTION (
    TransactionID VARCHAR2(10) CONSTRAINT PK_STAFF_TRANSACTION_TransactionID PRIMARY KEY,
    BookID VARCHAR2(10),
    StaffID VARCHAR2(10),
    transactionDate DATE,
    transactionType VARCHAR2(10) CONSTRAINT CK_STAFF_TRANSACTION_TransactionType CHECK(transactionType IN('ADD','DELETE')),
    transactionDetails VARCHAR2(150),
    CONSTRAINT fk_STAFF_TRANSACTION_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID),
    CONSTRAINT fk_STAFF_TRANSACTION_StaffID FOREIGN KEY (StaffID) REFERENCES STAFF(StaffID)
);

CREATE TABLE MEMBER_TRANSACTION (
    MemberID VARCHAR2(10),
    StaffID VARCHAR2(10),
    BookID VARCHAR2(10),
    transactionDate DATE,
    dueDate DATE,
    fine NUMBER(10),
    CONSTRAINT PK_MEMBER_TRANSACTION PRIMARY KEY (BookID,StaffID,MemberID),
    CONSTRAINT fk_MEMBER_TRANSACTION_MemberID FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID),
    CONSTRAINT fk_MEMBER_TRANSACTION_StaffID FOREIGN KEY (StaffID) REFERENCES STAFF(StaffID),
    CONSTRAINT fk_MEMBER_TRANSACTION_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID)
);

CREATE TABLE TRANSACTION_RECORD (
    TransactionID VARCHAR2(10) CONSTRAINT PK_TRANSACTION_RECORD_TransactionID PRIMARY KEY,
    MemberID VARCHAR2(10),
    BookID VARCHAR2(10),
    transactionDate DATE,
    transactionType VARCHAR2(10) CONSTRAINT CK_TRANSACTION_RECORD_TransactionType CHECK(transactionType IN('BORROW','RETURN','RENEW')),
    CONSTRAINT fk_TRANSACTION_RECORD_MemberID FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID),
    CONSTRAINT fk_TRANSACTION_RECORD_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID)
);

DROP TABLE TRANSACTION_RECORD;
DROP TABLE MEMBER_TRANSACTION;
DROP TABLE STAFF_TRANSACTION;
DROP TABLE BOOKS;
DROP TABLE STAFF;
DROP TABLE MEMBER;
DROP TABLE ADDRESS;
DROP TABLE LOGIN;

-- LOGIN
INSERT INTO LOGIN (userId, userName, passwd, accountType, accountStatus)
VALUES ('U001', 'John Doe', 'password123', 'Member', 0);
INSERT INTO LOGIN (userId, userName, passwd, accountType, accountStatus)
VALUES ('S001', 'Jane Smith', 'staff123', 'Staff', 0);

-- ADDRESS
INSERT INTO ADDRESS (MemberID, Street, City, Pincode)
VALUES ('U001', 'Main St', 'Cityville', 12345);

-- MEMBER
INSERT INTO MEMBER (MemberID, memberName, dob, phoneNo, mailid, membershipStatus)
VALUES ('U001', 'John Doe', '09-JAN-90', 1234567890, 'john.doe@example.com', 1);

-- STAFF
INSERT INTO STAFF (StaffID, staffName, phoneNo, mailid, position, salary, dateofjoin)
VALUES ('S001', 'Jane Smith', 9876543210, 'jane.smith@example.com', 'Manager', 5000, '12-JUN-22');

-- BOOKS
INSERT INTO BOOKS (BookID, title, author, desciption, isbn, publisher, publisherDate, lang, availabilityStatus)
VALUES ('B001', 'The Great Gatsby', 'F. Scott Fitzgerald', 'A classic novel', 1234567890, 'Penguin Books', '20-APR-20', 'English', 1);

-- STAFF_TRANSACTION
INSERT INTO STAFF_TRANSACTION (TransactionID, BookID, StaffID, transactionDate, transactionType, transactionDetails)
VALUES ('T001', 'B001', 'S001', '01-FEB-22', 'ADD', 'new book');

-- MEMBER_TRANSACTION
INSERT INTO MEMBER_TRANSACTION (MemberID, StaffID, BookID, transactionDate, dueDate, fine)
VALUES ('U001', 'S001', 'B001', '02-MAR-22', '02-APR-22', 0);

-- TRANSACTION_RECORD
INSERT INTO TRANSACTION_RECORD (TransactionID, MemberID, BookID, transactionDate, transactionType)
VALUES ('T001', 'U001', 'B001', '02-APR-22', 'BORROW');


