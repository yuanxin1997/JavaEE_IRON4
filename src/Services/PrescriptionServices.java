package Services;

import Database.PrescriptionDBAO;
import Model.Prescription;
import Utility.MedicineUtility;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by PawandeepSingh on 29/1/17.
 */

@Path("/prescription")
public class PrescriptionServices {


    /**
     * PURPOSE : to get all patient records
     *@return  JSON String ; which is a list of patients
     *
     * **/
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getpastprescription/{id}")
    public String getPatientPastPrescriptions(@PathParam("id") String consultid)
    {

        Gson gson = new Gson();
        Prescription prescription = PrescriptionDBAO.getPrescriptionsByConsultationID(consultid);

        List<String> medNames = MedicineUtility.getMedicineNameviaID(prescription.getMedicineIDs());

        prescription.setMedNamelist(medNames);

        return gson.toJson(prescription);
    }

}
