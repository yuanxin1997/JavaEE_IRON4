package diabetesWebSocket;


import diabetesModel.ProjectDAO;
import diabetesModel.ProjectEntity;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;


@ServerEndpoint(value="/newMemo/{id}",
        encoders={ProjectEncoder.class},
        decoders={ProjectDecoder.class}
)
public class NewMemoWebSocket {
    private static Set<Session> allSessions = new HashSet<Session>();
    @OnOpen
    public void onOpen(@PathParam("id") String id, Session session){
        System.out.println("user : " + id + " is connected for session: " + session.getId());
        session.getUserProperties().put("id", id);
        allSessions.add(session);
        System.out.println("===All connected user(NewMemo)===");
        for (Session s : allSessions) {
            System.out.println(s.getUserProperties().get("id"));
        }
        System.out.println("========================");
    }

    @OnMessage
    public void onMessage(ProjectEntity project, Session session) throws IOException {
        String sender = session.getUserProperties().get("id").toString();
        String identity = sender.substring(0,6);
        System.out.println("sender is "+sender+" identity is " +identity);
        ProjectDAO dao = new ProjectDAO();
        ProjectEntity updateMemo;
        if(identity.equalsIgnoreCase("doctor")){
            updateMemo = dao.resetMemoCount(project.getProjectId());
        }else{
            updateMemo = dao.updateMemoCount(project.getProjectId());
        }
        for (Session s: allSessions) {
            try {
                s.getBasicRemote().sendObject(updateMemo);
                System.out.println("Sent : " + updateMemo);
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
        System.out.println("===All connected user(NewMemo)===");
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