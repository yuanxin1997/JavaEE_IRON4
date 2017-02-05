package diabetesWebService;

import diabetesModel.DiabetepatientEntity;
import diabetesModel.PatientDAO;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by Owner on 12/22/2016.
 */
@Path("/patient")
public class PatientWebService {

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<DiabetepatientEntity> getPatients() {
        PatientDAO dao = new PatientDAO();
        List<DiabetepatientEntity> patients = dao.getAllPatients();
        return patients;
    }
    @GET
    @Path("/{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public DiabetepatientEntity getPatient(@PathParam("id") String patientId) {
        System.out.println("patientId " + patientId);
        PatientDAO dao = new PatientDAO();
        DiabetepatientEntity patient = dao.getPatient(patientId);
        return patient;
    }
}
