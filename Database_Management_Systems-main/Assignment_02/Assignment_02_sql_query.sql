
SPOOL D:\DBMS-lab\Assignment_02\Assignment_02.sql;
REM: Drop all TABLES
DROP TABLE sailors;

CREATE TABLE sailors(
    sailors_id VARCHAR(10) PRIMARY KEY CHECK(sailors_id LIKE 'S%'), -- - Ensure that sailors id begins with S (3.2)
    sailors_name VARCHAR(10),
    sailors_rating varchar(10) CHECK(sailors_rating in ('A','B','C','D')), -- - The rating for a sailor could be A, B or C. (4)
    sailors_dob DATE
);

ALTER TABLE sailors
ADD salary NUMBER(8);

-- - sailor
INSERT INTO sailors VALUES('S100','Raman','A','01-OCT-80', 27000);
INSERT INTO sailors VALUES('S200','Krishna','B','04-JUL-78',21000);
INSERT INTO sailors VALUES('S300','Gokul','C','05-FEB-75',16000);
INSERT INTO sailors VALUES('S400','Ravi','D','06-APR-78',10000);
INSERT INTO sailors VALUES('S500','James','A','07-MAY-78',25000);
INSERT INTO sailors VALUES('S600','Vasanth','B','20-MAY-87',20600);
INSERT INTO sailors VALUES('S700','Rahul','C','13-DEC-85',15500);
INSERT INTO sailors VALUES('S800','Vijay',NULL,'13-DEC-90',5000);
SELECT * FROM sailors;

REM: Display the name and salary of sailors earning more than $10000. (2)
SELECT sailors_name,salary FROM sailors WHERE salary>10000;

REM: Display the unique ratings of sailor from the SAILOR relation (3)
SELECT DISTINCT sailors_rating FROM sailors; 

REM:  Display sailor name, hike salary by 10% and label the columns as Sailor Name and New Salary respectively. (4)
UPDATE sailors 
SET salary = salary + (salary * 10/100);
SELECT sailors_name, salary FROM sailors;

REM: List sailor id, name, salary of all sailor(s) who was not rated yet (5)
SELECT sailors_id, sailors_name, salary FROM sailors WHERE sailors_rating IS NULL;

REM:  Show all data for sailors whose name starts with R and born before the year 1985(6)
SELECT * FROM sailors WHERE sailors_name LIKE 'R%' AND sailors_dob < '01-JAN-1985';

REM:  Display name, rating, salary of all sailors whose rating is A or B and whose salary is not equal to $21000 and $25000. (7)
SELECT sailors_name,sailors_rating,salary FROM sailors WHERE (sailors_rating = 'A' OR sailors_rating = 'B') AND (salary != 21000 AND salary != 25000);

REM:  Modify the query in 2 to display the name and salary of all sailors whose salary is not in the range of $10000 to $16000.(8)
SELECT sailors_name,salary FROM sailors WHERE salary NOT BETWEEN 10000 AND 16000;

REM: . List the sailors who was born between Jan 1985 and Dec 1985.(9)
SELECT * FROM sailors WHERE sailors_dob BETWEEN '01-Jan-1985' AND '31-DEC-1985';

-- - error -- -
REM:  Show the name of sailors together with their age in number of years and months [E.g., 18 Yrs 4 Months].(10)
SELECT SYSDATE FROM dual;
SELECT sailors_name,
       TRUNC(MONTHS_BETWEEN(SYSDATE, sailors_dob) / 12) AS year,
       MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, sailors_dob)), 12) AS months
FROM sailors;

REM: Display the sailor id and name of a sailor whose name has second letter a. Sort the result by name in descending order.(11)
SELECT sailors_name FROM sailors WHERE sailors_name LIKE '_a%' ORDER BY sailors_name;

REM: Show those sailors whose name starts with J, K, or R(12)
SELECT * FROM sailors WHERE sailors_name LIKE 'R%' OR sailors_name LIKE 'J%' OR sailors_name LIKE 'K%';

REM:  How many sailors have a name that ends with letter l.(13)
SELECT * FROM sailors WHERE sailors_name LIKE '%l';

REM: Display highest, lowest, sum and average salary earned by the sailors in rating-wise. Label the columns as Max, Min, Sum, and Avg respectively. Round your results to the nearest whole number. Sort your result by alphabetical order of rating. (14)
SELECT MAX(salary) AS MAX_SALARY,
    MIN(salary) AS MIN_SALARY,
    SUM(salary) AS SUM_SALARY,
    AVG(salary) AS AVG_SALARY
FROM sailors;
SELECT ROUND(MAX(salary), -3) AS ROUND_MAX,
    ROUND(MIN(salary), -3) AS ROUND_MIN,
    ROUND(SUM(salary), -3) AS ROUND_SUM,
    ROUND(AVG(salary), -3) AS ROUND_AVG
FROM sailors;
SELECT * FROM sailors ORDER BY sailors_rating DESC;

REM: Display the total salary for each rating. Exclude the ratings where the total salary is less than $25000.(15)
SELECT sailors_rating, COUNT(sailors_rating),SUM(salary) as total
FROM sailors 
GROUP BY sailors_rating
HAVING SUM(salary) >25000 ;

REM: Display the rating and salary of the lowest paid sailor in each rating. Exclude anyone whose rating is not known. Exclude any groups where the minimum salary is $15000 or less. Sort the output in descending order of salary. (16)
SELECT sailors_rating, MIN(salary) AS lowest_salary
FROM sailors
WHERE sailors_rating IS NOT NULL
GROUP BY sailors_rating
HAVING MIN(salary) > 15000
ORDER BY lowest_salary DESC;

REM: Using Update, Delete, TCL Statements(17)
REM: Mark an intermediate point in the transaction (savepoint).
SELECT * FROM sailors;
SAVEPOINT s1;

REM: Update the rating, salary of S800 to A, 10000 respectively.(18)
UPDATE sailors 
SET salary = 10000, sailors_rating = 'A'
WHERE sailors_id='S800';
SELECT * FROM sailors;

REM: Mark an intermediate point in the transaction (savepoint).(19)
SELECT * FROM sailors;
SAVEPOINT s2;

REM: Update the salary of all sailors with a hike by 5%.(20)
UPDATE sailors 
SET salary = salary * 1,15;
SELECT * FROM sailor;

REM: Delete the sailor(s) who was born before 1985.(21)
DELETE FROM sailors
WHERE EXTRACT(YEAR FROM sailors_dob) = 1985;

REM: Display the sailor relation.(22)
SELECT * FROM sailors;

REM: Discard the most recent update operations (rollback).(23)
ROLLBACK TO SAVEPOINT s2;
SELECT * FROM sailors;

24. Commit the changes.
COMMIT;
SELECT * FROM sailors;
ROLLBACK TO SAVEPOINT s1;

SPOOL stop;
