<%@ page import="java.util.ArrayList" %>
<%@ page import="WayfinderDBController.WaypointDA" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 1/29/2017
  Time: 1:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
            height: 350px;
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
                height: 210px;
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
                height: 300px;
                border: 2px;
                display: block;
            }
        }
    </style>

    <%
        ArrayList<String> selectedRoute = (ArrayList<String>) session.getAttribute("selectedRoute");
        String name = WaypointDA.getWaypointById(selectedRoute.get(selectedRoute.size()-1)).getName();
        String id = selectedRoute.get(selectedRoute.size()-1);

        //HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    %>

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
            <div class="col-md-12">
                <h1 class="text-center">The End</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 text-center">
                <p class="text-center">You've reached your destination!
                    <br>
                </p>
            </div>
        </div>
    </div>
</div>
<div class="topPart section">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <img id="map-canvas" src="/img/<%=id%>.jpg">
                <h2>Location:</h2>
                <h3><%=name%></h3>
            </div>
        </div>
    </div>
</div>
<div class="section topPart">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 text-center">
                <a class="btn btn-primary" href="WayfinderLanding.jsp">Back to Landing page</a>
            </div>
        </div>
    </div>
</div>
</body>

</html>