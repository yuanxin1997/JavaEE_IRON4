
<%@ page import="Model.Doctor" %><%--
  Created by IntelliJ IDEA.
  User: PawandeepSingh
  Date: 26/1/17
  Time: 12:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Doctor Dashboard</title>

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

    <%--moment JS--%>
    <script src="https://cdn.jsdelivr.net/momentjs/2.13.0/moment.min.js"></script>

    <!--jQuery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    <script type="text/javascript" src="../../assetsPawandeep/Dashboard/noty/packaged/jquery.noty.packaged.min.js"></script>

    <!--jquery ui-->
    <link href="../../assetsPawandeep/Dashboard/jquery-ui/jquery-ui.css" rel="stylesheet">
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery-ui.js"></script>
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery.ui.autocomplete.scroll.js"></script>
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery.ui.autocomplete.scroll.min.js"></script>

</head>

<body>

<%

    //Get logined user details
    Doctor doctor = (Doctor) session.getAttribute("doctor");
    String name = doctor.getFirstName() + " " + doctor.getLastName();
    String doctorid = doctor.getDoctorID();

%>


<script src="../../assetsPawandeep/Dashboard/doctorDashboard.js"></script>
<script>

    var doctorid = '<%=doctorid%>';

    var alertId;
    var patientnric;
    var patientname;
    var patientconsulttype;

    var minutes = 300000;// 5 minutes


    function setConferenceLink(nric,cid,consulttype)
    {
        location.href = '/conference?nric='+ nric + '&cid='+cid + '&consulttype='+consulttype;
    }

    function stopConsultationInterval(Id)
    {
        console.log('interval stopped');
        clearInterval(Id);
    }

    //TODO UPDATE THIS -- for testing is 5 seconds , actual 5 mins
    function AlertInterval(patientNRIC,consultID,consultType)
    {



         var seconds = 5000;//for testing
      var id = setInterval(function ()
      {
          console.log('alert interval beginning')
        patientConsultationAlert(patientNRIC,consultID,consultType);
      },seconds)

        return id;
    }


    //alert doctor of consultation
    function patientConsultationAlert(patientNRIC, consultID,consultType)
    {

        if(consultType == 'Walk-in')
        {
            consultType = 'WALKIN'
        }
        else
            {
                consultType = 'VIDEO'
            }

        // clearInterval(consultationIntervalId); //to stop interval
        var n =  noty({
            text        : 'Your next consultation is with <br>'+ patientname +'. \n Would you like to begin ? ',
            type        : 'alert',
            dismissQueue: false,
            layout      : 'topRight',
            theme       : 'relax',
            closeWith: [], // ['click', 'button', 'hover']
            animation:
            {
                open: {height: 'toggle'},
                close: {height: 'toggle'},
                easing: 'swing',
                speed: 500 // opening & closing animation speed
            },
            buttons: [
                {
                    addClass: 'btn btn-primary', text: 'Begin consultation',
                    id : 'call',
                    onClick: function ($noty)
                    {
                        stopConsultationInterval(alertId);
                        $noty.close();
                        setConferenceLink(patientNRIC,consultID, consultType);
                        //location.href = '/conference?nric=' + patientNRIC + '&cid=' + consultID;

                    }
                },
                {addClass: 'btn btn-danger', text: 'Remind me later', onClick: function ($noty) {
                    $noty.close();
                   // noty({dismissQueue: true, force: true, layout: layout, theme: 'defaultTheme', text: 'You clicked "Cancel" button', type: 'error'});
                }
                }
            ]
        })

        return n ;
    }



    $(document).ready(function ()
    {

            //FOR TESTING todo : remove this after presentation
            $('#testNoty').click(function ()
            {
                patientConsultationAlert("patientName","testnric")
            })


        var upcomingConsultations;//array to store doctor upcoming consultation


        //TODO : FOR TESTING : 5 SECONDS , ACTUAL 5 MINS
        //INTERVAL EVERY 5 SECONDS
        var intervalTest = 5000;
        var consultationIntervalId = setInterval(function ()
        {
            ConsultationInterval()
        },intervalTest);

        function getRemindedofUpcomingConsultation(upcomingdateTime,ptname,ptnric,cid,consulttype)
        {

            ////TO DETERMINE WHEN TO SET ALERT TO CALL PATIENT
            //IF CONSULTATION IS ABOUT TO BEGIN 15 MINUTES OR LESS
            // CALL PATIENT THEN
            //IF DOCTOR , SAYS LATER
            //REMIND HIM/HER EVERY 5 MINUTES

            var now = moment(new Date());

            var upcomingConsultTime = moment(upcomingdateTime, 'DD-MM-YYYY hh:mm:ss a');

            var mindiff = upcomingConsultTime.diff(now, 'minutes');
            var min = mindiff++;

            console.log(min);
            if (min < 15 && min >= 0) {
                patientname = ptname;
                patientnric = ptnric
                consultid = cid;
                patientconsulttype = consulttype;


                console.log('id is ' + consultid);

                //stop consultationinterval
                stopConsultationInterval(consultationIntervalId);
                //and begin alert interval
                alertId = AlertInterval(patientnric, consultid, patientconsulttype);
            }
        }


        function ConsultationInterval()
        {

            $('#doctorConsultationsTable > tbody').empty();//Empty table
            upcomingConsultations = getUpcomingConsultations(); //get consultation via ajax

            if(!(upcomingConsultations == null))
            {
                ////TO DETERMINE WHEN TO SET ALERT TO CALL PATIENT
                //IF CONSULTATION IS ABOUT TO BEGIN 15 MINUTES OR LESS
                // CALL PATIENT THEN
                //IF DOCTOR , SAYS LATER
                //REMIND HIM/HER EVERY 5 MINUTES
                var upcomingdatetime = upcomingConsultations[0].consultDateTime;
                var upcomingptname = upcomingConsultations[0].pt.firstName + " " + upcomingConsultations[0].pt.lastName;
                var upcomingptnric = upcomingConsultations[0].pID;
                var consultid = upcomingConsultations[0].ID;
                var consulttype =upcomingConsultations[0].consultType;


                getRemindedofUpcomingConsultation(upcomingdatetime,upcomingptname,upcomingptnric,consultid,consulttype);

                onViewPatientClickListener(upcomingConsultations); // refresh the table links
                setVideoBtnListener(upcomingConsultations);//as well as when starting video TODO - UPDATE THIS PORTION OF VIDEO BUTTON
            }


            }

        /*
        * To get upcoming consultations
        * */
        function getUpcomingConsultations()
        {
            var url = '/services/consultation/getdrupcomingconsultations/'+'<%=doctorid%>';
            var upcomingCn = [];//to store all latest consultations
            $.ajax({
                        async:false,//in order to return data
                        url: url,
                        type : 'GET',
                        datatype : 'json',
                        success:function (response)
                        {


                            var index = 0;//index to count num of rows
                            //console.log(response);
                            if(!(response.length==0))
                            {
                                upcomingCn = response;

                                for (var i = 0 ; i < response.length;i++)
                                {


                                    var cn = response[i];//get each consultation object
                                    index++;
                                    appendTableConsultation(index , cn.pt.firstName + " " + cn.pt.lastName , cn.consultDateTime , cn.consultType);
                                }
                            }
                            else
                                {
                                    upcomingCn = null;
//                                    alert('no consultation as of moment. seek nurse assistance.');
                                        console.log('no consultation as of moment.seek nurse assistance');
                                }
                        }

            })
            return upcomingCn;
        }


        //Insert Row into consultationTable
        function appendTableConsultation(num , patientName , consultDateTime , consultType)
        {
            //TODO UPDATE BUTTON LINKS FOR TYPE WALK IN AND VIDEO -- DONE
            var todayConsultTable =  $('#doctorConsultationsTable > tbody:last');
            var aTag;
            if(consultType == 'Video')
            {
                aTag = '<button id="startConference">Begin Conference</button>'
            }
            else
                {
                    aTag = '<button id="startConference">Begin consultation</button>'
                }

            todayConsultTable.append
            (
                    '<tr>' +
                    '  <td>' + (num) + '</td>'
                    + '<td>' + '<a id="viewPatient" data-toggle="modal" data-target="#modal1" href=#>'+ patientName + '</a>' + '</td>'
                    + '<td>' + consultDateTime + '</td>'
                    + '<td>' + consultType + '</td>' +
                    '<td>'+aTag +'<td>'+
                    '</tr>'
            );
        }

        //Listener for when video button is clicked
        function setVideoBtnListener(consultation)
        {

            //When Video conference button is clicked
            $('#doctorConsultationsTable').on('click','#startConference',function ()
            {
                var consultType = "";
                var rowIndex = $(this).closest('td').parent()[0].sectionRowIndex; // get selected row index
                if(consultation[rowIndex].consultType == "Walk-in")
                {
                    consultType = "WALKIN"
                }
                else
                    {
                        consultType = "VIDEO"
                    }

                setConferenceLink(consultation[rowIndex].pID,consultation[rowIndex].ID, consultType);
            })
        }


        //Listener for View patient link
        function onViewPatientClickListener(consultation)
        {
            $('#doctorConsultationsTable').on('click','#viewPatient',function ()
            {
                var rowIndex = $(this).closest('td').parent()[0].sectionRowIndex; // get selected row index
                console.log(rowIndex);
                //var currentRow=$(this).closest("tr");// get the current row

                var consultationDetail = consultation[rowIndex];
              //  console.log(consultationDetail);
                var patient = consultationDetail.pt;
                    //console.log(consultationDetail.pt);
                displayPatientDetails(patient.firstName + " " + patient.lastName,patient.NRIC,patient.DOB,patient.Height,patient.Weight);

            })
        }


        //To display the patient details when selected
        function displayPatientDetails(name,nric,dob,height,weight)
        {
            //TODO DISPLAY PATIENT DETAILS
            //for user to view
            $('#patientName').text(name);
            $('#patientNRIC').text(nric);
            $('#patientDOB').text(dob);
            $('#patientHeight').text(height);
            $('#patientWeight').text(weight);
        }

    })
</script>


<div class="wrapper">


    <div class="sidebar" data-color="black" >

        <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->
        <!--SIDE BAR NAVIGATION-->
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="javascript:void(0)" class="simple-text">
                    Consultation Conference
                </a>
            </div>

            <ul class="nav">

                <li class="active" id="mainClick">
                    <a href="#">
                        <i class="pe-7s-home"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

                <li id="consultationClick">
                    <a href="#">
                        <i class="pe-7s-note2"></i>
                        <p>Consultations</p>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <i class="pe-7s-users"></i>
                        <p>Patients</p>
                    </a>
                </li>

            </ul>
        </div>



    </div>
    <%--END OF SIDEBAR--%>

    <div class="main-panel">


        <%--TOP NAVBARS--%>
        <nav class="nav navbar-default navbar-fixed">

            <div class="container-fluid">


                <div class="collapse navbar-collapse">

                    <!--LEFT SIDE TOP BAR NAVIGATION-->

                    <ul class="nav navbar-nav navbar-left">
                        <%--<div> current time:  <span id="displaytime"></span></div>--%>
                    </ul>

                    <!--RIGHT SIDE TOP BAR NAVIGATION-->
                    <%--TODO UPDATE LIKE YUAN XIN's --%>
                    <ul class="nav navbar-nav navbar-right">

                        <li class="dropdown">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                Dr. <%=name%>
                                <b class="caret"></b>
                            </a>

                            <ul class="dropdown-menu">
                                <li>
                                    <a href="/telehtml/H@Hboard/H@HBoard.jsp">Head back to main page</a>
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



                        <button id="testNoty">test noty</button>

                        <div class="col-md-12">

                            <div class="card">

                                <div class="header">
                                    <h3 class="title">Upcoming Consultations</h3>
                                </div>

                                <div class="content table-full-width table-responsive">

                                        <table class="table" id="doctorConsultationsTable">

                                            <thead>

                                                <tr>
                                                    <th>No.</th>
                                                    <th>Patient Name</th>
                                                    <th>DateTime</th>
                                                    <th>Type</th>
                                                    <th>Action</th>
                                                </tr>

                                            </thead>

                                            <tbody>


                                            </tbody>


                                        </table>
                                </div>

                                <div class="footer">
                                    <hr>

                                    <div class="stats">
                                        &nbsp; click to view more
                                    </div>


                                </div>

                            </div>


                        </div>



                    </div>
                </div>
            </div>


            <%--<!--FOOTER-->--%>
            <%--<footer class="footer">--%>
                <%--<div class="container-fluid">--%>
                    <%--<nav class="pull-left">--%>
                        <%--<ul>--%>
                            <%--<li>--%>
                                <%--<a href="#">--%>
                                    <%--Home--%>
                                <%--</a>--%>
                            <%--</li>--%>

                        <%--</ul>--%>
                    <%--</nav>--%>
                <%--</div>--%>
            <%--</footer>--%>

    </div>

</div>
<%--END OF MAIN PANEL--%>


</body>

<!--   Core JS Files   -->
<script src="../../assetsPawandeep/Dashboard/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script src="../../assetsPawandeep/Dashboard/assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap-notify.js"></script>




</html>

<!--Modal for patient pop up-->
<!-- Modal Core -->
<div class="modal fade" id="modal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><span id="patientName"></span></h4>
            </div>

            <div class="modal-body">
                <p>NRIC:   <span id="patientNRIC"></span>        </p>
                <p>Date of Birth: <span id="patientDOB"></span>  </p>
                <p>Height : <span id="patientHeight"></span> cm </p>
                <p>Weight <span id="patientWeight"></span> kg </p>

            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Close</button>
                <!--<button type="button" class="btn btn-info btn-simple"><a href="DoctorConference.html" target="_blank">Call Patient</a></button>-->
            </div>
        </div>
    </div>
</div>
