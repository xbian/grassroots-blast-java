<script src="https://grassroots.tools/js/site.js"></script>
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
                       href="#" onclick="searchModal();">Search</a>
                </li>
                <li class="nav-item">
                    <a id="loginout" class="nav-link js-scroll-trigger" href="" data-toggle="tooltip"
                       data-placement="bottom" title="">Login</a>
                </li>
            </ul>
            <img class="navbar-nav navbar-right" style="height:50px;margin-left:50px;"
                 src="https://grassroots.tools/img/logo-white.png"/>
        </div>
    </div>
</nav>

<section id="project-info" style="margin-top:100px;">
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
</section>

<script type="text/javascript">
    $(document).ready(function () {
        var search_form_content = $('#search_form');
        $('#search_form').remove();
        $('#search_form_content').html(search_form_content);
        $('#search_form_popup').addClass("modal");
        $('#search_form_popup').addClass("fade");
        $('#search_form_popup').modal({
            show: false
        });

        if ($('#login_link') != null) {
            $('#loginout').html('Login');
            $('#loginout').attr('href', $('#login_link').attr('href'));
            $('#loginout').attr('data-toggle', 'tooltip');
            $('#loginout').attr('data-placement', 'bottom');
            $('#loginout').attr('title', 'You are viewing ' + $('#user .zone_name').html() + ' zone');
        } else if ($('#login_link') != null) {

            $('#loginout').html('logout');
            $('#loginout').attr('href', $('#login_link').attr('href'));
            $('#loginout').attr('data-toggle', 'tooltip');
            $('#loginout').attr('data-placement', 'bottom');
            $('#loginout').attr('title', 'You are logged in as ' + $('#user .zone_name').html());
        }


    });

    function licenseCollapse() {
        $("#licenseDetail").collapse('toggle');
    }

    function searchModal() {
        $('#search_form_popup').modal('show');

        SetUpMetadataKeysAutoCompleteList();
        SetUpMetadataValuesAutoCompleteList();
    }

</script>