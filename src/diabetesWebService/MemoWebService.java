package diabetesWebService;


import diabetesModel.MemoDAO;
import diabetesModel.MemoEntity;
import diabetesModel.ProjectDAO;
import diabetesModel.ProjectEntity;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by Owner on 12/31/2016.
 */
@Path("/memo")
public class MemoWebService {

    @GET
    @Path("/{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public List<MemoEntity> getMemosByProjectId(@PathParam("id") String projectId) {
        MemoDAO dao = new MemoDAO();
        List<MemoEntity> memos = dao.getAllMemoByProjectId(projectId);
        return memos;
    }


    @POST
    @Path("/writeMemo")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public MemoEntity writeMemo(MemoEntity memo){
        MemoDAO dao = new MemoDAO();
        System.out.println(memo.getAuthorName());
        System.out.println(memo.getIdentity());
        MemoEntity writeMemo = dao.writeMemo(dao.getNextId(), memo.getMemoDateTime(), memo.getContent(), memo.getAuthorName(), memo.getIdentity(), memo.getProjectId());
        ProjectDAO pdao = new ProjectDAO();
        if(memo.getIdentity().equalsIgnoreCase("patient")){
            ProjectEntity updateMemo = pdao.updateMemoCount(memo.getProjectId());
        }
        return writeMemo;
    }

    @GET
    @Path("resetMemoCount/{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public List<MemoEntity> resetMemoByProjectId(@PathParam("id") String projectId) {
        MemoDAO dao = new MemoDAO();
        List<MemoEntity> memos = dao.getAllMemoByProjectId(projectId);
        ProjectDAO pdao = new ProjectDAO();
        ProjectEntity resetMemo = pdao.resetMemoCount(projectId);
        return memos;
    }


}