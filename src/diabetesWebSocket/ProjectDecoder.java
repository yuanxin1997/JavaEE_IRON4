package diabetesWebSocket;

import com.google.gson.Gson;
import diabetesModel.ProjectEntity;

import javax.json.Json;
import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;
import java.io.StringReader;

public class ProjectDecoder implements Decoder.Text<ProjectEntity> {

    @Override
    public ProjectEntity decode(String jsonMessage) throws DecodeException {

        Gson gson = new Gson();
        ProjectEntity project = gson.fromJson(jsonMessage, ProjectEntity.class);

        return project;

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
        System.out.println("ProjectDecoder -init method called");
    }

    @Override
    public void destroy() {
        System.out.println("ProjectDecoder - destroy method called");
    }

}
