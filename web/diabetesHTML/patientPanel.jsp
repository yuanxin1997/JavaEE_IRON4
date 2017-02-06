<%@ page import="Model.Patient" %>
<!DOCTYPE html>
<%

        Patient pt = (Patient) session.getAttribute("patient");
    String patientid = pt.getPatientID();

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html ng-app="patientApp" ng-init="patientUser='<%=patientid%>'">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>h@h</title>
    <base href="/">
    <link rel="shortcut icon" href="">
    <link rel="stylesheet" href="../diabetesAssets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../diabetesAssets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/additional.css">
    <link rel="stylesheet" href="../diabetesAssets/css/Box-panels.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ebs-contact-form.css">
    <link rel="stylesheet" href="../diabetesAssets/css/JLX-Fixed-Nav-on-Scroll.css">
    <link rel="stylesheet" href="../diabetesAssets/css/Material-Card.css">
    <link rel="stylesheet" href="../diabetesAssets/css/Sidebar-Menu1.css">
    <link rel="stylesheet" href="../diabetesAssets/css/angular-toastr.css">
    <link rel="stylesheet" href="../diabetesAssets/css/nv.d3.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ngDialog.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ngDialog-theme-default.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ngDialog-theme-plain.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/animate.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ScheduleStyle.css">
    <link rel="stylesheet" href="../diabetesAssets/css/timedropper.css">
    <link rel="stylesheet" href="diabetesAssets/css/datepicker.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600" rel="stylesheet">

    <script src="../diabetesAssets/js/modernizr.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
    <script>
        if( !window.jQuery ) document.write('<script src="../diabetesAssets/js/jquery-3.0.0.min.js"><\/script>');
    </script>
    <!--<script src="diabetesAssets/js/jquery.min.js"></script>-->
    <script src="../diabetesAssets/js/angular.min.js"></script>
    <script src="../diabetesAssets/js/d3.js"></script>
    <script src="../diabetesAssets/js/nv.d3.js"></script>
    <script src="../diabetesAssets/js/angular-nvd3.js"></script>
    <script src="diabetesAssets/js/datepicker.min.js"></script>
    <script src="diabetesAssets/js/datepicker.en.js"></script>


    <style>
        [ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
            display: none !important;
        }
        a:hover {
            cursor:pointer;
        }
        .noDot{
            list-style-type: none;
        }
    </style>

    <script type="text/ng-template" id="profileTemplate">
        <div class="ngdialog-message">
            <div class="row">
                <div class="col-md-12">
                    <b><cite>Your Profile</cite></b>
                    <hr class="line">
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 text-center">
                    <img class="img-circle" width="170px" height="170"  my-src="data:image/jpeg;base64,{{arrayBufferToBase64Modal(patientDetailsCopy.profilePic)}}"  style="-webkit-user-select:none;
                                            display:block; margin:auto; border: 1px solid lightgrey;">
                </div>
                <div class="col-md-8">

                    <h1 style="margin-top: 0px;">{{ patientDetailsCopy.lastName + " " +patientDetailsCopy.firstName }}</h1>
                    <span style="color: grey;">Doctor ID   </span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetailsCopy.patientId}}<br>
                    <span style="color: grey;">Gender      </span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetailsCopy.gender}}<br>
                    <span style="color: grey;">Date Of Admission </span>&nbsp&nbsp&nbsp&nbsp{{patientDetailsCopy.dateOfAdmission}}<br>
                    <span style="color: grey;">Email       </span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetailsCopy.email}}<br>
                    <span style="color: grey;">Contact No  </span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetailsCopy.contactNo}}


                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <hr class="line" style="margin-bottom: 0px;">
                </div>
            </div>
        </div>
        <div class="ngdialog-buttons">
            <button type="button" class="ngdialog-button ngdialog-button-primary" ng-click="closeThisDialog()">Close</button>
        </div>
    </script>

</head>

<body ng-cloak ng-controller="myPatientController">

<nav class="navbar navbar-default" >
    <div class="container-fluid">
        <div class="navbar-header"><a href="" class="navbar-brand navbar-link">Diabetes Monitoring</a>
        </div>
        <div class="collapse navbar-collapse" id="navcol-2">
            <ul class="nav navbar-nav hidden-xs hidden-sm navbar-right" id="desktop-toolbar">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#"><img
                            class="img-circle" my-src="data:image/jpeg;base64,{{arrayBufferToBase64(patientDetails.profilePic)}}" width="25px" height="25px"> {{ patientDetails.lastName + " " +patientDetails.firstName }}
                        <i class="fa fa-chevron-down fa-fw"></i></a>
                    <ul class="dropdown-menu" role="menu">
                        <li role="presentation"><a href="" ng-click="openProfile()"><i class="fa fa-user fa-fw"></i> Profile </a></li>
                        <li role="presentation"><a href="/telehtml/H@Hboard/H@HBoard.jsp"><i class="fa fa-power-off fa-fw"></i>Logout </a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!--- Modal for profile --->
    <div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2"><img class="img-circle" my-src="data:image/jpeg;base64,{{arrayBufferToBase64(patientDetails.profilePic)}}"  width="50px" height="50px"><span> &nbsp{{ patientDetails.lastName + " " +patientDetails.firstName }}</span> </h4>
                </div>
                <div class="modal-body">
                    <br>
                    <ul>
                        <h6>Patient ID.</h6>
                        <li class="noDot">
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetails.patientId}}
                        </li>
                    </ul>
                    <br>
                    <ul>
                        <h6>Gender.</h6>
                        <li class="noDot">
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetails.gender}}
                        </li>
                    </ul>
                    <br>
                    <ul>
                        <h6>Date Of Admission.</h6>
                        <li class="noDot">
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetails.dateOfAdmission}}

                        </li>
                    </ul>
                    <br>
                    <ul>
                        <h6>Email.</h6>
                        <li class="noDot">
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetails.email}}
                        </li>
                    </ul>
                    <br>
                    <ul>
                        <h6>Contact No.</h6>
                        <li class="noDot">
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{patientDetails.contactNo}}
                        </li>
                    </ul>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                </div>
            </div>
        </div>
    </div>
    <!--- Modal for profile-->
</nav>

<div id="nowrapper" class="nowrapperclass">

<div class="container-fluid">
    <div class="top">
        <nav class="navbar navbar-default" id="navbar-main">
            <div class="container-fluid">
                <div class="navbar-header"><a class="navbar-brand navbar-link" >H@H ID: {{ patientDetails.patientId }}</a>
                    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcol-1"><span
                            class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span
                            class="icon-bar"></span><span class="icon-bar"></span></button>
                </div>
                <div class="collapse navbar-collapse" id="navcol-1">
                    <ul class="nav navbar-nav">
                        <li ui-sref-active="active" role="presentation"><a ui-sref="dailyTrack" >Daily Tracking</a></li>
                        <li ui-sref-active="active" role="presentation"><a ui-sref="memoSchedule" >Memo/Schedule </a></li>
                        <li ui-sref-active="active" role="presentation"><a ui-sref="statistic" >Statistic </a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</div>

<div class="container-fluid">
    <div class="mainContent">
        <ui-view></ui-view>
    </div>

</div>
</div>


<script src="../diabetesAssets/js/angular-ui-router.js"></script>
<script src="../diabetesAssets/js/angular-toastr.tpls.js"></script>
<script src="../diabetesAssets/js/angular-animate.min.js"></script>
<script src="../diabetesAssets/js/ngDialog.min.js"></script>
<script src="../diabetesAssets/js/moment.min.js"></script>
<script src="../diabetesAssets/js/angular-moment.js"></script>
<script src="../diabetesAssets/js/ui-bootstrap-2.3.1.js"></script>
<script src="../diabetesAssets/js/patientScript.js"></script>
<script src="../diabetesAssets/js/customService.js"></script>
<script src="../diabetesAssets/bootstrap/js/bootstrap.min.js"></script>
<script src="../diabetesAssets/js/JLX-Fixed-Nav-on-Scroll.js"></script>
<script src="../diabetesAssets/js/Sidebar-Menu.js"></script>
<script src="../diabetesAssets/js/timedropper.js"></script>


</body>

</html>