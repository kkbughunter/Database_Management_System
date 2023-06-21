# Database Connectivity

```sql
CREATE TABLE emp(
   name VARCHAR2(30),
   age NUMBER(5),
   dob VARCHAR2(30)
);
  ```
Change the IP over the line
```java
con = DriverManager.getConnection("jdbc:oracle:thin:@<IP ADDRESS>:1521:XE","system","01041");
```

