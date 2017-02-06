<%@ page import="Model.Patient" %><%--
  Created by IntelliJ IDEA.
  User: PawandeepSingh
  Date: 3/2/17
  Time: 2:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Patient Conference</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="../../assetsPawandeep/Dashboard/assets/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Animation library for notifications   -->
    <link href="../../assetsPawandeep/Dashboard/assets/css/animate.min.css" rel="stylesheet"/>
    <!--  Light Bootstrap Table core CSS    -->
    <link href="../../assetsPawandeep/Dashboard/assets/css/light-bootstrap-dashboard.css" rel="stylesheet"/>
    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="../../assetsPawandeep/Dashboard/assets/css/pe-icon-7-stroke.css" rel="stylesheet" />


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.js"></script>


    <script src="https://cdn.pubnub.com/pubnub.min.js"></script>
    <script src="../../assetsPawandeep/teleConference/webrtc.js"></script>

</head>
<%
    Patient pt = (Patient) session.getAttribute("patient");
    String name = pt.getFirstName();

    String NRIC = pt.getNRIC();

    String Consultid = request.getParameter("cid");

    //TODO : GET CONFERENECE AND SHOW DATE TIME
%>

<style>

    #local
    {
        position: fixed;
        top: 10px;
        right: 25px;

        width: 120px; height: 100px;
        /*for video to be ontop of stream video*/
        z-index: 998!important;
        margin-top: 5%;
    }

    #remote
    {
        top: 10px;
        right: 25px;
        z-index: 997 !important;
        margin-top: 5%;
    }



</style>



<script>

    var consultid = '<%=Consultid%>'

    var phoneNum = '<%=NRIC%>';
    // ~Warning~ You must get your own API Keys for non-demo purposes.
    // ~Warning~ Get your PubNub API Keys: https://www.pubnub.com/get-started/
    // The phone *number* can by any string value
    var phone = PHONE({
        number        :  phoneNum,
        publish_key   : 'pub-c-8fa2fbc3-e887-4032-8cbc-eecde52d9b3a',
        subscribe_key : 'sub-c-f2bfc6c4-cd1b-11e6-8164-0619f8945a4f',
        ssl           : true
    });

    phone.ready(function ()
    {
         phone.dial('D01');
    })


    phone.receive(function(session)
    {
//        var confirmPickUp = confirm('You have a incoming Call, Would like to pickup ?');

        // Display Your Friend's Live Video
        session.connected(function(session)
        {
           // if(confirmPickUp == true)
           // {

                phone.send({text:'start call'});//send message
                console.log('connected');
                //display patient video
                var remotevideo = document.getElementById('remote');
                var sessionvid = session.video; //get remote video
                remotevideo.src = sessionvid.src;



           // }
            //else
           // {
                //console.log('End call');
                //phone.send({text:'end'});

           // }


        });

        // when call ended
        session.ended(function(session){

            //direct patient back to main dashboard


                alert('Consultation has ended. Heading to consultation Bill');

                setTimeout(function () {
                    //TODO: PASS IN CONSULTATION ID AS WELL
                    location.href = '/telehtml/Dashboard/patientBillboard.jsp?cid='+consultid;
                },1000)


        });

    });


    var consultnotes;
    //receive message
    phone.message(function (session,message)
    {
        var lastentry = "";
        consultnotes = message.notes;


        // console.log(session.number + " " + message.notes);
        $('#recieveConsultNotes').text(consultnotes);

    })


    phone.connect(function(){    console.log('network LIVE.') })


    $(document).ready(function ()
    {
        var patientRecords =  getPatientPastRecords();
        function getPatientPastRecords()
        {
            var pastrecords = [];
            $.ajax(
                    {
                        async: false,
                        url : '/services/consultation/getpatientpastrecords/'+ '<%=NRIC%>',
                        type: 'GET',
                        datatype:'json',
                        success:function (data)
                        {
                            pastrecords = data;
                            var numOfRecords = data.length;
                            //console.log(pastrecords);

                            for(var i = 0 ; i < numOfRecords ;i++)
                            {
                                $('#pastRecordsNav').append
                                ( '<li><a href="#"><p>'+ pastrecords[i].consultDateTime + '</p></a></li>'
                                )
                            }
                        }
                    })

            return pastrecords;
        }

        function getPatientPastPrescriptions(consultid)
        {
            var pastprescriptions = [];
            $.ajax(
                    {
                        async : false,
                        url : '/services/prescription/getpastprescription/' + consultid,
                        type : 'GET',
                        datatype : 'json',
                        success:function(data)
                        {
                            pastprescriptions = data;
                        }
                    })
            return pastprescriptions;
        }

        //Every nav bar link clicked will change the look
        $('#pastRecordsNav > li').click(function ()
        {
            $('#selectedPastReport').empty();
            $('#selectedPastPrescriptionTable > tbody').empty();

            $("li.active").removeClass("active");
            $(this).addClass('active');

            var index = $(this).index();
            var selectedRecord = patientRecords[index];

            //get record diagnostics;
            var diagnosticReport = selectedRecord.diagnosticReport;

            //get record prescription
            var patientPrescriptions = getPatientPastPrescriptions(selectedRecord.ID);

            var medicineNames = patientPrescriptions.medNameList;

            var Dosages = patientPrescriptions.dosageList;
            var Frequency = patientPrescriptions.frequencyList;


            displayPastRecords(diagnosticReport,medicineNames,Dosages,Frequency);

        })

        function displayPastRecords(diagnosticReport,medicineName , dosage , frequency )
        {

            $('#selectedPastReport').text(diagnosticReport);

            var size = dosage.length;

            for(var i = 0 ; i < size ; i++)
            {
                var medname

                for(var j = 0 ; j<medicineName.length;j++)
                {
                    medname = medicineName[j];
                }

                $('#selectedPastPrescriptionTable > tbody').append
                (
                        '<tr>' +
                        '<td>' + medname  + '</td>' +
                        '<td>' + dosage[i]  + '</td>' +
                        '<td>' + frequency[i] + '</td>' +
                        '</tr>'
                );
            }



        }

        $('#pastRecordsNav > li:eq(0)').trigger('click');

    })



</script>



<body>

<div class="wrapper">

    <div class="sidebar" data-color="green" >

        <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->
        <!--SIDE BAR NAVIGATION-->
        <!--SIDE BAR NAVIGATION-->
        <div class="sidebar-wrapper">
            <div class="logo">


                My Past Records
            </div>

            <ul class="nav" id="pastRecordsNav">

                <%--<li class="active">--%>
                <%--<a href="#">--%>
                <%--<p>Record 1 </p>--%>
                <%--</a>--%>

                <%--</li>--%>


            </ul>
        </div>



    </div>
    <%--END OF SIDEBAR--%>



    <div class="main-panel">


        <%--TOP NAVBARS--%>
        <nav class="nav navbar-default navbar-fixed">

            <div class="container-fluid">

                <!--BAR NAVIGATION HEADER-->

                <div class="navbar-header">

                    <a class="navbar-brand" href="#">Dashboard</a>


                </div>

                <div class="collapse navbar-collapse">

                    <!--LEFT SIDE TOP BAR NAVIGATION-->

                    <ul class="nav navbar-nav navbar-left">
                        <li>
                            <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown">--%>
                            <%--<i class="fa fa-dashboard"></i>--%>
                            <%--</a>--%>
                        </li>
                    </ul>

                    <!--RIGHT SIDE TOP BAR NAVIGATION-->
                    <%--TODO UPDATE LIKE YUAN XIN's --%>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                Account
                                <b class="caret"></b>
                            </a>

                            <ul class="dropdown-menu">
                                <li>
                                    <a href="../Login/Login.jsp">Logout</a>
                                </li>
                            </ul>
                        </li>
                    </ul>

                </div>


            </div>
        </nav>
        <%--END OF TOP NAVBAR--%>


            <!--MAIN BODY-->
            <div class="content" id="mainBody">
                <div class="container-fluid" id="main">

                    <div class="row">

                        <div class="col-md-8" id="side">
                            <div class="card">
                                <div class="header">Selected Record</div>
                                <hr>
                                <div class="content">
                                    <p>Diagnostics Report :  <span id="selectedPastReport"></span> </p>
                                    <p>Medicine prescribed</p>


                                    <table class="table" id="selectedPastPrescriptionTable">

                                        <thead>
                                        <tr>
                                            <th>Medicine Name</th>
                                            <th>Dosage</th>
                                            <th>Frequency</th>
                                        </tr>
                                        </thead>

                                        <tbody>



                                        </tbody>
                                    </table>

                                </div>

                                <div class="footer">
                                    <hr>
                                    <div class="stats">
                                        <i class="fa fa-clock-o"></i>
                                        Date of Record added
                                    </div>
                                </div>

                            </div>
                        </div>


                        <div class="col-md-8">
                            <video autoplay id="local"></video>
                            <video autoplay id="remote" height="250px" style="position: fixed"></video>
                        </div>


                    </div>

                    <div class="row">

                        <div class="col-md-12">
                            <textarea readonly id="recieveConsultNotes"></textarea>
                        </div>

                    </div>




                </div>
            </div>


            <!--FOOTER-->
            <footer class="footer">
                <div class="container-fluid">
                    <nav class="pull-left">
                        <ul>
                            <li>
                                <a href="#">
                                    Home
                                </a>
                            </li>

                        </ul>
                    </nav>
                </div>
            </footer>



    </div>
</div>






</body>

<!--   Core JS Files   -->
<!--<script src="../../assetsPawandeep/Dashboard/assets/js/jquery-1.10.2.js" type="text/javascript"></script>-->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script src="../../assetsPawandeep/Dashboard/assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap-notify.js"></script>



</html>





