<%@ include file="header.jsp" %>

<div class="container">

    <div class="jumbotron">
        <h2>Wheat Information System</h2>

        <p>Wheat Information System...</p>

        <p>Search Literature Data</p>

        <div class="col-lg-6">
            <div class="input-group">
                <input type="text" class="form-control" id="searchStr"/>

          <span class="input-group-btn">
          <button type="button" class="btn btn-default" onclick="searchSolr();">Search</button>
          </span>
            </div>
        </div>
        <p>

        <div id="solrResult"></div>
        </p>
    </div>

</div>

<script type="text/javascript">
    function searchSolr() {

        Fluxion.doAjax(
                'wisControllerHelperService',
                'searchSolr',
                {
                    'searchStr':jQuery('#searchStr').val(),
                    'url': ajaxurl
                },
                {'doOnSuccess': function (json) {



                    jQuery('#solrResult').html(json.numFound);
                }
                }
        );
    }

</script>

<%@ include file="footer.jsp" %>