package diabetesWebService;

import diabetesModel.DiabetelogDAO;
import diabetesModel.DiabetelogEntity;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Owner on 12/23/2016.
 */
@Path("/diabetelog")
public class DiabetelogWebService {

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<DiabetelogEntity> getDiabetelogs() {
        DiabetelogDAO dao = new DiabetelogDAO();
        List<DiabetelogEntity> logs = dao.getAllDiabetesLog();
        return logs;
    }

    @GET
    @Path("/{id}/{date}")
    @Produces({MediaType.APPLICATION_JSON})
    public List<DiabetelogEntity> getDiabetelogsByProjectIdAndDate(@PathParam("id") String projectId,
                                                                   @PathParam("date") String date) {
        DiabetelogDAO dao = new DiabetelogDAO();
        System.out.println("'"+projectId+"'");
        System.out.println("'"+date+"'");
        List<DiabetelogEntity> logs = dao.getAllLogByProjectIdAndDate(projectId, date);
        return logs;
    }

    @POST
    @Path("/addValue")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public DiabetelogEntity addTrackingValue(DiabetelogEntity log){
        DiabetelogDAO dao = new DiabetelogDAO();
        System.out.println(log.getNotes());
        System.out.println(log.getTrackTime());
        System.out.println(log.getGlucoseLevel());
        DiabetelogEntity addedTV = dao.addTrackingValue(dao.getNextId(), log.getTrackDate(), log.getTrackTime(), log.getGlucoseLevel(), log.getNotes(), log.getProjectId());
        return addedTV;
    }

    @GET
    @Path("averageGlucose/{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public List<DiabetelogEntity> getAvgGlucoseByProjectId(@PathParam("id") String projectId) {
        DiabetelogDAO dao = new DiabetelogDAO();
        List<String> avgGlucoseListA = dao.getAvgGlucoseListAByProjectId(projectId);
        List<Double> avgGlucoseListB = dao.getAvgGlucoseListBByProjectId(projectId);
        List<DiabetelogEntity> log = new ArrayList<DiabetelogEntity>();

        for (int i = 0; i < avgGlucoseListA.size(); i++) {
            String trackDate = avgGlucoseListA.get(i);
            double glucoseLevel = avgGlucoseListB.get(i);
            int glucoseLevelInt = (int)glucoseLevel;
            System.out.println(trackDate);
            System.out.println(glucoseLevelInt);
            log.add(new DiabetelogEntity(trackDate,glucoseLevelInt));
        }
        return log;
    }



}
