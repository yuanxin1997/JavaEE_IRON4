package WayfinderController;

import WayfinderDBController.WaypointDA;
import WayfinderModel.Waypoint;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by User on 2/1/2017.
 */
@WebServlet(name = "QRServlet", urlPatterns = "/qrscan")
public class QRServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session=request.getSession(true);
        String usage = (String) session.getAttribute("usage");

        if((usage!=null && usage.equals("origin"))){
            String name="";
            String id = request.getParameter("id");
            String destId = (String) session.getAttribute("destId");

            ArrayList<String> accessRouteString = new ArrayList<String>();
            ArrayList<String> bestRouteString = new ArrayList<String>();
            ArrayList<Waypoint> accessRoute = new ArrayList<Waypoint>();
            ArrayList<Waypoint> bestRoute = new ArrayList<Waypoint>();

            RoutingController rc = new RoutingController();

            accessRouteString = rc.routeAccess(id, destId);
            bestRouteString = rc.routeBest(id, destId);

            try
            {
                accessRoute = WaypointDA.getWaypointList(accessRouteString);
                bestRoute = WaypointDA.getWaypointList(bestRouteString);
                name = WaypointDA.getWaypointById(id).getName();
            }catch(SQLException e){e.printStackTrace();}

            session.setAttribute("orgId", id);
            session.setAttribute("currId", id);
            session.setAttribute("orgName", name);
            session.setAttribute("bestRoute", bestRoute);
            session.setAttribute("accessRoute", accessRoute);
            session.setAttribute("accessRouteString", accessRouteString);
            session.setAttribute("bestRouteString", bestRouteString);

            System.out.println("Servlet Origin Scan executed.");
            response.sendRedirect("html/WayfinderStep3.jsp");
        }
        else if((usage!=null && usage.equals("map"))){
            String currId = request.getParameter("id");
            session.setAttribute("currId",currId);
            int i =  (Integer) session.getAttribute("nextPoint");
            ArrayList<String> selectedRoute = new ArrayList<String>();
            selectedRoute = (ArrayList<String>) session.getAttribute("selectedRoute");

            System.out.println("Servlet Progress Scan executed: next Point = " + i + " right ID = "+ selectedRoute.get(i) );
            System.out.println("Servlet Progress Scan executed pt2: curr ID = "+ currId + " Selected route size: "+ selectedRoute.size());

            if((i+2)>selectedRoute.size() && selectedRoute.get(i).equalsIgnoreCase(currId)){
                response.sendRedirect("html/WayfinderEnd.jsp");
                System.out.println("Map point ends");
            }else if(selectedRoute.get(i).equalsIgnoreCase(currId)){
                response.sendRedirect("/mapServlet?error=false");
                System.out.println("QRServlet sent positive");
            }else if(!selectedRoute.get(i).equalsIgnoreCase(currId)){
                response.sendRedirect("/mapServlet?error=true");
                System.out.println("QRServlet sent error");
            }
        }

    }
}
