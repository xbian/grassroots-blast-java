<%@ include file="header.jsp" %>

<div class="container center-block">

    <%--<div class="jumbotron">--%>
        <h2>Yellow Rust Map</h2>

        <div class="row">
            <div class="col-lg-6">
                <div class="input-group">
                    <input type="checkbox" value="2014"/> 2014
                    <input type="checkbox" value="2015"/> 2015
                </div>
            </div>
        </div>
        <br/>

        <div class="row">
            <div class="col-lg-6">

                <div class="input-group">
            <span class="input-group-btn">
                <button type="button" class="btn btn-default" onclick="addRandomPointer();">Add Random Pointer</button>
                <button type="button" class="btn btn-default" onclick="removePointers();">Remove Pointers</button>
            </span>
                    <input type="text" class="form-control" size="20"
                           placeholder="Search"/>
                </div>
            </div>
        </div>
        <br/><br/>

        <div id="map"></div>


    <%--</div>--%>
</div>
</div>

</div>

<script type="text/javascript">

    jQuery(document).ready(function () {
    });


    var markers = new Array();

    //    var items = [{"lat":"51.000","lon":"13.000"},{"lat":"52.000","lon":"13.010"},{"lat":"52.000","lon":"13.020"}];


    function sheetUploadSuccess(json) {
        jQuery('#statusdiv').html("Processing...");
        processSheetUpload(json.frameId);
    }

    function cancelSheetUpload() {
        jQuery('#sheetformdiv').css("display", "none");
    }

    function processSheetUpload(frameId) {
        jQuery('#statusdiv').html("Processing...done");

        var iframe = document.getElementById(frameId);
        var iframedoc = iframe.document;
        if (iframe.contentDocument)
            iframedoc = iframe.contentDocument;
        else if (iframe.contentWindow)
            iframedoc = iframe.contentWindow.document;
        var response = jQuery(iframedoc).contents().find('body:first').find('#uploadresponsebody').val();
        if (!Utils.validation.isNullCheck(response)) {
            jQuery('#statusdiv').html(response.toString());
        }
        else {
            setTimeout(function () {
                processSheetUpload(frameId)
            }, 2000);
        }

    }

    var map = L.map('map').setView([52.621615, 10.219470], 5);

    L.tileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
        maxZoom: 18
//        id: 'mapbox.streets',
//        accessToken: 'pk.eyJ1IjoiYmlhbnhpbmdkb25nIiwiYSI6ImUyY2YxYzZkYzk4MGMwMTNmOTg3ZDk4NmRhZWMxMTgwIn0.NUz8YeHedm4Jqm9fcq-f7A'
    }).addTo(map);


    function addRandomPointer() {
        var la = randomIntFromInterval(45, 60);
        var lo = randomIntFromInterval(0, 25);

        addPointer(la, lo, "Hey, random!");

    }

    //    var marker = L.marker([la, lo]).addTo(map).bindPopup(note);

    function addPointer(la, lo, note) {
        var markerLayer = L.marker([la, lo]).bindPopup(note);
        markers.push(markerLayer);
        map.addLayer(markerLayer);
    }

    function removePointers() {
        for (i = 0; i < markers.length; i++) {
            map.removeLayer(markers[i]);
        }
        markers = [];
    }


    var marker = L.marker([52.621615, 1.219]).addTo(map);
    //    var marker1 = L.marker([52.622616, 1.219]).addTo(map);
    //    var marker2 = L.marker([52.623617, 1.219]).addTo(map);
    //    var marker3 = L.marker([52.624618, 1.219]).addTo(map);
    //    var marker4 = L.marker([52.625619, 1.219]).addTo(map);
    //    var marker5 = L.marker([52.626620, 1.219]).addTo(map);
    //    var marker5 = L.marker([52.626620, 13.219]).addTo(map);

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

    var polygon = L.polygon([
        [52.61, 1.19],
        [52.61, 1.22],
        [52.59, 1.205]
    ]).addTo(map);

    var square = L.rectangle([
        [52.66, 1.19],
        [52.66, 1.22],
        [52.64, 1.19],
        [52.64, 1.22]
    ]).addTo(map);


    marker.bindPopup("TGAC, Cannot be removed!");
    marker5.bindPopup("somewhere");
    circle.bindPopup("West of TGAC");
    circle1.bindPopup("East of TGAC");
    polygon.bindPopup("South of TGAC");
    square.bindPopup("North of TGAC");


    function randomIntFromInterval(min, max) {
        return Math.floor(Math.random() * (max - min + 1) + min);
    }


</script>

<%@ include file="footer.jsp" %>