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
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.locks.Lock;

/**
 * Created by User on 2/5/2017.
 */
@WebServlet(name = "FeedbackReceiveServlet", urlPatterns = "/feedbackServlet")
public class FeedbackReceiveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        String type = request.getParameter("type");
        HttpSession session=request.getSession();
        String waId = (String) session.getAttribute("currId");
        //String waId = "A1-002";
        int randomNum = ThreadLocalRandom.current().nextInt(0000, 9997 + 1);
        java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
        java.sql.Time timeNow = new java.sql.Time(date.getTime());
        String fbId = Integer.toString(randomNum);


        boolean crit = false;
        int typeInt =1;

        switch (type) {
            case "1":
                crit = false;
                typeInt=1;
                break;
            case "2":
                crit = false;
                typeInt=2;
                break;
            case "3":
                crit = true;
                typeInt=3;
                break;
            default:
                crit = true;
                typeInt=4;
                break;
        }

        try
        {
            Waypoint wa = WaypointDA.getWaypointById(waId);
            Feedback fb = new Feedback(fbId, wa.getName(), wa.getId(), crit, typeInt, date, timeNow);
            FeedbackDA.newFeedback(fb);
            WaypointDA.increaseWaypointFeedback(waId);
        }catch(SQLException e){e.printStackTrace();}

        response.sendRedirect("html/WayfinderStep4.jsp");

    }
}
