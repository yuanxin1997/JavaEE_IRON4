package diabetesModel;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

/**
 * Created by Owner on 1/15/2017.
 */
public class ScheduleDAO {
    private EntityManager em;

    public ScheduleDAO() {
        em = EMF.get().createEntityManager();
    }

    public int getNextId(){
        int nextId = 0;
        try {
            Query query = em.createQuery("select b from ScheduleEntity b order by b.id DESC");
            query.setMaxResults(1);
            List<ScheduleEntity> results = query.getResultList();
            nextId = ((results.get(0).getId())+1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }

    public List<ScheduleEntity> getScheduleByProjectIdAndDay(String projectId, String day) {
        List<ScheduleEntity> list = null;
        try {
            Query query = em.createQuery("select b from ScheduleEntity b where b.projectId = '" + projectId
                    + "' and b.day = '" + day + "' and b.deleteStatus = 'no'");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ScheduleEntity addEvent(int id, String day, String projectId, String tag, String startTime, String endTime, String content, String deleteStatus){
        ScheduleEntity event = new ScheduleEntity();

        event.setId(id);
        event.setDay(day);
        event.setProjectId(projectId);
        event.setTag(tag);
        event.setStartTime(startTime);
        event.setEndTime(endTime);
        event.setContent(content);
        event.setDeleteStatus(deleteStatus);

        em.getTransaction().begin();
        em.persist(event);
        em.getTransaction().commit();
        return event;
    }

    public ScheduleEntity updateEvent(int id, String day, String projectId, String tag, String startTime, String endTime, String content, String deleteStatus){
        ScheduleEntity event = null;

        try{
            event = em.find(ScheduleEntity.class, id);

            em.getTransaction().begin();

            event.setDay(day);
            event.setProjectId(projectId);
            event.setTag(tag);
            event.setStartTime(startTime);
            event.setEndTime(endTime);
            event.setContent(content);
            event.setDeleteStatus(deleteStatus);

            em.getTransaction().commit();
            em.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return event;
    }

    public ScheduleEntity removeEvent(int id){
        ScheduleEntity event = null;
        try{
            event = em.find(ScheduleEntity.class, id);
            em.getTransaction().begin();
            event.setDeleteStatus("deleted");
            em.getTransaction().commit();
        }catch(Exception e){
            e.printStackTrace();
        }
        return event;
    }


}