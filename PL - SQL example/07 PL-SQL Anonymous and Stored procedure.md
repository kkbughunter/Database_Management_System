## Anonymous PL/SQL Code:
Anonymous PL/SQL blocks are blocks of code that are executed directly without being stored as named procedures or functions. 
They are typically used for ad-hoc or one-time tasks.
  - The Above all given code are example of **Anonymous PL/SQL Code**.

## PL/SQL Procedure Parameters:
```sql
CREATE TABLE numbers(
    number1 NUMBER(5),
    number2 NUMBER(5)
);
CREATE TABLE number_logs(
    number1 NUMBER(5),
    number2 NUMBER(5),
    res NUMBER(10)
);
INSERT INTO numbers VALUES(10,50);
```

```sql
CREATE OR REPLACE PROCEDURE add2num (
  p_number1 NUMBER, -- IN argument 1
  p_number2 NUMBER, -- IN argument 2
  p_sum OUT NUMBER  -- OUT argument 
)
AS
BEGIN
  p_sum := p_number1 + p_number2;
END;
/
```
```sql
DECLARE
  p_sum NUMBER;
BEGIN
  add2num(10, 20, p_sum); -- procedure call
  DBMS_OUTPUT.PUT_LINE('The sum is: ' || p_sum);
  add2num(61, 45, p_sum); -- procedure call
  DBMS_OUTPUT.PUT_LINE('The sum is: ' || p_sum);
END;
/
```




