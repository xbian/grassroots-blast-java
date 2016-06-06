<%@ include file="header.jsp" %>

<div class="container center-block">

    <div class="jumbotron">
        <h2>Node JS test</h2>
     <div id="result"></div>

    </div>
</div>

<script type="text/javascript">
    jQuery(document).ready(function () {
        Fluxion.doAjax(
                'wisControllerHelperService',
                'getpapers',
                {
                    'query':'wheat',
                    'dir':'/Users/bianx/Downloads/wheat',
                    'url': ajaxurl
                },
                {
                    'doOnSuccess': function (json) {
                        jQuery('#result').html(json.response);
                    }
                }
        );
    });

</script>

<%@ include file="footer.jsp" %>