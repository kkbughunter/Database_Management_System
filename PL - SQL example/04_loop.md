# Loop in Pl/Sql
## Types of Loop
  - FOR LOOP
  - WHILE LOOP
  - DO-WHILE LOOP
## Advanced level LOOP (let we see later)
  - FORALL
  - Cursor FOR LOOP


## FOR LOOP
```sql
DECLARE
	n NUMBER(3);
BEGIN
	n := 5;
	FOR i IN 0..n LOOP
		dbms_output.put_line(i);
	END LOOP;
END;
```

## WHILE LOOP
```sql
DECLARE
	n NUMBER(3) := 10;
	i NUMBER(3) := 5;
BEGIN
	WHILE i <= n LOOP
		dbms_output.put_line(i);
		i := i + 1;
	END LOOP;
END;
```
## DO-WHILE LOOP
```sql
DECLARE 
	n NUMBER(3) := 20;
	i NUMBER(3) := 0;
BEGIN
	LOOP 
    	dbms_output.put_line(i);
		i := i + 5;
	EXIT WHEN i>=n; 
	END LOOP;
END;
```
