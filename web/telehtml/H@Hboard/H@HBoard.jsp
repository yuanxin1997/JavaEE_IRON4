<%@ page import="Model.Doctor" %>
<%@ page import="Model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Hospital @ Home </title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />

    <!--     Fonts and icons     -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

    <!-- CSS Files -->
    <link href="../../assetsPawandeep/Login/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../assetsPawandeep/Login/assets/css/material-kit.css" rel="stylesheet"/>

    <!--jQuery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
<%

    String name = "";
    String usertype = "";

    if(session.getAttribute("user") instanceof Doctor)
    {
        Doctor dr = (Doctor) session.getAttribute("doctor");
        name = "Dr" + dr.getFirstName();
        usertype = "doctor";
    }
    else if(session.getAttribute("user") instanceof Patient)
        {
            Patient pt = (Patient) session.getAttribute("patient");
            name = pt.getFirstName() + " " + pt.getLastName();
            usertype ="patient";
        }


%>

<script>
    var userType = '<%=usertype%>'
    console.log(userType);

    $(document).ready(function ()
    {
        if (userType == 'doctor')
        {
            $('#teleconferencelink').attr("href",'../../telehtml/Dashboard/doctorDashboard.jsp');
            $('#teleconferencelink').text('Tele-Conference Consultation');

            $('#diabetesmonitorlink').attr('href','../../diabetesHTML/doctorPanel.jsp');
            $('#diabetesmonitorlink').text('Doctor Diabetes monitor');

        }
        else if(userType == 'patient')
        {
            $('#teleconferencelink').attr("href",'../../telehtml/Dashboard/patientDashboard.jsp');
            $('#teleconferencelink').text('Tele-Conference Consultation');


            $('#diabetesmonitorlink').attr('href','../../diabetesHTML/patientPanel.jsp');
            $('#diabetesmonitorlink').text('Patient Diabetes monitor');
        }

    })

</script>




<%--TODO: MAKE IT LOOK NICER--%>

<%--<a id="teleconferencelink"></a>--%>


<%--&lt;%&ndash; TODO: Direct to YUAN XIN part&ndash;%&gt;--%>
<%--<a id="diabetesmonitorlink">Diabetes Monitoring</a>--%>

<div class="wrapper">
    <div class="header">

    </div>
    <!-- you can use the class main-raised if you want the main area to be as a page with shadows -->
    <div class="main">
        <div class="container">

            <div class="row">
                <div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
                    <div class="card card-signup">

                            <div class="header header-primary text-center">
                                <h4>Welcome <%=name%> </h4>
                            </div>

                            <div class="content text-center">
                                <a class="btn btn-round btn-info" id="teleconferencelink">Tele-conference consultation</a>
                                 <a id="diabetesmonitorlink" class="btn btn-round btn-info">Diabetes Monitoring</a></button>


                            </div>
                            <div class="footer text-center">
                                <hr>
                                <a  class="btn btn-round btn-danger" href="/telehtml/Login/Login.jsp">Logout</a>
                            </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


</body>




</body>


<!--   Core JS Files   -->
<script src="../../assetsPawandeep/Login/assets/js/jquery.min.js" type="text/javascript"></script>
<script src="../../assetsPawandeep/Login/assets/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../../assetsPawandeep/Login/assets/js/material.min.js"></script>

<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="../../assetsPawandeep/Login/assets/js/nouislider.min.js" type="text/javascript"></script>

<!--  Plugin for the Datepicker, full documentation here: http://www.eyecon.ro/bootstrap-datepicker/ -->
<script src="../../assetsPawandeep/Login/assets/js/bootstrap-datepicker.js" type="text/javascript"></script>

<!-- Control Center for Material Kit: activating the ripples, parallax effects, scripts from the example pages etc -->
<script src="../../assetsPawandeep/Login/assets/js/material-kit.js" type="text/javascript"></script>


</html>