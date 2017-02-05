package diabetesWebService;

import diabetesModel.DiabetedoctorEntity;
import diabetesModel.DoctorDAO;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/doctor")
public class DoctorWebService {

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<DiabetedoctorEntity> getDoctors() {
        DoctorDAO dao = new DoctorDAO();
        List<DiabetedoctorEntity> doctors = dao.getAllDoctors();
        return doctors;
    }
    @GET
    @Path("/{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public DiabetedoctorEntity getDoctor(@PathParam("id") String doctorId) {
        System.out.println("doctorId " + doctorId);
        DoctorDAO dao = new DoctorDAO();
        DiabetedoctorEntity doctor = dao.getDoctor(doctorId);
        return doctor;
    }
}