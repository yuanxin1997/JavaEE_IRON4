<%@ page import="Model.Patient" %><%--
  Created by IntelliJ IDEA.
  User: PawandeepSingh
  Date: 30/1/17
  Time: 2:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Patient Dashboard</title>

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
    Patient pt = (Patient) session.getAttribute("patient");
    String name = pt.getFirstName() +" "+pt.getLastName();

    String NRIC = pt.getNRIC();


    boolean conferenceEnd = false;
    if(!(request.getParameter("end") == null) && request.getParameter("end").equals("finished"))
    {
        conferenceEnd = true;
    }

%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.pubnub.com/pubnub.min.js"></script>
<script src="../../assetsPawandeep/teleConference/patientwebrtc.js"></script>

<script>

    var conferenceEnd = false;
    conferenceEnd = <%=conferenceEnd%>;

    var doctorOverseeingID;
    var consultID;


    setInterval(function()
    {
            getPatientUpcomingConsultation();
        console.log('interval');
    },5000)
    
    function getPatientUpcomingConsultation()
    {
        $('#upcomingConsultationTable tbody').empty();
        $.ajax(
                {
                    url : '/services/consultation/getpatientupcomingconsultation/'+ '<%=pt.getNRIC()%>',
                    type: 'GET',
                    datatype : 'json',
                    success : function (data)
                    {

                        for(i = 0 ; i<data.length;i++)
                        {
                            console.log(data.Did);
                            doctorOverseeingID = data[i].dID;

                            consultID = data[i].ID;
                            var consultdatetime = data[i].consultDateTime;
                            var consulttype = data[i].consultType;
                            var doctor = getDoctorOverseeing(doctorOverseeingID);
                            $('#upcomingConsultationTable tbody:last').append
                            (
                                    '<tr>' +
                                    '  <td>' + (i+1) + '</td>'
                                    + '<td>' + '<a id="viewPatient" data-toggle="modal" data-target="#modal1" href=#>'+ 'Dr ' + doctor.firstName + ' ' + doctor.lastName + '</a>' + '</td>'
                                    + '<td>' + consultdatetime + '</td>'
                                    + '<td>' + consulttype + '</td>' +
                                    '</tr>'
                            )
                        }







                    }
                })
    }

    function getDoctorOverseeing(doctorid)
    {
        var doctor;
        $.ajax(
                {
                    async : false,
                    url : '/services/doctor/getdoctor/'+doctorid,
                    type: 'GET',
                    datatype : 'json',
                    success : function (data)
                    {
                        doctor = data;

                    }
                })

        return doctor;
    }

    
    function BillReady()
    {
        var n =  noty({
            text        : 'Bill is ready.',
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
                    addClass: 'btn btn-primary', text: 'View Bill',
                    id : 'Okay',
                    onClick: function ($noty)
                    {
                        $noty.close();
                        //location.href = '/conference?nric=' + patientNRIC;

                    }
                },
                {
                    addClass: 'btn btn-danger', text: 'Dismiss',
                    onClick: function ($noty)
                    {
                    $noty.close();
                    // noty({dismissQueue: true, force: true, layout: layout, theme: 'defaultTheme', text: 'You clicked "Cancel" button', type: 'error'});
                    }
                }

            ]
        })

        return n ;
    }

    function AlertConference()
    {
        //TODO:UPDATE SO THAT IT CAN BE UPDATED CID CAN BE SENT TO CONFERENCE ALSO
        var n =  noty({
            text        : 'Doctor is ready for you. Are you ready ? ',
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
                        console.log('consultid is ' + consultID);
                        $noty.close();
                        location.href ='/telehtml/teleConference/patientConference.jsp?cid='+consultID;
                        //location.href = '/conference?nric=' + patientNRIC;

                    }
                }
            ]
        })

        return n ;
    }

    var phoneNum = '<%=NRIC%>';
    console.log(phoneNum);
    var phone = PHONE({
        number        :  phoneNum ,
        publish_key   : 'pub-c-8fa2fbc3-e887-4032-8cbc-eecde52d9b3a',
        subscribe_key : 'sub-c-f2bfc6c4-cd1b-11e6-8164-0619f8945a4f',
        ssl           : true
    });

    phone.connect(function(){    console.log('network LIVE.') })

    $(document).ready(function ()
    {

        getPatientUpcomingConsultation();

    })



</script>
<script src="../../assetsPawandeep/teleConference/PatientPhone.js"></script>

<div class="wrapper">


    <div class="sidebar" data-color="green" >

        <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->
        <!--SIDE BAR NAVIGATION-->
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="javascript:void(0)" class="simple-text">
                    Welcome <%=name%>
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
                    <a href="patientBillboard.jsp">
                        <i class="pe-7s-users"></i>
                        <p>Bills</p>
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

                <!--BAR NAVIGATION HEADER-->

                <div class="navbar-header">

                </div>

                <div class="collapse navbar-collapse">

                    <!--LEFT SIDE TOP BAR NAVIGATION-->

                    <ul class="nav navbar-nav navbar-left">
                        <%--<li>--%>
                        <%--</li>--%>
                    </ul>

                    <!--RIGHT SIDE TOP BAR NAVIGATION-->
                    <%--TODO UPDATE LIKE YUAN XIN's --%>
                    <ul class="nav navbar-nav navbar-right">

                        <li class="dropdown">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                <%=name%>
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
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                    <h3 class="title">
                                        My upcoming consultation
                                    </h3>
                            </div>

                            <div class="content">

                                <table class="table" id="upcomingConsultationTable">

                                    <thead>

                                    <tr>
                                        <th>No.</th>
                                        <th>Doctor Overseeing</th>
                                        <th>DateTime</th>
                                        <th>Type</th>
                                    </tr>

                                    </thead>

                                    <tbody>


                                    </tbody>
                                </table>

                            </div>

                        </div>

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


<%--&lt;%&ndash;!--Modal for Doctor pop up-->&ndash;%&gt;--%>
<%--<!-- Modal Core -->--%>
<%--<div class="modal fade" id="modal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--%>
    <%--<div class="modal-dialog">--%>
        <%--<div class="modal-content">--%>
            <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
                <%--<h4 class="modal-title" id="myModalLabel"><span id="drName"></span></h4>--%>
            <%--</div>--%>

            <%--<div class="modal-body">--%>
                <%--<input type="hidden" name="drName" value="" id="patientNamefield" >--%>
                <%--<p>NRIC:   <span id="patientNRIC"></span>      <input type="hidden" name="patientNRIC" id="patientNRICfield" >    </p>--%>
                <%--<p>Date of Birth: <span id="patientDOB"></span> <input type="hidden" name="patientDOB" id="patientDOBfield" > </p>--%>
                <%--<p>Height : <span id="patientHeight"></span> cm <input type="hidden" name="patientHeight"  id="patientHeightfield" ></p>--%>
                <%--<p>Weight <span id="patientWeight"></span> kg  <input type="hidden" name="patientWeight"  id="patientWeightfield" ></p>--%>

            <%--</div>--%>


            <%--<div class="modal-footer">--%>
                <%--<button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Close</button>--%>
                <%--<!--<button type="button" class="btn btn-info btn-simple"><a href="DoctorConference.html" target="_blank">Call Patient</a></button>-->--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>