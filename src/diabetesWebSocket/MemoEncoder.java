package diabetesWebSocket;

import com.google.gson.Gson;
import diabetesModel.MemoEntity;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class MemoEncoder implements Encoder.Text<MemoEntity> {

    @Override
    public String encode(MemoEntity memo) throws EncodeException {
        Gson gson = new Gson();
        return gson.toJson(memo);
    }

    @Override
    public void init(EndpointConfig ec) {
        System.out.println("MemoDecoder - init method called");
    }

    @Override
    public void destroy() {
        System.out.println("MemoDecoder - destroy method called");
    }

}