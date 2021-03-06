<%@ page import="Model.Doctor" %>

<!DOCTYPE html>


<%
    Doctor dr = (Doctor) session.getAttribute("doctor");
    String did = dr.getDoctorID();
    System.out.println(did);
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html ng-app="doctorApp" ng-init="doctorUser='D01' ">
<head>
    <meta charset="utf-8">
    <title>h@h</title>
    <base href="/">
    <link rel="shortcut icon" href="">
    <link rel="stylesheet" href="../diabetesAssets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../diabetesAssets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/additional.css">
    <link rel="stylesheet" href="../diabetesAssets/css/Box-panels.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ebs-contact-form.css">
    <link rel="stylesheet" href="../diabetesAssets/css/JLX-Fixed-Nav-on-Scroll.css">
    <link rel="stylesheet" href="../diabetesAssets/css/editSchedule.css">
    <link rel="stylesheet" href="../diabetesAssets/css/Material-Card.css">
    <link rel="stylesheet" href="../diabetesAssets/css/Sidebar-Menu1.css">
    <link rel="stylesheet" href="../diabetesAssets/css/angular-toastr.css">
    <link rel="stylesheet" href="../diabetesAssets/css/nv.d3.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ngDialog.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ngDialog-theme-default.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ngDialog-theme-plain.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/animate.min.css">
    <link rel="stylesheet" href="../diabetesAssets/css/ScheduleStyle.css">
    <link rel="stylesheet" href="diabetesAssets/css/datepicker.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600" rel="stylesheet">

    <script src="../diabetesAssets/js/modernizr.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
    <script>
        if( !window.jQuery ) document.write('<script src="../diabetesAssets/js/jquery-3.0.0.min.js"><\/script>');
    </script>

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

    <script type="text/ng-template" id="projectTemplate">
        <div class="ngdialog-message">
            <div>
                <div>
                    <div>
                        <h2 class="text-center text-info">New Project</h2></div>
                    <div>
                        <form id="editEventForm">
                            <form id="my-form">
                                <div class="form-group has-feedback">
                                    <input type="tel" name="project" ng-model="cp.patientId" ng-change="cp.projectId=cp.patientId" placeholder="Enter patient&#39;s ID..." class="form-control"  /><i aria-hidden="true" class="form-control-feedback fa fa-pencil"></i></div>
                            </form>
                        </form>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="ngdialog-buttons">
            <button type="button" class="ngdialog-button ngdialog-button-primary" ng-click="checkInput() && confirm(temp)">Create</button>
            <button type="button" class="ngdialog-button ngdialog-button-secondary" ng-click="closeThisDialog()">Cancel</button>
        </div>
    </script>

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
                                        <img class="img-circle" width="170px" height="170"  my-src="data:image/jpeg;base64,{{arrayBufferToBase64Modal(docDetailsCopy.profilePic)}}"  style="-webkit-user-select:none;
                                            display:block; margin:auto; border: 1px solid lightgrey;">
                                    </div>
                                    <div class="col-md-8">

                                                <h1 style="margin-top: 0px;">{{ docDetailsCopy.lastName + " " +docDetailsCopy.firstName }}</h1>
                                                <span style="color: grey;">Doctor ID   </span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{docDetailsCopy.doctorId}}<br>
                                                <span style="color: grey;">Gender      </span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{docDetailsCopy.gender}}<br>
                                                <span style="color: grey;">Date Joined </span>&nbsp&nbsp&nbsp{{docDetailsCopy.dateJoined}}<br>
                                                <span style="color: grey;">Email       </span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{docDetailsCopy.email}}<br>
                                                <span style="color: grey;">Contact No  </span>&nbsp&nbsp&nbsp&nbsp{{docDetailsCopy.contactNo}}


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

<body ng-cloak ng-controller="myDoctorController">

<!--- Nav bar --->
<nav class="navbar navbar-default" >
    <div class="container-fluid">
        <div class="navbar-header"><a class="navbar-brand navbar-link">Diabetes Monitoring</a>
            <a class="btn btn-link navbar-btn" role="button" href="#menu-toggle" id="menu-toggle"><i class="fa fa-bars"></i></a>
        </div>
        <div class="collapse navbar-collapse" id="navcol-2">
            <ul class="nav navbar-nav hidden-xs hidden-sm navbar-right" id="desktop-toolbar">
                <li id="searchProjectField" ng-show="checkState()"><input type="text"  class="form-control" ng-model="searchText" placeholder="Search for a project..."></li>
                <li role="presentation" ng-show="checkState()"><a href="" class="aClick" ng-click="openCreateProject()" ><i class="fa fa-plus"></i></a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#"><img class="img-circle" width="25px" height="25px"  my-src="data:image/jpeg;base64,{{arrayBufferToBase64(doctorDetails.profilePic)}}" > <span>{{ doctorDetails.lastName + " " +doctorDetails.firstName }}</span> <i class="fa fa-chevron-down fa-fw"></i></a>
                    <ul class="dropdown-menu" role="menu">
                        <li role="presentation"><a href="" ng-click="openProfile()"><i class="fa fa-user fa-fw"></i> Profile </a></li>
                        <li role="presentation"><a href="/telehtml/H@Hboard/H@HBoard.jsp"><i class="fa fa-power-off fa-fw"></i>Logout </a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!--- Nav bar --->

<!-- Modal for profile -->
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2"><img class="img-circle" my-src="data:image/jpeg;base64,{{arrayBufferToBase64(doctorDetails.profilePic)}}"  width="50px" height="50px"><span> &nbsp{{ doctorDetails.lastName + " " +doctorDetails.firstName }}</span> </h4>
            </div>
            <div class="modal-body">
                <br>
                <ul>
                    <h6>DoctorID.</h6>
                    <li class="noDot">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{doctorDetails.doctorId}}
                    </li>
                </ul>
                <br>
                <ul>
                    <h6>Gender.</h6>
                    <li class="noDot">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{doctorDetails.gender}}
                    </li>
                </ul>
                <br>
                <ul>
                    <h6>Date Joined.</h6>
                    <li class="noDot">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{doctorDetails.dateJoined}}
                    </li>
                </ul>
                <br>
                <ul>
                    <h6>Email.</h6>
                    <li class="noDot">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{doctorDetails.email}}
                    </li>
                </ul>
                <br>
                <ul>
                    <h6>Contact No.</h6>
                    <li class="noDot">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{doctorDetails.contactNo}}
                    </li>
                </ul>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>
<!-- Modal for profile -->





<!--- Body --->
<div id="wrapper">


    <!--- side bar --->
    <div id="sidebar-wrapper" >
        <ul class="sidebar-nav" style="margin-bottom: 100pt">
            <li class="sidebar-brand">

                <a ui-sref-active="sideActive" ui-sref="docHome" ><i class="glyphicon glyphicon-home"></i>&nbsp&nbsp&nbsp Home </a>
            </li>

            <li ng-repeat="project in projects">
                <a ui-sref-active="sideActive" ui-sref="docNav.scheduleEdit({id:project.projectId})"><i class="glyphicon glyphicon-folder-open"></i>&nbsp&nbsp&nbsp {{ project.projectId }} </a>
            </li>
        </ul>
    </div>
    <!--- side bar --->



    <!--- main view --->
    <div class="page-content-wrapper" >
        <ui-view></ui-view>
    </div>
    <!--- main view --->


</div>
<!--- Body --->

<!--<script src="diabetesAssets/js/jquery.min.js"></script>-->
<script src="../diabetesAssets/js/angular-ui-router.js"></script>
<script src="../diabetesAssets/js/angular-toastr.tpls.js"></script>
<script src="../diabetesAssets/js/angular-animate.min.js"></script>
<script src="../diabetesAssets/js/ngDialog.min.js"></script>
<script src="../diabetesAssets/js/moment.min.js"></script>
<script src="../diabetesAssets/js/angular-moment.js"></script>
<script src="../diabetesAssets/js/ui-bootstrap-2.3.1.js"></script>
<script src="../diabetesAssets/js/doctorScript.js"></script>
<script src="../diabetesAssets/js/customService.js"></script>
<script src="../diabetesAssets/bootstrap/js/bootstrap.min.js"></script>
<script src="../diabetesAssets/js/JLX-Fixed-Nav-on-Scroll.js"></script>
<script src="../diabetesAssets/js/Sidebar-Menu.js"></script>


</body>

</html>

