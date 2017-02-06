package Controller;

import Database.LoginDBAO;
import Model.Doctor;
import Model.Patient;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by PawandeepSingh on 4/1/17.
 */
@WebServlet(name = "LoginServlet",urlPatterns = "/dashboard")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // session
        HttpSession session = request.getSession(true);

        //get username and password
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Object user = LoginDBAO.getUser(username,password);
        if(!(user == null))
        {
            if(user instanceof Doctor)
            {
                Doctor dr = (Doctor) user;
                session.setAttribute("user",dr);
                session.setAttribute("doctor",dr);//create session attribute of user object

                //                //go to H@h dashboard
                RequestDispatcher rd = request.getRequestDispatcher("telehtml/H@Hboard/H@HBoard.jsp");
                //            "html/DoctorDashboard/DashboardDoctor.jsp"
                rd.forward(request,response);

            }
            else if (user instanceof Patient)
            {
                Patient pt = (Patient) user;
                //GO TO PATIENT H@h BOARD
                session.setAttribute("user",pt);
                session.setAttribute("patient",pt);//create session attribute of user object
                RequestDispatcher rd = request.getRequestDispatcher("telehtml/H@Hboard/H@HBoard.jsp");
                rd.forward(request,response);

            }
        }
        else
            {
                request.setAttribute("errorMessage","Invalid user or password");
                request.getRequestDispatcher("telehtml/Login/Login.jsp").forward(request,response);

            }

//
//        //get the user from db
//        User user = LoginDBAO.getUser(username,password);
//        if(!(user==null))//if user is in DB
//        {
//            session.setAttribute("user",user);//create session attribute of user object
//
//            if(user instanceof Doctor) //if user is a doctor
//            {
//                //go to H@h dashboard
//                RequestDispatcher rd = request.getRequestDispatcher("html/H@Hboard/H@HBoard.jsp");
//                //            "html/DoctorDashboard/DashboardDoctor.jsp"
//                rd.forward(request,response);
//            }
//            else if(user instanceof Patient)
//            {
//                //GO TO PATIENT DASHBOARD
//
//            }
//
//
//        }
//        else // if user not in DB
//            {   //set a request attribute back to login page
//                request.setAttribute("errorMessage","Invalid user or password");
//                request.getRequestDispatcher("html/Login/LoginPage.jsp").forward(request,response);
//            }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
//        request.setAttribute("session invalid","invalid");
//        request.getRequestDispatcher("html/Login/Login.jsp").forward(request,response);

    }
}
