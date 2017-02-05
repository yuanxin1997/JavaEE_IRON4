package diabetesModel;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

/**
 * Created by Owner on 12/31/2016.
 */
public class MemoDAO {
    private EntityManager em;

    public MemoDAO() {
        em = EMF.get().createEntityManager();
    }

    public int getNextId(){
        int nextId = 0;
        try {
            Query query = em.createQuery("select b from MemoEntity b order by b.id DESC");
            query.setMaxResults(1);
            List<MemoEntity> results = query.getResultList();
            nextId = ((results.get(0).getId())+1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }

    public List<MemoEntity> getAllMemoByProjectId(String id) {
        List<MemoEntity> list = null;
        try {
            Query query = em.createQuery("select b from MemoEntity b where b.projectId = '" + id + "'");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public MemoEntity writeMemo(int id, String memoDateTime, String content, String authorName, String identity, String projectId){
        MemoEntity newMemo = new MemoEntity();

        newMemo.setId(id);
        newMemo.setMemoDateTime(memoDateTime);
        newMemo.setContent(content);
        newMemo.setAuthorName(authorName);
        newMemo.setIdentity(identity);
        newMemo.setProjectId(projectId);

        em.getTransaction().begin();
        em.persist(newMemo);
        em.getTransaction().commit();
        return newMemo;
    }

}
