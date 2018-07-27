<%--<script src="https://grassroots.tools/js/site.js"></script>--%>
<link rel="stylesheet" type="text/css" href="/eirods_dav_files/styles/header.css"/>


<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top" style="text-transform: none ! important;">Grassroots
            Data Repository</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">
            Menu
            <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a id="searchLink" class="nav-link js-scroll-trigger" data-toggle=“modal” data-target=“#search_form”
                       href="#" onclick="searchCollapse();">Search</a>
                    <div id="searchFormHolder"
                         style="display:none;position: absolute; margin-top:20px;margin-right:20px;"></div>
                </li>
                <li class="nav-item">
                    <a id="loginout" class="nav-link js-scroll-trigger" href="" data-toggle="tooltip"
                       data-placement="bottom" title="">Login</a>
                </li>
            </ul>
            <img class="navbar-nav navbar-right" style="height:50px;margin-left:50px;"
                 src="https://grassroots.tools/img/logo-white.png"
                 alt="The Earlham Institute logo"/>
        </div>
    </div>
</nav>
<section id="services" ${projectStyle}>
    <div class="container">
        <h3 id="projectName" style="color: #18bc9c;">${projectName}</h3>
        <i>
            <small> ${poi} </small>
        </i>
        <div id="description" style="text-align: justify; padding-bottom: 30px;">${description}</div>

        <div id="licensePanel" style="${license_style}">
            This data is made available under the <a href="#" onclick="licenseCollapse();"><span
                style="color: rgba(198, 31, 22, 1);">${license}</span></a>
            <br/>
            <div id="licenseDetail" class="collapse" style="padding-top:20px;">
                ${license_detail}
            </div>
        </div>
    </div>
</section>

<%--<script type="text/javascript">--%>
    <%--$(document).ready(function () {--%>
        <%--var search_form_content = $('#search_form_2');--%>
        <%--$('#search_form').remove();--%>
        <%--$('#searchFormHolder').html(search_form_content);--%>
        <%--$('#search_form_popup').addClass("modal");--%>
        <%--$('#search_form_popup').addClass("fade");--%>
        <%--// $('#search_form_popup').modal({--%>
        <%--//     show: false--%>
        <%--// });--%>

        <%--if ($('#login_link') != null) {--%>
            <%--$('#loginout').html('Login');--%>
            <%--$('#loginout').attr('href', $('#login_link').attr('href'));--%>
            <%--$('#loginout').attr('data-toggle', 'tooltip');--%>
            <%--$('#loginout').attr('data-placement', 'bottom');--%>
            <%--$('#loginout').attr('title', 'You are viewing ' + $('#user .zone_name').html() + ' zone');--%>
        <%--} else if ($('#login_link') != null) {--%>

            <%--$('#loginout').html('logout');--%>
            <%--$('#loginout').attr('href', $('#login_link').attr('href'));--%>
            <%--$('#loginout').attr('data-toggle', 'tooltip');--%>
            <%--$('#loginout').attr('data-placement', 'bottom');--%>
            <%--$('#loginout').attr('title', 'You are logged in as ' + $('#user .zone_name').html());--%>
        <%--}--%>


    <%--});--%>

    <%--function licenseCollapse() {--%>
        <%--$("#licenseDetail").collapse('toggle');--%>
    <%--}--%>

    <%--function searchModal() {--%>
        <%--$('#search_form_popup').modal('show');--%>

        <%--SetUpMetadataKeysAutoCompleteList();--%>
        <%--SetUpMetadataValuesAutoCompleteList();--%>
    <%--}--%>


    <%--function searchCollapse() {--%>
        <%--if ($('#searchFormHolder').css('display') == 'none') {--%>
            <%--$('#searchFormHolder').show();--%>
            <%--$('#searchFormHolder').css({--%>
                <%--"left": $('#searchLink').offset().left,--%>
                <%--"top": $('#searchLink').offset().top + 40,--%>
                <%--"z-index": "9999"--%>
            <%--});--%>
            <%--$('#mainNav').css({--%>
                <%--"padding-bottom": "60px"--%>
            <%--});--%>
            <%--$('#project-info').css({--%>
                <%--"margin-top": "140px"--%>
            <%--});--%>
        <%--} else {--%>

            <%--$('#searchFormHolder').hide();--%>
            <%--$('#mainNav').css({--%>
                <%--"padding-bottom": "25px"--%>
            <%--});--%>
            <%--$('#project-info').css({--%>
                <%--"margin-top": "120px"--%>
            <%--});--%>
        <%--}--%>
        <%--SetUpMetadataKeysAutoCompleteList();--%>
        <%--SetUpMetadataValuesAutoCompleteList();--%>
    <%--}--%>

<%--</script>--%>

<%--<form action="/wheat/api/metadata/search" id="search_form_2">--%>

<%--<div class="input-group">--%>
<%--<input name="key" type="text" id="search_key" class="form-control" placeholder="Attribute"--%>
<%--aria-label="Attribute" aria-describedby="">--%>
<%--<input type="text" id="search_value" name="value" class="form-control" placeholder="Value" aria-label="Value"--%>
<%--aria-describedby="">--%>
<%--<div class="input-group-append">--%>
<%--<button class="btn btn-light" type="submit">Search</button>--%>
<%--</div>--%>
<%--</div>--%>

<%--<ul id="search_keys_autocomplete_list" class="autocomplete"></ul>--%>
<%--<ul id="search_values_autocomplete_list" class="autocomplete"></ul>--%>
<%--</form>--%>

<form action="/wheat/search" id="search_form_2">

    <div class="input-group">
        <input name="key" type="text" id="search_key" class="form-control" placeholder="Attribute"
               aria-label="Attribute" aria-describedby="">
        <input type="text" id="search_value" name="value" class="form-control" placeholder="Value" aria-label="Value"
               aria-describedby="">
        <div class="input-group-append">
            <button class="btn btn-light" type="submit">Search</button>
        </div>
    </div>

    <ul id="search_keys_autocomplete_list" class="autocomplete"></ul>
    <ul id="search_values_autocomplete_list" class="autocomplete"></ul>
</form>