package Utility;

import Database.MedicineDBAO;
import Model.Medicine;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 3/2/17.
 */
public class MedicineUtility
{
    public static List<String> getMedicineIDviaName(List<String> medName)
    {
        List<Medicine> Medicines = MedicineDBAO.getAllMedicines();
            List<String> medIdList = new ArrayList<String>();


            for(int i = 0 ; i < medName.size();i++)
            {

                for (int j = 0 ; j<Medicines.size(); j++)
                {
                    if(Medicines.get(j).getName().equals(medName.get(i)))
                    {
                        String id = Integer.toString(Medicines.get(j).getMedID());
                        medIdList.add(id);
                    }
                }

            }

        return medIdList;
    }

    public static List<String> getMedicineNameviaID(List<String> medID)
    {
        List<Medicine> Medicines = MedicineDBAO.getAllMedicines();
        List<String> medName = new ArrayList<String>();

        for (int i = 0;i<medID.size();i++)
        {
            for (int j = 0 ;j<Medicines.size() ;j++)
            {
                String medid = String.valueOf(Medicines.get(j).getMedID());

                if(medid.equals(medID.get(i)))
                {
                    medName.add(Medicines.get(j).getName());
                }
            }
        }

        return medName;
    }



}
