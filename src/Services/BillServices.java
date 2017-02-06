package Services;

import Database.BillDBAO;
import Database.PaymentDBAO;
import Model.Bill;
import Utility.BillUtility;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by PawandeepSingh on 5/2/17.
 */
// The Java class will be hosted at the URI path "/helloworld"
@Path("/bill")
public class BillServices {
    // The Java method will process HTTP GET requests

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getpatientconsultationbill/{id}")
    public String getPatientConsultationBill(@PathParam("id") String consultationid) {
        Gson gson = new Gson();

        Bill consultationBill = BillUtility.viewBill(consultationid);
        return gson.toJson(consultationBill);
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getpatientbills/{id}")
    public String getPatientBills(@PathParam("id") String patientID)
    {
        Gson gson = new Gson();
        List<Bill> billList = BillDBAO.getPatientBills(patientID);

        for (int i = 0 ; i<billList.size();i++)
        {
            boolean paymentexists =  PaymentDBAO.checkPaymentExists(billList.get(i).getBillID());
            if(paymentexists)
            {
                billList.get(i).setPaymentMade(true);
            }
        }


        return gson.toJson(billList);
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getbill/{id}")
    public String getBill(@PathParam("id") String billid)
    {
        Gson gson = new Gson();
      Bill bill = BillDBAO.getBill(billid);
        Bill consultBill = BillUtility.viewBill(bill.getConsultID());


        return gson.toJson(consultBill);
    }




}
