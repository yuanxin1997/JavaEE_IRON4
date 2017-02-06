package Services;

import Database.MedicineDBAO;
import Model.Medicine;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by PawandeepSingh on 29/1/17.
 */


@Path("/medicine")
public class MedicineServices {


    /**
     * PURPOSE : To get all medicine names
     *@return  JSON String ; which is a list of Medicine Names
     *
     * **/
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public String getAllMedicineNames() {

        Gson gson = new Gson();
        List<Medicine> medicineList = MedicineDBAO.getAllMedicines(); //GET ALL MEDICINE DETAIL

        String[] medNames = new String[medicineList.size()];
        for (int i = 0 ; i<medicineList.size();i++)
        {
                medNames[i] = medicineList.get(i).getName(); //STORE MEDICINE NAMES ONTO ARRAY
        }

        return gson.toJson(medNames) ;
    }

}
