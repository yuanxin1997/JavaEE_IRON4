package diabetesModel;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;


/**
 * Created by Owner on 12/12/2016.
 */
public class ProjectDAO {
    private EntityManager em;

    public ProjectDAO() {
        em = EMF.get().createEntityManager();
    }

    public List<ProjectEntity> getAllProjects() {
        List<ProjectEntity> list = null;
        try {
            Query query = em.createQuery("select b from ProjectEntity b");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<ProjectEntity> getAllProjectsByDoctorId(String id) {
        List<ProjectEntity> list = null;
        try {
            Query query = em.createQuery("select b from ProjectEntity b where b.doctorId = '" + id + "'");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public ProjectEntity getProject(String id) {
        ProjectEntity project = null;
        try {
            Query query = em.createQuery("select b from ProjectEntity b where b.projectId = '" + id + "'");
            project = (ProjectEntity)query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return project;
    }
    public int getNextId(){
        int nextId = 0;
        try {
            Query query = em.createQuery("select b from ProjectEntity b order by b.id DESC");
            query.setMaxResults(1);
            List<ProjectEntity> results = query.getResultList();
            nextId = ((results.get(0).getId())+1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }

    public ProjectEntity createProject(int id, String projectId, String doctorId, String patientId, String createdOn, String fullName){
        ProjectEntity newProject = new ProjectEntity();
        newProject.setId(id);
        newProject.setProjectId(projectId);
        newProject.setDoctorId(doctorId);
        newProject.setPatientId(patientId);
        newProject.setCreatedOn(createdOn);
        newProject.setNewMemo(0);
        newProject.setLevel("normal");
        newProject.setFullName(fullName);
        em.getTransaction().begin();
        em.persist(newProject);
        em.getTransaction().commit();
        return newProject;
    }
    public ProjectEntity updateLevel(String projectId, String level){
        ProjectEntity project = null;
        try{
            project = (ProjectEntity)em.find(ProjectEntity.class, projectId);
            em.getTransaction().begin();
            project.setLevel(level);
            em.getTransaction().commit();
        }catch(Exception e){
            e.printStackTrace();
        }
        return project;
    }
    public ProjectEntity updateMemoCount(String projectId){
        ProjectEntity project = null;

        try{
            project = (ProjectEntity)em.find(ProjectEntity.class, projectId);
            int memoCount = project.getNewMemo()+1;
            em.getTransaction().begin();
            project.setNewMemo(memoCount);
            em.getTransaction().commit();
            em.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return project;
    }

    public ProjectEntity resetMemoCount(String projectId){
        ProjectEntity project = null;

        try{
            project = (ProjectEntity)em.find(ProjectEntity.class, projectId);
            em.getTransaction().begin();
            project.setNewMemo(0);
            em.getTransaction().commit();
            em.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return project;
    }

}
