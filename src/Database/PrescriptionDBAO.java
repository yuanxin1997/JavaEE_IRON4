package Database;

import Model.Prescription;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 9/1/17.
 */
public class PrescriptionDBAO
{

    //TODO TO INSERT INSERT INTO table_name (col1,col2,col3) values (?,?,?) - DONE

    /**
     * Convert resultset to Prescription
     * **/
    public static Prescription convertToPrescription(ResultSet rs) throws SQLException
    {
        Prescription prescription = null;

        List<String> medicineIDs = new ArrayList<String>();
        List<String> dosageList = new ArrayList<String>();
        List<String> frequencyList = new ArrayList<String>();
        String consultID = "";
        String patientID = "";

//        String prescriptionID = rs.getString("prescriptionid");

        while (rs.next())
        {
            String medName = rs.getString("medid");
            String dosage = rs.getString("dosage");
            String frequency = rs.getString("frequency");

            consultID = rs.getString("consultid");
            patientID = rs.getString("patientid");

            medicineIDs.add(medName);
            dosageList.add(dosage);
            frequencyList.add(frequency);

        }

        prescription = new Prescription(consultID,patientID,medicineIDs,dosageList,frequencyList);
        return prescription;
    }



    /**
     * Gets all prescription based on consultation ID
     * @return Prescription
     * **/
    public static Prescription getPrescriptionsByConsultationID(String consultID)
    {


        Prescription prescription = new Prescription();

        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();
        query = "select * from prescription where consultid = ? ";
        ps = db.getPreparedStatement(query);

        try {
            ps.setString(1,consultID);
            rs = ps.executeQuery();
             prescription = convertToPrescription(rs);


        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return prescription;
    }

    /**
     * Insert patient prescription into prescription db table
     * @return true if insert successful, false otherwise
     * **/
    public static boolean addPatientPrescriptions(String consultId, String patientId, Prescription prescription)
    {
        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();

        boolean success = false;

        query = "INSERT INTO prescription (consultid,patientid,dosage,frequency,medid) VALUES (?,?,?,?,?)";
        ps = db.getPreparedStatement(query);

        try
        {
            int size = prescription.getMedicineIDs().size();
            for (int i = 0 ; i < size ; i++)
            {
                ps.setString(1,consultId);
                ps.setString(2,patientId);
                ps.setString(3, prescription.getDosageList().get(i));
                ps.setString(4, prescription.getFrequencyList().get(i));
                ps.setString(5, prescription.getMedicineIDs().get(i));
                if (ps.executeUpdate() == 1)
                {
                    success = true;
                }


            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return success;
    }




    public static void main(String args[])
    {
        System.out.println(PrescriptionDBAO.getPrescriptionsByConsultationID("3").getMedNamelist().get(0));

//        System.out.println(getPatientPrescriptions("1").get(0).getDosage());
    }
}
