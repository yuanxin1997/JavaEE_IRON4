package Controller;

import Database.BillDBAO;
import Database.ConsultationDBAO;
import Database.PrescriptionDBAO;
import Model.Bill;
import Model.Prescription;
import Utility.BillUtility;
import Utility.MedicineUtility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 6/1/17.
 */
@WebServlet(name = "ConferenceServlet",urlPatterns = {"/conference"})
public class ConferenceServlet extends HttpServlet {

    //Variables
    //TO BE SHARED ACROSS THE POST AND GET METHODS

    private String patientID;
    private String consultationID;

    //private String consultationType;

    //POST WILL BE CALLED WHEN Conference ends
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        Bill bill;
        System.out.println(patientID + "\t " + consultationID);

        Prescription prescription;//Create Prescription

        //GET respectives Parameters
        String consultDuration = request.getParameter("duration");
        System.out.println(consultDuration);


        String report = request.getParameter("finalReport");
        String[] medicines = request.getParameterValues("medicineName");
        String [] dosesnum = request.getParameterValues("dosesNum");
        String [] doseunit = request.getParameterValues("doseUnit");
        String[] frequencynum = request.getParameterValues("frequencyNum");
        String[] frequencyunit = request.getParameterValues("frequencyUnit");

        Double consultdurationdb = new Double( Double.parseDouble(consultDuration));
        int consultdurationINT = consultdurationdb.intValue();

        if(!(medicines.length == 0)) //if have medicines
        {
            //Store array variables into Lists
            List<String> medicineName = new ArrayList<String>();
            List<String> Doses = new ArrayList<String>();
            List<String> Frequency = new ArrayList<String>();

            for (int i = 0 ; i < medicines.length;i++)
            {
                //store array elements into respective lists
                medicineName.add(medicines[i]);
                Doses.add(dosesnum[i] + " " + doseunit[i]);
                Frequency.add(frequencynum[i] + " " + frequencyunit[i]);
                System.out.println(medicines[i] + "\t" + dosesnum[i] + "\t" + doseunit[i] + frequencynum[i]);
            }
            System.out.println("size " + medicineName.size());
            List<String> medicineIdlist = MedicineUtility.getMedicineIDviaName(medicineName);
            System.out.println(medicineIdlist.get(0));
            //instianitate object with respective values
            //medicineName

            prescription = new Prescription(consultationID,patientID,medicineIdlist,Doses,Frequency);



            bill = BillUtility.CalculateBill(medicineIdlist,consultdurationINT,consultationID);

            System.out.println(bill.getConsultID());
            System.out.println(bill.getTotalAmountPayable());
            System.out.println(bill.getBillingDate());


            //when prescription inserted and consultation updated successfully
            if(PrescriptionDBAO.addPatientPrescriptions(consultationID,patientID, prescription) && ConsultationDBAO.updateDoctorConsultation(report,consultationID,"FINISHED",consultDuration)
                    && BillDBAO.createBill(bill))
            {
                //Direct back to doctordashboard
                RequestDispatcher rd = request.getRequestDispatcher("/telehtml/Dashboard/doctorDashboard.jsp");//TODO CHANGE DIRECTORY OF CONFERENCE FROM DOCTOR DASHBOARD
                rd.forward(request,response);
            }
            else
            {
                System.out.println("ERROROROROROROROROOROROROROROROROROOR");

            }
        }
        else
            {
                bill = BillUtility.CalculateBill(null,consultdurationINT,consultationID);

                if(ConsultationDBAO.updateDoctorConsultation(report,consultationID,"FINISHED",consultDuration)  && BillDBAO.createBill(bill))
                {
                    //Direct back to doctordashboard
                    RequestDispatcher rd = request.getRequestDispatcher("/telehtml/Dashboard/doctorDashboard.jsp");//TODO CHANGE DIRECTORY OF CONFERENCE FROM DOCTOR DASHBOARD
                    rd.forward(request,response);
                }
                else
                {
                    System.out.println("ERROROROROROROROROOROROROROROROROROOR");
                }
            }







    }

    //GET WILL BE CALLED WHEN Dashbord directs to conference to respective patient
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        //GET nric and consultit
        patientID = request.getParameter("nric");
        consultationID = request.getParameter("cid");

       String consultationType = request.getParameter("consultype");

        //Afterwards direct user to conference page
        RequestDispatcher rd = request.getRequestDispatcher("telehtml/teleConference/doctorConference.jsp");//TODO CHANGE DIRECTORY OF CONFERENCE FROM DOCTOR DASHBOARD
        rd.forward(request,response);
    }
}
