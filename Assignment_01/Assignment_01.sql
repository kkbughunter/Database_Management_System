SQL> 
SQL> REM: CREATE TABLE WITH ALL CONSTRAINT
SQL> CREATE TABLE boat(
  2      boat_id VARCHAR(10) PRIMARY KEY CHECK(boat_id LIKE 'B%'), -- - Ensure that boat id begins with B (3.1)
  3      boat_name VARCHAR(10),
  4      boat_type VARCHAR(10) CHECK(boat_type in ('LUX','CAR','CRU')), -- - The type of boat can be LUX for Luxurious, CAR for Caravan, CRU for Cruiser (2)
  5      max_capa NUMBER(10),
  6      boat_price NUMBER(10),
  7      boat_color VARCHAR(10)
  8  );

Table created.

SQL> 
SQL> CREATE TABLE sailors(
  2      sailors_id VARCHAR(10) PRIMARY KEY CHECK(sailors_id LIKE 'S%'), -- - Ensure that sailors id begins with S (3.2)
  3      sailors_name VARCHAR(10),
  4      sailors_rating varchar(10) CHECK(sailors_rating in ('A','B','C')), -- - The rating for a sailor could be A, B or C. (4)
  5      sailors_dob DATE
  6  );

Table created.

SQL> 
SQL> CREATE TABLE tourists(
  2      tourists_id VARCHAR(10) PRIMARY KEY CHECK(tourists_id LIKE 'T%'), -- - Ensure that tourists id begins with T (3.3)
  3      tourists_name CHAR(10),
  4      tourists_address VARCHAR(10),
  5      tourists_dob DATE,
  6      tourists_phone NUMBER(10) UNIQUE-- - The phone number of the tourists should differ from each other.(5)
  7  );

Table created.

SQL> 
SQL> 
SQL> CREATE TABLE Reservation(
  2      boat_id VARCHAR(10),
  3      sailors_id VARCHAR(10),
  4      date_of_sail DATE,
  5      tourists_id VARCHAR(10) NOT NULL,
  6      date_of_reserve DATE,
  7      no_of_per NUMBER(10),
  8      CONSTRAINT PK_Person PRIMARY KEY (boat_id ,sailors_id, date_of_sail ),
  9      CONSTRAINT FK_boat_id FOREIGN KEY (boat_id) REFERENCES boat(boat_id),
 10      CONSTRAINT FK_sailors_id FOREIGN KEY (sailors_id) REFERENCES sailors(sailors_id),
 11      CONSTRAINT FK_tourists_id FOREIGN KEY (tourists_id) REFERENCES tourists(tourists_id),
 12      CONSTRAINT C_date CHECK ((date_of_sail - date_of_reserve) > 12) -- -  Advance booking can be done ahead of 12 days (6)
 13  );

Table created.

SQL> 
SQL> 
SQL> REM: The type of boat can be LUX for Luxurious, CAR for Caravan, CRU for Cruiser (2) - SUCCESS
SQL> INSERT INTO boat VALUES('B1','boat1','LUX',3,400,'red');

1 row created.

SQL> 
SQL> REM: The type of boat can be LUX for Luxurious, CAR for Caravan, CRU for Cruiser (2) - FAILUR
SQL> INSERT INTO boat VALUES('B2','boat2','CAR-LUX',3,300,'white');
INSERT INTO boat VALUES('B2','boat2','CAR-LUX',3,300,'white')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.SYS_C007108) violated 


SQL> 
SQL> REM: Ensure that boat id begins with B (3.1) - SUCCESS
SQL> INSERT INTO boat VALUES('B3','boat3','CRU',3,200,'blue');

1 row created.

SQL> 
SQL> REM: Ensure that boat id begins with B (3.1) - FAILUR
SQL> INSERT INTO boat VALUES('E3','boat3','CRU',3,200,'blue');
INSERT INTO boat VALUES('E3','boat3','CRU',3,200,'blue')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.SYS_C007107) violated 


SQL> 
SQL> REM: Ensure that sailors id begins with S (3.2) - SUCCESS
SQL> INSERT INTO sailors VALUES('S100','sam','A','13-FEB-2003');

1 row created.

SQL> 
SQL> REM: Ensure that sailors id begins with S (3.2) - FAILUR
SQL> INSERT INTO sailors VALUES('O200','som','B','13-FEB-2003');
INSERT INTO sailors VALUES('O200','som','B','13-FEB-2003')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.SYS_C007110) violated 


SQL> 
SQL> REM: Ensure that tourists id begins with T (3.3) - SUCCESS
SQL> INSERT INTO tourists VALUES('T202','mega','chennai','02-JAN-2003',9870654321);

1 row created.

SQL> 
SQL> REM: Ensure that tourists id begins with T (3.3) - FAILUR
SQL> INSERT INTO tourists VALUES('P202','mega','chennai','02-JAN-2003',9870654321);
INSERT INTO tourists VALUES('P202','mega','chennai','02-JAN-2003',9870654321)
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.SYS_C007113) violated 


SQL> 
SQL> REM: The rating for a sailor could be A, B or C. (4) - SUCCESS
SQL> INSERT INTO sailors VALUES('S200','som','B','10-FEB-2003');

1 row created.

SQL> 
SQL> REM: The rating for a sailor could be A, B or C. (4) - FAILUR
SQL> INSERT INTO sailors VALUES('S300','ram','D','06-MAR-2002');
INSERT INTO sailors VALUES('S300','ram','D','06-MAR-2002')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.SYS_C007111) violated 


SQL> 
SQL> REM: The phone number of the tourists should differ from each other.(5) - SUCCESS
SQL> INSERT INTO tourists VALUES('T202','mega','chennai','13-APR-2003',9870654321);
INSERT INTO tourists VALUES('T202','mega','chennai','13-APR-2003',9870654321)
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.SYS_C007114) violated 


SQL> 
SQL> REM: The phone number of the tourists should differ from each other.(5) - FAILUR
SQL> INSERT INTO tourists VALUES('T303','karthik','chennai','13-APR-2003',9870654321);
INSERT INTO tourists VALUES('T303','karthik','chennai','13-APR-2003',9870654321)
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.SYS_C007115) violated 


SQL> 
SQL> REM: Advance booking can be done ahead of 12 days (6) - SUCCESS
SQL> INSERT INTO Reservation VALUES('B3','S100','15-JUN-2023', 'T202', '01-MAY-2023', 3);

1 row created.

SQL> 
SQL> REM: Advance booking can be done ahead of 12 days (6) - FAILUR
SQL> INSERT INTO Reservation VALUES('B3','S100','16-JUN-2023', 'T202', '12-JUN-2023', 3);
INSERT INTO Reservation VALUES('B3','S100','16-JUN-2023', 'T202', '12-JUN-2023', 3)
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.C_DATE) violated 


SQL> 
SQL> REM: Once the boat and sailor are booked, the same (boat & sailor) cannot be reserved by another tourist on the same sail date.(7) - SUCCESS
SQL> INSERT INTO Reservation VALUES('B3','S100','22-DEC-2023', 'T202', '20-DEC-2023', 3);
INSERT INTO Reservation VALUES('B3','S100','22-DEC-2023', 'T202', '20-DEC-2023', 3)
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.C_DATE) violated 


SQL> 
SQL> REM: Once the boat and sailor are booked, the same (boat & sailor) cannot be reserved by another tourist on the same sail date.(7) - FAILUR
SQL> INSERT INTO Reservation VALUES('B3','S100','22-DEC-2023', 'T202', '20-DEC-2023', 3);
INSERT INTO Reservation VALUES('B3','S100','22-DEC-2023', 'T202', '20-DEC-2023', 3)
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.C_DATE) violated 


SQL> 
SQL> REM: It is identified that the number of children have to be mentioned while booking the boat by the tourists. (8)
SQL> ALTER TABLE Reservation
  2  ADD no_children NUMBER(5);

Table altered.

SQL> DESCRIBE Reservation;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 BOAT_ID                                   NOT NULL VARCHAR2(10)
 SAILORS_ID                                NOT NULL VARCHAR2(10)
 DATE_OF_SAIL                              NOT NULL DATE
 TOURISTS_ID                               NOT NULL VARCHAR2(10)
 DATE_OF_RESERVE                                    DATE
 NO_OF_PER                                          NUMBER(10)
 NO_CHILDREN                                        NUMBER(5)

SQL> INSERT INTO Reservation VALUES('B3','S100','22-JAN-2023', 'T202', '08-JAN-2023', 3, 1);

1 row created.

SQL> SELECT * FROM Reservation;

BOAT_ID    SAILORS_ID DATE_OF_S TOURISTS_I DATE_OF_R  NO_OF_PER NO_CHILDREN     
---------- ---------- --------- ---------- --------- ---------- -----------     
B3         S100       15-JUN-23 T202       01-MAY-23          3                 
B3         S100       22-JAN-23 T202       08-JAN-23          3           1     

SQL> 
SQL> REM: The width of a tourist name is not adequate for most of the tourists. (9)
SQL> ALTER TABLE tourists
  2  MODIFY tourists_name VARCHAR(25);

Table altered.

SQL> DESCRIBE tourists;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 TOURISTS_ID                               NOT NULL VARCHAR2(10)
 TOURISTS_NAME                                      VARCHAR2(25)
 TOURISTS_ADDRESS                                   VARCHAR2(10)
 TOURISTS_DOB                                       DATE
 TOURISTS_PHONE                                     NUMBER(10)

SQL> 
SQL> REM: The dateofbirth of a tourist can be addressed later / removed from the schema (10)
SQL> ALTER TABLE tourists
  2  DROP COLUMN tourists_dob;

Table altered.

SQL> DESCRIBE tourists;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 TOURISTS_ID                               NOT NULL VARCHAR2(10)
 TOURISTS_NAME                                      VARCHAR2(25)
 TOURISTS_ADDRESS                                   VARCHAR2(10)
 TOURISTS_PHONE                                     NUMBER(10)

SQL> 
SQL> REM:  Reservation cannot be done without the reserve date. (11)
SQL> ALTER TABLE Reservation
  2  MODIFY date_of_reserve DATE NOT NULL;

Table altered.

SQL> DESCRIBE Reservation;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 BOAT_ID                                   NOT NULL VARCHAR2(10)
 SAILORS_ID                                NOT NULL VARCHAR2(10)
 DATE_OF_SAIL                              NOT NULL DATE
 TOURISTS_ID                               NOT NULL VARCHAR2(10)
 DATE_OF_RESERVE                           NOT NULL DATE
 NO_OF_PER                                          NUMBER(10)
 NO_CHILDREN                                        NUMBER(5)

SQL> 
SQL> REM:  The rating for sailor - D has to be added. (12)
SQL> ALTER TABLE sailors
  2  MODIFY (sailors_rating varchar(1) CHECK(sailors_rating in ('A','B','C','D')));

Table altered.

SQL> DESCRIBE sailors;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SAILORS_ID                                NOT NULL VARCHAR2(10)
 SAILORS_NAME                                       VARCHAR2(10)
 SAILORS_RATING                                     VARCHAR2(1)
 SAILORS_DOB                                        DATE

SQL> 
SQL> REM:  A sailor may resign his job later or a boat may get damaged. Hence on removing the details of the sailor / boat, ensure that all the corresponding details are also deleted.(13)
SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA S SAILORS_D                                               
---------- ---------- - ---------                                               
S100       sam        A 13-FEB-03                                               
S200       som        B 10-FEB-03                                               

SQL> SELECT * FROM boat;

BOAT_ID    BOAT_NAME  BOAT_TYPE    MAX_CAPA BOAT_PRICE BOAT_COLOR               
---------- ---------- ---------- ---------- ---------- ----------               
B1         boat1      LUX                 3        400 red                      
B3         boat3      CRU                 3        200 blue                     

SQL> DELETE FROM sailors WHERE sailors_id='S200';

1 row deleted.

SQL> DELETE FROM boat WHERE boat_id='B1';

1 row deleted.

SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA S SAILORS_D                                               
---------- ---------- - ---------                                               
S100       sam        A 13-FEB-03                                               

SQL> SELECT * FROM boat;

BOAT_ID    BOAT_NAME  BOAT_TYPE    MAX_CAPA BOAT_PRICE BOAT_COLOR               
---------- ---------- ---------- ---------- ---------- ----------               
B3         boat3      CRU                 3        200 blue                     

SQL> 
SQL> 
SQL> SPOOL stop;
