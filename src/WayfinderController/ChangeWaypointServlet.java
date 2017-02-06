package WayfinderController;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by admin on 2/3/2017.
 */
@WebServlet(name = "ChangeWaypointServlet", urlPatterns = "/changeServlet")
public class ChangeWaypointServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        session.setAttribute("changeOrigin", request.getParameter("originId"));

        response.sendRedirect("html/WayfinderStep1.jsp");
    }
}
