package Controller;

import Database.PaymentDBAO;
import Model.Payment;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by PawandeepSingh on 5/2/17.
 */
@WebServlet(name = "PaymentServlet",urlPatterns = "/payment")
public class PaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Payment payment = new Payment();
        
        String billID = request.getParameter("billid"); //// TODO: MUST GET BILLID and patientid
        String patientID = request.getParameter("patientidinput"); // will be the nric

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String emailaddr = request.getParameter("emailaddr");

        //credit card Info

        String paymentType = request.getParameter("cardtype");
        String creditcardnum =  request.getParameter("creditcardnum"); // convert to int
        String creditcardExpiry = request.getParameter("monthexpiredate") + "/" + request.getParameter("yearexpiredate");
        String cscNum = request.getParameter("cscnum"); // convert to int

        String companyInput = request.getParameter("company");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zip"); // convert to int
        String country = request.getParameter("countryinput");
        String phone = request.getParameter("phone");

        //
        System.out.println(creditcardnum);
        int creditCardnumINT = Integer.parseInt(creditcardnum);
        int cscNumInt = Integer.parseInt(cscNum);
        int zipInt = Integer.parseInt(zipcode);
        
        payment = new Payment(billID,patientID,creditCardnumINT,paymentType,creditcardExpiry,cscNumInt,address1,address2,state,zipInt,country);

        if(PaymentDBAO.insertPayment(payment))
        {
            RequestDispatcher rd = request.getRequestDispatcher("/telehtml/Dashboard/patientBillboard.jsp");
            rd.forward(request,response);
        }




    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
