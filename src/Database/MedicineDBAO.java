package Database;

import Model.Medicine;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 9/1/17.
 */
public class MedicineDBAO
{

    /**
     * Get all medicine from DB
     * @return List of Medicine
     * **/
    public static List<Medicine> getAllMedicines()
    {

        List<Medicine> medicineList = new ArrayList<Medicine>();

        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();

        query = "select * from medicine";
        ps = db.getPreparedStatement(query);
        try {
            rs = ps.executeQuery();

            while (rs.next())
            {
                int medID = rs.getInt("medid");
                String medName =rs.getString("name");
                double medPrice = rs.getDouble("price");
                medicineList.add(new Medicine(medID,medName,medPrice));

            }


        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return medicineList;
    }


    public static void main(String args[])
    {
        System.out.println(getAllMedicines().get(0).getName());
    }
}
