package WayfinderDBController;

import WayfinderModel.Feedback;
import wayfinder.db.DBController;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by admin on 12/13/2016.
 */
public class FeedbackDA {

    public static void newFeedback(Feedback f) {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        PreparedStatement preparedStatement = null;

        String insertTableSQL = "INSERT INTO feedback"
                + "(id, name, waypoint_id, crit, type, date, time) VALUES"
                + "(?,?,?,?,?,?,?)";

        java.sql.Date dateNow = new Date(Calendar.getInstance().getTimeInMillis());

        java.sql.Time timeNow = new java.sql.Time(dateNow.getTime());

        try {
            preparedStatement = myConn.prepareStatement(insertTableSQL);

            preparedStatement.setString(1, f.getId());
            preparedStatement.setString(2, f.getName());
            preparedStatement.setString(3, f.getWaypointId());
            preparedStatement.setBoolean(4, f.getCrit());
            preparedStatement.setInt(5, f.getType());
            preparedStatement.setDate(6, dateNow);
            preparedStatement.setTime(7, timeNow);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Feedback getFeedback(String id) throws SQLException {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("SELECT * FROM feedback WHERE id = '" + id + "';");
        myRs = myStmt.executeQuery();
        myRs.next();
        return convertToFeedback(myRs);
    }

    public static ArrayList getAllFeedback() throws SQLException {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        ArrayList<Feedback> allFeedback = new ArrayList<Feedback>();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("SELECT * FROM feedback;");
        myRs = myStmt.executeQuery();
        while(myRs.next())
        {
            allFeedback.add(convertToFeedback(myRs));
        }
        return allFeedback;
    }

    public static ArrayList getAllFeedback(String id) throws SQLException {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        ArrayList<Feedback> allFeedback = new ArrayList<Feedback>();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("SELECT * FROM feedback WHERE waypoint_id = '"+id+"'" +
                "ORDER BY date, time DESC;");
        myRs = myStmt.executeQuery();
        while(myRs.next())
        {
            allFeedback.add(convertToFeedback(myRs));
        }
        return allFeedback;
    }

    public static Feedback convertToFeedback(ResultSet myRs) throws SQLException{
        String id = myRs.getString(1);
        String name = myRs.getString(2);
        String waypointId = myRs.getString(3);
        boolean crit = myRs.getBoolean(4);
        int type = myRs.getInt(5);
        Date date = myRs.getDate(6);
        Time time = myRs.getTime(7);

        return new Feedback(id,name,waypointId,crit,type,date,time);
    }

    public static void deleteFeedback(String id) throws SQLException {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("DELETE FROM feedback WHERE id='"+id+"';");
        myStmt.executeUpdate();
    }

    public static void deleteAllIdFeedback(String id) throws SQLException {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("DELETE FROM feedback WHERE waypoint_id='"+id+"';");
        myStmt.executeUpdate();
    }

    public static void deleteAllFeedback() throws SQLException {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("DELETE FROM feedback;");
        myStmt.executeUpdate();
    }

}
