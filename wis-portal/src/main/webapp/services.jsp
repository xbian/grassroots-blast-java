<%@ include file="header.jsp" %>

<meta http-equiv="refresh" content="0; url=https://grassroots.tools/#services" />
<div class="container center-block">

    <div class="jumbotron">
        <h2>Grassroots Infrastructure Services</h2>
        <p>The Grassroots Infrastructure has been developed to expose a number of important and powerful technologies that can benefit
        researchers and developers to realise their data management needs.</p>

        <p>Existing services:</p>

        <ul>
            <li><a href="<c:url value='/grassroots-portal/blast'/>">Blast searches on HPC</a></li>
            <li>iRODS file management</li>
            <li>Solr / ElasticSearch indexers</li>
            <li><a href="/yellowrust-map">Geo-location information</a></li>
        </ul>

    </div>
</div>

<script type="text/javascript">
    jQuery(document).ready(function () {
    });

</script>

<%@ include file="footer.jsp" %>