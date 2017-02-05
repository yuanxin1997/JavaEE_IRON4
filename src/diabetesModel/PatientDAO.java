package diabetesModel;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

/**
 * Created by Owner on 12/22/2016.
 */
public class PatientDAO {
    private EntityManager em;

    public PatientDAO() {
        em = EMF.get().createEntityManager();
    }

    public List<DiabetepatientEntity> getAllPatients() {
        List<DiabetepatientEntity> list = null;
        try {
            Query query = em.createQuery("select b from DiabetepatientEntity b");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public DiabetepatientEntity getPatient(String id) {
        DiabetepatientEntity patient = null;
        try {
            Query query = em.createQuery("select b from DiabetepatientEntity b where b.patientId = '" + id + "'");
            patient = (DiabetepatientEntity)query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return patient;
    }
}
