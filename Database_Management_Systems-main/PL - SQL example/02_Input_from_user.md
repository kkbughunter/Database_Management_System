# Get input from user
## This my work may not work.
### Method 1
```sql
DECLARE
	x NUMBER(3);
BEGIN
	x := &x;
	dbms_output.put_line('Your like ' || x || 'much...');
END;
```

### Method 2
```sql
DECLARE
	x NUMBER(3);
BEGIN
	ACCEPT x NUMBER PROMPT 'Enter a number: ';
	dbms_output.put_line('Your like ' || x || 'much...');
END;
```
