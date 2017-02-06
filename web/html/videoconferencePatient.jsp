<html><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <link href="../assetsPawandeep/css/videoconferencestyle.css" rel="stylesheet" type="text/css">






    <script src="../assetsPawandeep/js/peer.min.js"></script>
    <script>

        // Compatibility shim
        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;


        // PeerJS object
        var peer = new Peer('12',{ key: '3dlfqs1r2s79o1or', debug: 3});


        peer.on('open', function()
        {
            // display id to connect
//            step1();
//            alert(peer.id);
            console.log(peer.id);

        });

        // Receiving a call
        peer.on('call', function(call)
        {
            // Answer the call automatically (instead of prompting user) for demo purposes
            call.answer(window.localStream);
            step3(call);
        });

//        // Click handlers setup
//        $(function()
//        {
//               //button clicked
//            $('#make-call').click(function(){
//                // Initiate a call!
//                //id of person you are calling
//                var call = peer.call($(null, window.localStream));
////                var call = peer.call($('#callto-id').val(), window.localStream);
//
//                step3(call); // to set up call
//            });
//
//            //to end the call
//            $('#end-call').click(function(){
//                window.existingCall.close();
////                step2();
//            });
//
//
////            // Retry if getUserMedia fails
////            $('#step1-retry').click(function(){
////                $('#step1-error').hide();
////                step1();
////            });
//
//            // Get things started
//            step1();
            step1();
//        });


        function step1 () {
            // Get audio/video stream
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
//            $('#step1, #step2').hide();
//            $('#step3').show();
        }


    </script>




</head>
<body>



<div class="container-fluid" col-md-12>

    <div class="row">

        <div class="col-md-6" id="col">

            <div>
                <!--     <h3>Thumbnail label</h3>
                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id
                      elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies
                      vehicula ut id elit.vehicula ut id elit.vehicula ut id elit.</p> -->

                <video id="their-video" autoplay=""></video>

            </div>


        </div>


        <div class="col-md-6" id="col">

            <div class="col-md-12" id="div1">
                <video id="my-video" muted="true" autoplay=""></video>
            </div>
            <div class="col-md-12" id="div2">


                    <%--<button type="text" id="end-call">END CALL</button>--%>

                    <span id="their-id"></span>
            </div>
        </div>

    </div>

</div>



</body></html>