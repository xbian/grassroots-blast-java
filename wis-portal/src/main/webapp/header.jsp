<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-gb">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta http-equiv='cache-control' content='no-cache'>
    <meta http-equiv='expires' content='0'>
    <meta http-equiv='pragma' content='no-cache'>

    <%-- timestamp to force browser to reload javascript --%>
    <jsp:useBean id="timestamp" class="java.util.Date" scope="request"/>

    <title>Wheat Information System Portal <c:if test="${not empty title}">- ${title}</c:if></title>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/prototype.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/fluxion-ajax/fluxion-ajax-compiled.js?ts=${timestamp.time}'/>"></script>

    <!-- bootstrap -->
    <script src="<c:url value='/scripts/bootstrap/bootstrap.min.js?ts=${timestamp.time}'/>" type="text/javascript"></script>
    <link href="<c:url value='/scripts/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="<c:url value='/styles/style.css?ts=${timestamp.time}'/>" type="text/css">
    <!-- font awesome -->
    <link href="<c:url value='/scripts/fontawesome/css/font-awesome.min.css'/>" rel="stylesheet" type="text/css">


    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/scriptaculous.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/activityInput.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/effects.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/unittest.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/dragdrop.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/slider.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/builder.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/sound.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/scriptaculous/controls.js'/>"></script>--%>


    <!-- jQuery -->
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery-1.11.3.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery-ui-1.11.4.custom/jquery-ui.min.js'/>"></script>
    <%--<script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.simplyCountable.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.tinysort.min.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.tablesorter.min.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.uitablefilter.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.validate.min.js'/>"></script>--%>
    <%--<script type="text/javascript" src="<c:url value='/scripts/jquery/colorbox/jquery.colorbox-min.js'/>"></script>--%>
    <link rel="stylesheet" href="<c:url value='/scripts/jquery/jquery-ui-1.11.4.custom/jquery-ui.min.css'/>"
          type="text/css">
    <link rel="stylesheet" href="<c:url value='/scripts/jquery/colorbox/colorbox.css'/>"
          type="text/css">

    <!-- Leaflet -->
    <link rel="stylesheet" href="<c:url value='/scripts/leaflet/leaflet.css'/>" />
    <script src="<c:url value='/scripts/leaflet/leaflet.js'/>"></script>

    <!-- Leaflet markercluster -->
    <link rel="stylesheet" href="<c:url value='/scripts/leaflet.markercluster/MarkerCluster.css'/>" />
    <link rel="stylesheet" href="<c:url value='/scripts/leaflet.markercluster/MarkerCluster.Default.css'/>" />
    <script src="<c:url value='/scripts/leaflet.markercluster/leaflet.markercluster.js'/>"></script>

    <!-- wis -->
    <script type="text/javascript" src="<c:url value='/scripts/wis.js?ts=${timestamp.time}'/>"></script>

    <%--<script type="text/javascript" src="<c:url value='/scripts/multi_select_drag_drop.js?ts=${timestamp.time}'/>"></script>--%>


    <script type="text/javascript" src="<c:url value='/scripts/FileSaver.min.js'/>"></script>

    <!-- give $ back to prototype -->
    <script type="text/javascript">jQuery.noConflict();</script>


    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-21666189-10', 'auto');
        ga('send', 'pageview');

    </script>

</head>
<body>

<!-- Fixed navbar -->
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="background-color:white!important;">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Grassroots Infrastructure</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li ><a href="<c:url value='/'/>">Home</a></li>
                <li><a href="<c:url value='/grassroots-portal/services'/>">Services</a></li>
                <li><a href="<c:url value='/grassroots-portal/indexer'/>">Search</a></li>
                <li><a href="<c:url value='/grassroots-portal/contact'/>">Contact</a></li>
                <li><a href="http://wheatis.tgac.ac.uk/grassroots/api/">Grassroots API</a></li>
            </ul>
            <img class ="navbar-nav navbar-right" style="height:50px;" src="<c:url value='/images/tgac_logo.png'/>"/>
        </div>
    </div>
</nav>

