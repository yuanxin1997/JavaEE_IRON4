package Model;

/**
 * Created by PawandeepSingh on 9/1/17.
 */


/*medID - PK
	name
	price*/
public class Medicine
{

    //INSTANCE VARIABLES
    private int medID;
    private String Name;
    private double Price;

    //CONSTRUCTORS
    public Medicine(){}

    public Medicine(int medID, String name, double price)
    {
        this.medID = medID;
        Name = name;
        Price = price;
    }

    //GETTERS AND SETTERS
    public int getMedID() {
        return medID;
    }

    public void setMedID(int medID) {
        this.medID = medID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double price) {
        Price = price;
    }
}
