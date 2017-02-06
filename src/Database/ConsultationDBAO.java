package Database;

import Model.Consultation;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 4/1/17.
 */
public class ConsultationDBAO
{


    //When adding to db , make sure date is in yyyy-mm-dd format
    //                      and time is in 24 hour format
                        // to add in mysql is date + " " + time

    //// create format for 12 hour and 24 hour format
//    SimpleDateFormat date12Format = new SimpleDateFormat("hh:mm a");
//    SimpleDateFormat date24Format = new SimpleDateFormat("HH:mm");
   // selectedTime = date24Format.format(date12Format.parse(tableTime)); // convert 12 hour text format to 24 hour text format

    //to retreive date and time use ,
//    					//year-month-day	                                                      // hour:min am/pm - 12 hr format
    //date_format(apptdatetime, '%y-%m-%d') as apptdate , time_format(apptdatetime, '%h:%i %p') as apptime from appointment;


    /**
    * Convert resultset to Consultation object
    * **/
    public static Consultation convertToConsultation(ResultSet rs) throws SQLException {
        Consultation cn = new Consultation();

        int consultid = rs.getInt("consultid");
        String did = rs.getString("did");
        String pid = rs.getString("pid");

        String consultDate = rs.getString("consultdate");
        String consultTime = rs.getString("consulttime");
        String consultDateTime = consultDate + " " + consultTime;

        String diagnostic = rs.getString("diagnostics");
       String prescriptionid = "";
//               rs.getString("prescriptionid");
        String consultType = rs.getString("consulttype");

        String status = rs.getString("status");
        int duration = rs.getInt("consultduration");

        cn = new Consultation(consultid,did,pid,consultDateTime,diagnostic,prescriptionid,consultType,status,duration);
        return cn;
    }


        /**
         * Get doctor consultations
         * @return List of doctor consultations
         * **/
        public static List<Consultation> getDoctorConsultations(String doctorid)
        {
            List<Consultation> consultations = new ArrayList<Consultation>();
            DBController db = new DBController();
            String query;
            PreparedStatement ps;
            ResultSet rs;

            db.getConnection();

            query = "select consultid , did , pid , diagnostics  , consulttype ,date_format(consultdatetime, '%d-%m-%Y') as consultdate " +
                    ", time_format(consultdatetime , '%h:%i %p') as consulttime , status , consultduration from consultation where did = ? AND status = 'BOOKED' ";
            ps = db.getPreparedStatement(query);

            try
            {
                ps.setString(1,doctorid);
                rs = ps.executeQuery();

                while (rs.next())
                {
                Consultation cn = convertToConsultation(rs);
                consultations.add(cn);

                }
            } catch (SQLException e)
            {
                e.printStackTrace();
            }
            db.terminate();
            return consultations;
        }



        /**
        * Returns  doctor's UPCOMING consultations of today (sorted by time ascending)
         * based on the current time now
         * @return list of consultations
        * **/
        public static List<Consultation> getDoctorUpcomingConsultation(String doctorid)
        {
            List<Consultation> consultations = new ArrayList<Consultation>();

            DBController db = new DBController();
            String query;
            PreparedStatement ps;
            ResultSet rs;

            db.getConnection();

            query = "select consultid , did , pid , diagnostics , consulttype ,date_format(consultdatetime, '%d-%m-%Y') as consultdate " +
                    ",time_format(consultdatetime , '%h:%i %p') as consulttime , status , consultduration from consultation where did = ? AND " +
                    "DATEDIFF(NOW(), consultdatetime) = 0 and timestampdiff(MINUTE,consultdatetime,now()) <= 0 and status = 'BOOKED' order by TIME(consulttime)";
            ps = db.getPreparedStatement(query);


            try {
                ps.setString(1,doctorid);
                rs = ps.executeQuery();

                while (rs.next())
                {
                    Consultation cn = convertToConsultation(rs);
                    consultations.add(cn);
                }


            } catch (SQLException e) {
                e.printStackTrace();
            }
            db.terminate();

            return consultations;
        }

        /**
         *
         * Update doctor consultation
         * @return boolean success : true for successful update , false otherwise
         * */
        public static boolean updateDoctorConsultation(String report,String consultid,String status,String consultationDuration)
        {
            boolean success = false;
            DBController db = new DBController();
            String query;
            PreparedStatement ps;
            ResultSet rs;


            db.getConnection();

            query = "UPDATE consultation SET diagnostics = ? , status = ?, consultduration = ? where consultid = ?";
            ps = db.getPreparedStatement(query);

            try {
                ps.setString(1,report);
                ps.setString(2,status);
                ps.setString(3,consultationDuration);
                ps.setString(4,consultid);

                if (ps.executeUpdate() == 1)
                {
                    success = true;
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }

            db.terminate();
            return success;
        }


        /**
        * Get patient past consultation records
         * based on current date and time
         *
         * @return List of consultation
         * * **/
        public static List<Consultation> getPatientPastRecords(String patientID)
        {
            List<Consultation> patientRecords = new ArrayList<Consultation>();
            DBController db = new DBController();
            String query;
            PreparedStatement ps;
            ResultSet rs;

            db.getConnection();

            query = "select consultid , did , pid , diagnostics , consulttype ,date_format(consultdatetime, '%d-%m-%Y') as consultdate " +
                    ", time_format(consultdatetime , '%h:%i %p') as consulttime , status , consultduration from consultation where  pid = ? and status = 'FINISHED' and " +
                    "timestampdiff(MINUTE,consultdatetime,now()) > 0 order by DATE(consultdatetime),TIME(consultdatetime)";
            //timediff(now(),consultdatetime) > now()
            ps = db.getPreparedStatement(query);

            try {
                ps.setString(1,patientID);
                rs = ps.executeQuery();

                while (rs.next())
                {
                    Consultation cn = convertToConsultation(rs);
                    patientRecords.add(cn);
                }


            } catch (SQLException e) {
                e.printStackTrace();
            }

            db.terminate();
            return  patientRecords;
        }



        public static List<Consultation> getPatientUpcomingConsultation(String patientid)
        {
            List<Consultation> ptCn = new ArrayList<Consultation>();

            DBController db = new DBController();
            String query;
            PreparedStatement ps;
            ResultSet rs;

            db.getConnection();

            query = "select consultid , did , pid , diagnostics, consulttype ,date_format(consultdatetime, '%d-%m-%Y') as consultdate " +
                    ", time_format(consultdatetime , '%h:%i %p') as consulttime , status , consultduration from consultation where pid = ? AND " +
                    "  DATEDIFF(NOW(), consultdatetime) = 0 and status = 'BOOKED' and timestampdiff(MINUTE,consultdatetime,now()) <= 0 order by TIME(consulttime)";

            ps = db.getPreparedStatement(query);

            try {
                ps.setString(1,patientid);
                rs = ps.executeQuery();
                while(rs.next())
                {
                    ptCn.add(convertToConsultation(rs));
                }


            } catch (SQLException e) {
                e.printStackTrace();
            }

            db.terminate();
            return  ptCn;
        }



        public static Consultation getSelectedConsultation(String consultid)
        {
            Consultation cn = new Consultation();
            DBController db = new DBController();
            String query;
            PreparedStatement ps;
            ResultSet rs;

            db.getConnection();
            query = "select consultid , did , pid , diagnostics, consulttype ,date_format(consultdatetime, '%d-%m-%Y') as consultdate " +
                    ", time_format(consultdatetime , '%h:%i %p') as consulttime , status , consultduration from consultation where consultid = ? ";
            ps = db.getPreparedStatement(query);

            try {
                ps.setString(1,consultid);
                rs = ps.executeQuery();
                if(rs.next())
                {
                    cn = convertToConsultation(rs);
                }
                else{
                    return null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }


            return cn;

        }




    public static void main(String[] args)
    {
        System.out.println(getDoctorUpcomingConsultation("D02").get(0).getConsultDateTime());
       // System.out.println(getPatientConsultation("S987654F"));
    }
}

