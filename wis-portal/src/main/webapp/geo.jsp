<%@ include file="header.jsp" %>

<div class="container center-block">

    <div class="jumbotron">
        <h2>GeoJSON and Leaflet</h2>


        <div id="sheetformdiv" class="simplebox ui-corner-all">
            <table class="in">
                <tr>
                    <td>
                        <form method='post'
                              id='sheet_upload_form'
                              action='<c:url value="/wis-portal/upload/importyr/sheet"/>'
                              enctype="multipart/form-data"
                              target="form_target_upload"
                              onsubmit="Utils.fileUpload.fileUploadProgress('sheet_upload_form', 'statusdiv', sheetUploadSuccess);">
                            <input type="file" name="file"/>
                            <button type="submit" class="br-button ui-state-default ui-corner-all">Upload</button>
                            <button type="button" class="br-button ui-state-default ui-corner-all"
                                    onclick="cancelSheetUpload();">Cancel
                            </button>
                        </form>
                    </td>
                </tr>
            </table>
        </div>
        <div id="statusdiv"></div>
    </div>

        <p></p>

        <div id="map"></div>

    </div>
</div>

</div>

<script type="text/javascript">

    jQuery(document).ready(function () {
    });

    function sheetUploadSuccess(json) {
        jQuery('#statusdiv').html("Processing...");
        processSheetUpload(json.frameId);
    }

    function cancelSheetUpload() {
        jQuery('#sheetformdiv').css("display", "none");
    }

    function processSheetUpload(frameId){

        var iframe = document.getElementById(frameId);
        var iframedoc = iframe.document;
        if (iframe.contentDocument)
            iframedoc = iframe.contentDocument;
        else if (iframe.contentWindow)
            iframedoc = iframe.contentWindow.document;
        var response = jQuery(iframedoc).contents().find('body:first').find('#uploadresponsebody').val();
        jQuery('#result').html(response.toString());

    }

    var map = L.map('map').setView([52.621615, 1.219470], 12);

    L.tileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
        maxZoom: 18
//        id: 'mapbox.streets',
//        accessToken: 'pk.eyJ1IjoiYmlhbnhpbmdkb25nIiwiYSI6ImUyY2YxYzZkYzk4MGMwMTNmOTg3ZDk4NmRhZWMxMTgwIn0.NUz8YeHedm4Jqm9fcq-f7A'
    }).addTo(map);

    var marker = L.marker([52.621615, 1.219]).addTo(map);

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


    marker.bindPopup("TGAC");
    circle.bindPopup("West of TGAC");
    circle1.bindPopup("East of TGAC");
    polygon.bindPopup("South of TGAC");
    square.bindPopup("North of TGAC");

</script>

<%@ include file="footer.jsp" %>