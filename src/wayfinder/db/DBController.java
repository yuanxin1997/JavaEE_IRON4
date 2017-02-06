package wayfinder.db;

import java.sql.*;

public class DBController {
    private Connection myConn;
    private Statement myStmt;
    private ResultSet myRs;
    private String myUrl = "jdbc:mysql://localhost/jedp?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    private String myUser = "root";
    private String myPass = "060122";

    public Connection getConnection() {
        try { // here
            Class.forName("com.mysql.jdbc.Driver");
            myConn = DriverManager.getConnection(myUrl, myUser, myPass);
            System.out.println("Connection established");

        }
        catch(ClassNotFoundException e) {
            e.printStackTrace();
        }
        catch(SQLException e) {
            e.printStackTrace();
        }
        return myConn;
    }
}
