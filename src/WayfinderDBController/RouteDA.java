package WayfinderDBController;

import WayfinderModel.Path;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import wayfinder.db.DBController;

/**
 * Created by admin on 12/13/2016.
 */
public class RouteDA {

    public Path getRoute(String routeId) throws SQLException {
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("SELECT * FROM route WHERE id = '" + routeId + "';");
        myRs = myStmt.executeQuery();
        myRs.next();
        return convertToRoute(myRs);
    }

    public ArrayList<Path> getRouteList(ArrayList<String> idList)throws SQLException{
        ArrayList<Path> pathList = new ArrayList<Path>();
        for(int i=0; i<idList.size(); i++){
            System.out.println(idList.size() + " :TRUESIZE" );
            pathList.add(getRoute(idList.get(i)));
            System.out.println(pathList.size());
        }
        return pathList;
    }

    public static Path convertToRoute(ResultSet myRs) throws SQLException{
        String id = myRs.getString(1);
        String parentA = myRs.getString(2);
        System.out.println(parentA);
        String parentB = myRs.getString(3);
        boolean access = myRs.getBoolean(4);
        boolean avail = myRs.getBoolean(5);
        String desciption = myRs.getString(6);
        System.out.println(desciption);

        return new Path(id, parentA, parentB, access, avail, desciption);
    }

    public static ArrayList<Path> getAllRoute() throws SQLException{
        ArrayList<Path> pathList = new ArrayList<Path>();
        DBController dbController = new DBController();
        Connection myConn = dbController.getConnection();
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        myStmt = myConn.prepareStatement("SELECT * FROM route;");
        myRs = myStmt.executeQuery();
        while(myRs.next())
        {
            pathList.add(convertToRoute(myRs));
        }
        return pathList;
    }

}
