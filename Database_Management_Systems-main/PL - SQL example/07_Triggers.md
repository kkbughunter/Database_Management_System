# Triggers 
Triggers in Oracle are database objects that are automatically executed or fired in response to specific database events, 
such as INSERT, UPDATE, DELETE, or DDL (Data Definition Language) statements. Triggers are used to enforce data integrity rules, 
perform complex calculations, maintain audit trails, and automate certain database operations.


1. Application Triggers: Application triggers are custom triggers created by application developers to execute specific actions within the application's code. They are associated with application-level events and are used to enforce business rules or perform application-specific logic.

2. Database Triggers: Database triggers are database objects that are automatically executed in response to database events, such as INSERT, UPDATE, DELETE, or DDL statements. They are defined at the database level and can be used to enforce data integrity, maintain audit trails, or perform database-level operations.

```sql
CREATE TABLE students (
    sid   NUMBER,
    sname VARCHAR2(50),
    dept  VARCHAR2(50),
    mark1 NUMBER,
    mark2 NUMBER,
    mark3 NUMBER
);

INSERT INTO students VALUES (1, 'John', 'Computer Science', 80, 75, 85);
INSERT INTO students VALUES (2, 'Alice', 'Mathematics', 90, 85, 95);
INSERT INTO students VALUES (3, 'Emily', 'Physics', 70, 80, 75);
INSERT INTO students VALUES (4, 'Michael', 'Chemistry', 85, 90, 80);
```
Once the trigger is created, you don't need to explicitly call it.
```sql
CREATE OR REPLACE TRIGGER check_mark_trigger
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
BEGIN
    IF :NEW.mark1 > 100 OR :NEW.mark2 > 100 OR :NEW.mark3 > 100 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid mark! Marks should be less than or equal to 100.');
    END IF;
END;
```
now try with this Insert Query (it give the trigger error)
```sql
INSERT INTO students VALUES (1, 'Sam', 'Computer Science', 110, 78, 95);
UPDATE students SET mark1 = 90, mark2 = 20, mark3 = 103 WHERE sid=2;
```
## Trigger chain
Trigger T1 could cause trigger T2 to fire, which could cause trigger T3 and so on (a trigger chain).
