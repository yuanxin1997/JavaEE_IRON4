package Utility;

import Database.DoctorDBAO;
import Database.PatientDBAO;
import Model.Doctor;
import Model.Patient;

/**
 * Created by PawandeepSingh on 31/1/17.
 */
public class CheckUserAccount
{
    public static Object getUserType(char userType,String username)
    {



        if (userType == 'D')
        {
            Doctor dr = new Doctor();
            dr = DoctorDBAO.getDoctor(username);
            return  dr;
        }
        else if(userType == 'P')
        {
            Patient pt = new Patient();
            pt = PatientDBAO.getPatientviaID(username);
            return pt;
        }
        else
            {
                return null;
            }

    }

}
