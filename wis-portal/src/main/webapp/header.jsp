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

    <link rel="stylesheet" href="<c:url value='/styles/style.css?ts=${timestamp.time}'/>" type="text/css">
    <title>Wheat Information System Portal <c:if test="${not empty title}">- ${title}</c:if></title>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/prototype.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/fluxion-ajax/fluxion-ajax-compiled.js?ts=${timestamp.time}'/>"></script>

    <!-- bootstrap -->
    <script src="<c:url value='/scripts/bootstrap/bootstrap.min.js?ts=${timestamp.time}'/>" type="text/javascript"></script>
    <link href="<c:url value='/scripts/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

    <!-- font awesome -->
    <link href="<c:url value='/scripts/fontawesome/css/font-awesome.min.css'/>" rel="stylesheet" type="text/css">

    <!--Scriptaculous JS scripts below -->
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/scriptaculous.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/activityInput.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/effects.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/unittest.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/dragdrop.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/slider.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/builder.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/sound.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/scriptaculous/controls.js'/>"></script>

    <!-- jQuery -->
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery-1.4.2.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery-ui-1.8.custom.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.simplyCountable.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.tinysort.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.tablesorter.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.uitablefilter.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/js/jquery.validate.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/colorbox/jquery.colorbox-min.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='/scripts/jquery/css/smoothness/jquery-ui-1.8.custom.css'/>"
          type="text/css">
    <link rel="stylesheet" href="<c:url value='/scripts/jquery/colorbox/colorbox.css'/>"
          type="text/css">

    <!-- Leaflet -->
    <link rel="stylesheet" href="<c:url value='/scripts/leaflet/leaflet.css'/>" />
    <script src="<c:url value='/scripts/leaflet/leaflet.js'/>"></script>

    <!-- wis -->
    <script type="text/javascript" src="<c:url value='/scripts/wis.js?ts=${timestamp.time}'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/external.js?ts=${timestamp.time}'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/search.js?ts=${timestamp.time}'/>"></script>

    <!--CryptoJS-->
    <script type="text/javascript" src="<c:url value='/scripts/sha1.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/enc-base64-min.js'/>"></script>


    <!-- give $ back to prototype -->
    <script type="text/javascript">jQuery.noConflict();</script>

    <script type="text/javascript" src="<c:url value='/scripts/multi_select_drag_drop.js?ts=${timestamp.time}'/>"></script>

    <%--<link rel="shortcut icon" href="<c:url value='/styles/images/favicon.ico'/>" type="image/x-icon"/>--%>

    <!--drop down menu -->

    <script src="<c:url value='/scripts/menus.js?ts=${timestamp.time}'/>" type="text/javascript"></script>

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
<nav class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Wheat Information System</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li ><a href="<c:url value='/'/>">Portal Home</a></li>
                <li><a href="<c:url value='/wis-portal/yellowrustmap'/>">Yellow Rust Map</a></li>
                <li><a href="<c:url value='/wis-portal/indexer'/>">Solr &amp; Elasticsearch</a></li>
                <li><a href="<c:url value='/wis-portal/about'/>">About</a></li>
                <li><a href="<c:url value='/wis-portal/contact'/>">Contact</a></li>
                <li><a href="http://wheatis.tgac.ac.uk/wheatis-dev-docs/">API</a></li>
                <%--<li class="dropdown">--%>
                    <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <span class="caret"></span></a>--%>
                    <%--<ul class="dropdown-menu" role="menu">--%>
                        <%--<li><a href="#">Action</a></li>--%>
                        <%--<li><a href="#">Another action</a></li>--%>
                        <%--<li><a href="#">Something else here</a></li>--%>
                        <%--<li class="divider"></li>--%>
                        <%--<li class="dropdown-header">Nav header</li>--%>
                        <%--<li><a href="#">Separated link</a></li>--%>
                        <%--<li><a href="#">One more separated link</a></li>--%>
                    <%--</ul>--%>
                <%--</li>--%>
            </ul>
            <img class ="navbar-nav navbar-right" style="height:50px;" src="<c:url value='/images/tgac_logo.png'/>"/>
        </div>
    </div>
</nav>

