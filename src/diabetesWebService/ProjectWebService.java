package diabetesWebService;


import diabetesModel.*;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/project")
public class ProjectWebService {

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<ProjectEntity> getProjects() {
        ProjectDAO dao = new ProjectDAO();
        List<ProjectEntity> projects = dao.getAllProjects();
        return projects;
    }
    @GET
    @Path("/{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public List<ProjectEntity> getProjectsByDoctor(@PathParam("id") String doctorId) {
        ProjectDAO dao = new ProjectDAO();
        List<ProjectEntity> projects = dao.getAllProjectsByDoctorId(doctorId);
        return projects;
    }


    @POST
    @Path("/createProject")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public ProjectEntity createProject(ProjectEntity project){
        ProjectDAO dao = new ProjectDAO();
        PatientDAO dao2 = new PatientDAO();
        DiabetepatientEntity patient = dao2.getPatient(project.getPatientId());
        String fullName = patient.getLastName() + " " + patient.getFirstName();
        System.out.println(project.getCreatedOn());
        System.out.println(project.getDoctorId());
        System.out.println(project.getPatientId());
        ProjectEntity createdProject = dao.createProject(dao.getNextId(), project.getProjectId(), project.getDoctorId(), project.getPatientId(), project.getCreatedOn(), fullName);
        return createdProject;
    }

    @POST
    @Path("/updateLevel")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public ProjectEntity updateLevel(ProjectEntity project){
        ProjectDAO dao = new ProjectDAO();
        System.out.println(project.getLevel());
        System.out.println(project.getProjectId());
        ProjectEntity updated = dao.updateLevel(project.getProjectId(), project.getLevel());
        return updated;
    }


}