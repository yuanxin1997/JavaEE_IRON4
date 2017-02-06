package WayfinderController;

import WayfinderDBController.FeedbackDA;
import WayfinderDBController.WaypointDA;
import WayfinderModel.Feedback;
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
 * Created by User on 2/6/2017.
 */
@WebServlet(name = "FeedbackDismissServlet", urlPatterns = "/feedbackDismiss") // /feedbackDismiss?all=no&delAllId=no&delId=
public class FeedbackDismissServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String delAll = request.getParameter("all");
        String delAllId = request.getParameter("delAllId");
        String delId = request.getParameter("delId");

        String location = request.getParameter("from");

        try
        {

        if(!delAll.equalsIgnoreCase("no"))
        {

            ArrayList<Waypoint> wa = WaypointDA.getAllWaypointNoAccess();

            for(int i=0; i<wa.size(); i++){

                FeedbackDA.deleteAllFeedback();
                WaypointDA.decreaseWaypointFeedback(wa.get(i).getId(), wa.get(i).getFeedBackAmt());
                WaypointDA.enableWaypoint(wa.get(i).getId());

            }

        }
        else if (!delAllId.equalsIgnoreCase("no"))
            {
                Waypoint wa = (Waypoint) session.getAttribute("feedbackSelected");
                int fbNum = FeedbackDA.getAllFeedback(wa.getId()).size();
                FeedbackDA.deleteAllIdFeedback(delAllId);
                WaypointDA.decreaseWaypointFeedback(wa.getId(), fbNum);
            }
            else if (!delId.equalsIgnoreCase("no"))
            {
                System.out.println("FINAL FBID IS "+ delId);

                FeedbackDA.deleteFeedback(delId);
                Waypoint wa = (Waypoint) session.getAttribute("feedbackSelected");
                WaypointDA.decreaseWaypointFeedback(wa.getId(), 1);
            }
        }catch(SQLException e){e.printStackTrace();}



        switch(location){
            case "feedback": response.sendRedirect("html/WaypointFeedbackControl.jsp");
                break;
            default:  response.sendRedirect("html/WayfinderWaypointControl.jsp");
                break;
        }

    }
}
