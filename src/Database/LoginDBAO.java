package Database;

import Model.Patient;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static Utility.CheckUserAccount.getUserType;

/**
 * Created by PawandeepSingh on 4/1/17.
 */
public class LoginDBAO
{

    public static Object getUser(String username,String password)
    {


        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        String usernameUpperCase = username.toUpperCase();
        char firstLetter = usernameUpperCase.charAt(0);

        db.getConnection();

        query = "select * from useraccount where username = ? and password = ?";
        ps = db.getPreparedStatement(query);

        try {
            ps.setString(1,username);
            ps.setString(2,password);
            rs = ps.executeQuery();

            if(rs.next())
            {
                return getUserType(firstLetter,username);
            }
            else
                {
                    return null;
                }

        } catch (SQLException e) {
            e.printStackTrace();
        }


        db.terminate();
        return null;
    }

    public static void main(String[] args)
    {

        System.out.println(((Patient)getUser("P01","TEST111")).getRace());
    }


//    /**
//     * To get user information after they have login
//     * @return user
//     * **/
//    public static User getUser(String username , String password)
//    {
//        DBController db = new DBController();
//        String query;
//        PreparedStatement ps;
//        ResultSet rs;
//
//        User user = new User();
//        try
//        {
//            String usernameUpperCase = username.toUpperCase(); // converts username to uppercase
//            char firstLetter = usernameUpperCase.charAt(0);// get first character of user
//
//            String userType = null;
//            String pkColumnName = null;
//
//            //if user is a doctor
//            if(firstLetter == 'D')
//            {
//                userType = "Doctor";
//                pkColumnName = "did";
//                user = new Doctor(); //create doctor instance
//            }
//            else if(usernameUpperCase.length() == 9)//else if is a patient
//            {
//                userType = "Patient";
//                pkColumnName = "nric";
//                user = new Patient(); // create patient instance
//            }
//            else // else neither
//                {
//                    return null;
//                }
//
//            db.getConnection();
//
//
//            query = "select * from "+ userType +" where "+ pkColumnName +" = ? and password = ?";
//            ps = db.getPreparedStatement(query);
//            ps.setString(1,usernameUpperCase);
//            ps.setString(2,password);
//
//            rs = ps.executeQuery();
//            if(rs.next())
//            {
//                user.setName(rs.getString("name"));
//                user.setID(rs.getString(pkColumnName));
//            }
//            else {return null;}
//
//        }catch (SQLException e) {e.printStackTrace();}
//
//        db.terminate();
//        return user;
//    }
}
