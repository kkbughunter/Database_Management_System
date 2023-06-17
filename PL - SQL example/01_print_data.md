# Print data.
This query is use to display output in terminal.
```sql
SET SERVEROUTPUT ON;
```
## Type 01
```sql
BEGIN
	dbms_output.put_line('Hello World!...');
END;
```
## Type 02
```sql
DECLARE 
	x NUMBER(3);
BEGIN
	temp := 3;
	dbms_output.put_line('Value of X : ' || x);
END;
```
```sql
DECLARE 
	x NUMBER(3) := 10;
BEGIN
	dbms_output.put_line('Value of X : ' || x || '.');
END;
```
