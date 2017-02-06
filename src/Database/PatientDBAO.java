package Database;

import Model.Patient;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 4/1/17.
 */


public class PatientDBAO
{


    /**
    * Convert resultset to patient
    * */
    public static Patient covertToPatient(ResultSet rs) throws SQLException
    {

        Patient pt = new Patient();

        String patientid = rs.getString("patientId");
        String nric = rs.getString("nric");

        //String password = rs.getString("password");

        //String name = rs.getString("name");
        String firstname = rs.getString("firstName");
        String lastname = rs.getString("lastName");
        String gender = rs.getString("gender");

        String dob = rs.getString("dob");
        double height = rs.getDouble("height");
        double weight = rs.getDouble("weight");
        String bloodtype = rs.getString("bloodtype");

        String race = rs.getString("race");
        String sex = rs.getString("sex");
        int phonenum = rs.getInt("phonenum");
        int telephonenum = rs.getInt("telephonenum");
        String allergies = rs.getString("allergies");
        String citizenship = rs.getString("citizenship");
        String dietaryneeds = rs.getString("dietaryneeds");

        String email = rs.getString("email");
        String dateofAdmission = rs.getString("dateOfAdmission");
        String profilePic = "";
                //rs.getString("profilePic");

        String diabetic = rs.getString("isDiabetic");
        boolean isdiabetic = false;
        if(!(diabetic == null))
        {
            if(diabetic.equalsIgnoreCase("YES"))
            {
                isdiabetic = true;
            }
            else
            {
                isdiabetic = false;
            }
        }


        pt = new Patient(patientid,nric,firstname,lastname,gender,dob,height,weight,bloodtype,race,sex
        ,phonenum,telephonenum,allergies,citizenship,dietaryneeds,email,dateofAdmission,profilePic,isdiabetic);



//        pt = new Patient(nric,password,name,dob,height,weight,bloodtype
//                ,race,sex,phonenum,telephonenum,allergies,citizenship,dietaryneeds);


        return pt;
    }

    /**
     * Get Patient details via PatientID
     * **/
    public static Patient getPatientviaID(String patientid)
    {
        Patient pt = null;

        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();

        query = "select * from patient where patientId = ?";
        ps = db.getPreparedStatement(query);

        try {
            ps.setString(1,patientid);
            rs = ps.executeQuery();
            if(rs.next())
            {

                pt = covertToPatient(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return pt;
    }


    /**
    * Get Patient details via NRIC
    * **/
    public static Patient getPatient(String NRIC)
    {
        Patient pt = null;

        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();

        query = "select * from patient where nric = ?";
        ps = db.getPreparedStatement(query);

        try {
            ps.setString(1,NRIC);
            rs = ps.executeQuery();
            if(rs.next())
            {

                pt = covertToPatient(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return pt;
    }


    /**
     * Get all patients
     *@return List of patients
     * **/
    public static List<Patient> getAllPatients()
    {
        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();

        List<Patient> ptlist = new ArrayList<Patient>();

        query = "SELECT * FROM PATIENT";
        ps = db.getPreparedStatement(query);
        try {
            rs = ps.executeQuery();
            while (rs.next())
            {
                Patient pt = covertToPatient(rs);

                ptlist.add(pt);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return ptlist;
    }


    public static void main(String [] args)
    {
        Patient PT = PatientDBAO.getPatientviaID("P01");
        System.out.println(PT.getRace());
    }
}
