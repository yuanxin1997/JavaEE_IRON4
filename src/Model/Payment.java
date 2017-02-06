package Model;

/**
 * Created by PawandeepSingh on 4/2/17.
 */
public class Payment
{
    private String paymentID;
    private String billID;

    private String patientid;

    private String Name;
    private String emailAddress;

    private int creditCardNumber;
    private String paymentType;
    private String creditCardExpiryDate;
    private int CSVNumber;

    private String streetAddress1;
    private String streetAddress2;
    private String stateProvince;
    private int postalCode;
    private String Country;
    private int PhoneNum;

    public Payment(){}

    public Payment(String billID, String patientid, int creditCardNumber, String paymentType, String creditCardExpiryDate, int CSVNumber, String streetAddress1, String streetAddress2, String stateProvince, int postalCode, String country) {
        this.billID = billID;
        this.patientid = patientid;
        this.creditCardNumber = creditCardNumber;
        this.paymentType = paymentType;
        this.creditCardExpiryDate = creditCardExpiryDate;
        this.CSVNumber = CSVNumber;
        this.streetAddress1 = streetAddress1;
        this.streetAddress2 = streetAddress2;
        this.stateProvince = stateProvince;
        this.postalCode = postalCode;
        Country = country;
    }

    //GETTERS AND SETTERS


    public String getPatientid() {
        return patientid;
    }

    public void setPatientid(String patientid) {
        this.patientid = patientid;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public String getBillID() {
        return billID;
    }

    public void setBillID(String billID) {
        this.billID = billID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public int getCreditCardNumber() {
        return creditCardNumber;
    }

    public void setCreditCardNumber(int creditCardNumber) {
        this.creditCardNumber = creditCardNumber;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getCreditCardExpiryDate() {
        return creditCardExpiryDate;
    }

    public void setCreditCardExpiryDate(String creditCardExpiryDate) {
        this.creditCardExpiryDate = creditCardExpiryDate;
    }

    public int getCSVNumber() {
        return CSVNumber;
    }

    public void setCSVNumber(int CSVNumber) {
        this.CSVNumber = CSVNumber;
    }

    public String getStreetAddress1() {
        return streetAddress1;
    }

    public void setStreetAddress1(String streetAddress1) {
        this.streetAddress1 = streetAddress1;
    }

    public String getStreetAddress2() {
        return streetAddress2;
    }

    public void setStreetAddress2(String streetAddress2) {
        this.streetAddress2 = streetAddress2;
    }

    public String getStateProvince() {
        return stateProvince;
    }

    public void setStateProvince(String stateProvince) {
        this.stateProvince = stateProvince;
    }

    public int getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(int postalCode) {
        this.postalCode = postalCode;
    }

    public String getCountry() {
        return Country;
    }

    public void setCountry(String country) {
        Country = country;
    }

    public int getPhoneNum() {
        return PhoneNum;
    }

    public void setPhoneNum(int phoneNum) {
        PhoneNum = phoneNum;
    }
}
