package WayfinderController;
import WayfinderDBController.FeedbackDA;
import WayfinderDBController.WaypointDA;
import WayfinderModel.Feedback;
import WayfinderModel.Waypoint;
import com.google.gson.Gson;
import com.sun.net.httpserver.HttpServer;
import com.sun.jersey.api.container.httpserver.HttpServerFactory;
import com.sun.syndication.feed.atom.Feed;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;


@Path("/wayfinderFeedback")
public class WayfinderFeedbackService{

    @GET
    @Path("/getWaypoint")
    @Produces({MediaType.APPLICATION_JSON})
    public String getAllFeedbackWaypoints() throws SQLException
    {
        Gson gson = new Gson();
        ArrayList<Waypoint> fbList = WaypointDA.getAllWaypointNoAccess();

        return gson.toJson(fbList);
    }
    @GET
    @Path("/getFeedbackTime/{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public String getFeedbackTime(@PathParam("id") String id) throws SQLException
    {
        Gson gson = new Gson();

        ArrayList<Feedback> fbList = FeedbackDA.getAllFeedback(id);

        return gson.toJson(fbList);
    }
}
