select * from Logint;
select * from ADDRESS;
select * from MEMBER;
select * from STAFF;
select * from BOOKS;
select * from  STAFF_TRANSACTION;
select * from MEMBER_TRANSACTION ;
select * from TRANSACTION_RECORD;

DROP TABLE TRANSACTION_RECORD;
DROP TABLE MEMBER_TRANSACTION;
DROP TABLE STAFF_TRANSACTION;
DROP TABLE BOOKS;
DROP TABLE STAFF;
DROP TABLE MEMBER;
DROP TABLE ADDRESS;
DROP TABLE LOGINT;

CREATE TABLE LoginRecord(
    userId VARCHAR2(40),
    userName VARCHAR2(50)
);
CREATE TABLE LOGINT(
    userId VARCHAR2(40),
    userName VARCHAR2(50),
    passwd VARCHAR2(60),
    accountType VARCHAR2(8) CONSTRAINT CK_LOGINT_AccountType CHECK(accountType IN ('Staff','Member')),
    accountStatus NUMBER CONSTRAINT CK_LOGINT_AccountStatus CHECK(accountStatus IN(1,0)), -- - 0 for unblock, 1 for block
    CONSTRAINT PK_LOGINT_UserID PRIMARY KEY(userId)
);

CREATE TABLE ADDRESS(
    MemberID VARCHAR2(5),
    Street VARCHAR2(40),
    City VARCHAR2(40),
    Pincode NUMBER(35),
    CONSTRAINT Pk_ADDRESS_MemberID PRIMARY KEY(MemberID) 
);


CREATE TABLE MEMBER (
    MemberID VARCHAR2(5) CONSTRAINT PK_MEMBER_MemberID PRIMARY KEY,
    memberName VARCHAR2(50) CONSTRAINT NN_MEMBER_MemberName NOT NULL,
    dob VARCHAR2(12),
    phoneNo NUMBER(35),
    mailid VARCHAR2(50) CONSTRAINT NN_MEMBER_MailID NOT NULL,
    membershipStatus NUMBER CONSTRAINT CK_MEMBER_MembershipStatus CHECK(membershipStatus IN (0, 1)),-- - 0 for normal, 1 for Pro.
    CONSTRAINT FK_MEMBERtoADDRESS_MemberID FOREIGN KEY (MemberID) REFERENCES ADDRESS(MemberID),
    CONSTRAINT FK_MEMBERtoLOGINT_MemberID FOREIGN KEY (MemberID) REFERENCES LOGINT(userId)
);


CREATE TABLE STAFF(
    StaffID VARCHAR2(5) CONSTRAINT PK_STAFF_MemberID PRIMARY KEY,
    staffName VARCHAR2(50) CONSTRAINT NN_STAFF_MemberName NOT NULL,
    phoneNo NUMBER(35),
    mailid VARCHAR2(50) CONSTRAINT NN_STAFF_MailID NOT NULL,
    position VARCHAR2(40),
    salary NUMBER(35),
    dateofjoin VARCHAR2(12),
    CONSTRAINT FK_STAFF_StaffID FOREIGN KEY (StaffID) REFERENCES LOGINT(userId)
);


CREATE TABLE BOOKS(
    BookID VARCHAR2(5) CONSTRAINT PK_BOOKS_BookID PRIMARY KEY,
    title VARCHAR2(50) CONSTRAINT NN_BOOKS_Title NOT NULL,
    author VARCHAR2(50) CONSTRAINT NN_BOOKS_Author NOT NULL,
    desciption VARCHAR2(350),
    isbn NUMBER(35) CONSTRAINT NN_BOOKS_ISBN NOT NULL,
    publisher VARCHAR2(50),
    publisherDate VARCHAR2(12),
    lang VARCHAR2(60) CONSTRAINT NN_BOOKS_Language NOT NULL,
    availabilityStatus NUMBER CONSTRAINT CK_BOOKS_AvailabilityStatus CHECK(availabilityStatus IN (0, 1))-- - 0 for available, 1 for not available.
);

CREATE TABLE STAFF_TRANSACTION (
    TransactionID VARCHAR2(5) CONSTRAINT PK_STAFF_TRANSACTION_TransactionID PRIMARY KEY,
    BookID VARCHAR2(5),
    StaffID VARCHAR2(5),
    transactionDate VARCHAR2(12),
    transactionType VARCHAR2(10) CONSTRAINT CK_STAFF_TRANSACTION_TransactionType CHECK(transactionType IN('ADD','DELETE')),
    transactionDetails VARCHAR2(350),
    CONSTRAINT fk_STAFF_TRANSACTION_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID),
    CONSTRAINT fk_STAFF_TRANSACTION_StaffID FOREIGN KEY (StaffID) REFERENCES STAFF(StaffID)
);

CREATE TABLE MEMBER_TRANSACTION (
    MemberID VARCHAR2(5),
    StaffID VARCHAR2(5),
    BookID VARCHAR2(5),
    transactionDate VARCHAR2(12),
    dueDate VARCHAR2(12),
    fine NUMBER(10),
    CONSTRAINT PK_MEMBER_TRANSACTION PRIMARY KEY (BookID,StaffID,MemberID),
    CONSTRAINT fk_MEMBER_TRANSACTION_MemberID FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID),
    CONSTRAINT fk_MEMBER_TRANSACTION_StaffID FOREIGN KEY (StaffID) REFERENCES STAFF(StaffID),
    CONSTRAINT fk_MEMBER_TRANSACTION_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID)
);

CREATE TABLE TRANSACTION_RECORD (
    TransactionID VARCHAR2(5) CONSTRAINT PK_TRANSACTION_RECORD_TransactionID PRIMARY KEY,
    MemberID VARCHAR2(5),
    BookID VARCHAR2(5),
    transactionDate VARCHAR2(12),
    transactionType VARCHAR2(10) CONSTRAINT CK_TRANSACTION_RECORD_TransactionType CHECK(transactionType IN('BORROW','RETURN','RENEW')),
    CONSTRAINT fk_TRANSACTION_RECORD_MemberID FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID),
    CONSTRAINT fk_TRANSACTION_RECORD_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID)
);

UPDATE logint
set passwd = '11'
where userid = 'U002';


commit;


INSERT INTO BOOKS VALUES ('B002', 'Computer Networks', 'Andrew S. Tanenbaum', 'A comprehensive guide to computer networking', 9876543210, 'Prentice Hall', '15-JAN-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B003', 'Introduction to Algorithms', 'Thomas H. Cormen', 'A fundamental book on algorithms and data structures', 8765432109, 'MIT Press', '01-SEP-21', 'English', 1);
INSERT INTO BOOKS VALUES ('B004', 'Artificial Intelligence: A Modern Approach', 'Stuart Russell, Peter Norvig', 'An authoritative textbook on AI', 7654321098, 'Pearson', '10-MAR-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B005', 'Database System Concepts', 'Abraham Silberschatz, Henry F. Korth, S. Sudarshan', 'A comprehensive introduction to database systems', 6543210987, 'McGraw-Hill Education', '20-JUL-21', 'English', 0);
INSERT INTO BOOKS VALUES ('B006', 'Operating System Concepts', 'Abraham Silberschatz, Peter B. Galvin, Greg Gagne', 'A classic textbook on operating systems', 5432109876, 'Wiley', '05-MAY-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B007', 'Computer Architecture: A Quantitative Approach', 'John L. Hennessy, David A. Patterson', 'A comprehensive guide to computer architecture', 4321098765, 'Morgan Kaufmann', '25-JUN-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B008', 'Introduction to the Theory of Computation', 'Michael Sipser', 'A classic textbook on the theory of computation', 3210987654, 'Cengage Learning', '10-DEC-21', 'English', 0);
INSERT INTO BOOKS VALUES ('B009', 'Data Structures and Algorithms in Java', 'Robert Lafore', 'A practical book on data structures and algorithms', 2109876543, 'Sams Publishing', '18-APR-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B010', 'Computer Graphics: Principles and Practice', 'John F. Hughes, Andries van Dam, James D. Foley', 'A comprehensive guide to computer graphics', 1098765432, 'Pearson', '05-FEB-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B011', 'Artificial Intelligence: Foundations of Computational Agents', 'David L. Poole, Alan K. Mackworth', 'An introduction to AI and intelligent agents', 987654321, 'Cambridge University Press', '20-SEP-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B012', 'Operating Systems: Three Easy Pieces', 'Remzi H. Arpaci-Dusseau, Andrea C. Arpaci-Dusseau', 'An introductory book on operating systems', 876543210, 'Arpaci-Dusseau Books', '15-MAR-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B013', 'Computer Networks: A Systems Approach', 'Larry L. Peterson, Bruce S. Davie', 'A comprehensive guide to computer networks', 765432109, 'Morgan Kaufmann', '30-JUL-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B014', 'Introduction to Algorithms: A Creative Approach', 'Udi Manber', 'An innovative approach to learning algorithms', 654321098, 'Addison-Wesley', '05-OCT-21', 'English', 1);
INSERT INTO BOOKS VALUES ('B015', 'Database Management Systems', 'Raghu Ramakrishnan, Johannes Gehrke', 'A comprehensive book on database management systems', 543210987, 'McGraw-Hill Education', '20-MAY-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B016', 'Computer Organization and Design', 'David A. Patterson, John L. Hennessy', 'A textbook on computer organization and design principles', 432109876, 'Morgan Kaufmann', '10-JAN-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B017', 'Introduction to Artificial Intelligence', 'Wolfgang Ertel', 'An introduction to AI and machine learning', 321098765, 'Springer', '25-SEP-21', 'English', 0);
INSERT INTO BOOKS VALUES ('B018', 'Programming Language Pragmatics', 'Michael L. Scott', 'A comprehensive guide to programming languages', 210987654, 'Morgan Kaufmann', '10-JUN-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B020', 'Machine Learning: A Probabilistic Perspective', 'Kevin P. Murphy', 'A comprehensive book on machine learning', 98765432, 'MIT Press', '30-SEP-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B021', 'Introduction to Computer Security', 'Michael T. Goodrich, Roberto Tamassia', 'A comprehensive guide to computer security', 87654321, 'Pearson', '25-MAR-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B022', 'Data Mining: Concepts and Techniques', 'Jiawei Han, Micheline Kamber', 'A textbook on data mining and knowledge discovery', 76543210, 'Morgan Kaufmann', '10-AUG-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B023', 'Computer Vision: Algorithms and Applications', 'Richard Szeliski', 'A comprehensive guide to computer vision', 65432109, 'Springer', '05-NOV-21', 'English', 1);
INSERT INTO BOOKS VALUES ('B024', 'Introduction to the Design and Analysis of Algorithms', 'Anany Levitin', 'A textbook on algorithm design and analysis', 54321098, 'Pearson', '20-APR-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B025', 'Artificial Intelligence: Structures and Strategies for Complex Problem Solving', 'George F. Luger', 'An introduction to AI problem-solving techniques', 43210987, 'Pearson', '25-JAN-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B026', 'Computer Networking: A Top-Down Approach', 'James F. Kurose, Keith W. Ross', 'A comprehensive book on computer networking', 32109876, 'Pearson', '20-OCT-21', 'English', 0);
INSERT INTO BOOKS VALUES ('B027', 'Data Structures: Abstraction and Design Using Java', 'Elliot B. Koffman, Paul A. T. Wolfgang', 'A practical approach to data structures using Java', 21098765, 'Wiley', '05-JUN-22', 'English', 1);
INSERT INTO BOOKS VALUES ('B028', 'Computer Graphics: Principles and Practice in C', 'James D. Foley, Andries van Dam, Steven K. Feiner', 'A classic guide to computer graphics using C', 10987654, 'Pearson', '20-FEB-22', 'English', 0);
INSERT INTO BOOKS VALUES ('B029', 'Pattern Recognition and Machine Learning', 'Christopher M. Bishop', 'A comprehensive book on pattern recognition and ML', 9876543, 'Springer', '05-OCT-22', 'English', 1);


INSERT INTO MEMBER VALUES ('');
DELETE FROM member;
DELETE FROM address;
DELETE FROM logint;

DELETE FROM books WHERE bookid='b0';
ALTER TABLE STAFF_TRANSACTION
DROP CONSTRAINT fk_STAFF_TRANSACTION_BookID;

ALTER TABLE STAFF_TRANSACTION
ADD CONSTRAINT fk_STAFF_TRANSACTION_BookID
FOREIGN KEY (BookID)
REFERENCES BOOKS(BookID)
ON DELETE CASCADE;

commit;
SELECT lang FROM BOOKS GROUP BY lang;


INSERT INTO STAFF_TRANSACTION VALUES ('t1','b1','s1','01-01-23','ADD','ADD')

-- Trigger
CREATE OR REPLACE TRIGGER LoginTrigger
AFTER INSERT ON LOGINT
FOR EACH ROW
DECLARE
    v_username VARCHAR2(50);
BEGIN
    SELECT userName INTO v_username FROM LOGINT WHERE userId = :new.userId;

    IF v_username IS NOT NULL THEN
        INSERT INTO LoginRecord(userId, userName) VALUES (:new.userId, v_username);
    END IF;
END;
/


