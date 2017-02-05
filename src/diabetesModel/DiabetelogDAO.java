package diabetesModel;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

/**
 * Created by Owner on 12/23/2016.
 */
public class DiabetelogDAO {
    private EntityManager em;

    public DiabetelogDAO() {
        em = EMF.get().createEntityManager();
    }

    public List<DiabetelogEntity> getAllDiabetesLog() {
        List<DiabetelogEntity> list = null;
        try {
            Query query = em.createQuery("select b from DiabetelogEntity b");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<DiabetelogEntity> getAllLogByProjectIdAndDate(String projectId, String date) {
        List<DiabetelogEntity> list = null;
        try {
            Query query = em.createQuery("select b from DiabetelogEntity b where b.projectId = '" + projectId
                                            + "' and b.trackDate = '" + date + "'");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getNextId(){
        int nextId = 0;
        try {
            Query query = em.createQuery("select b from DiabetelogEntity b order by b.id DESC");
            query.setMaxResults(1);
            List<DiabetelogEntity> results = query.getResultList();
            nextId = ((results.get(0).getId())+1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }

    public DiabetelogEntity addTrackingValue(int id, String trackDate, String trackTime, Integer glucoseLevel, String notes, String projectId){
        DiabetelogEntity newTV = new DiabetelogEntity();
        newTV.setId(id);
        newTV.setTrackDate(trackDate);
        newTV.setTrackTime(trackTime);
        newTV.setGlucoseLevel(glucoseLevel);
        newTV.setNotes(notes);
        newTV.setProjectId(projectId);
        em.getTransaction().begin();
        em.persist(newTV);
        em.getTransaction().commit();
        return newTV;
    }


    public DiabetelogEntity getDiabetesLog(String id) {
        DiabetelogEntity diabetelog = null;
        try {
            Query query = em.createQuery("select b from DiabetelogEntity b where b.projectId = '" + id + "'");
            diabetelog = (DiabetelogEntity)query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return diabetelog;
    }

    public DiabetelogEntity retrieveTrackingValue(int projectId){
        DiabetelogEntity diabetelog = null;
        try{

            diabetelog = (DiabetelogEntity)em.find(DiabetelogEntity.class, projectId);

        }catch(Exception e){
            e.printStackTrace();
        }
        return diabetelog;
    }

    public List<String> getAvgGlucoseListAByProjectId(String projectId) {
        List<String> list = null;
        try {
            Query query = em.createQuery("select b.trackDate" +
                    " from DiabetelogEntity b where b.projectId = '" + projectId
                    + "' group by b.trackDate");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Double> getAvgGlucoseListBByProjectId(String projectId) {
        List<Double> list = null;
        try {
            Query query = em.createQuery("select avg(b.glucoseLevel)" +
                    " from DiabetelogEntity b where b.projectId = '" + projectId
                    + "' group by b.trackDate");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
