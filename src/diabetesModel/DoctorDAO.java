package diabetesModel;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;


/**
 * Created by Owner on 12/12/2016.
 */
public class DoctorDAO {
    private EntityManager em;

    public DoctorDAO() {
        em = EMF.get().createEntityManager();
    }

    public List<DiabetedoctorEntity> getAllDoctors() {
        List<DiabetedoctorEntity> list = null;
        try {
            Query query = em.createQuery("select b from DiabetedoctorEntity b");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public DiabetedoctorEntity getDoctor(String id) {
        DiabetedoctorEntity doctor = null;
        try {
            Query query = em.createQuery("select b from DiabetedoctorEntity b where b.doctorId = '" + id + "'");
            doctor = (DiabetedoctorEntity)query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return doctor;
    }
}
