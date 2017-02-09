package Database;

import Model.Payment;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by PawandeepSingh on 5/2/17.
 */
public class PaymentDBAO
{
    public static boolean insertPayment(Payment payment)
    {
        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();
        boolean success =false;
        query = "INSERT INTO Payment(billid,patientid,creditcardnum,paymenttype,expirydate," +
                "csvnum,streetAddress1,streetAddress2,state,postalcode,country)\n" +
                "VALUES\n" +
                "(?,?,?,?,?,?,?,?,?,?,?); ";
        ps = db.getPreparedStatement(query);

        try {
            ps.setString(1,payment.getBillID());
            ps.setString(2,payment.getPatientid());
            ps.setInt(3,payment.getCreditCardNumber());
            ps.setString(4,payment.getPaymentType());
            ps.setString(5,payment.getCreditCardExpiryDate());
            ps.setInt(6,payment.getCSVNumber());
            ps.setString(7,payment.getStreetAddress1());
            ps.setString(8,payment.getStreetAddress2());
            ps.setString(9,payment.getStateProvince());
            ps.setInt(10,payment.getPostalCode());
            ps.setString(11,payment.getCountry());

            if(ps.executeUpdate() == 1)
            {
                success = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return success;
    }

//    public static boolean checkPaymentExists(String billid)
//    {
//        DBController db = new DBController();
//        String query;
//        PreparedStatement ps;
//        ResultSet rs;
//
//        db.getConnection();
//        boolean success =false;
//
//        query = "select * from payment where billid = ?";
//        ps = db.getPreparedStatement(query);
//
//        try {
//            ps.setString(1,billid);
//            rs = ps.executeQuery();
//            if(rs.next())
//            {
//                success = true;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        db.terminate();
//        return success;
//
//    }
}
