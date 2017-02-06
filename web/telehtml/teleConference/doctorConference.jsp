<%@ page import="Model.User" %>
<%@ page import="Model.Doctor" %><%--
  Created by IntelliJ IDEA.
  User: PawandeepSingh
  Date: 26/1/17
  Time: 5:09 PM
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Consultation On-Going</title>

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





    <!--jquery ui-->

    <link href="../../assetsPawandeep/Dashboard/jquery-ui/jquery-ui.css" rel="stylesheet">
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery-ui.js"></script>
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery.ui.autocomplete.scroll.js"></script>
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery.ui.autocomplete.scroll.min.js"></script>


    <!--&lt;!&ndash;Bootstrap select&ndash;&gt;-->

    <!--&lt;!&ndash; Latest compiled and minified CSS &ndash;&gt;-->
    <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/css/bootstrap-select.min.css">-->

    <!--&lt;!&ndash; Latest compiled and minified JavaScript &ndash;&gt;-->
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/js/bootstrap-select.min.js"></script>-->

    <!--&lt;!&ndash; (Optional) Latest compiled and minified JavaScript translation files &ndash;&gt;-->
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/js/i18n/defaults-*.min.js"></script>-->

<%
    String pId = request.getParameter("nric");
    System.out.println("patient id is " + pId );

    //User u = (User) session.getAttribute("user");
    Doctor dr = (Doctor) session.getAttribute("doctor");
    System.out.println("doctor id is " + dr.getDoctorID());

    String consulttype = (String) request.getParameter("consulttype");

    System.out.println(consulttype);


%>



    <style>

        /*#videoContainer*/
        /*{*/

        /*!*width: 480px;*!*/
        /*!*height: 250px;*!*/
        /*!*max-width: 360px;*!*/
        /*!*max-height: 250px;*!*/


        /*!*width: auto;*!*/
        /*!*height:auto;*!*/
        /*!*position: relative;*!*/
        /*!*float: right;*!*/
        /*!*border: 2px black dotted;*!*/
        /*}*/

        #local
        {
            /*position: absolute;   for the video so stay still*/

            /*for video to follow along*/
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

        #fixedPos
        {
            /*position: fixed;*/
            /*z-index: 99!important;*/
        }

        /*#MedicationTakingCard*/
        /*{*/
        /*overflow: auto;*/
        /*}*/





    </style>




    <script type="text/javascript" >



        var second = 0;
        var minute = 0;
        var durationtimerID;

        function duration()
        {
            //console.log(second);
            second++;
            durationTimer();
        }
        function durationTimer()
        {
            durationtimerID = setTimeout(duration,1000);
        }

        function stopDuration()
        {
            clearTimeout(durationtimerID);
        }

        //Validate Fields
        function ValidateInput()
        {
            var isValid = true;
            if($('#finalReport').val() == "")
            {
                alert('missing fields')
                return false;
            }

            $('#finalPrescription input').each(function ()
            {
                var element = $(this);
                if(element.val() == "")
                {
                    alert('missing fields')
                    isValid = false;
                }
            })
            return isValid;
        }


        var myPhone = PHONE({
            number : '<%=dr.getDoctorID()%>', // my phone number
            // keys from https://www.pubnub.com/
            publish_key   : 'pub-c-8fa2fbc3-e887-4032-8cbc-eecde52d9b3a',
            subscribe_key : 'sub-c-f2bfc6c4-cd1b-11e6-8164-0619f8945a4f',
            ssl           : true // for security encryption

        })
        var consulttype = '<%=consulttype%>';
        myPhone.consultType = consulttype;

        //dial the number to call patient
        function dialnumber()
        {
            var session = myPhone.dial('<%=pId%>');// start to call patient
            console.log("Calling patient now");
        }


        $(document).ready(function ()
        {
            $('#modal1').modal({backdrop: 'static', keyboard: false})
            $('#modal1').modal('hide');


            durationTimer();
            consulttype = '<%=consulttype%>';

            if(consulttype == 'WALKIN')
            {
                $('#side').attr('class','col-md-12');
                $('#local').remove();
                $('#remote').remove();
                $('#myModal').remove();
                $('#videosCol').remove();

            }
            //TODO UNCOMMENT THIS
            $('#myModal').modal({backdrop: 'static', keyboard: false})
            $('#myModal').modal('show');


            myPhone.ready(function ()
            {
                 dialnumber();

            });

            var patientRecords =  getPatientPastRecords();
            function getPatientPastRecords()
            {
                var pastrecords = [];
                $.ajax(
                        {
                            async: false,
                            url : '/services/consultation/getpatientpastrecords/'+ '<%=pId%>',
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


            //TODO : IF POSSIBLE , WHEN ONE MEDICINE SELECTED REMOVE THAT FROM THE MEDICINE
           var medName =  getMedicineNames();
            function getMedicineNames()
            {
                var medicineName = [];
                    $.ajax(
                            {
                                async : false,
                                url : '/services/medicine',
                                type: 'GET',
                                datatype : 'json',
                                success : function (data)
                                {
                                    //console.log(data);
                                    medicineName = data;
                                }
                            })
                return medicineName;
            }




            //TODO: DATA TO DISPLAY FOR MEDICINE NAME - DONE

            //when add button is clicked add rows
            $("#add").click(function ()
            {
                addTableRow('#medicineTable >tbody:last');
            });

            $('.add').click(function ()
            {
                addTableRow('#finalPrescription > tbody:last')
            })


            function addTableRow(selector)
            {
                $(selector).append('<tr><td>' + '<input type="text" placeholder="medicineName" name="medicineName" class="medicineName">' +'</td>'
                        +
                        '<td>'+
                        '<input type="number" name="dosesNum" class="medicineFields"style="width: 50px"> &nbsp;'+
                        '<select name="doseUnit" class="medicineFields"style="width: 100px">'+
                        '<option>Ml</option>' +
                        '<option>Capsules</option>' +
                        '<option>Shots</option>'+
                        '<option>Tablets</option>'+
                        '</select>'+
                        '</td>'

                        +       '<td>'+
                        '<input type="number" name="frequencyNum" class="medicineFields" style="width: 50px"> &nbsp;  times &nbsp;'+
                        '<select name="frequencyUnit"  class="medicineFields"  style="width: 100px">'+
                        '<option>daily</option>'+
                         '<option>every night</option>'   +
                        '</select>'
                        + '</td>'
                        + '<td><button id="remove" class="btn-round" style="color: red; background: white"><i class="pe-7s-less"></i></button>' + '  ' +
//                        '<button id="alter">Edit Row</button>' +
                        '</td>'
                )

                DisplayMedicineNamesinField();

            }

            //when remove button is clicked,respective row is removed
            $('.table').on('click','#remove',function () {
                var rowIndex = $(this).closest('td').parent()[0].sectionRowIndex;
                $(this).closest('tr').remove();

            })


            //the respectives table row on the medicine name field
            $('.table').on('focus','.medicineName',function ()
            {
//               getRemainingMed();

                DisplayMedicineNamesinField();

            })


            //displays the medicine name when field is focused on
            function DisplayMedicineNamesinField()
            {
                //availableTags
                $( '.medicineName' ).autocomplete({
                    source: medName ,
                    maxShowItems: 5,
                    minLength: 0
                }) .focus(function () {
                    $(this).autocomplete('search', $(this).val())
                });

            }

//            function getRemainingMed()
//            {
//                //GET FOCUSED INPUT NOT EACH INPUT
//                var medicineNames = $('.medicineName ');
//
//                if(medicineNames.length > 0)
//                {
//                    medicineNames.each(function ()
//                    {
//                        var element = $(this);
//                        for(var i = 0 ; i<medName.length;i++)
//                        {
//                            if(!(element.activeElement))
//                            {
//                                if(medName[i] == element.val())
//                                {
//                                    medName.splice(i,1);
//                                }
//                            }
//                        }
//                    })
//                }
//                else if(medicineNames.length <= 0)
//                    {
//                        medName = getMedicineNames();
//                    }
//
//            }

            //when end call copy report into modal
            // and table onto modal
            $('#endCall').click(function ()
            {
                $('#modal1').modal('show');

                $('#finalReport').text($('#doctorReport').val());

                minute = second/60;
                $('#consultationDuration').val(minute);
                CopyTableData();

            })

            //copy table from the page onto the modal
            function CopyTableData()
            {
                $('#finalPrescription > tbody').empty();

                var medicinetable = $('#medicineTable > tbody tr');
                var clone  =  medicinetable.clone();

                var originalselects = medicinetable.find('select');

                clone.find('select').each(function (index,item)
                {
                    $(item).val(originalselects.eq(index).val());
                })

                clone.appendTo($('#finalPrescription > tbody'));
                DisplayMedicineNamesinField();
            }


            
        })

    </script>
    <!--Setting up of phone call and recieve calls-->
    <script src="../../assetsPawandeep/teleConference/DoctorPhone.js"></script>


</head>
<body>

<div class="wrapper">

    <div class="sidebar" data-color="purple" data-image="assets/img/sidebar-5.jpg">

        <!--

            Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
            Tip 2: you can also add an image using data-image tag

        -->

        <!--SIDE BAR NAVIGATION-->
        <div class="sidebar-wrapper">
            <div class="logo">
                Patient Past Records
            </div>

            <ul class="nav" id="pastRecordsNav">



            </ul>
        </div>
    </div>

    <!--TOP BAR NAVIGATION-->
    <div class="main-panel">
        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">

                <!--BAR NAVIGATION HEADER-->

                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Dashboard</a>
                </div>

                <div class="collapse navbar-collapse">

                    <!--LEFT SIDE TOP BAR NAVIGATION-->

                    <ul class="nav navbar-nav navbar-left">
                    </ul>

                    <!--RIGHT SIDE TOP BAR NAVIGATION-->

                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <button id="endCall" class="btn btn-warning btn-round">End Call</button>
                        </li>


                    </ul>
                </div>
            </div>
        </nav>




        <!--MAIN BODY-->
        <div class="content">
            <div class="container-fluid">


                <div class="row">

                    <div class="col-md-8" id="side">
                        <div class="card">
                            <div class="header">Selected Record</div>
                            <hr>
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


                    <div class="col-md-8 pull-right" id="videosCol">

                        <div class="card-plain" id="videoContainer">

                            <div class="content">
                                <video id="remote" autoplay="true"  height="250px" style="position: fixed"></video>
                                <!--style="position: fixed"-->


                                <div id="local-container">
                                    <video id="local" autoplay="true"></video>
                                </div>
                            </div>

                        </div>



                    </div>


                </div>

                <div class="row">
                    <div class="col-md-12">

                        <div class="card" id="MedicationTakingCard">

                            <div class="header">
                                <p>Medication Taking</p>
                            </div>

                            <hr>

                            <div class="content">
                                <p>Report/Diagnostics: </p>
                                <textarea cols="100" rows="5" id="doctorReport"></textarea>

                            </div>
                        </div>




                    </div>
                </div>

                <div class="row">

                    <div class="col-md-12">

                        <div class="card">
                            <div class="header">
                                <h4>Prescribe Medicine</h4>
                                <button id="add" class="btn-lg btn-round pull-left" style="color: green;background: white"><i class="btn-icon pe-7s-plus"></i></button>
                            </div>

                            <div class="content">

                                <table class="table" id="medicineTable">
                                    <!--<button data-toggle="modal" data-target="#modal1"> Edit medicine</button>-->
                                    <thead>
                                    <td>Medicine</td>
                                    <td>Doses</td>
                                    <td>Frequency</td>
                                    <td>Action</td>
                                    </thead>

                                    <tbody>

                                    <%--<tr>--%>
                                        <%--<td><input type="text" name="medicineName" placeholder="medicineName" class="medicineName medicineFields"></td>--%>

                                        <%--<td>--%>

                                            <%--<input type="number" name="dosesNum" class="medicineFields"style="width: 50px"> &nbsp;--%>
                                            <%--<select name="doseUnit" class="medicineFields"style="width: 100px">--%>
                                                <%--<option>ml</option>--%>
                                                <%--<option>capsules</option>--%>
                                                <%--<option>shots</option>--%>
                                            <%--</select>--%>

                                        <%--</td>--%>

                                        <%--<td>--%>
                                            <%--<input type="number" name="frequencyNum" class="medicineFields" style="width: 50px"> &nbsp;  times &nbsp;--%>

                                            <%--<select name="frequencyUnit"  class="medicineFields"  style="width: 100px">--%>
                                                <%--<option>daily</option>--%>
                                                <%--<option>3 times a day</option>--%>
                                                <%--<option>every night</option>--%>
                                            <%--</select>--%>

                                        <%--</td>--%>



                                        <%--<td><button id="remove">Remove Row</button>--%>
                                            <%--<!--<button id="alter">Edit Row</button>-->--%>
                                        <%--</td>--%>

                                    <%--</tr>--%>

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

                <div class="pull-right">
                    <%--<button id="startCall" class="btn btn-warning" >Call Patient </button>--%>
                </div>

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

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>





</html>


<!--&lt;!&ndash;Modal for patient pop up&ndash;&gt;-->
<!--&lt;!&ndash; Modal Core &ndash;&gt;-->
<div class="modal fade" id="modal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
                <h4 class="modal-title" id="myModalLabel">Consultation Summary</h4>

            </div>
            <div class="modal-body">



                <form action="/conference" method="post" onsubmit="return ValidateInput();">

                    <input hidden name="nric" value="<%=pId%>">

                    <input hidden name="duration" value="" id="consultationDuration">

                <h6>Report/Diagnostic</h6>
                <textarea id="finalReport" cols="100" rows="10" name="finalReport"></textarea>

                 <hr>

                <h6>Prescribe Medicine</h6><button type="button" class="add btn btn-round pull-left" style="color: green;background: white"><i class="btn-icon pe-7s-plus"></i></button>
                <table class="table" id="finalPrescription" >
                    <thead>
                    <td>Medicine Name</td>
                    <td>Doses</td>
                    <td>Frequency</td>
                    <td>Action</td>
                    </thead>



                    <tbody>




                    </tbody>


                </table>
                    <button  id="confirmConsultationDetails">Confirm Consultation</button>
                </form>
            </div>
            <div class="modal-footer">
                <%--<a  id="confirmConsultationDetails" href="/html/Dashboard/doctorDashboard.jsp">Confirm Consultation</a>--%>
                <!--<button type="button" class="btn btn-info btn-simple"><a href="DoctorConference.html" target="_blank">Call Patient</a></button>-->
            </div>
        </div>
    </div>
</div>



<!-- Modal Core -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeLoadModal">&times;</button>--%>
                <h4 class="modal-title" id="myModalLabel1">Tele-Conference Beginning momentarily</h4>
            </div>
            <div class="modal-body">
               Loading
            </div>
            <div class="modal-footer">
                <%--<button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Close</button>--%>
                <%--<button type="button" class="btn btn-info btn-simple">Save</button>--%>
            </div>
        </div>
    </div>
</div>


