<%@ page import="WayfinderModel.Waypoint" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="WayfinderDBController.WaypointDA" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 12/14/2016
  Time: 1:49 PM
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
    <link href="..\css\style.css" rel="stylesheet" type="text/css">

    <script type="text/javascript">

        function openCity(cityName, optionName) {
            document.getElementsByClassName('myUL').disabled = false;
            var i;
            var x = document.getElementsByClassName("city");
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            document.getElementById(cityName).style.display = "block";
            document.getElementById('myInput').reset();
            document.getElementById('listAll').style.display = "none";
        }

        function inputFocus() {
            document.getElementById('listAll').style.display = "";
            document.getElementById('London').style.display = "none";
            document.getElementById('Paris').style.display = "none";
            document.getElementById('Tokyo').style.display = "none";
        }

        function displayFilter() {
            var input, filter, ul, li, a, i, b;
            input = document.getElementById('myInput');
            filter = input.value.toUpperCase();
            ul = document.getElementById("ulAll");
            li = ul.getElementsByTagName('li');

            for (i = 0; i < li.length; i++) {
                a = li[i].getElementsByTagName("h3")[0];
                b = li[i].getElementsByTagName("p")[0];
                if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                }else if (b.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";
                }
            }
        }

    </script>

    <style>

        .topPart{
            margin: 0 auto;
            padding-top:0;
        }

        #myInput {
            background-position: 10px 12px; /* Position the search icon */
            background-repeat: no-repeat; /* Do not repeat the icon image */
            width: 100%; /* Full-width */
            font-size: 16px; /* Increase font-size */
            padding: 12px 20px 12px 40px; /* Add some padding */
            border: 1px solid #ddd; /* Add a grey border */
            margin-bottom: 12px; /* Add some space below the input */
        }


        #ulAll {
            /* Remove default list styling */
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        #ulAll li{
            border: 2px solid #ddd; /* Add a border to all links */
            padding:0;
        }

        #ulAll li a {
            margin: -1px 0 0 0; /* Prevent double borders */
            background-color: #f6f6f6; /* Grey background color */
            padding: 12px; /* Add some padding */
            text-decoration: none; /* Remove default text underline */
            color: black; /* Add a black text color */
            display: block; /* Make it into a block element to fill the whole list */
        }
        #ulAll li a:hover:not(.header) {
            background-color: #eee; /* Add a hover effect to all links, except for headers */
        }

        .myUL {
            /* Remove default list styling */
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .myUL li{
            border: 1px solid #ddd; /* Add a border to all links */
            padding:0;
        }

        .myUL li a {
            margin: -1px 0 0 0; /* Prevent double borders */
            background-color: #f6f6f6; /* Grey background color */
            padding: 12px; /* Add some padding */
            text-decoration: none; /* Remove default text underline */
            color: black; /* Add a black text color */
            display: block; /* Make it into a block element to fill the whole list */
        }

        .myUL li a:hover:not(.header) {
            background-color: #eee; /* Add a hover effect to all links, except for headers */
        }

    </style>

    <%
        ArrayList<Waypoint> waLa = new ArrayList<Waypoint>();
        ArrayList<Waypoint> waWa = new ArrayList<Waypoint>();
        ArrayList<Waypoint> waAll = new ArrayList<Waypoint>();


        try{
            waLa = WaypointDA.getLandmarkWaypoints();
            waWa = WaypointDA.getWardWaypoints();
            waAll = WaypointDA.getAllWaypointNoAccess();
        }catch (SQLException e){e.printStackTrace();}

        Collections.sort(waAll, new Comparator<Waypoint>() {
            public int compare(Waypoint one, Waypoint other) {
                return one.getName().compareTo(other.getName());
            }
        });
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
                    <a href="mainPage.html">Home</a>
                </li>
                <li class="active">
                    <a href="WayfinderLanding.jsp">Wayfinder</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="section topPart">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">Step 1: Set your sights</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <p class="text-center">Select the type of Location that you want to find.</p>
            </div>
        </div>
    </div>
</div>
<div class="section topPart">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <input type="text" id="myInput" onfocus="inputFocus()" onkeyup="displayFilter()" placeholder="Search for wards/rooms..">

                <ul class="nav nav-justified nav-pills" style="border: 2px; border-color: gainsboro; margin-bottom: 10px;">
                    <li id="landmarks"><a href="#" onclick="openCity('London', 'landmarks')">Hospital Landmarks</a></li>
                    <li id="wards"><a href="#" onclick="openCity('Paris', 'wards')">Wards / Clinics</a></li>
                </ul>

                <div id="listAll" class="w3-container city" >
                    <ul class="list-group" id="ulAll">
                        <h2>All locations</h2>
                        <%
                        for (int i=0;i<waAll.size();i++) {
                            String name = (String) waAll.get(i).getName();
                            String id = (String) waAll.get(i).getId();
                            String desc =  (String) waAll.get(i).getDesc();
                        %>
                        <li class="list-group-item">
                            <a href="/selectDestination?name=<%=name%>&id=<%=id%>">
                                <h3><%=name%></h3>
                                <p><%=desc%></p>
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </div>

                <div id="London" class="w3-container city"style="display:none" >
                    <ul class="list-group myUL">
                        <h2>Landmarks</h2>
                        <%
                            for (int i=0;i<waLa.size();i++) {
                                String name = (String) waLa.get(i).getName();
                                String id = (String) waLa.get(i).getId();
                                String desc =  (String) waLa.get(i).getDesc();
                        %>
                        <li class="list-group-item">
                            <a href="/selectDestination?name=<%=name%>&id=<%=id%>">
                                <h3><%=name%></h3>
                                <p><%=desc%></p>
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </div>

                <div id="Paris" class="w3-container city" style="display:none">
                    <ul class="list-group myUL">
                        <h2>Wards / Clinics / Consultation</h2>
                        <%
                            for (int i=0;i<waWa.size();i++) {
                                String name = (String) waWa.get(i).getName();
                                String id = (String) waWa.get(i).getId();
                                String desc =  (String) waWa.get(i).getDesc();
                        %>
                        <li class="list-group-item">
                            <a href="/selectDestination?name=<%=name%>&id=<%=id%>">
                                <h3><%=name%></h3>
                                <p><%=desc%></p>
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>


</body></html>