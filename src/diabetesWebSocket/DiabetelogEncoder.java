package diabetesWebSocket;


import com.google.gson.Gson;
import diabetesModel.DiabetelogEntity;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class DiabetelogEncoder implements Encoder.Text<DiabetelogEntity> {

    @Override
    public String encode(DiabetelogEntity log) throws EncodeException {
        Gson gson = new Gson();
        return gson.toJson(log);
    }

    @Override
    public void init(EndpointConfig ec) {
        System.out.println("DiabetelogEncoder - init method called");
    }

    @Override
    public void destroy() {
        System.out.println("DiabetelogEncoder - destroy method called");
    }

}
