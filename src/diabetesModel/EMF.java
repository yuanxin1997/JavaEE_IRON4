package diabetesModel;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Created by Owner on 12/12/2016.
 */
public class EMF {
    private static final EntityManagerFactory emfInstance = Persistence.createEntityManagerFactory("diabetesMonitoring");
    private EMF() {}
    public static EntityManagerFactory get() {
        return emfInstance;
    }
}