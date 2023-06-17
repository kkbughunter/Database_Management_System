SQL> REM: Drop all TABLES
SQL> DROP TABLE sailors;
DROP TABLE sailors
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> 
SQL> CREATE TABLE sailors(
  2      sailors_id VARCHAR(10) PRIMARY KEY CHECK(sailors_id LIKE 'S%'), -- - Ensure that sailors id begins with S (3.2)
  3      sailors_name VARCHAR(10),
  4      sailors_rating varchar(10) CHECK(sailors_rating in ('A','B','C','D')), -- - The rating for a sailor could be A, B or C. (4)
  5      sailors_dob DATE
  6  );

Table created.

SQL> 
SQL> ALTER TABLE sailors
  2  ADD salary NUMBER(8);

Table altered.

SQL> 
SQL> -- - sailor
SQL> INSERT INTO sailors VALUES('S100','Raman','A','01-OCT-80', 27000);

1 row created.

SQL> INSERT INTO sailors VALUES('S200','Krishna','B','04-JUL-78',21000);

1 row created.

SQL> INSERT INTO sailors VALUES('S300','Gokul','C','05-FEB-75',16000);

1 row created.

SQL> INSERT INTO sailors VALUES('S400','Ravi','D','06-APR-78',10000);

1 row created.

SQL> INSERT INTO sailors VALUES('S500','James','A','07-MAY-78',25000);

1 row created.

SQL> INSERT INTO sailors VALUES('S600','Vasanth','B','20-MAY-87',20600);

1 row created.

SQL> INSERT INTO sailors VALUES('S700','Rahul','C','13-DEC-85',15500);

1 row created.

SQL> INSERT INTO sailors VALUES('S800','Vijay',NULL,'13-DEC-90',5000);

1 row created.

SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      27000                           
S200       Krishna    B          04-JUL-78      21000                           
S300       Gokul      C          05-FEB-75      16000                           
S400       Ravi       D          06-APR-78      10000                           
S500       James      A          07-MAY-78      25000                           
S600       Vasanth    B          20-MAY-87      20600                           
S700       Rahul      C          13-DEC-85      15500                           
S800       Vijay                 13-DEC-90       5000                           

8 rows selected.

SQL> 
SQL> REM: Display the name and salary of sailors earning more than $10000. (2)
SQL> SELECT sailors_name,salary FROM sailors WHERE salary>10000;

SAILORS_NA     SALARY                                                           
---------- ----------                                                           
Raman           27000                                                           
Krishna         21000                                                           
Gokul           16000                                                           
James           25000                                                           
Vasanth         20600                                                           
Rahul           15500                                                           

6 rows selected.

SQL> 
SQL> REM: Display the unique ratings of sailor from the SAILOR relation (3)
SQL> SELECT DISTINCT sailors_rating FROM sailors;

SAILORS_RA                                                                      
----------                                                                      
                                                                                
D                                                                               
A                                                                               
B                                                                               
C                                                                               

SQL> 
SQL> REM:  Display sailor name, hike salary by 10% and label the columns as Sailor Name and New Salary respectively. (4)
SQL> UPDATE sailors
  2  SET salary = salary + (salary * 10/100);

8 rows updated.

SQL> SELECT sailors_name, salary FROM sailors;

SAILORS_NA     SALARY                                                           
---------- ----------                                                           
Raman           29700                                                           
Krishna         23100                                                           
Gokul           17600                                                           
Ravi            11000                                                           
James           27500                                                           
Vasanth         22660                                                           
Rahul           17050                                                           
Vijay            5500                                                           

8 rows selected.

SQL> 
SQL> REM: List sailor id, name, salary of all sailor(s) who was not rated yet (5)
SQL> SELECT sailors_id, sailors_name, salary FROM sailors WHERE sailors_rating IS NULL;

SAILORS_ID SAILORS_NA     SALARY                                                
---------- ---------- ----------                                                
S800       Vijay            5500                                                

SQL> 
SQL> REM:  Show all data for sailors whose name starts with R and born before the year 1985(6)
SQL> SELECT * FROM sailors WHERE sailors_name LIKE 'R%' AND sailors_dob < '01-JAN-1985';

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S400       Ravi       D          06-APR-78      11000                           

SQL> 
SQL> REM:  Display name, rating, salary of all sailors whose rating is A or B and whose salary is not equal to $21000 and $25000. (7)
SQL> SELECT sailors_name,sailors_rating,salary FROM sailors WHERE (sailors_rating = 'A' OR sailors_rating = 'B') AND (salary != 21000 AND salary != 25000);

SAILORS_NA SAILORS_RA     SALARY                                                
---------- ---------- ----------                                                
Raman      A               29700                                                
Krishna    B               23100                                                
James      A               27500                                                
Vasanth    B               22660                                                

SQL> 
SQL> REM:  Modify the query in 2 to display the name and salary of all sailors whose salary is not in the range of $10000 to $16000.(8)
SQL> SELECT sailors_name,salary FROM sailors WHERE salary NOT BETWEEN 10000 AND 16000;

SAILORS_NA     SALARY                                                           
---------- ----------                                                           
Raman           29700                                                           
Krishna         23100                                                           
Gokul           17600                                                           
James           27500                                                           
Vasanth         22660                                                           
Rahul           17050                                                           
Vijay            5500                                                           

7 rows selected.

SQL> 
SQL> REM: . List the sailors who was born between Jan 1985 and Dec 1985.(9)
SQL> SELECT * FROM sailors WHERE sailors_dob BETWEEN '01-Jan-1985' AND '31-DEC-1985';

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S700       Rahul      C          13-DEC-85      17050                           

SQL> 
SQL> -- - error -- -
SQL> REM:  Show the name of sailors together with their age in number of years and months [E.g., 18 Yrs 4 Months].(10)
SQL> SELECT SYSDATE FROM dual;

SYSDATE                                                                         
---------                                                                       
09-APR-23                                                                       

SQL> SELECT sailors_name,
  2         TRUNC(MONTHS_BETWEEN(SYSDATE, sailors_dob) / 12) AS year,
  3         MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, sailors_dob)), 12) AS months
  4  FROM sailors;

SAILORS_NA       YEAR     MONTHS                                                
---------- ---------- ----------                                                
Raman              42          6                                                
Krishna            44          9                                                
Gokul              48          2                                                
Ravi               45          0                                                
James              44         11                                                
Vasanth            35         10                                                
Rahul              37          3                                                
Vijay              32          3                                                

8 rows selected.

SQL> 
SQL> REM: Display the sailor id and name of a sailor whose name has second letter a. Sort the result by name in descending order.(11)
SQL> SELECT sailors_name FROM sailors WHERE sailors_name LIKE '_a%' ORDER BY sailors_name;

SAILORS_NA                                                                      
----------                                                                      
James                                                                           
Rahul                                                                           
Raman                                                                           
Ravi                                                                            
Vasanth                                                                         

SQL> 
SQL> REM: Show those sailors whose name starts with J, K, or R(12)
SQL> SELECT * FROM sailors WHERE sailors_name LIKE 'R%' OR sailors_name LIKE 'J%' OR sailors_name LIKE 'K%';

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S200       Krishna    B          04-JUL-78      23100                           
S400       Ravi       D          06-APR-78      11000                           
S500       James      A          07-MAY-78      27500                           
S700       Rahul      C          13-DEC-85      17050                           

SQL> 
SQL> REM:  How many sailors have a name that ends with letter l.(13)
SQL> SELECT * FROM sailors WHERE sailors_name LIKE '%l';

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S300       Gokul      C          05-FEB-75      17600                           
S700       Rahul      C          13-DEC-85      17050                           

SQL> 
SQL> REM: Display highest, lowest, sum and average salary earned by the sailors in rating-wise. Label the columns as Max, Min, Sum, and Avg respectively. Round your results to the nearest whole number. Sort your result by alphabetical order of rating. (14)
SQL> SELECT MAX(salary) AS MAX_SALARY,
  2      MIN(salary) AS MIN_SALARY,
  3      SUM(salary) AS SUM_SALARY,
  4      AVG(salary) AS AVG_SALARY
  5  FROM sailors;

MAX_SALARY MIN_SALARY SUM_SALARY AVG_SALARY                                     
---------- ---------- ---------- ----------                                     
     29700       5500     154110   19263.75                                     

SQL> SELECT ROUND(MAX(salary), -3) AS ROUND_MAX,
  2      ROUND(MIN(salary), -3) AS ROUND_MIN,
  3      ROUND(SUM(salary), -3) AS ROUND_SUM,
  4      ROUND(AVG(salary), -3) AS ROUND_AVG
  5  FROM sailors;

 ROUND_MAX  ROUND_MIN  ROUND_SUM  ROUND_AVG                                     
---------- ---------- ---------- ----------                                     
     30000       6000     154000      19000                                     

SQL> SELECT * FROM sailors ORDER BY sailors_rating DESC;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S800       Vijay                 13-DEC-90       5500                           
S400       Ravi       D          06-APR-78      11000                           
S300       Gokul      C          05-FEB-75      17600                           
S700       Rahul      C          13-DEC-85      17050                           
S600       Vasanth    B          20-MAY-87      22660                           
S200       Krishna    B          04-JUL-78      23100                           
S100       Raman      A          01-OCT-80      29700                           
S500       James      A          07-MAY-78      27500                           

8 rows selected.

SQL> 
SQL> REM: Display the total salary for each rating. Exclude the ratings where the total salary is less than $25000.(15)
SQL> SELECT sailors_rating, COUNT(sailors_rating),SUM(salary) as total
  2  FROM sailors
  3  GROUP BY sailors_rating
  4  HAVING SUM(salary) >25000 ;

SAILORS_RA COUNT(SAILORS_RATING)      TOTAL                                     
---------- --------------------- ----------                                     
A                              2      57200                                     
B                              2      45760                                     
C                              2      34650                                     

SQL> 
SQL> REM: Display the rating and salary of the lowest paid sailor in each rating. Exclude anyone whose rating is not known. Exclude any groups where the minimum salary is $15000 or less. Sort the output in descending order of salary. (16)
SQL> SELECT sailors_rating, MIN(salary) AS lowest_salary
  2  FROM sailors
  3  WHERE sailors_rating IS NOT NULL
  4  GROUP BY sailors_rating
  5  HAVING MIN(salary) > 15000
  6  ORDER BY lowest_salary DESC;

SAILORS_RA LOWEST_SALARY                                                        
---------- -------------                                                        
A                  27500                                                        
B                  22660                                                        
C                  17050                                                        

SQL> 
SQL> REM: Using Update, Delete, TCL Statements(17)
SQL> REM: Mark an intermediate point in the transaction (savepoint).
SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S200       Krishna    B          04-JUL-78      23100                           
S300       Gokul      C          05-FEB-75      17600                           
S400       Ravi       D          06-APR-78      11000                           
S500       James      A          07-MAY-78      27500                           
S600       Vasanth    B          20-MAY-87      22660                           
S700       Rahul      C          13-DEC-85      17050                           
S800       Vijay                 13-DEC-90       5500                           

8 rows selected.

SQL> SAVEPOINT s1;

Savepoint created.

SQL> 
SQL> REM: Update the rating, salary of S800 to A, 10000 respectively.(18)
SQL> UPDATE sailors
  2  SET salary = 10000, sailors_rating = 'A'
  3  WHERE sailors_id='S800';

1 row updated.

SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S200       Krishna    B          04-JUL-78      23100                           
S300       Gokul      C          05-FEB-75      17600                           
S400       Ravi       D          06-APR-78      11000                           
S500       James      A          07-MAY-78      27500                           
S600       Vasanth    B          20-MAY-87      22660                           
S700       Rahul      C          13-DEC-85      17050                           
S800       Vijay      A          13-DEC-90      10000                           

8 rows selected.

SQL> 
SQL> REM: Mark an intermediate point in the transaction (savepoint).(19)
SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S200       Krishna    B          04-JUL-78      23100                           
S300       Gokul      C          05-FEB-75      17600                           
S400       Ravi       D          06-APR-78      11000                           
S500       James      A          07-MAY-78      27500                           
S600       Vasanth    B          20-MAY-87      22660                           
S700       Rahul      C          13-DEC-85      17050                           
S800       Vijay      A          13-DEC-90      10000                           

8 rows selected.

SQL> SAVEPOINT s2;

Savepoint created.

SQL> 
SQL> REM: Update the salary of all sailors with a hike by 5%.(20)
SQL> UPDATE sailors
  2  SET salary = salary * 1,15;
SET salary = salary * 1,15
                        *
ERROR at line 2:
ORA-01747: invalid user.table.column, table.column, or column specification 


SQL> SELECT * FROM sailor;
SELECT * FROM sailor
              *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> 
SQL> REM: Delete the sailor(s) who was born before 1985.(21)
SQL> DELETE FROM sailors
  2  WHERE EXTRACT(YEAR FROM sailors_dob) = 1985;

1 row deleted.

SQL> 
SQL> REM: Display the sailor relation.(22)
SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S200       Krishna    B          04-JUL-78      23100                           
S300       Gokul      C          05-FEB-75      17600                           
S400       Ravi       D          06-APR-78      11000                           
S500       James      A          07-MAY-78      27500                           
S600       Vasanth    B          20-MAY-87      22660                           
S800       Vijay      A          13-DEC-90      10000                           

7 rows selected.

SQL> 
SQL> REM: Discard the most recent update operations (rollback).(23)
SQL> ROLLBACK TO SAVEPOINT s2;

Rollback complete.

SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S200       Krishna    B          04-JUL-78      23100                           
S300       Gokul      C          05-FEB-75      17600                           
S400       Ravi       D          06-APR-78      11000                           
S500       James      A          07-MAY-78      27500                           
S600       Vasanth    B          20-MAY-87      22660                           
S700       Rahul      C          13-DEC-85      17050                           
S800       Vijay      A          13-DEC-90      10000                           

8 rows selected.

SQL> 
SQL> 24. Commit the changes.
SP2-0734: unknown command beginning "24. Commit..." - rest of line ignored.
SQL> COMMIT;

Commit complete.

SQL> SELECT * FROM sailors;

SAILORS_ID SAILORS_NA SAILORS_RA SAILORS_D     SALARY                           
---------- ---------- ---------- --------- ----------                           
S100       Raman      A          01-OCT-80      29700                           
S200       Krishna    B          04-JUL-78      23100                           
S300       Gokul      C          05-FEB-75      17600                           
S400       Ravi       D          06-APR-78      11000                           
S500       James      A          07-MAY-78      27500                           
S600       Vasanth    B          20-MAY-87      22660                           
S700       Rahul      C          13-DEC-85      17050                           
S800       Vijay      A          13-DEC-90      10000                           

8 rows selected.

SQL> ROLLBACK TO SAVEPOINT s1;
ROLLBACK TO SAVEPOINT s1
*
ERROR at line 1:
ORA-01086: savepoint 'S1' never established in this session or is invalid 


SQL> 
SQL> SPOOL stop;
