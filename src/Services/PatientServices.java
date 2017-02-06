package Services;

import Database.PatientDBAO;
import Model.Patient;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by PawandeepSingh on 4/1/17.
 */


@Path("/patient")
public class PatientServices
{



    /**
     * PURPOSE : to get all patient records
     *@return  JSON String ; which is a list of patients
     *
     * **/
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getallpatients")
    public String getAllPatients()
    {
        Gson gson = new Gson();
        List<Patient> patientList = PatientDBAO.getAllPatients();
        return gson.toJson(patientList);

    }




}
