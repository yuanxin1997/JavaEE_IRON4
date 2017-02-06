package Utility;

import Database.BillDBAO;
import Database.ConsultationDBAO;
import Database.MedicineDBAO;
import Database.PrescriptionDBAO;
import Model.Bill;
import Model.Consultation;
import Model.Medicine;
import Model.Prescription;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by PawandeepSingh on 4/2/17.
 */
public class BillUtility
{
    private static final double GST = 7;


    public static Bill CalculateBill(List<String> medIDlist , int consulttaionDuration, String consultationID)
    {
        List<Double> Amount = new ArrayList<Double>();
        Bill bill = new Bill();

        List<Double> medicinePriceList= new ArrayList<Double>();
        List<Medicine> medicines = MedicineDBAO.getAllMedicines();

        if(!(medIDlist == null))
        {

            //get the price of the medicines
            for (int i = 0 ; i < medIDlist.size();i++)
            {
                for(int j = 0 ; j < medicines.size(); j++ )
                {
                    int medicineid = medicines.get(j).getMedID();
                    String medicineidString = Integer.toString(medicineid);

                    if(medIDlist.get(i).equals(medicineidString))
                    {
                        medicinePriceList.add(medicines.get(j).getPrice());
                        System.out.println("med id is :" + medIDlist.get(i) + "\t med price is " + medicines.get(j).getPrice());
                    }
                }
            }

            for(int i = 0 ; i<medicinePriceList.size();i++)
            {
                Amount.add(medicinePriceList.get(i));
            }

        }
        else
            {
                double medPrice = 0;
                Amount.add(medPrice);
            }

        double consultaionPrice = 0 ;

        //calculate price of consultation
        if(consulttaionDuration > 30 && consulttaionDuration < 45 ) // in minutes
        {
            consultaionPrice = 15;
        }
        else if(consulttaionDuration >= 45 && consulttaionDuration < 60 )
        {
            consultaionPrice = 25;
        }
        else if(consulttaionDuration > 60)
        {
            consultaionPrice = 30;
        }

        System.out.println("consult duration is " + consulttaionDuration + "\n consult price : " + consultaionPrice);



        Amount.add(consultaionPrice);

        // calculate totalAmount

        //before gst
        double totalAmountBeforeGST = 0;
        for(int i = 0 ; i <Amount.size();i++)
        {
            totalAmountBeforeGST += Amount.get(i);
        }

        //after gst
        double totalAmountAfterGST = (totalAmountBeforeGST*(GST/100))+totalAmountBeforeGST;

        System.out.println("price before gst is " + totalAmountBeforeGST + "\n after gst " + totalAmountAfterGST);

        DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss a");
        Date today = new Date();


        bill = new Bill(consultationID,totalAmountAfterGST,df.format(today));

        //get medicine price
        //duration of consultation
        //calcualte with and without gst 7

        return bill;

    }

    public static Bill viewBill(String consultid)
    {
        List<String> descriptions = new ArrayList<String>();
        List<Double> priceList = new ArrayList<Double>();
        Bill bill;
        bill = BillDBAO.getBillviaConsultID(consultid);

        Consultation cn = ConsultationDBAO.getSelectedConsultation(consultid);
        Prescription pt = PrescriptionDBAO.getPrescriptionsByConsultationID(consultid);
        List<Medicine> mdlist = MedicineDBAO.getAllMedicines();

        //get medicine descriptions
        // and price of each medicine
        for(int i = 0 ; i<pt.getMedicineIDs().size();i++)
        {

            int medid = Integer.valueOf(pt.getMedicineIDs().get(i));

            for(int j = 0 ; j<mdlist.size() ; j++)
            {
                if(mdlist.get(j).getMedID() == medid )
                {
                    descriptions.add(mdlist.get(j).getName());
                    System.out.println();

                }
            }

        }

        for(int i = 0 ; i<descriptions.size();i++)
        {
            for(int j = 0 ; j<mdlist.size() ; j++)
            {
                    if(descriptions.get(i).equals(mdlist.get(j).getName()))
                    {
                        priceList.add(mdlist.get(j).getPrice());
                    }
            }
        }


        //get duration
        int duration = cn.getConsultDuration();
        String durationStr = Integer.toString(duration);
        descriptions.add("Consult duration : " + durationStr);


        //get duration price
        double consultaionPrice = 0 ;

        //calculate price of consultation
        if(duration > 30 && duration < 45 ) // in minutes
        {
            consultaionPrice = 15;
        }
        else if(duration >= 45 && duration < 60 )
        {
            consultaionPrice = 25;
        }
        else if(duration > 60)
        {
            consultaionPrice = 30;
        }

        priceList.add(consultaionPrice);



        //total amount
        // total charge b4 gst
        double AmtBeforeGST = (bill.getTotalAmountPayable())/1.07;
        DecimalFormat df = new DecimalFormat("##.##");
        bill.setTotalAmtBeforeGST(Double.valueOf(df.format(AmtBeforeGST)));

        bill.setDescriptionList(descriptions);
        bill.setPriceList(priceList);




        return bill;
    }





    public static void main(String [] args)
    {
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss a");
        Date today = new Date();
        System.out.println(df.format(today));


        Bill b = viewBill("3");
        for(int i = 0 ; i <b.getDescriptionList().size();i++)
        {
            System.out.println("description ------  price");
            System.out.println(b.getDescriptionList().get(i) + "------" + b.getPriceList().get(i));




        }
        System.out.println("tOTAL CHARGE " + b.getTotalAmtBeforeGST());
        System.out.println("Before GST " + b.getTotalAmtBeforeGST());
        System.out.println("After GST " + b.getTotalAmountPayable());
        System.out.println("Total Amount payable " + b.getTotalAmountPayable());
    }
}
