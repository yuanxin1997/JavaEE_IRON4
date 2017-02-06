package WayfinderController;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by User on 2/1/2017.
 */
@WebServlet(name = "OriginServlet", urlPatterns = "/orgscan")
public class OriginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session=request.getSession();
        session.setAttribute("usage", "origin");
        System.out.println("Servlet forwarding to QR Origin. usage id="+session.getAttribute("usage"));
        response.sendRedirect("html/WayfinderQR.jsp");

    }
}
