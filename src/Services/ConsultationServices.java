package Services;

import Database.ConsultationDBAO;
import Database.PatientDBAO;
import Model.Consultation;
import Model.Patient;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 4/1/17.
 */

@Path("/consultation")
public class ConsultationServices
{

    /**
     * PURPOSE : to get list of Doctor consultation records with the patient records included
     *@return  JSON String ; which is a list of consultation
     *
     * **/

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getdoctorconsultations/{id}")
    public String getDrConsultations(@PathParam("id") String doctorid)
    {
        Gson gson = new Gson();
        List<Consultation> cnList = ConsultationDBAO.getDoctorConsultations(doctorid); //GET doctor consultations
        for(int i = 0 ; i<cnList.size() ; i++)//for each consultation
        {
            //GET PATIENT DETAIL
            String patientid = cnList.get(i).getpID();
            Patient pt = PatientDBAO.getPatient(patientid);
            cnList.get(i).setPt(pt);//AND STORE INTO LIST
        }
        return gson.toJson(cnList);
    }

    /**
     * PURPOSE : to get list of Doctor Upcoming consultation of today
     *@return  JSON String ; which is a list of consultation
     *
     * **/

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getdrupcomingconsultations/{id}")
    public String getDrUpcomingConsultations(@PathParam("id") String doctorid)
    {
        List<Consultation> cnList = new ArrayList<Consultation>();
        Gson gson = new Gson();
        try
        {
            System.out.println(doctorid);
            cnList = ConsultationDBAO.getDoctorUpcomingConsultation(doctorid);//GET doctor consultations
            for(int i = 0 ; i<cnList.size() ; i++)//for each consultation
            {
                //GET PATIENT DETAIL
                String patientid = cnList.get(i).getpID();
                Patient pt = PatientDBAO.getPatient(patientid);
                cnList.get(i).setPt(pt);//AND STORE INTO LIST
            }
        }
        catch (Exception e)
        {
           e.printStackTrace();
        }


        return gson.toJson(cnList);
    }

    /**
     * PURPOSE : to get Patient past consultation records
     *@return  JSON String ; which is a list of past patient consultation records
     *
     * **/

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getpatientpastrecords/{patientid}")
    public String getPastConsultationRecords(@PathParam("patientid") String patientID)
    {
        List<Consultation> patientPastRecords = new ArrayList<Consultation>();
        Gson gson = new Gson();

        patientPastRecords = ConsultationDBAO.getPatientPastRecords(patientID);

        return gson.toJson(patientPastRecords) ;
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("/getpatientupcomingconsultation/{patientid}")
    public String getPatientUpcomingConsultation(@PathParam("patientid") String patientID)
    {
           List<Consultation> cnList = ConsultationDBAO.getPatientUpcomingConsultation(patientID);
            Gson gson = new Gson();

            return gson.toJson(cnList);
    }



}
