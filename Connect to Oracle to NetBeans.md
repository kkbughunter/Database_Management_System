

Step 01: Import this Packages
```
import java.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
```
Step 02: Create a Variables inside the Class
```
    Connection con;
    Statement st;
    PreparedStatement ps;
    ResultSet rs;
```
Step 03: Add Connection Code inside the **constructor**
```
    try {
            initComponents();
            
            Class.forName("oracle.jdbc.OracleDriver");
            try {
                con = DriverManager.getConnection("jdbc:oracle:thin:@<IP ADRESS>:XE","USERNAME","PASSWD");
            } catch (SQLException ex) {
                Logger.getLogger(insert.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(insert.class.getName()).log(Level.SEVERE, null, ex);
        }
```
Step 03.1: Create a table before runing
```
create table student1 (name VARCHAR2(25), age VARCHAR2(4));
```

Step 04: Write a Query Code **example**
 ```
      try {
            // TODO add your handling code here:
            
            String sql = "INSERT INTO student1 VALUES(?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, name.getText());
            ps.setString(2, age.getText());
            ps.execute();
        } catch (SQLException ex) {
            Logger.getLogger(insert.class.getName()).log(Level.SEVERE, null, ex);
        }
 ```

