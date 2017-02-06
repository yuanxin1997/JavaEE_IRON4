package Database;

import Model.Doctor;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by PawandeepSingh on 31/1/17.
 */
public class DoctorDBAO
{

    private static Doctor convertToDoctor(ResultSet rs) throws SQLException
    {
        Doctor dr = new Doctor();

        String doctorid = rs.getString("doctorId");
        String firstName = rs.getString("firstName");
        String lastName = rs.getString("lastName");
        String dateJoined = rs.getString("dateJoined");
        String gender = rs.getString("gender");
        String email = rs.getString("email");
        String contactNo = rs.getString("contactNo");
        String profilePic = rs.getString("profilePic");

        dr = new Doctor(doctorid,firstName,lastName,email,dateJoined,gender,contactNo,profilePic);

        return dr;
    }


    public static Doctor getDoctor(String doctorid)
    {
        Doctor dr = new Doctor();

        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();

        query = "select * from doctor where doctorId = ?";
        ps = db.getPreparedStatement(query);

        try {
            ps.setString(1,doctorid);
            rs = ps.executeQuery();
            if(rs.next())
            {
                dr = convertToDoctor(rs);
            }
            else
                {
                    dr = null;
                }


        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return dr;
    }

    public static void main(String[] args){
        System.out.println(getDoctor("D01").getDoctorID());
    }

}
