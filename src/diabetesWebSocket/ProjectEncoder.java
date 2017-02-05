package diabetesWebSocket;

import com.google.gson.Gson;
import diabetesModel.ProjectEntity;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class ProjectEncoder implements Encoder.Text<ProjectEntity> {

    @Override
    public String encode(ProjectEntity project) throws EncodeException {
        Gson gson = new Gson();
        return gson.toJson(project);
    }

    @Override
    public void init(EndpointConfig ec) {
        System.out.println("ProjectEncoder - init method called");
    }

    @Override
    public void destroy() {
        System.out.println("ProjectEncoder - destroy method called");
    }

}