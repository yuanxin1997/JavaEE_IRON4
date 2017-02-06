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

/**
 * Created by User on 2/6/2017.
 */
@WebServlet(name = "FeedbackEnableServlet", urlPatterns = "/enableWaypoint")
public class FeedbackEnableServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        Waypoint w = new Waypoint();
        try
        {
            w = WaypointDA.getWaypoint(id);

            if(w.getListValue().equalsIgnoreCase("1")){
                WaypointDA.enableWaypoint(id);
            }
            else{
                WaypointDA.disableWaypoint(id);
            }

            w = WaypointDA.getWaypoint(id);
        } catch (SQLException e){e.printStackTrace();}



        session.setAttribute("feedbackSelected", w);

        response.sendRedirect("html/WaypointFeedbackControl.jsp");
    }
}
