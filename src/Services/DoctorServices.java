package Services;

import Database.DoctorDBAO;
import Model.Doctor;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 * Created by PawandeepSingh on 5/2/17.
 */
// The Java class will be hosted at the URI path "/helloworld"
@Path("/doctor")
public class DoctorServices {


    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getdoctor/{id}")
    public String getDoctor(@PathParam("id") String did)
    {
        Gson gson = new Gson();
        Doctor dr = new Doctor();

        dr = DoctorDBAO.getDoctor(did);

        return gson.toJson(dr);
    }
}
