<%@ include file="header.jsp" %>

<div class="container">

    <div class="jumbotron">
        <h2>Wheat Information System</h2>


        <p>Search Literature Data</p>

        <div class="row">
            <div class="col-lg-6">
                <div class="input-group">
                    <input type="text" class="form-control" id="searchStr"/>

          <span class="input-group-btn">
          <button type="button" class="btn btn-default" onclick="searchSolr();">Search</button>
          </span>
                </div>
            </div>
        </div>
        <p></p>

        <div id="solrResult"></div>
    </div>

</div>

<script type="text/javascript">
    function searchSolr() {
        jQuery('#solrResult').html('');
        Fluxion.doAjax(
                'wisControllerHelperService',
                'searchSolr',
                {
                    'searchStr': jQuery('#searchStr').val(),
                    'url': ajaxurl
                },
                {'doOnSuccess': function (json) {
                    jQuery('#solrResult').append("<p>Found " + json.numFound + "</p>");
                    jQuery('#solrResult').append('<ul class="list-group">');
                    jQuery.each(json.docs, function (key, value) {
                        jQuery('#solrResult').append("<li class='list-group-item'>Title: " + value['title'] + "<br/>Author: <i>" + value['author'] + "</i></li>");
                    });
                    jQuery('#solrResult').append('</ul>');
                }
                }
        );
    }

</script>

<%@ include file="footer.jsp" %>