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
    });

    var map = L.map('map').setView([52.621615, 1.219470], 13);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery &copy; <a href="http://mapbox.com">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox.streets',
        accessToken: 'pk.eyJ1IjoiYmlhbnhpbmdkb25nIiwiYSI6ImUyY2YxYzZkYzk4MGMwMTNmOTg3ZDk4NmRhZWMxMTgwIn0.NUz8YeHedm4Jqm9fcq-f7A'
    }).addTo(map);
    var marker = L.marker([52.621615, 1.219470]).addTo(map);
    var circle = L.circle([52.621615, 1.20], 500, {
        color: 'red',
        fillColor: '#f03',
        fillOpacity: 0.5
    }).addTo(map);
    var circle1 = L.circle([52.621615, 1.23], 200, {
        color: 'green',
        fillColor: 'green',
        fillOpacity: 0.5
    }).addTo(map);

</script>

<%@ include file="footer.jsp" %>