package Database;

import Model.Bill;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 4/2/17.
 */
public class BillDBAO
{


    private static Bill convertToBill(ResultSet rs) throws SQLException
    {
        Bill bill = new Bill();

        String billid = rs.getString("billid");
        String consultid = rs.getString("consultid");
        double totalamountpayable = rs.getDouble("totalamountpayable");
        String billingdate = rs.getString("billingdate");


        bill = new Bill(billid,consultid,totalamountpayable,billingdate);


        return bill;
    }


    public static boolean createBill(Bill bill)
    {
        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();

        boolean success = false;

        query = "INSERT INTO Bill(consultid,totalamountpayable,billingdate) VALUES(?,?,?)";
        ps = db.getPreparedStatement(query);


        try
        {

            ps.setString(1,bill.getConsultID());
            ps.setDouble(2,bill.getTotalAmountPayable());
            ps.setString(3,bill.getBillingDate());
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


    public static Bill getBillviaConsultID(String consultid)
    {
        Bill bill = new Bill();

        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();


        query = "select * from Bill where consultid = ?";
        ps = db.getPreparedStatement(query);

        try {
            ps.setString(1,consultid);
            rs = ps.executeQuery();
            if(rs.next())
            {
                bill = convertToBill(rs);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return bill;
    }

    public static List<Bill> getPatientBills(String patientid)
    {
        List<Bill> billList = new ArrayList<Bill>();
        Bill bill;


        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();


        query = "select billid,b.consultid,totalamountpayable,billingdate from Bill b inner join consultation cn on b.consultid = cn.consultid where cn.pid = ?";
        ps = db.getPreparedStatement(query);

        try {
            System.out.println("ID IS :" + patientid);
            ps.setString(1,patientid);
            rs = ps.executeQuery();
            while (rs.next())
            {
                    billList.add(convertToBill(rs));
                    System.out.println("have");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        db.terminate();

        return billList;
    }

    public static Bill getBill(String billid)
    {
        Bill bill = new Bill();
        DBController db = new DBController();
        String query;
        PreparedStatement ps;
        ResultSet rs;

        db.getConnection();
        query = "select * from Bill where billid = ?";

        ps = db.getPreparedStatement(query);
        try {
            ps.setString(1,billid);
            rs = ps.executeQuery();
            if(rs.next())
            {
                bill = convertToBill(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        db.terminate();
        return bill;
    }
}
