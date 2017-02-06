package Model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by PawandeepSingh on 9/1/17.
 */

/*
* -medName fk        			-pk
	-Dosage (take how much )				 	composite keys
	-Frequency (how many times a day)
	-PatientID - patient NRIC fk     -pk
	-DoctorID
*
* */

//ONE PRESCRIPTION CAN HAVE MANY MEDICINES
public class Prescription
{
    //INSTANCE VARIABLES
    private List<String> medicineID;
    private List<String> dosageList;
    private List<String> frequencyList;

    //EACH PRESCRIPTION IS BELONGS TO A SPECIFIC CONSULATIONID
    // AND PATIENTID(same as NRIC)
    private String consultID;
    private String patientID;

    private List<String> medNameList = new ArrayList<String>();


    //CONSTRUCTORS
    public Prescription(){}

    public Prescription(String consultID, String patientID, List<String> medicineIDList , List<String> dosageList , List<String> frequencyList)
    {
        this.consultID = consultID;
        this.patientID = patientID;

        this.medicineID = medicineIDList;
        this.dosageList = dosageList;
        this.frequencyList = frequencyList;
    }

    //GETTERS AND SETTERS


    public List<String> getMedNamelist() {
        return medNameList;
    }

    public void setMedNamelist(List<String> medNamelist) {
        this.medNameList = medNamelist;
    }

    public List<String> getMedicineIDs() {
        return medicineID;
    }

    public void setMedicineIDList(List<String> medicineID) {
        this.medicineID = medicineID;
    }

    public List<String> getDosageList() {
        return dosageList;
    }

    public void setDosageList(List<String> dosageList) {
        this.dosageList = dosageList;
    }

    public List<String> getFrequencyList() {
        return frequencyList;
    }

    public void setFrequencyList(List<String> frequencyList) {
        this.frequencyList = frequencyList;
    }

    public String getConsultID() {
        return consultID;
    }

    public void setConsultID(String consultID) {
        this.consultID = consultID;
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }
}
