<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="../assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Dashboard Doctor</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="../assetsPawandeep/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="../assetsPawandeep/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="../assetsPawandeep/css/light-bootstrap-dashboard.css" rel="stylesheet"/>

    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="../assetsPawandeep/css/pe-icon-7-stroke.css" rel="stylesheet" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

</head>
<body>

<script src="../assetsPawandeep/js/peer.min.js"></script>
<%--<script src="videoconference.js"></script>--%>




<script>

    // Compatibility shim
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

    var videostream;

    // PeerJS object
    var peer = new Peer('1',{ key: '3dlfqs1r2s79o1or', debug: 3});


    peer.on('open', function()
    {
        // display id to connect

//        alert(peer.id);

    });

    // Receiving a call
    peer.on('call', function(call)
    {
        // Answer the call automatically (instead of prompting user) for demo purposes
        call.answer(window.localStream);
        step3(call);
    });

    // Click handlers setup
    $(function()
    {
//        //button clicked
        $('#make-call').click(function()
        {
            // Initiate a call!
            //id of person you are calling
//            var call = peer.call($('#callto-id').val(), window.localStream);
            var call = peer.call("12", window.localStream);
        <%--<%=request.getAttribute("patientKey")%>--%>
            step3(call); // to set up call
        });

        //to end the call
        $('#end-call').click(function(){
            window.existingCall.close();




//                step2();
        });


//            // Retry if getUserMedia fails
//            $('#step1-retry').click(function(){
//                $('#step1-error').hide();
//                step1();
//            });

        // Get things started
        step1();



    });



    function step1 () {


        $('#videoCall').click(function()
        {
            if(navigator.getUserMedia)
            {
                navigator.getUserMedia({audio: true, video: true}, function(stream)
                {

                    // Set your video displays
                    //id to your videocam

                  $('#my-video').prop('src', URL.createObjectURL(stream));
                    window.localStream = stream;



//                step2();
                    //in case of error
                }, function(){ alert("Fail to Access Camera and mic , try again"); });
            }







        })



    }

    function step3 (call)
    {
        // Hang up on an existing call if present
        //if already got call , hang up
        if (window.existingCall) {
            window.existingCall.close();
        }

        // Wait for stream on the call, then set peer video display
        call.on('stream', function(stream)
        {
            //person videocam you are calling to
            $('#their-video').prop('src', URL.createObjectURL(stream));
        });

        // UI stuff
        window.existingCall = call;
        $('#their-id').text(call.peer);


        // to end call , when either party ends it
        call.on('close', function()
        {
            alert("call ended");
        });
    }
    //            $('#step1, #step2').hide();
    //            $('#step3').show();
</script>




<script>

    $(document).ready(function() {

        $('#ConsultationView').hide();
        $('#videoConference').hide();


        $('#Consultation').click(function (event) {



            $('#MainView').hide();
            $('#videoConference').hide();


            $('.content .container-fluid').append($('#ConsultationView'));
//
            $('#ConsultationView').show();



        });


        $('#videoCall').click(function(){


            $('#ConsultationView').hide();

            $('.content .container-fluid').append($('#videoConference'));


            $('#videoConference').show();
        })


        var count = 0;
        var start;
        $('#make-call').click(function()
        {
            start = setInterval(duration, 1000);

            function duration()
            {
                count++;
                console.log(count);
            }


        })

        $('#end-call').click(function()
        {
            clearInterval(start);
            console.log(count/60);
        })


    })


</script>

<div class="wrapper">
    <div class="sidebar" data-color="purple" data-image="assets/img/sidebar-5.jpg">

        <!--

            Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
            Tip 2: you can also add an image using data-image tag

        -->

        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="" class="simple-text">
                    Doctor
                </a>
            </div>

            <ul class="nav">
                <li class="active" id="Dashboard">
                    <a href="javascript:void(0)">
                        <i class="pe-7s-graph"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li class="active">
                    <a id="Consultation" href="javascript:void(0)">
                      <i class="pe-7s-note2"></i>
                      <p>Consultations</p>
                     </a>


                </li>

            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
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
                    <ul class="nav navbar-nav navbar-left">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-dashboard"></i>
                            </a>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#">
                                Account
                            </a>
                        </li>
                        <li>
                            <a href="html/login.jsp">
                               Logout <i class="pe-7s-power"></i>
                            </a>

                        </li>


                    </ul>
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">

                <div class="row" id="MainView">
                    Hello Doctor
                </div>
            </div>
        </div>







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
                <p class="copyright pull-right">
                    <%--&copy; 2016 <a href="http://www.creative-tim.com">Creative Tim</a>, made with love for a better web--%>
                </p>
            </div>
        </footer>

    </div>
</div>
</body>


<div class="row" id="ConsultationView">
    <div class="col-md-12">

        <div class="card">
            <div class="content table-responsive table-full-width">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Num</th>
                        <th>Patient Name</th>
                        <th>Consultation Type</th>
                        <th>Consultation Date and Time</th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>John Tan</td>
                        <td>Video</td>
                        <td>14 December 2016 04:30 pm</td>
                        <td><a  id="videoCall" href="javascript:void(0)">Start Video Call</a></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<link href="../assetsPawandeep/css/videoconferencestyle.css" rel="stylesheet" />
<div id="videoConference" class="row" >

    <div class="col-md-8">

        <button id="make-call"> click to make call</button>
        <%--<input type="text" id="callto-id" placeholder="id to call person">--%>
        <%--<span id="their-id"></span>--%>

            <div id="patient">
                <video id="their-video" autoplay></video>
            </div>



    </div>
    <div class="col-md-4">
        <div>
            <video id="my-video" muted="true" controls autoplay></video>
            <p>Notes for doctor to be able to store for consultation</p>
            <button class="button" id="end-call">End Conference</button>

        </div>
    </div>



</div>






<!--   Core JS Files   -->
<script src="../assetsPawandeep/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="../assetsPawandeep/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="../assetsPawandeep/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script src="../assetsPawandeep/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="../assetsPawandeep/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="../assetsPawandeep/js/light-bootstrap-dashboard.js"></script>

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script src="../assetsPawandeep/js/demo.js"></script>




</html>
