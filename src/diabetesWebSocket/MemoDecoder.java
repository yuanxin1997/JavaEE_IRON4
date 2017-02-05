package diabetesWebSocket;

import com.google.gson.Gson;
import diabetesModel.MemoEntity;

import javax.json.Json;
import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;
import java.io.StringReader;

public class MemoDecoder implements Decoder.Text<MemoEntity> {

    @Override
    public MemoEntity decode(String jsonMessage) throws DecodeException {

        Gson gson = new Gson();
        MemoEntity memo = gson.fromJson(jsonMessage, MemoEntity.class);

        return memo;

    }

    @Override
    public boolean willDecode(String jsonMessage) {
        try {
            // Check if incoming message is valid JSON
            Json.createReader(new StringReader(jsonMessage)).readObject();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public void init(EndpointConfig ec) {
        System.out.println("MemoDecoder -init method called");
    }

    @Override
    public void destroy() {
        System.out.println("MemoDecoder - destroy method called");
    }

}