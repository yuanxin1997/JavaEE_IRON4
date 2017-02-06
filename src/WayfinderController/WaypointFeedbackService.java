package WayfinderController;

import WayfinderDBController.FeedbackDA;
import WayfinderDBController.WaypointDA;
import WayfinderModel.Feedback;
import WayfinderModel.Waypoint;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by User on 2/5/2017.
 */
@Path("/waypointFeedback")
public class WaypointFeedbackService {

        @GET
        @Path("/getAllFeedback/{id}")
        @Produces({MediaType.APPLICATION_JSON})
        public String getAllFeedbackWaypoints(@PathParam("id") String id)
        {

            Gson gson = new Gson();
            ArrayList<Feedback> fbList = new ArrayList<Feedback>();
            try
            {
                fbList = FeedbackDA.getAllFeedback(id);
            }catch(SQLException e){e.printStackTrace();}


            return gson.toJson(fbList);
        }

        @GET
        @Produces({MediaType.APPLICATION_JSON})
        @Path("/checkStatus/{id}")
        public String checkWaypointStatus(@PathParam("id") String id) throws SQLException
        {
            Gson gson = new Gson();

            Waypoint w = WaypointDA.getWaypoint(id);

            return gson.toJson(w);
        }


}
