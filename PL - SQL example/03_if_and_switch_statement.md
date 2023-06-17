# only if
```sql

DECLARE
	x NUMBER(3);
	y NUMBER(3);
BEGIN
	x := 5;
	y := 5;
	IF x = y THEN
		dbms_output.put_line('x equal to y');
	END IF;
END;
```

# if - else
```sql
DECLARE
	x NUMBER(3);
	y NUMBER(3);
BEGIN
	x := 5;
	y := 8;
	IF x = y THEN
		dbms_output.put_line('x equal to y');
	ELSE
		dbms_output.put_line('x is not equal to y');
	END IF;
END;
```
# else - if
```sql
DECLARE
	x NUMBER(3);
	y NUMBER(3);
BEGIN
	x := 5;
	y := 8;
	IF x < y THEN
		dbms_output.put_line('x less than y');
	ELSIF x > y THEN
		dbms_output.put_line('x greater than y');
	ELSE
		dbms_output.put_line('x is equal to y');
	END IF;
END;
```
# Switch case
```sql
DECLARE
   days VARCHAR(20);
BEGIN
    days := 'FRI';
	dbms_output.put_line('user input is : ' || days);

	CASE days
        WHEN 'SUN' THEN
        	dbms_output.put_line('SUNDAY');
        WHEN 'MON' THEN
        	dbms_output.put_line('MONDAY');
        WHEN 'TUE' THEN
        	dbms_output.put_line('TUESDAY');
        WHEN 'WED' THEN
        	dbms_output.put_line('WEDNESDAY');
        WHEN 'THU' THEN
        	dbms_output.put_line('THURSEDAY');
        WHEN 'FRI' THEN
        	dbms_output.put_line('FRIDAY');
        WHEN 'SAT' THEN
        	dbms_output.put_line('SATURDAY');
	ELSE 
            dbms_output.put_line('Error in input...');
	END CASE;	
END;
```
