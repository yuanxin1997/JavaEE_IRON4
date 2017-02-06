package Model;

/**
 * Created by PawandeepSingh on 3/1/17.
 */

/*
* NRIC
	Password
	name
	DOB
	height
	weight
	Blood type
	Race
	Sex
	Phone number
	tele-phone number
	Allergies
	citizenship
	dietary needs
*
* */

//Patient is child of User
public class Patient {

    //INSTANCE VARIABLES
    private String patientID;
    private String NRIC;

    private String firstName;
    private String lastName;

    private String Gender;
    private String DOB;//date of birth
    private double Height;
    private double Weight;
    private String bloodType;


    private String Race;
    private String Sex;
    private int phoneNum;
    private int telePhoneNum;

    private String Allergies;
    private String Citizenship;
    private String dietaryNeeds;

    private String emailAddress;
    private String dateOfAdmission;
    private String profilePic;

    private boolean isDiabetic;



    //CONSTRUCTORS
    public Patient(){}

    public Patient
            (
            String patientID, String NRIC, String firstName, String lastName, String gender, String DOB, double height,
            double weight, String bloodType, String race, String sex, int phoneNum, int telePhoneNum, String allergies,
            String citizenship, String dietaryNeeds, String emailAddress, String dateOfAdmission, String profilePic
            ,boolean isDiabetic
            )
    {
        this.patientID = patientID;
        this.NRIC = NRIC;
        this.firstName = firstName;
        this.lastName = lastName;
        Gender = gender;
        this.DOB = DOB;
        Height = height;
        Weight = weight;
        this.bloodType = bloodType;
        Race = race;
        Sex = sex;
        this.phoneNum = phoneNum;
        this.telePhoneNum = telePhoneNum;
        Allergies = allergies;
        Citizenship = citizenship;
        this.dietaryNeeds = dietaryNeeds;
        this.emailAddress = emailAddress;
        this.dateOfAdmission = dateOfAdmission;
        this.profilePic = profilePic;

        this.isDiabetic = isDiabetic;
    }


    //GETTERS AND SETTERS


    public boolean isDiabetic() {
        return isDiabetic;
    }

    public void setDiabetic(boolean diabetic) {
        isDiabetic = diabetic;
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public String getNRIC() {
        return NRIC;
    }

    public void setNRIC(String NRIC) {
        this.NRIC = NRIC;
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

    public String getGender() {
        return Gender;
    }

    public void setGender(String gender) {
        Gender = gender;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public double getHeight() {
        return Height;
    }

    public void setHeight(double height) {
        Height = height;
    }

    public double getWeight() {
        return Weight;
    }

    public void setWeight(double weight) {
        Weight = weight;
    }

    public String getBloodType() {
        return bloodType;
    }

    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }

    public String getRace() {
        return Race;
    }

    public void setRace(String race) {
        Race = race;
    }

    public String getSex() {
        return Sex;
    }

    public void setSex(String sex) {
        Sex = sex;
    }

    public int getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(int phoneNum) {
        this.phoneNum = phoneNum;
    }

    public int getTelePhoneNum() {
        return telePhoneNum;
    }

    public void setTelePhoneNum(int telePhoneNum) {
        this.telePhoneNum = telePhoneNum;
    }

    public String getAllergies() {
        return Allergies;
    }

    public void setAllergies(String allergies) {
        Allergies = allergies;
    }

    public String getCitizenship() {
        return Citizenship;
    }

    public void setCitizenship(String citizenship) {
        Citizenship = citizenship;
    }

    public String getDietaryNeeds() {
        return dietaryNeeds;
    }

    public void setDietaryNeeds(String dietaryNeeds) {
        this.dietaryNeeds = dietaryNeeds;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getDateOfAdmission() {
        return dateOfAdmission;
    }

    public void setDateOfAdmission(String dateOfAdmission) {
        this.dateOfAdmission = dateOfAdmission;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }
}
