package diabetesWebService;


import diabetesModel.ScheduleDAO;
import diabetesModel.ScheduleEntity;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by Owner on 1/15/2017.
 */
@Path("/schedule")
public class ScheduleWebService {

    @GET
    @Path("/{id}/{day}")
    @Produces({MediaType.APPLICATION_JSON})
    public List<ScheduleEntity> getEventsByProjectIdAndDate(@PathParam("id") String projectId,
                                                            @PathParam("day") String day) {
        ScheduleDAO dao = new ScheduleDAO();
        List<ScheduleEntity> schedule = dao.getScheduleByProjectIdAndDay(projectId, day);
        return schedule;
    }

    @POST
    @Path("/addEvent")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public ScheduleEntity addEvent(ScheduleEntity event){
        ScheduleDAO dao = new ScheduleDAO();
        System.out.println(event.getTag());
        System.out.println(event.getStartTime());
        ScheduleEntity added = dao.addEvent(dao.getNextId(), event.getDay(), event.getProjectId(), event.getTag(), event.getStartTime(), event.getEndTime(), event.getContent(), "no");
        return added;
    }

    @DELETE
    @Path("/{deleteId}")
    @Produces({MediaType.APPLICATION_JSON})
    public ScheduleEntity removeEvent(@PathParam("deleteId") int id){
        ScheduleDAO dao = new ScheduleDAO();
        ScheduleEntity removed = dao.removeEvent(id);
        return removed;
    }

    @PUT
    @Path("/updateEvent")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public ScheduleEntity updateEvent(ScheduleEntity event){
        ScheduleDAO dao = new ScheduleDAO();
        System.out.println(event.getTag());
        System.out.println(event.getContent());
        ScheduleEntity updated = dao.updateEvent(event.getId(), event.getDay(), event.getProjectId(), event.getTag(), event.getStartTime(), event.getEndTime(), event.getContent(), event.getDeleteStatus());
        return updated;
    }

}
