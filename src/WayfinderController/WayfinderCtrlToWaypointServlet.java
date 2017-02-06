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
 * Created by admin on 2/5/2017.
 */
@WebServlet(name = "WayfinderCtrlToWaypointServlet", urlPatterns = "/waypointRedirect")
public class WayfinderCtrlToWaypointServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String waId = request.getParameter("waypointId");

        try
        {
            HttpSession session = request.getSession();
            Waypoint wa = (Waypoint) WaypointDA.getWaypoint(waId);
            session.setAttribute("feedbackSelected", wa);
        }catch(SQLException e){e.printStackTrace();}

        response.sendRedirect("html/WaypointFeedbackControl.jsp");
    }
}
