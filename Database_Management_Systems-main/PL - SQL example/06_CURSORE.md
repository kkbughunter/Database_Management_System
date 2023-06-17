# About cursors and types:

1. Cursors in PL/SQL:
   - A cursor is a database object used to retrieve and manipulate query results in a procedural manner.
   - Cursors provide a way to process result sets row by row, enabling you to perform operations on each fetched row.

2. Types of Cursors:
   - Explicit Cursor: An explicit cursor is a cursor that you explicitly declare, open, fetch, and close in your PL/SQL code. You have full control over its operations and can define the query, fetch the data, and handle exceptions explicitly.
   - Implicit Cursor: An implicit cursor is a cursor that is automatically created and managed by the Oracle database without requiring explicit declaration. It is used for executing SQL statements such as SELECT, INSERT, UPDATE, and DELETE. Implicit cursors are handy for simple operations, as they handle the statement execution and result retrieval automatically.
## Explicit Cursor Example:
To execute a multi­row query, Oracle opens an unnamed work area that strores processing
information. An explicit cursor lets you name the work area, access the information, and process the
rows individually.

### Use three commands to control a cursor: OPEN, FETCH, and CLOSE. First, 
  - initialize the cursor with the OPEN statement, which identifies the resultset. 
  - Then, execute FETCH repeatedly until all rows rows have been retrieved. 
  - When the last row has been processed, release the cursor with the CLOSE statement.
```sql
DECLARE
   -- Explicit Cursor
   CURSOR emp_cursor IS
      SELECT employee_id, last_name, salary
      FROM employees
      WHERE salary > 6000;

   emp_rec emp_cursor%ROWTYPE;
BEGIN
   OPEN emp_cursor;
   LOOP
      FETCH emp_cursor INTO emp_rec;
      EXIT WHEN emp_cursor%NOTFOUND;
      dbms_output.put_line('Employee ID: ' || emp_rec.employee_id);
      dbms_output.put_line('Last Name: ' || emp_rec.last_name);
      dbms_output.put_line('Salary: ' || emp_rec.salary);
      dbms_output.put_line('------------------');
   END LOOP;
   CLOSE emp_cursor;
END;
```

Butt Oracle PL/SQL that is not associated with an explicitly declared cursor, Oracle implicitly opens a cursor to process that statement. 
It means that Oracle automatically handles the processing and retrieval of the result set for you without the need for explicit cursor 
operations like opening, fetching, or closing.

## Implicit Cursor Example:
Implicit cursors are convenient for simple operations where you don't need fine-grained control over cursor operations. 
They simplify the code by automatically managing the result set processing for you.

```sql
DECLARE
   emp_rec employees%ROWTYPE;
BEGIN
   -- Implicit Cursor
   FOR emp_row IN (SELECT employee_id, last_name, salary FROM employees WHERE salary <= 6000) LOOP
      dbms_output.put_line('Employee ID: ' || emp_row.employee_id);
      dbms_output.put_line('Last Name: ' || emp_row.last_name);
      dbms_output.put_line('Salary: ' || emp_row.salary);
      dbms_output.put_line('------------------');
   END LOOP;
END;

```
## Cursor FOR Loops:
```sql
DECLARE
   -- Explicit Cursor
   CURSOR emp_cursor IS
      SELECT employee_id, last_name, salary
      FROM employees
      WHERE salary > 6000;

BEGIN
   -- Cursor FOR Loop
   FOR emp_rec IN emp_cursor LOOP
      dbms_output.put_line('Employee ID: ' || emp_rec.employee_id);
      dbms_output.put_line('Last Name: ' || emp_rec.last_name);
      dbms_output.put_line('Salary: ' || emp_rec.salary);
      dbms_output.put_line('------------------');
   END LOOP;
END;
```
1. Simplified Syntax: Cursor loops eliminate explicit cursor operations for easier code management.
2. Automatic Cursor Handling: Cursor loops handle cursor operations (open, fetch, close) automatically.
3. Efficient Performance: Cursor loops fetch result sets in batches for improved performance.
4. Streamlined Iteration: Cursor loops iterate over result sets row by row with a clean syntax.


## Anonymous PL/SQL Code:
Anonymous PL/SQL blocks are blocks of code that are executed directly without being stored as named procedures or functions. 
They are typically used for ad-hoc or one-time tasks.
  - The Above all given code are example of **Anonymous PL/SQL Code**.

## PL/SQL Procedure Parameters:






