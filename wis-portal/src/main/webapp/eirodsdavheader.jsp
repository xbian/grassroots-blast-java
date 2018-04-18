<%--<link href="https://grassroots.tools/css/site.css" rel="stylesheet">--%>
<%--<script src="https://grassroots.tools/js/site.js"></script>--%>
<style type="text/css">
    .fixed-top {
        top: -20px ! important;
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

    section {
        padding: 30px 0 ! important;
    }
    body {
        font-family: Lato, 'Helvetica Neue', Helvetica, Arial, sans-serif;
        overflow-x: hidden;
        width: 95%;
    }


    p {
        font-size: 1em;
    }

    @media (min-width: 992px) {

        p {
            font-size: 20px
        }
    }
    p.small {
        font-size: 16px
    }

    a, a.active, a:active, a:focus, a:hover {
        color: #18bc9c ;
        text-decoration: underline;
        -webkit-text-underline-position: under;
        -ms-text-underline-position: below;
        text-underline-position: under;
        /*text-underline-position: under;*/
        outline: 0
    }

    nav a, a.active, a:active, a:focus, a:hover {
        text-decoration: none;
    }

    h1, h2, h3, h4, h5, h6 {
        font-family: Montserrat, 'Helvetica Neue', Helvetica, Arial, sans-serif;
        font-weight: 700;
        text-transform: uppercase
    }

    hr.star-light, hr.star-primary {
        max-width: 250px;
        margin: 25px auto 30px;
        padding: 0;
        text-align: center;
        border: none;
        border-top: solid 5px
    }

    hr.star-light:after, hr.star-primary:after {
        font-family: FontAwesome;
        font-size: 2em;
        position: relative;
        top: -.8em;
        display: inline-block;
        padding: 0 .25em;
        content: '\f005'
    }

    hr.star-light {
        border-color: #fff
    }

    hr.star-light:after {
        color: #fff;
        background-color: #18bc9c
    }

    hr.star-primary {
        border-color: #2c3e50
    }

    hr.star-primary:after {
        color: #2c3e50;
        background-color: #fff
    }

    .img-centered {
        margin: 0 auto
    }

    section {
        padding: 100px 0
    }

    section h2 {
        font-size: 3em;
        margin: 0
    }

    section.success {
        color: #fff;
        background: #18bc9c
    }

    @media (max-width: 767px) {
        section {
            padding: 75px 0
        }

        section.first {
            padding-top: 75px
        }
    }

    .scroll-top {
        position: fixed;
        z-index: 1049;
        right: 2%;
        bottom: 2%;
        width: 50px;
        height: 50px
    }

    .scroll-top .btn {
        font-size: 16px;
        line-height: 28px;
        width: 50px;
        height: 50px;
        text-align: center;
        border-radius: 100%
    }

    .scroll-top .btn:focus {
        outline: 0
    }

    #mainNav {
        font-family: Montserrat, 'Helvetica Neue', Helvetica, Arial, sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        border: none;
        background: #2c3e50
    }

    #mainNav a:focus {
        outline: 0
    }

    #mainNav .navbar-brand {
        font-size: 1.1rem;
        color: #fff
    }

    #mainNav .navbar-brand.active, #mainNav .navbar-brand:active, #mainNav .navbar-brand:focus, #mainNav .navbar-brand:hover {
        color: #fff
    }

    #mainNav .navbar-nav {
        letter-spacing: 1px
    }

    #mainNav .navbar-nav li.nav-item a.nav-link {
        color: #fff
    }

    #mainNav .navbar-nav li.nav-item a.nav-link:hover {
        color: #18bc9c;
        outline: 0
    }

    #mainNav .navbar-nav li.nav-item a.nav-link:active, #mainNav .navbar-nav li.nav-item a.nav-link:focus {
        color: #fff
    }

    #mainNav .navbar-toggler {
        font-size: 14px;
        padding: 11px;
        text-transform: uppercase;
        color: #fff;
        border-color: #fff
    }

    #mainNav .navbar-toggler:focus, #mainNav .navbar-toggler:hover {
        color: #fff;
        border-color: #18bc9c;
        background-color: #18bc9c
    }

    @media (min-width: 992px) {

        body {
            width: 80% ! important;
        }

        #mainNav {
            padding-top: 25px;
            padding-bottom: 25px;
            -webkit-transition: padding-top .3s, padding-bottom .3s;
            -moz-transition: padding-top .3s, padding-bottom .3s;
            transition: padding-top .3s, padding-bottom .3s
        }

        #mainNav .navbar-brand {
            font-size: 2em;
            -webkit-transition: all .3s;
            -moz-transition: all .3s;
            transition: all .3s
        }

        #mainNav .navbar-nav > li.nav-item > a.nav-link.active {
            color: #fff;
            border-radius: 3px;
            background: #18bc9c
        }

        #mainNav .navbar-nav > li.nav-item > a.nav-link.active:active, #mainNav .navbar-nav > li.nav-item > a.nav-link.active:focus, #mainNav .navbar-nav > li.nav-item > a.nav-link.active:hover {
            color: #fff;
            background: #18bc9c
        }

    }

    header.masthead {
        padding-top: 100px;
        padding-bottom: 50px;
        text-align: center;
        color: #fff;
        /*background: #18bc9c*/
    }

    header.masthead img {
        display: block;
        margin: 0 auto 20px
    }

    header.masthead .intro-text .name {
        font-family: Montserrat, 'Helvetica Neue', Helvetica, Arial, sans-serif;
        font-size: 2em;
        font-weight: 700;
        display: block;
        text-transform: uppercase
    }

    header.masthead .intro-text .skills {
        font-size: 1.25em;
        font-weight: 300
    }

    header.masthead p {
        font-size: 1em;
        font-weight: 200
    }

    @media (min-width: 768px) {
        header.masthead {
            padding-top: 200px;
            padding-bottom: 100px
        }

        header.masthead .intro-text .name {
            font-size: 4.75em
        }

        header.masthead .intro-text .skills {
            font-size: 1.75em
        }

        header.masthead p {
            font-size: 1.25em
        }
    }


    @media (min-width: 767px) {


    .floating-label-form-group {
        position: relative;
        margin-bottom: 0;
        padding-bottom: .5em;
        border-bottom: 1px solid #eee
    }

    .floating-label-form-group input, .floating-label-form-group textarea {
        font-size: 1.5em;
        position: relative;
        z-index: 1;
        padding-right: 0;
        padding-left: 0;
        resize: none;
        border: none;
        border-radius: 0;
        background: 0 0;
        box-shadow: none !important
    }

    .floating-label-form-group label {
        font-size: .85em;
        line-height: 1.764705882em;
        position: relative;
        z-index: 0;
        top: 2em;
        display: block;
        margin: 0;
        -webkit-transition: top .3s ease, opacity .3s ease;
        -moz-transition: top .3s ease, opacity .3s ease;
        -ms-transition: top .3s ease, opacity .3s ease;
        transition: top .3s ease, opacity .3s ease;
        vertical-align: middle;
        vertical-align: baseline;
        opacity: 0
    }

    .floating-label-form-group:not(:first-child) {
        padding-left: 14px;
        border-left: 1px solid #eee
    }

    .floating-label-form-group-with-value label {
        top: 0;
        opacity: 1
    }

    .floating-label-form-group-with-focus label {
        color: #18bc9c
    }

    form .row:first-child .floating-label-form-group {
        border-top: 1px solid #eee
    }


    #header-section:before{
        z-index: 1;
        opacity: 0.2;
    }

    a.darker, a.darker:active, a.darker:focus, a.darker:hover{
        text-decoration: underline;
        color: white;
        /*color:  #00695C;*/
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
                    <a id="searchLink" class="nav-link js-scroll-trigger" data-toggle=“modal” data-target=“#search_form” href="#" onclick="searchModal();">Search</a>
                </li>
                <li class="nav-item">
                <a class="nav-link js-scroll-trigger" href="">Login</a>
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
        This data is made available under the <a href="#" data-toggle=“collapse” data-target="#licenseDetail" onclick="licenseCollapse();"><span style="color: rgba(198, 31, 22, 1);">${license}</span> click for more details...</a>
        <br/>
        <div id="licenseDetail" class="collapse" style="padding-top:20px;">
            ${license_detail}
        </div>
    </div>
</section>

<script type="text/javascript">
    $(document).ready(function () {
        $('#search_form').model();
    });

    function licenseCollapse() {
      $("#licenseDetail").collapse('toggle');
    }
    function searchModale() {
        $('#search_form').modal('toggle');
    }
</script>