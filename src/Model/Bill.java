package Model;

import java.util.List;

/**
 * Created by PawandeepSingh on 4/2/17.
 */
public class Bill
{
    private String BillID;
    private double Amount;
    private double totalAmountPayable;
    private String BillingDate;

    private List<String> descriptionList;
    private List<Double> priceList;
    private String consultID;

    private double totalAmtBeforeGST;

    private boolean isPaymentMade;

    public double getTotalAmtBeforeGST() {
        return totalAmtBeforeGST;
    }

    public void setTotalAmtBeforeGST(double totalAmtBeforeGST) {
        this.totalAmtBeforeGST = totalAmtBeforeGST;
    }

    public Bill(){}


    //used to insert into db
    public Bill(String consultID,double totalAmountPayable,String billingDate)
    {
        this.consultID = consultID;
        this.totalAmountPayable =totalAmountPayable;
        this.BillingDate = billingDate;
    }

    public Bill(String billid,String consultid , double totalamountpayable,String billingDate)
    {
        this.BillID = billid;
        this.consultID = consultid;
        this.totalAmountPayable = totalamountpayable;
        this.BillingDate = billingDate;
    }

    public boolean isPaymentMade() {
        return isPaymentMade;
    }

    public void setPaymentMade(boolean paymentMade) {
        isPaymentMade = paymentMade;
    }

    public Bill(String billID, double amount, double totalAmountPayable, String billingDate, List<String> descriptionList, String consultID) {
        BillID = billID;
        Amount = amount;
        this.totalAmountPayable = totalAmountPayable;
        BillingDate = billingDate;
        this.descriptionList = descriptionList;
        this.consultID = consultID;
    }

    public List<Double> getPriceList() {
        return priceList;
    }

    public void setPriceList(List<Double> priceList) {
        this.priceList = priceList;
    }

    public String getConsultID() {
        return consultID;
    }

    public void setConsultID(String consultID) {
        this.consultID = consultID;
    }

    public String getBillID() {
        return BillID;
    }

    public void setBillID(String billID) {
        BillID = billID;
    }

    public List<String> getDescriptionList() {
        return descriptionList;
    }

    public void setDescriptionList(List<String> description) {
        this.descriptionList = description;
    }

    public double getAmount() {
        return Amount;
    }

    public void setAmount(double amount) {
        Amount = amount;
    }

    public double getTotalAmountPayable() {
        return  totalAmountPayable;
    }

    public void setTotalAmountPayable(double totalAmountPayable) {
        this.totalAmountPayable = totalAmountPayable;
    }

    public String getBillingDate() {
        return BillingDate;
    }

    public void setBillingDate(String billingDate) {
        BillingDate = billingDate;
    }
}
