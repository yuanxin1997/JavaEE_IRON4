package diabetesWebSocket;

import diabetesModel.MemoDAO;
import diabetesModel.MemoEntity;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;


@ServerEndpoint(value="/memo/{id}",
        encoders={MemoEncoder.class},
        decoders={MemoDecoder.class}
)
public class MemoWebSocket {
    private static Set<Session> allSessions = new HashSet<Session>();
    @OnOpen
    public void onOpen(@PathParam("id") String id, Session session){
        System.out.println("user : " + id + " is connected for session: " + session.getId());
        session.getUserProperties().put("id", id);
        allSessions.add(session);
        System.out.println("===All connected user(Memo)===");
        for (Session s : allSessions) {
                    System.out.println(s.getUserProperties().get("id"));
        }
        System.out.println("========================");
    }

    @OnMessage
    public void onMessage(MemoEntity memo, Session session) throws IOException {
        MemoDAO dao = new MemoDAO();
        System.out.println(memo.getAuthorName());
        System.out.println(memo.getIdentity());
        MemoEntity writeMemo = dao.writeMemo(dao.getNextId(), memo.getMemoDateTime(), memo.getContent(), memo.getAuthorName(), memo.getIdentity(), memo.getProjectId());

        for (Session s: allSessions) {
            try {
                s.getBasicRemote().sendObject(writeMemo);
                System.out.println("Sent : " + writeMemo);
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
        System.out.println("===All connected user(Memo)===");
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