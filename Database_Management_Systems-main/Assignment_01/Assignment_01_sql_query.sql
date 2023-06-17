
SPOOL D:\DBMS-lab\Assignment_01\Assignment_02.sql;
REM: Drop all TABLES
DROP TABLE Reservation;
DROP TABLE boat;
DROP TABLE sailors;
DROP TABLE tourists;

REM: CREATE TABLE WITH ALL CONSTRAINT
CREATE TABLE boat(
    boat_id VARCHAR(10) PRIMARY KEY CHECK(boat_id LIKE 'B%'), -- - Ensure that boat id begins with B (3.1)
    boat_name VARCHAR(10),
    boat_type VARCHAR(10) CHECK(boat_type in ('LUX','CAR','CRU')), -- - The type of boat can be LUX for Luxurious, CAR for Caravan, CRU for Cruiser (2)
    max_capa NUMBER(10),
    boat_price NUMBER(10),
    boat_color VARCHAR(10)
);

CREATE TABLE sailors(
    sailors_id VARCHAR(10) PRIMARY KEY CHECK(sailors_id LIKE 'S%'), -- - Ensure that sailors id begins with S (3.2)
    sailors_name VARCHAR(10),
    sailors_rating varchar(10) CHECK(sailors_rating in ('A','B','C')), -- - The rating for a sailor could be A, B or C. (4)
    sailors_dob DATE
);

CREATE TABLE tourists(
    tourists_id VARCHAR(10) PRIMARY KEY CHECK(tourists_id LIKE 'T%'), -- - Ensure that tourists id begins with T (3.3)
    tourists_name CHAR(10),
    tourists_address VARCHAR(10),
    tourists_dob DATE,
    tourists_phone NUMBER(10) UNIQUE-- - The phone number of the tourists should differ from each other.(5)
);


CREATE TABLE Reservation(
    boat_id VARCHAR(10),
    sailors_id VARCHAR(10),
    date_of_sail DATE,
    tourists_id VARCHAR(10) NOT NULL,
    date_of_reserve DATE,
    no_of_per NUMBER(10),
    CONSTRAINT PK_Person PRIMARY KEY (boat_id ,sailors_id, date_of_sail ),
    CONSTRAINT FK_boat_id FOREIGN KEY (boat_id) REFERENCES boat(boat_id),
    CONSTRAINT FK_sailors_id FOREIGN KEY (sailors_id) REFERENCES sailors(sailors_id),
    CONSTRAINT FK_tourists_id FOREIGN KEY (tourists_id) REFERENCES tourists(tourists_id),
    CONSTRAINT C_date CHECK ((date_of_sail - date_of_reserve) > 12) -- -  Advance booking can be done ahead of 12 days (6)
);


REM: The type of boat can be LUX for Luxurious, CAR for Caravan, CRU for Cruiser (2) - SUCCESS
INSERT INTO boat VALUES('B1','boat1','LUX',3,400,'red');

REM: The type of boat can be LUX for Luxurious, CAR for Caravan, CRU for Cruiser (2) - FAILUR
INSERT INTO boat VALUES('B2','boat2','CAR-LUX',3,300,'white');

REM: Ensure that boat id begins with B (3.1) - SUCCESS
INSERT INTO boat VALUES('B3','boat3','CRU',3,200,'blue');

REM: Ensure that boat id begins with B (3.1) - FAILUR
INSERT INTO boat VALUES('E3','boat3','CRU',3,200,'blue');

REM: Ensure that sailors id begins with S (3.2) - SUCCESS
INSERT INTO sailors VALUES('S100','sam','A','13-FEB-2003');

REM: Ensure that sailors id begins with S (3.2) - FAILUR
INSERT INTO sailors VALUES('O200','som','B','13-FEB-2003');

REM: Ensure that tourists id begins with T (3.3) - SUCCESS
INSERT INTO tourists VALUES('T202','mega','chennai','02-JAN-2003',9870654321);

REM: Ensure that tourists id begins with T (3.3) - FAILUR
INSERT INTO tourists VALUES('P202','mega','chennai','02-JAN-2003',9870654321);

REM: The rating for a sailor could be A, B or C. (4) - SUCCESS
INSERT INTO sailors VALUES('S200','som','B','10-FEB-2003');

REM: The rating for a sailor could be A, B or C. (4) - FAILUR
INSERT INTO sailors VALUES('S300','ram','D','06-MAR-2002');

REM: The phone number of the tourists should differ from each other.(5) - SUCCESS
INSERT INTO tourists VALUES('T202','mega','chennai','13-APR-2003',9870654321);

REM: The phone number of the tourists should differ from each other.(5) - FAILUR
INSERT INTO tourists VALUES('T303','karthik','chennai','13-APR-2003',9870654321);

REM: Advance booking can be done ahead of 12 days (6) - SUCCESS
INSERT INTO Reservation VALUES('B3','S100','15-JUN-2023', 'T202', '01-MAY-2023', 3);

REM: Advance booking can be done ahead of 12 days (6) - FAILUR
INSERT INTO Reservation VALUES('B3','S100','16-JUN-2023', 'T202', '12-JUN-2023', 3);

REM: Once the boat and sailor are booked, the same (boat & sailor) cannot be reserved by another tourist on the same sail date.(7) - SUCCESS
INSERT INTO Reservation VALUES('B3','S100','22-DEC-2023', 'T202', '20-DEC-2023', 3);

REM: Once the boat and sailor are booked, the same (boat & sailor) cannot be reserved by another tourist on the same sail date.(7) - FAILUR
INSERT INTO Reservation VALUES('B3','S100','22-DEC-2023', 'T202', '20-DEC-2023', 3);

REM: It is identified that the number of children have to be mentioned while booking the boat by the tourists. (8)
ALTER TABLE Reservation
ADD no_children NUMBER(5);
DESCRIBE Reservation;
INSERT INTO Reservation VALUES('B3','S100','22-JAN-2023', 'T202', '08-JAN-2023', 3, 1);
SELECT * FROM Reservation;

REM: The width of a tourist name is not adequate for most of the tourists. (9)
ALTER TABLE tourists 
MODIFY tourists_name VARCHAR(25);
DESCRIBE tourists;

REM: The dateofbirth of a tourist can be addressed later / removed from the schema (10)
ALTER TABLE tourists
DROP COLUMN tourists_dob;
DESCRIBE tourists;

REM:  Reservation cannot be done without the reserve date. (11)
ALTER TABLE Reservation
MODIFY date_of_reserve DATE NOT NULL;
DESCRIBE Reservation;

REM:  The rating for sailor – D has to be added. (12)
ALTER TABLE sailors
MODIFY (sailors_rating varchar(1) CHECK(sailors_rating in ('A','B','C','D')));
DESCRIBE sailors;

REM:  A sailor may resign his job later or a boat may get damaged. Hence on removing the details of the sailor / boat, ensure that all the corresponding details are also deleted.(13)
SELECT * FROM sailors;
SELECT * FROM boat;
DELETE FROM sailors WHERE sailors_id='S200';
DELETE FROM boat WHERE boat_id='B1';
SELECT * FROM sailors;
SELECT * FROM boat;
	

SPOOL stop;

