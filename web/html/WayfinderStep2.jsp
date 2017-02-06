<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 12/14/2016
  Time: 2:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="..\css\qq.css" rel="stylesheet" type="text/css">
    <link href="..\css\style.css" rel="stylesheet" type="text/css">
    <title>Title</title>
    <%
        session.setAttribute("usage", "origin");
    %>

    <style>
        .topPart{
            margin: 0 auto;
            padding-top:0;
        }
    </style>

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
<div class="section topPart">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1>Step 2: Finding yourself</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 text-center">
                <p>Tell us your location by scanning a nearby QR tag!
                    <br>
                </p>
            </div>
        </div>
    </div>
</div>
<div class="section topPart">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">Find your nearest QR code Waypoint!</h1>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-12 text-center">
                <a class="btn btn-primary" href="/orgscan">Scan QR Code<br></a>
            </div>
        </div>
    </div>
</div>
</body>

</html>
