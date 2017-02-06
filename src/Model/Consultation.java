package Model;

/**
 * Created by PawandeepSingh on 3/1/17.
 */



public class Consultation
{

    //Instance Variables

    private int ID; // consultation ID : Primary Key
    private String dID; // doctorID
    private String pID;// patientid; same is patient NRIC
    private String consultDateTime; // consultation date and time

    //TODO:MORE STUFF CAN BE DONE UNDER CONSULTATION ENTITY AND CHECK ON DATETIME AND CHECK ON PATIENT LIST - DONE

    private String consultType; // consultation type; VIDEO || WALK-IN

    private String Status; // consultation type; BOOKED || FINISHED

    private Patient pt = new Patient(); // One consultation must have one patient

    // Once consultation is finished
    private String diagnosticReport; // will have consultation Report
    private String prescriptionID;   // and have a prescriptionID

    private int consultDuration;


    //CONSTRUCTORS
//    public Consultation(int ID, String dID, String pID, String consultDateTime,String status) {
//        this.ID = ID;
//        this.dID = dID;
//        this.pID = pID;
//        this.consultDateTime = consultDateTime;
//        this.Status = status;
//    }

    public Consultation(int ID, String dID, String pID, String consultDateTime , String diagnosticReport , String prescriptionID ,String consultType , String status,int consultDuration) {
        this.ID = ID;
        this.dID = dID;
        this.pID = pID;
        this.consultDateTime = consultDateTime;
        this.diagnosticReport = diagnosticReport;
        this.prescriptionID = prescriptionID;

        this.consultType = consultType;
        this.Status = status;
        this.consultDuration = consultDuration;

    }

    public int getConsultDuration() {
        return consultDuration;
    }

    public void setConsultDuration(int consultDuration) {
        this.consultDuration = consultDuration;
    }

    //GETTER AND SETTERS
    public String getDiagnosticReport() {
        return diagnosticReport;
    }

    public void setDiagnosticReport(String diagnosticReport) {
        this.diagnosticReport = diagnosticReport;
    }

    public String getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(String prescriptionID) {
        this.prescriptionID = prescriptionID;
    }

    public Patient getPt() {
        return pt;
    }

    public void setPt(Patient pt) {
        this.pt = pt;
    }

    public Consultation(){}

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getdID() {
        return dID;
    }

    public void setdID(String dID) {
        this.dID = dID;
    }

    public String getpID() {
        return pID;
    }

    public void setpID(String pID) {
        this.pID = pID;
    }

    public String getConsultDateTime() {
        return consultDateTime;
    }

    public void setConsultDateTime(String consultDateTime) {
        this.consultDateTime = consultDateTime;
    }

    public String getConsultType() {
        return consultType;
    }

    public void setConsultType(String consultType) {
        this.consultType = consultType;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }
}
