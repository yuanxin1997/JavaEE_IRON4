package Model;

/**
 * Created by PawandeepSingh on 3/1/17.
 */


public class User
{

    // INSTANCE VARIABLES
    private String Username; // will respective doctorId and patientID
    private String Password;
    private String emailAddress;

    //CONSTRUCTORS
    public User(){}

    public User(String username , String password , String emailAddress)
    {
        this.Username = username;
        this.Password = password;
        this.emailAddress = emailAddress;
    }


    //GETTERS AND SETTERS

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
}
