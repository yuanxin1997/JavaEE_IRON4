package Database;

import java.sql.*;

public class DBController {
    private Connection con;

    /********************************************************
     * Method Name : testDriver
     * Input Parameter : nil
     * Purpose : To test if the driver is properly installed
     * Return :nil
     *******************************************************/

    public void testDriver() throws Exception {
        System.out.println("Initializing Server... ");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println(" Driver Found.");
        }
        catch (ClassNotFoundException e) {
            System.out.println(" Driver Not Found, exiting..");
            throw (e);
        }
    }
    public void getConnection(){
        String url = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            url = "jdbc:mysql://localhost/jedp";
            con = DriverManager.getConnection(url, "root", "IT1639");
            System.out.println("Successfully connected to " + url+ ".");
        }
        catch (SQLException e) {
            System.out.println("Connection failed ->"+ url);
            System.out.println(e);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    /************************************************************
     * Method Name : readRequest
     * Input Parameter : String (database query)
     * Purpose : Obtain the result set from the db query
     * Return : resultSet (records from the query)
     ************************************************************/
    public ResultSet readRequest(String dbQuery) {
        ResultSet rs = null;
        System.out.println("DB Query: " + dbQuery);
        try {
            // create a statement object
            Statement stmt = con.createStatement();
            // execute an SQL query and get the result
            rs = stmt.executeQuery(dbQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    /***********************************************************
     * Method Name : updateRequest
     * Input Parameter : String (database query)
     * Purpose : Execute update using the db query
     * Return : int (count is 1 if successful)
     ***********************************************************/
    public int updateRequest(String dbQuery) {
        int count = 0;
        System.out.println("DB Query: " + dbQuery);
        try {
            // create a statement object
            Statement stmt = con.createStatement();
            // execute an SQL query and get the result
            count = stmt.executeUpdate(dbQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    /***********************************************************
     * Method Name : getPreparedStatement
     * Input Parameter : String (database query)
     * Purpose : Gets Prepared Statement using the db query
     * Return : Prepared Statement
     ***********************************************************/
    public PreparedStatement getPreparedStatement(String dbQuery) {
        PreparedStatement pstmt = null;
        System.out.println("DB prepare statement: " + dbQuery);
        try {
            // create a statement object
            pstmt = con.prepareStatement(dbQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pstmt;
    }
    /***********************************************************
     * Method Name : terminate
     * Input Parameter : nil
     * Purpose : Close db conection
     * Return :nil
     **********************************************************/
    public void terminate() {
        // close connection
        try {
            con.close();
            System.out.println("Connection is closed");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	public static void main(String[] arg)throws Exception{
		DBController db = new DBController();
		db.testDriver();
		db.getConnection();
	}
}