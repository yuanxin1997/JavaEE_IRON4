<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 1/29/2017
  Time: 10:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>QRCODE</title>

    <style type="text/css">
    </style>

    <script src="../js/scripts.js"></script>
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

<body onload="load()">
<div class="container">

    <video id="camera-stream" width="500" height="250" autoplay></video>

</div>
<button id="button1" onclick="captureToCanvas()">Capture</button><br>
<canvas id="qr-canvas" width="640" height="480"></canvas>

<script type="text/javascript">
    var gCtx = null;
    var gCanvas = null;

    var imageData = null;
    var ii=0;
    var jj=0;
    var c=0;
    var stop = false;

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
//            flash = document.getElementById("embedflash");
//            flash.ccCapture();
        //            var canvas = document.getElementById("qr-canvas");
//            var context = canvas.getContext("2d");
//            context.fillRect(0,0,w,h);
//            context.drawImage(video, 0,0, w, h);

        var canvas = document.getElementById("qr-canvas");
        var video = document.getElementById("camera-stream");
        var context = canvas.getContext("2d");
        //if (localMediaStream) {
        context.drawImage(video, 0, 0);
        // "image/webp" works in Chrome.
        // Other browsers will fall back to image/png.
        //document.querySelector('img').src = canvas.toDataURL('image/webp');
        qrcode.decode();
    }

</script>

</body>

</html>