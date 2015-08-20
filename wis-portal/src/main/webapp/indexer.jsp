<%@ include file="header.jsp" %>

<div class="container center-block">

    <div class="jumbotron">
        <h2>Solr &amp; Elasticsearch</h2>

        <p>Search Literature Data</p>

        <div class="row">
            <div class="col-lg-6">
                <div class="input-group">
                    <input type="text" class="form-control" id="searchStr"/>

          <span class="input-group-btn">
          <button type="button" class="btn btn-default" onclick="searchSolr();">Search Solr</button>
          </span>
                </div>
            </div>
        </div>
        <p></p>

        <div id="solrResult"></div>


        <p>Search iRods Data on ElasticSearch</p>

        <div class="form-group">
            <input type="text" class="form-control" id="name"/>

        </div>
        <div class="form-group">
            <input type="text" class="form-control" id="value"/>
        </div>

        <button type="button" class="btn btn-default" onclick="searchElasticsearch();">Search ElasticSearch</button>
        <p></p>

        <div id="esResult"></div>
    </div>
</div>

</div>

<script type="text/javascript">
    jQuery(document).ready(function () {
    });

    function searchSolr() {
        jQuery('#solrResult').html('');
        Fluxion.doAjax(
                'wisControllerHelperService',
                'searchSolr',
                {
                    'searchStr': jQuery('#searchStr').val(),
                    'url': ajaxurl
                },
                {
                    'doOnSuccess': function (json) {
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
    function searchElasticsearch() {
        jQuery('#solrResult').html('');
        Fluxion.doAjax(
                'wisControllerHelperService',
                'searchElasticSearch',
                {
                    'name': jQuery('#name').val(),
                    'value': jQuery('#value').val(),
                    'url': ajaxurl
                },
                {
                    'doOnSuccess': function (json) {
                        jQuery('#esResult').append(json.toString());
                        alert(json);
                        console.log(json);
                    }
                }
        );
    }

</script>

<%@ include file="footer.jsp" %>