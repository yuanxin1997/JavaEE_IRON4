package Model;

/**
 * Created by PawandeepSingh on 3/1/17.
 */

//did - ID PK
//        Password
//        specialisaton ? //TODO FOR DOCTOR ENTITY:
//        Name


public class Doctor
{
    private String doctorID;//SAME AS USER: username variable
    private String firstName;
    private String lastName;

    private String emailAddress;
    private String dateJoined;
    private String Gender;
    private String contactNo;
    private String profilePic;//TODO check on picture data type


    //CONSTRUCTORS
    public Doctor()
    {

    }


    public Doctor(String doctorID,String firstName, String lastName,String emailAddress ,String dateJoined, String gender, String contactNo, String profilePic) {

        this.doctorID = doctorID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.emailAddress = emailAddress;
        this.dateJoined = dateJoined;
        Gender = gender;
        this.contactNo = contactNo;
        this.profilePic = profilePic;
    }


    //GETTERS AND SETTERS


    public String getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getDateJoined() {
        return dateJoined;
    }

    public void setDateJoined(String dateJoined) {
        this.dateJoined = dateJoined;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String gender) {
        Gender = gender;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }
}
