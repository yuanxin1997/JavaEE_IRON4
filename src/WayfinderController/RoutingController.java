package WayfinderController;

import WayfinderDBController.WaypointDA;
import WayfinderModel.Point;
import WayfinderModel.Route;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by User on 2/1/2017.
 */
public class RoutingController {
    private ArrayList<Point> pointList;
    private ArrayList<Point> accessPointList;
    private ArrayList<Point> accessBorderList;
    private ArrayList<Point> universalPoints;

    public RoutingController()
    {
        try
        {
            pointList = WaypointDA.getPointList();
            accessPointList = WaypointDA.getAccessPointList();
            accessBorderList = WaypointDA.getAccessBorderList();
            universalPoints = WaypointDA.getUniversalPoints();
        }catch(SQLException e)
        {
            e.printStackTrace();
        }
    }

    public ArrayList<String> routeBest(String start, String dest)
    {
        ArrayList<String> routingResult = new ArrayList<String>();
        Route r = new Route(start, dest);
        r.setStartPoint(start);
        r.setDestPoint(dest);
        r.setShortestRoute(pointList);
        routingResult = r.getShortestList();

        return routingResult;
    }

    public ArrayList<String> routeAccess(String start, String dest)
    {
        ArrayList<String> routingResult = new ArrayList<String>();
        Route r = new Route(start, dest);
        r.setStartPoint(start);
        r.setDestPoint(dest);
        routingResult = r.getAccessRoute(pointList, accessPointList, accessBorderList, universalPoints);

        return routingResult;
    }

    public static void main(String[]args)
    {
        //Best routing test
        System.out.println("Routing for best between 1 and 12: ");
        RoutingController rc = new RoutingController();
        ArrayList<String> bestRouteResult = rc.routeBest("A1-001", "A1-011");


        //Access routing test
        System.out.println("Routing for access route between 1 and 12");
        ArrayList<String> accessRouteResult = rc.routeAccess("A1-004", "A1-011");
        System.out.println("");
        System.out.println("");
        System.out.print("End Test Best Route: ");
        for(int i = 0; i < bestRouteResult.size(); i++)
        {
            System.out.print(bestRouteResult.get(i));
            if(i != bestRouteResult.size()-1)
            {
                System.out.print(", ");
            }
        }
        System.out.println("");
        System.out.print("End Test Access Route: ");
        for(int i = 0; i < accessRouteResult.size(); i++)
        {
            System.out.print(accessRouteResult.get(i));
            if(i != accessRouteResult.size()-1)
            {
                System.out.print(", ");
            }
        }
        System.out.println("");
    }
}
