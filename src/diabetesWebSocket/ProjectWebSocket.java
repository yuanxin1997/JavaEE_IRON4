package diabetesWebSocket;


import diabetesModel.ProjectDAO;
import diabetesModel.ProjectEntity;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;


@ServerEndpoint(value="/project/{id}",
        encoders={ProjectEncoder.class},
        decoders={ProjectDecoder.class}
)
public class ProjectWebSocket {
    private static Set<Session> allSessions = new HashSet<Session>();
    @OnOpen
    public void onOpen(@PathParam("id") String id, Session session){
        System.out.println("user : " + id + " is connected for session: " + session.getId());
        session.getUserProperties().put("id", id);
        allSessions.add(session);
        System.out.println("===All connected user(Project)===");
        for (Session s : allSessions) {
            System.out.println(s.getUserProperties().get("id"));
        }
        System.out.println("========================");
    }

    @OnMessage
    public void onMessage(ProjectEntity project, Session session) throws IOException {
        ProjectDAO dao = new ProjectDAO();
        System.out.println(project.getLevel());
        System.out.println(project.getProjectId());
        ProjectEntity updated = dao.updateLevel(project.getProjectId(), project.getLevel());

        for (Session s: allSessions) {
            try {
                s.getBasicRemote().sendObject(updated);
                System.out.println("Sent : " + updated);
            } catch (EncodeException e) {
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(CloseReason reason, Session session) {
        allSessions.remove(session);
        System.out.println("Closing a WebSocket due to " + reason.getReasonPhrase());
        System.out.println("Session Id: " + session.getId() + " has ended");
        System.out.println("===All connected user(Project)===");
        for (Session s : allSessions) {
            System.out.println(s.getUserProperties().get("id"));
        }
        System.out.println("========================");

    }
    @OnError
    public void onError(Session session, Throwable thr) {
        allSessions.remove(session);
        System.out.println("error occur");
    }

}