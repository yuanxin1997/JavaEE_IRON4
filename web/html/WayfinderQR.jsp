<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>HTML5 Demo: getUserMedia (Treehouse Blog)</title>
    <link rel="stylesheet" href="style.css">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="..\css\qq.css" rel="stylesheet" type="text/css">
    <link href="..\css\style.css" rel="stylesheet" type="text/css">
    <style>
        body {
            /*background: #F7F7F7;*/
            /*margin: 0;*/
            /*padding: 0;*/
        }

        #video-container {
            margin: auto;
            width: 450px;
            height:350px;
            padding: 2em;
            background: white;
            box-shadow: 0 1px 10px #D9D9D9;
        }

        #qr-canvas{
            visibility: hidden;
        }

        #camera-stream{
            margin: 0;
        }

    </style>

    <script src="../js/qrVideo.js"></script>
    <script type="text/javascript" src="../js/QRReader/grid.js"></script>
    <script type="text/javascript" src="../js/QRReader/version.js"></script>
    <script type="text/javascript" src="../js/QRReader/detector.js"></script>
    <script type="text/javascript" src="../js/QRReader/formatinf.js"></script>
    <script type="text/javascript" src="../js/QRReader/errorlevel.js"></script>
    <script type="text/javascript" src="../js/QRReader/bitmat.js"></script>
    <script type="text/javascript" src="../js/QRReader/datablock.js"></script>
    <script type="text/javascript" src="../js/QRReader/bmparser.js"></script>
    <script type="text/javascript" src="../js/QRReader/datamask.js"></script>
    <script type="text/javascript" src="../js/QRReader/rsdecoder.js"></script>
    <script type="text/javascript" src="../js/QRReader/gf256poly.js"></script>
    <script type="text/javascript" src="../js/QRReader/gf256.js"></script>
    <script type="text/javascript" src="../js/QRReader/decoder.js"></script>
    <script type="text/javascript" src="../js/QRReader/qrcode.js"></script>
    <script type="text/javascript" src="../js/QRReader/findpat.js"></script>
    <script type="text/javascript" src="../js/QRReader/alignpat.js"></script>
    <script type="text/javascript" src="../js/QRReader/databr.js"></script>



</head>
<body>
<div class="section text-center" style="margin-bottom: 0;">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>QR Code Scan</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <p>Put the QR code up to the camera and Scan!
                    <br>
                </p>
            </div>
        </div>
    </div>
</div>

<div class="section" style="margin-top: 0;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 text-center">
                <video id="camera-stream" width="400" height="300" autoplay></video>
            </div>
        </div>
    </div>
</div>
<div class="section" style="margin-top: 0;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 text-center">
                <br>
                <a class="btn btn-primary" id="button1" onclick="captureToCanvas()">Scan</a>
            </div>
        </div>
    </div>
</div>
<div class="section" style="margin-top: 0;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 text-center">
                <canvas id="qr-canvas" width="640" height="480"></canvas>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var gCtx = null;
    var gCanvas = null;

    var imageData = null;
    var ii=0;
    var jj=0;
    var c=0;

    var video = document.getElementById("camera-stream");
    var canvas = document.getElementById("qr-canvas");
    var context = canvas.getContext("2d");
    var w, h, ratio;

    video.addEventListener("loadedmetadata", function() {
        ratio = video.videoWidth / video.videoHeight;
        w = video.videoWidth - 100;
        h = parseInt(w / ratio, 10);
        canvas.width = w;
        canvas.height = h;
    }, false);

    function dragenter(e) {
        e.stopPropagation();
        e.preventDefault();
    }

    function dragover(e) {
        e.stopPropagation();
        e.preventDefault();
    }
    function drop(e) {
        e.stopPropagation();
        e.preventDefault();

        var dt = e.dataTransfer;
        var files = dt.files;

        handleFiles(files);
    }

    function handleFiles(f)
    {
        var o=[];
        for(var i =0;i<f.length;i++)
        {
            var reader = new FileReader();

            reader.onload = (function(theFile) {
                return function(e) {
                    qrcode.decode(e.target.result);
                };
            })(f[i]);

            // Read in the image file as a data URL.
            reader.readAsDataURL(f[i]);	}
    }

    function read(a)
    {
        alert(a);
    }

    function load()
    {
        initCanvas(640,480);
        qrcode.callback = read;
        qrcode.decode("meqrthumb.png");
    }

    function initCanvas(ww,hh)
    {
        gCanvas = document.getElementById("qr-canvas");
        gCanvas.addEventListener("dragenter", dragenter, false);
        gCanvas.addEventListener("dragover", dragover, false);
        gCanvas.addEventListener("drop", drop, false);
        var w = ww;
        var h = hh;
        gCanvas.style.width = w + "px";
        gCanvas.style.height = h + "px";
        gCanvas.width = w;
        gCanvas.height = h;
        gCtx = gCanvas.getContext("2d");
        gCtx.clearRect(0, 0, w, h);
        imageData = gCtx.getImageData( 0,0,320,240);
    }

    function passLine(stringPixels) {
        //a = (intVal >> 24) & 0xff;

        var coll = stringPixels.split("-");

        for(var i=0;i<320;i++) {
            var intVal = parseInt(coll[i]);
            r = (intVal >> 16) & 0xff;
            g = (intVal >> 8) & 0xff;
            b = (intVal ) & 0xff;
            imageData.data[c+0]=r;
            imageData.data[c+1]=g;
            imageData.data[c+2]=b;
            imageData.data[c+3]=255;
            c+=4;
        }

        if(c>=320*240*4) {
            c=0;
            gCtx.putImageData(imageData, 0,0);
        }
    }

    function captureToCanvas() {

        var canvas = document.getElementById("qr-canvas");
        var video = document.getElementById("camera-stream");
        var context = canvas.getContext("2d");
        context.drawImage(video, 0, 0);
        qrcode.decode();
        alert("Proceeding to Step 3");
        window.location.href = "/qrscan?id="+qrcode.result;//=A1-001";
    }



</script>


</body>

</html>