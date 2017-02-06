package WayfinderController;

import WayfinderDBController.WaypointDA;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by admin on 2/2/2017.
 */
@WebServlet(name = "MapPointServlet", urlPatterns = "/mapServlet")
public class MapPointServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ReentrantLock lock = new ReentrantLock();

        HttpSession session=request.getSession();
        ArrayList<Integer> x = new ArrayList<Integer>();
        ArrayList<String> waypointIDList = new ArrayList<String>();

        if(session.getAttribute("irc")==null)
        {
            String selR = request.getParameter("selectedRoute");

            if(selR.equalsIgnoreCase("accessRoute"))
            {
                waypointIDList = (ArrayList<String>) session.getAttribute("accessRouteString");
                session.setAttribute("selectedRoute", waypointIDList);
            }
            else
            {
                waypointIDList = (ArrayList<String>) session.getAttribute("bestRouteString");
                session.setAttribute("selectedRoute", waypointIDList);
            }

//            waypointIDList.add("A1-001");
//            waypointIDList.add("A1-003");
//            waypointIDList.add("A1-005");session.setAttribute("selectedRoute", waypointIDList);

            lock.lock();
            System.out.println("PROCESS LOCKED *********************");
            ImageRenderController irc = new ImageRenderController();
            String imgPath = "";
            try {



                try
                {
                    //Path path = FileSystems.getDefault().getPath("C:/Users/admin/IdeaProjects/IronFour/web/img/", "generatedMap.png");
                    //Files.delete(path);
                    x = WaypointDA.getCoordinatesById(waypointIDList.get(0));
                    irc.spawnWaypoints(waypointIDList);
                    irc.spawnArrows(waypointIDList);
                    imgPath = irc.spawnCurrentIndicator(x.get(0), x.get(1));
                }catch (SQLException e){e.printStackTrace();}

            } finally {
                lock.unlock();
                System.out.println("PROCESS UNLOCKED ***********************");


                session.setAttribute("irc", irc);
                session.setAttribute("nextPoint", 1);
                session.setAttribute("imgPath", imgPath);
                System.out.println("Servlet Initial Map Spawn executed.");
                response.sendRedirect("html/WayfinderStep4.jsp");
            }

        }
        else
        {
            ImageRenderController irc = (ImageRenderController) session.getAttribute("irc");
            waypointIDList = (ArrayList<String>) session.getAttribute("selectedRoute");
            int i = (Integer) session.getAttribute("nextPoint");
            String error = "";
            String imgPath = "";

            lock.lock();

            try {

                try
                {
//                    Path path = FileSystems.getDefault().getPath("C:/Users/admin/IdeaProjects/IronFour/web/img/", "generatedMap.png");
//                    Files.delete(path);

                    x = WaypointDA.getCoordinatesById(waypointIDList.get(i));
                    System.out.println(waypointIDList.get(i) + " ID. Xcordinates: " + x.get(0));
                    imgPath = irc.spawnCurrentIndicator(x.get(0), x.get(1));
                    error = request.getParameter("error");

                }catch (SQLException|NullPointerException e){e.printStackTrace();}

            } finally {
                lock.unlock();

                if(error.equalsIgnoreCase("true"))
                {
                    session.setAttribute("nextPoint", i);
                    session.setAttribute("imgPath", imgPath);
                    response.sendRedirect("html/WayfinderStep4.jsp");
                    System.out.println("Error in MapPoint");
                }
                else
                {
                    session.setAttribute("nextPoint", i+1);
                    session.setAttribute("imgPath", imgPath);
                    response.sendRedirect("html/WayfinderStep4.jsp");
                    System.out.println("MapPoint executed");
                }

                System.out.println("Servlet Subsequent Spawn executed.");

            }
        }
    }
}
