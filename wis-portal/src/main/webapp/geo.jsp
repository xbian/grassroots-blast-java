<%@ include file="header.jsp" %>

<div class="container center-block">

    <div class="jumbotron">
        <h2>Wheat Information System GeoJSON and Leaflet</h2>

        <p></p>

        <div id="map"></div>

    </div>
</div>

</div>

<script type="text/javascript">

    jQuery(document).ready(function () {
        getBlastDBs();
    });
</script>

<%@ include file="footer.jsp" %>