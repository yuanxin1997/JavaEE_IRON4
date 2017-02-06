<%@ page import="java.util.ArrayList" %>
<%@ page import="WayfinderDBController.WaypointDA" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 1/31/2017
  Time: 6:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="..\css\qq.css" rel="stylesheet" type="text/css">



    <style>
        .topPart{
            margin: 0 auto;
            padding-top:0;
        }
        #map-canvas
        {
            margin-left: auto;
            margin-right: auto;
            width: 500px;
            height: 500px;
            border: 2px;
            border-color: #0f0f0f;
            display: block;
        }
        @media (min-width:350px)
        {
            #map-canvas
            {
                margin-left: auto;
                margin-right: auto;
                width: 350px;
                height: 350px;
                border: 2px;
                display: block;
            }
        }
        @media (min-width:1000px)
        {
            #map-canvas
            {
                margin-left: auto;
                margin-right: auto;
                width: 500px;
                height: 500px;
                border: 2px;
                display: block;
            }
        }
    </style>

    <%
        try{
            Thread.sleep(3000);
        }catch(InterruptedException e){e.printStackTrace();}

        response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
        response.setHeader("Pragma","no-cache"); //HTTP 1.0C:\Users\admin\IdeaProjects\IronFour\web\img\generatedMap.png
        response.setDateHeader ("Expires", -1); //prevents caching at the proxy server

        session.setAttribute("usage", "map");
        int x = (Integer) session.getAttribute("nextPoint");
        ArrayList<String> waypointIdList = (ArrayList<String>) session.getAttribute("selectedRoute");
        String org = WaypointDA.getWaypoint(waypointIdList.get(x-1)).getName();
        String dest = WaypointDA.getWaypoint(waypointIdList.get(x)).getName();
        String imgSrc = (String)session.getAttribute("imgPath");
        imgSrc = "../img/"+ imgSrc.substring(imgSrc.lastIndexOf('/'));


//        String imgSrc = "/img/generatedMap.png";
//        String imgSrc = "C:/Users/admin/IdeaProjects/IronFour/web/img/generatedMap.png?t=" + new Date().getTime();

        //System.out.println("New Img Source: "+ imgSrc);
    %>

    <%--<script>--%>
        <%--window.onload(setTimeout(function(){--%>
<%--//            var img = new Image();--%>
<%--//            var div = document.getElementById('foo');--%>
<%--//--%>
<%--//            img.onload = function() {--%>
<%--//                div.appendChild(img);--%>
<%--//            };--%>
<%--//--%>
<%--//            img.src = '/img/generatedMap.png?t=' + new Date().getTime();--%>

            <%--$('#mapArea').prepend('<img id="map-canvas" src="/img/generatedMap.png">')--%>
        <%--}),3000);--%>
    <%--</script>--%>

</head>
<body>

<div class="navbar navbar-default navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-ex-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand"><span>Wayfinder</span></a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-ex-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="">
                    <a href="#">Home</a>
                </li>
                <li class="active">
                    <a href="WayfinderLanding.jsp">Wayfinder</a>
                </li>
                <li>
                    <a href="#">Diabetes Monitor</a>
                </li>
                <li>
                    <a href="login.jsp">Virtual Chat</a>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="section text-center topPart">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Step 4: Wayfinding</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <p>Follow the map!</p>
            </div>
        </div>
    </div>
</div>
<div class="section topPart">
    <div class="container">
        <div class="row">
            <div class="col-xs-12" id="mapArea">
                <img id="map-canvas" src="<%=imgSrc%>">
                <%--<canvas id="map-canvas"></canvas>--%>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 text-center" >
                <br>
                <a class="btn btn-primary" href="WayfinderQR.jsp">Scan QR Code</a>
            </div>
        </div>
    </div>
</div>
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>On Route</h2>
                <h3>From: <%=org%></h3>
                <h3>To: <%=dest%></h3>
                <p>Please take note of your surroundings and follow the directions given
                    on the map!</p>
                <a class="btn btn-primary" href="javascript:history.back()">Previous Waypoint</a>
            </div>
        </div>
    </div>
</div>
</body>

</html>
