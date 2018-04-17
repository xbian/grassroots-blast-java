
<link href="https://grassroots.tools/css/site.css" rel="stylesheet">
<%--<script src="https://grassroots.tools/js/site.js"></script>--%>
<style type="text/css">
    .fixed-top{
        top:-20px ! important;
    }

    .text-primary {
        color: rgba(198, 31, 22, 1) ! important;
    }

    a, a.active, a:active, a:focus, a:hover {
        color: #18bc9c;
        text-decoration: underline;
        -webkit-text-underline-position: under;
        -ms-text-underline-position: below;
        text-underline-position: under;
        /*text-underline-position: under;*/
        outline: 0
    }
    footer {
        color: black ! important;
    }

    section {
        padding: 30px 0 ! important;
    }

</style>

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
                    <a class="nav-link js-scroll-trigger" href="#services">Search</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="#about">Login</a>
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
    <div id="description" style="text-align: justify">${description}</div>

    <div id="license-panel" class="panel panel-primary" style="${license_style}">
        <div class="panel-body">
            <h3 class="text-on-pannel text-primary" data-toggle="collapse" data-target="#license-detail"><strong
                    class="text-uppercase" id="license">${license}</strong>
            </h3>
            <div id="license-detail" class="collapse">
                ${license_detail}
            </div>
        </div>
    </div>
</section>