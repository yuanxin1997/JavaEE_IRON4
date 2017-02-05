package diabetesWebSocket;

import diabetesModel.DiabetelogDAO;
import diabetesModel.DiabetelogEntity;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;


@ServerEndpoint(value="/diabeteLog/{id}",
        encoders={DiabetelogEncoder.class},
        decoders={DiabetelogDecoder.class}
)
public class DiabetelogWebSocket {
    private static Set<Session> allSessions = new HashSet<Session>();
    @OnOpen
    public void onOpen(@PathParam("id") String id, Session session){
        System.out.println("user : " + id + " is connected for session: " + session.getId());
        session.getUserProperties().put("id", id);
        allSessions.add(session);
        System.out.println("===All connected user(diabeteLog)===");
        for (Session s : allSessions) {
            System.out.println(s.getUserProperties().get("id"));
        }
        System.out.println("========================");
    }

    @OnMessage
    public void onMessage(DiabetelogEntity log, Session session) throws IOException {
        DiabetelogDAO dao = new DiabetelogDAO();
        System.out.println(log.getNotes());
        System.out.println(log.getTrackTime());
        System.out.println(log.getGlucoseLevel());
        DiabetelogEntity addedTV = dao.addTrackingValue(dao.getNextId(), log.getTrackDate(), log.getTrackTime(), log.getGlucoseLevel(), log.getNotes(), log.getProjectId());

        for (Session s: allSessions) {
            try {
                s.getBasicRemote().sendObject(addedTV);
                System.out.println("Sent : " + addedTV);
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
        System.out.println("===All connected user(diabeteLog)===");
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