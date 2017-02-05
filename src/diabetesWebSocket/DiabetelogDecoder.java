package diabetesWebSocket;

import com.google.gson.Gson;
import diabetesModel.DiabetelogEntity;

import javax.json.Json;
import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;
import java.io.StringReader;

public class DiabetelogDecoder implements Decoder.Text<DiabetelogEntity> {

    @Override
    public DiabetelogEntity decode(String jsonMessage) throws DecodeException {

        Gson gson = new Gson();
        DiabetelogEntity log = gson.fromJson(jsonMessage, DiabetelogEntity.class);

        return log;

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
        System.out.println("DiabetelogDecoder -init method called");
    }

    @Override
    public void destroy() {
        System.out.println("DiabetelogDecoder - destroy method called");
    }

}
