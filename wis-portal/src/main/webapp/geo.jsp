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
                <button type="button" class="btn btn-default" onclick="popup('hello! this is a popup.');">Popup</button>
                <button type="button" class="btn btn-default"
                        onclick="mapFitBounds([[49.781264,-7.910156],[61.100789, -0.571289]]);">Bound UK
                </button>
                <button type="button" class="btn btn-default"
                        onclick="mapFitBounds([[36.738884,-14.765625],[56.656226, 32.34375]]);">Bound Europe
                </button>
            </span>
            </div>
        </div>
        <div class="col-lg-6">
            <input type="text" class="form-control" size="20"
                   placeholder="Search"/>
        </div>
    </div>
        <br/>
    <div class="row">
        <div class="col-lg-6">

            <div class="input-group">
            <span class="input-group-btn">
                <button type="button" class="btn btn-default" onclick="displayYRLocationsNoDetails();">Magic</button>
            </span>
            </div>
        </div>
        <div class="col-lg-6">
        </div>
    </div>
    <br/><br/>

    <div id="map"></div>

</div>
</div>

</div>

<script type="text/javascript">

    jQuery(document).ready(function () {
    });

    var markers = new Array();

    var markersGroup = new L.MarkerClusterGroup();

    var map = L.map('map').setView([52.621615, 10.219470], 5);

    L.tileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
        maxZoom: 18
//        id: 'mapbox.streets',
//        accessToken: 'pk.eyJ1IjoiYmlhbnhpbmdkb25nIiwiYSI6ImUyY2YxYzZkYzk4MGMwMTNmOTg3ZDk4NmRhZWMxMTgwIn0.NUz8YeHedm4Jqm9fcq-f7A'
    }).addTo(map);

    function displayYRLocationsNoDetails() {
        var results = location_list['results'];
        console.log(results);
        for (i = 0; i < results.length; i++) {
            var la = results[i]['location']['latitude'];
            var lo = results[i]['location']['longitude'];

            addPointer(la, lo, "YR la: " + la + " lo: " + lo);
        }
    }

    function addRandomPointer() {
        var la = randomNumberFromInterval(45, 60);
        var lo = randomNumberFromInterval(0, 25);

        addPointer(la, lo, "Hey, random! la: " + la + " lo: " + lo);
    }

    //    var marker = L.marker([la, lo]).addTo(map).bindPopup(note);

    function addPointer(la, lo, note) {
        var markerLayer = L.marker([la, lo]).bindPopup(note);
        markers.push(markerLayer);
//        map.addLayer(markerLayer);
        markersGroup.addLayer(markerLayer);
        map.addLayer(markersGroup);
    }

    function removePointers() {
//        for (i = 0; i < markers.length; i++) {
//            map.removeLayer(markers[i]);
//        }
//        markers = [];
        map.removeLayer(markersGroup);
        markersGroup = new L.MarkerClusterGroup();
    }

    function popup(msg) {
        L.popup()
                .setLatLng([52.621615, 8.219])
                .setContent(msg)
                .openOn(map);
    }

    function mapFitBounds(list) {
        map.fitBounds(list);
    }


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

    marker.bindPopup("TGAC, Cannot be removed!");
    circle.bindPopup("West of TGAC");
    circle1.bindPopup("East of TGAC");
    polygon.bindPopup("South of TGAC");
    square.bindPopup("North of TGAC");

    function randomNumberFromInterval(min, max) {
        return Math.random() * (max - min + 1) + min;
    }


    var location_list = {
        "results": [
            {
                "_id": {
                    "$oid": "55f052a66ca5bb47f62bdd01"
                },
                "ID": "14.0001",
                "location": {
                    "east_bound": 19.4480523,
                    "latitude": 45.1,
                    "longitude": 15.2,
                    "south_bound": 42.3924451,
                    "north_bound": 46.5552234,
                    "west_bound": 13.4896912
                }
            },
            {
                "_id": {
                    "$oid": "55f052aa6ca5bb47f62bdd03"
                },
                "ID": "14.0003",
                "location": {
                    "east_bound": 17.9931076,
                    "latitude": 49.7033115,
                    "longitude": 17.9725365,
                    "south_bound": 49.6866417,
                    "north_bound": 49.726421,
                    "west_bound": 17.935725
                }
            },
            {
                "_id": {
                    "$oid": "55f052ab6ca5bb47f62bdd05"
                },
                "ID": "14.0004",
                "location": {
                    "east_bound": 2.889854,
                    "latitude": 49.834103,
                    "longitude": 2.868337,
                    "south_bound": 49.819147,
                    "north_bound": 49.8431391,
                    "west_bound": 2.8476749
                }
            },
            {
                "_id": {
                    "$oid": "55f052ab6ca5bb47f62bdd07"
                },
                "ID": "14.0005",
                "location": {
                    "east_bound": 2.889854,
                    "latitude": 49.834103,
                    "longitude": 2.868337,
                    "south_bound": 49.819147,
                    "north_bound": 49.8431391,
                    "west_bound": 2.8476749
                }
            },
            {
                "_id": {
                    "$oid": "55f052ab6ca5bb47f62bdd09"
                },
                "ID": "14.0006",
                "location": {
                    "east_bound": 2.889854,
                    "latitude": 49.834103,
                    "longitude": 2.868337,
                    "south_bound": 49.819147,
                    "north_bound": 49.8431391,
                    "west_bound": 2.8476749
                }
            },
            {
                "_id": {
                    "$oid": "55f052ab6ca5bb47f62bdd0b"
                },
                "ID": "14.0007",
                "location": {
                    "east_bound": 4.3358174,
                    "latitude": 49.2949709,
                    "longitude": 4.31981,
                    "south_bound": 49.2876935,
                    "north_bound": 49.3022472,
                    "west_bound": 4.3038026
                }
            },
            {
                "_id": {
                    "$oid": "55f052ab6ca5bb47f62bdd0d"
                },
                "ID": "14.0008",
                "location": {
                    "latitude": 48.098662,
                    "longitude": 14.901602
                }
            },
            {
                "_id": {
                    "$oid": "55f052ab6ca5bb47f62bdd0f"
                },
                "ID": "14.0009",
                "location": {
                    "latitude": 48.098662,
                    "longitude": 14.901602
                }
            },
            {
                "_id": {
                    "$oid": "55f052ac6ca5bb47f62bdd11"
                },
                "ID": "14.0010",
                "location": {
                    "east_bound": 16.7851765,
                    "latitude": 52.0398736,
                    "longitude": 16.7691691,
                    "south_bound": 52.0330096,
                    "north_bound": 52.0467365,
                    "west_bound": 16.7531617
                }
            },
            {
                "_id": {
                    "$oid": "55f052ac6ca5bb47f62bdd13"
                },
                "ID": "14.0011",
                "location": {
                    "east_bound": 19.4480523,
                    "latitude": 45.1,
                    "longitude": 15.2,
                    "south_bound": 42.3924451,
                    "north_bound": 46.5552234,
                    "west_bound": 13.4896912
                }
            },
            {
                "_id": {
                    "$oid": "55f052ac6ca5bb47f62bdd15"
                },
                "ID": "14.0012",
                "location": {
                    "east_bound": 19.4480523,
                    "latitude": 45.1,
                    "longitude": 15.2,
                    "south_bound": 42.3924451,
                    "north_bound": 46.5552234,
                    "west_bound": 13.4896912
                }
            },
            {
                "_id": {
                    "$oid": "55f052ac6ca5bb47f62bdd17"
                },
                "ID": "14.0013",
                "location": {
                    "east_bound": 19.4480523,
                    "latitude": 45.1,
                    "longitude": 15.2,
                    "south_bound": 42.3924451,
                    "north_bound": 46.5552234,
                    "west_bound": 13.4896912
                }
            },
            {
                "_id": {
                    "$oid": "55f052ac6ca5bb47f62bdd19"
                },
                "ID": "14.0014",
                "location": {
                    "east_bound": -2.339808,
                    "latitude": 47.937204,
                    "longitude": -2.361053,
                    "south_bound": 47.932304,
                    "north_bound": 47.946235,
                    "west_bound": -2.3748041
                }
            },
            {
                "_id": {
                    "$oid": "55f052ad6ca5bb47f62bdd1b"
                },
                "ID": "14.0015",
                "location": {
                    "east_bound": -2.5243591,
                    "latitude": 47.9382639,
                    "longitude": -2.566119,
                    "south_bound": 47.878771,
                    "north_bound": 47.97126,
                    "west_bound": -2.6561681
                }
            },
            {
                "_id": {
                    "$oid": "55f052ad6ca5bb47f62bdd1d"
                },
                "ID": "14.0016",
                "location": {
                    "east_bound": -2.3034679,
                    "latitude": 47.988202,
                    "longitude": -2.3816639,
                    "south_bound": 47.956971,
                    "north_bound": 48.030921,
                    "west_bound": -2.4458331
                }
            },
            {
                "_id": {
                    "$oid": "55f052ad6ca5bb47f62bdd1f"
                },
                "ID": "14.0017",
                "location": {
                    "east_bound": -1.2767089,
                    "latitude": 51.154214,
                    "longitude": -1.335825,
                    "south_bound": 51.123026,
                    "north_bound": 51.1970003,
                    "west_bound": -1.3777775
                }
            },
            {
                "_id": {
                    "$oid": "55f052ad6ca5bb47f62bdd21"
                },
                "ID": "14.0018",
                "location": {
                    "east_bound": -1.2767089,
                    "latitude": 51.154214,
                    "longitude": -1.335825,
                    "south_bound": 51.123026,
                    "north_bound": 51.1970003,
                    "west_bound": -1.3777775
                }
            },
            {
                "_id": {
                    "$oid": "55f052b16ca5bb47f62bdd23"
                },
                "ID": "14.0024",
                "location": {
                    "east_bound": 18.9888746,
                    "latitude": 53.7263529,
                    "longitude": 18.9323043,
                    "south_bound": 53.6847476,
                    "north_bound": 53.7561068,
                    "west_bound": 18.9014003
                }
            },
            {
                "_id": {
                    "$oid": "55f052b16ca5bb47f62bdd25"
                },
                "ID": "14.0025",
                "location": {
                    "east_bound": 18.9888746,
                    "latitude": 53.7263529,
                    "longitude": 18.9323043,
                    "south_bound": 53.6847476,
                    "north_bound": 53.7561068,
                    "west_bound": 18.9014003
                }
            },
            {
                "_id": {
                    "$oid": "55f052b16ca5bb47f62bdd27"
                },
                "ID": "14.0026",
                "location": {
                    "east_bound": 17.32554,
                    "latitude": 52.22908,
                    "longitude": 17.27607,
                    "south_bound": 52.2083301,
                    "north_bound": 52.25333,
                    "west_bound": 17.23504
                }
            },
            {
                "_id": {
                    "$oid": "55f052b16ca5bb47f62bdd29"
                },
                "ID": "14.0027",
                "location": {
                    "east_bound": 17.32554,
                    "latitude": 52.22908,
                    "longitude": 17.27607,
                    "south_bound": 52.2083301,
                    "north_bound": 52.25333,
                    "west_bound": 17.23504
                }
            },
            {
                "_id": {
                    "$oid": "55f052b16ca5bb47f62bdd2b"
                },
                "ID": "14.0028",
                "location": {
                    "east_bound": 17.32554,
                    "latitude": 52.22908,
                    "longitude": 17.27607,
                    "south_bound": 52.2083301,
                    "north_bound": 52.25333,
                    "west_bound": 17.23504
                }
            },
            {
                "_id": {
                    "$oid": "55f052b26ca5bb47f62bdd2d"
                },
                "ID": "14.0029",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052b26ca5bb47f62bdd2f"
                },
                "ID": "14.0030",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052b26ca5bb47f62bdd31"
                },
                "ID": "14.0031",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052b26ca5bb47f62bdd33"
                },
                "ID": "14.0032",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052b26ca5bb47f62bdd35"
                },
                "ID": "14.0033",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052b36ca5bb47f62bdd37"
                },
                "ID": "14.0034",
                "location": {
                    "east_bound": 19.4480523,
                    "latitude": 45.1,
                    "longitude": 15.2,
                    "south_bound": 42.3924451,
                    "north_bound": 46.5552234,
                    "west_bound": 13.4896912
                }
            },
            {
                "_id": {
                    "$oid": "55f052b36ca5bb47f62bdd39"
                },
                "ID": "14.0035",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052b36ca5bb47f62bdd3b"
                },
                "ID": "14.0036",
                "location": {
                    "east_bound": 13.1969709,
                    "latitude": 51.0495315,
                    "longitude": 13.1892088,
                    "south_bound": 51.0446356,
                    "north_bound": 51.052895,
                    "west_bound": 13.1599452
                }
            },
            {
                "_id": {
                    "$oid": "55f052b36ca5bb47f62bdd3d"
                },
                "ID": "14.0037",
                "location": {
                    "east_bound": 13.1969709,
                    "latitude": 51.0495315,
                    "longitude": 13.1892088,
                    "south_bound": 51.0446356,
                    "north_bound": 51.052895,
                    "west_bound": 13.1599452
                }
            },
            {
                "_id": {
                    "$oid": "55f052b46ca5bb47f62bdd3f"
                },
                "ID": "14.0038",
                "location": {
                    "east_bound": 13.1969709,
                    "latitude": 51.0495315,
                    "longitude": 13.1892088,
                    "south_bound": 51.0446356,
                    "north_bound": 51.052895,
                    "west_bound": 13.1599452
                }
            },
            {
                "_id": {
                    "$oid": "55f052b46ca5bb47f62bdd41"
                },
                "ID": "14.0039",
                "location": {
                    "east_bound": 9.1892683802915,
                    "latitude": 52.823762,
                    "longitude": 9.1878063,
                    "south_bound": 52.8224789197085,
                    "north_bound": 52.8251768802915,
                    "west_bound": 9.1865704197085
                }
            },
            {
                "_id": {
                    "$oid": "55f052b46ca5bb47f62bdd43"
                },
                "ID": "14.0040",
                "location": {
                    "east_bound": 9.1892683802915,
                    "latitude": 52.823762,
                    "longitude": 9.1878063,
                    "south_bound": 52.8224789197085,
                    "north_bound": 52.8251768802915,
                    "west_bound": 9.1865704197085
                }
            },
            {
                "_id": {
                    "$oid": "55f052b46ca5bb47f62bdd45"
                },
                "ID": "14.0041",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052b56ca5bb47f62bdd47"
                },
                "ID": "14.0042",
                "location": {
                    "east_bound": 9.5509864,
                    "latitude": 52.3560174,
                    "longitude": 9.5446879,
                    "south_bound": 52.35408,
                    "north_bound": 52.35729,
                    "west_bound": 9.54129
                }
            },
            {
                "_id": {
                    "$oid": "55f052b56ca5bb47f62bdd49"
                },
                "ID": "14.0043",
                "location": {
                    "east_bound": 11.9774439,
                    "latitude": 48.3416234,
                    "longitude": 11.9729206,
                    "south_bound": 48.3391976,
                    "north_bound": 48.3441806,
                    "west_bound": 11.9686056
                }
            },
            {
                "_id": {
                    "$oid": "55f052b56ca5bb47f62bdd4b"
                },
                "ID": "14.0044",
                "location": {
                    "east_bound": 12.6141579,
                    "latitude": 48.8124703,
                    "longitude": 12.6116722,
                    "south_bound": 48.810814,
                    "north_bound": 48.8145265,
                    "west_bound": 12.6094865
                }
            },
            {
                "_id": {
                    "$oid": "55f052b56ca5bb47f62bdd4d"
                },
                "ID": "14.0045",
                "location": {
                    "east_bound": 15.8622646,
                    "latitude": 49.9497244,
                    "longitude": 15.7950578,
                    "south_bound": 49.9091753,
                    "north_bound": 49.9851863,
                    "west_bound": 15.7500095
                }
            },
            {
                "_id": {
                    "$oid": "55f052b66ca5bb47f62bdd4f"
                },
                "ID": "14.0046",
                "location": {
                    "east_bound": 1.788466,
                    "latitude": 47.935644,
                    "longitude": 1.764464,
                    "south_bound": 47.9170949,
                    "north_bound": 47.966879,
                    "west_bound": 1.7121209
                }
            },
            {
                "_id": {
                    "$oid": "55f052b66ca5bb47f62bdd51"
                },
                "ID": "14.0047",
                "location": {
                    "east_bound": 1.788466,
                    "latitude": 47.935644,
                    "longitude": 1.764464,
                    "south_bound": 47.9170949,
                    "north_bound": 47.966879,
                    "west_bound": 1.7121209
                }
            },
            {
                "_id": {
                    "$oid": "55f052b66ca5bb47f62bdd53"
                },
                "ID": "14.0048",
                "location": {
                    "east_bound": 24.1458931,
                    "latitude": 51.919438,
                    "longitude": 19.145136,
                    "south_bound": 49.0020252,
                    "north_bound": 54.835784,
                    "west_bound": 14.1228641
                }
            },
            {
                "_id": {
                    "$oid": "55f052b66ca5bb47f62bdd55"
                },
                "ID": "14.0049",
                "location": {
                    "east_bound": 24.1458931,
                    "latitude": 51.919438,
                    "longitude": 19.145136,
                    "south_bound": 49.0020252,
                    "north_bound": 54.835784,
                    "west_bound": 14.1228641
                }
            },
            {
                "_id": {
                    "$oid": "55f052b66ca5bb47f62bdd57"
                },
                "ID": "14.0050",
                "location": {
                    "east_bound": 24.1458931,
                    "latitude": 51.919438,
                    "longitude": 19.145136,
                    "south_bound": 49.0020252,
                    "north_bound": 54.835784,
                    "west_bound": 14.1228641
                }
            },
            {
                "_id": {
                    "$oid": "55f052b76ca5bb47f62bdd59"
                },
                "ID": "14.0051",
                "location": {
                    "east_bound": 1.8282989,
                    "latitude": 48.327838,
                    "longitude": 1.788206,
                    "south_bound": 48.2988601,
                    "north_bound": 48.354796,
                    "west_bound": 1.758415
                }
            },
            {
                "_id": {
                    "$oid": "55f052b76ca5bb47f62bdd5b"
                },
                "ID": "14.0052",
                "location": {
                    "east_bound": 2.5395399,
                    "latitude": 44.359977,
                    "longitude": 2.505311,
                    "south_bound": 44.3300331,
                    "north_bound": 44.38948,
                    "west_bound": 2.408613
                }
            },
            {
                "_id": {
                    "$oid": "55f052b76ca5bb47f62bdd5d"
                },
                "ID": "14.0053",
                "location": {
                    "east_bound": 10.8555079,
                    "latitude": 51.8619255,
                    "longitude": 10.8482023,
                    "south_bound": 51.8565769,
                    "north_bound": 51.8652726,
                    "west_bound": 10.8397799
                }
            },
            {
                "_id": {
                    "$oid": "55f052b76ca5bb47f62bdd5f"
                },
                "ID": "14.0054",
                "location": {
                    "east_bound": 1.8282989,
                    "latitude": 48.327838,
                    "longitude": 1.788206,
                    "south_bound": 48.2988601,
                    "north_bound": 48.354796,
                    "west_bound": 1.758415
                }
            },
            {
                "_id": {
                    "$oid": "55f052b86ca5bb47f62bdd61"
                },
                "ID": "14.0055",
                "location": {
                    "east_bound": 1.8282989,
                    "latitude": 48.327838,
                    "longitude": 1.788206,
                    "south_bound": 48.2988601,
                    "north_bound": 48.354796,
                    "west_bound": 1.758415
                }
            },
            {
                "_id": {
                    "$oid": "55f052b86ca5bb47f62bdd63"
                },
                "ID": "14.0056",
                "location": {
                    "east_bound": 10.8555079,
                    "latitude": 51.8619255,
                    "longitude": 10.8482023,
                    "south_bound": 51.8565769,
                    "north_bound": 51.8652726,
                    "west_bound": 10.8397799
                }
            },
            {
                "_id": {
                    "$oid": "55f052b86ca5bb47f62bdd65"
                },
                "ID": "14.0057",
                "location": {
                    "east_bound": 1.8282989,
                    "latitude": 48.327838,
                    "longitude": 1.788206,
                    "south_bound": 48.2988601,
                    "north_bound": 48.354796,
                    "west_bound": 1.758415
                }
            },
            {
                "_id": {
                    "$oid": "55f052b86ca5bb47f62bdd67"
                },
                "ID": "14.0058",
                "location": {
                    "east_bound": 1.8282989,
                    "latitude": 48.327838,
                    "longitude": 1.788206,
                    "south_bound": 48.2988601,
                    "north_bound": 48.354796,
                    "west_bound": 1.758415
                }
            },
            {
                "_id": {
                    "$oid": "55f052b86ca5bb47f62bdd69"
                },
                "ID": "14.0059",
                "location": {
                    "east_bound": 17.3960271,
                    "latitude": 49.593778,
                    "longitude": 17.2508787,
                    "south_bound": 49.5329452,
                    "north_bound": 49.6546554,
                    "west_bound": 17.1630437
                }
            },
            {
                "_id": {
                    "$oid": "55f052b96ca5bb47f62bdd6b"
                },
                "ID": "14.0060",
                "location": {
                    "east_bound": 17.3960271,
                    "latitude": 49.593778,
                    "longitude": 17.2508787,
                    "south_bound": 49.5329452,
                    "north_bound": 49.6546554,
                    "west_bound": 17.1630437
                }
            },
            {
                "_id": {
                    "$oid": "55f052b96ca5bb47f62bdd6d"
                },
                "ID": "14.0061",
                "location": {
                    "east_bound": 17.3960271,
                    "latitude": 49.593778,
                    "longitude": 17.2508787,
                    "south_bound": 49.5329452,
                    "north_bound": 49.6546554,
                    "west_bound": 17.1630437
                }
            },
            {
                "_id": {
                    "$oid": "55f052b96ca5bb47f62bdd6f"
                },
                "ID": "14.0062",
                "location": {
                    "east_bound": 2.5395399,
                    "latitude": 44.359977,
                    "longitude": 2.505311,
                    "south_bound": 44.3300331,
                    "north_bound": 44.38948,
                    "west_bound": 2.408613
                }
            },
            {
                "_id": {
                    "$oid": "55f052b96ca5bb47f62bdd71"
                },
                "ID": "14.0063",
                "location": {
                    "east_bound": 2.5395399,
                    "latitude": 44.359977,
                    "longitude": 2.505311,
                    "south_bound": 44.3300331,
                    "north_bound": 44.38948,
                    "west_bound": 2.408613
                }
            },
            {
                "_id": {
                    "$oid": "55f052b96ca5bb47f62bdd73"
                },
                "ID": "14.0064",
                "location": {
                    "east_bound": 1.8282989,
                    "latitude": 48.327838,
                    "longitude": 1.788206,
                    "south_bound": 48.2988601,
                    "north_bound": 48.354796,
                    "west_bound": 1.758415
                }
            },
            {
                "_id": {
                    "$oid": "55f052ba6ca5bb47f62bdd75"
                },
                "ID": "14.0065",
                "location": {
                    "east_bound": 5.3110356,
                    "latitude": 51.8319019,
                    "longitude": 5.2793557,
                    "south_bound": 51.8209698,
                    "north_bound": 51.8572119,
                    "west_bound": 5.2670501
                }
            },
            {
                "_id": {
                    "$oid": "55f052ba6ca5bb47f62bdd77"
                },
                "ID": "14.0066",
                "location": {
                    "east_bound": 4.9384056,
                    "latitude": 51.8081653,
                    "longitude": 4.891848,
                    "south_bound": 51.7202495,
                    "north_bound": 51.8249676,
                    "west_bound": 4.6762966
                }
            },
            {
                "_id": {
                    "$oid": "55f052ba6ca5bb47f62bdd79"
                },
                "ID": "14.0067",
                "location": {
                    "east_bound": 5.8162936,
                    "latitude": 52.4552356,
                    "longitude": 5.692693,
                    "south_bound": 52.3704981,
                    "north_bound": 52.4999011,
                    "west_bound": 5.56504
                }
            },
            {
                "_id": {
                    "$oid": "55f052ba6ca5bb47f62bdd7b"
                },
                "ID": "14.0068",
                "location": {
                    "east_bound": 5.6059638,
                    "latitude": 52.518537,
                    "longitude": 5.471422,
                    "south_bound": 52.3843956,
                    "north_bound": 52.6928126,
                    "west_bound": 5.2584712
                }
            },
            {
                "_id": {
                    "$oid": "55f052bb6ca5bb47f62bdd7d"
                },
                "ID": "14.0076",
                "location": {
                    "east_bound": 11.4974325,
                    "latitude": 44.4482151,
                    "longitude": 11.4672909,
                    "south_bound": 44.43269,
                    "north_bound": 44.4532301,
                    "west_bound": 11.4603948
                }
            },
            {
                "_id": {
                    "$oid": "55f052bb6ca5bb47f62bdd7f"
                },
                "ID": "14.0077",
                "location": {
                    "east_bound": 11.8426886,
                    "latitude": 44.5151005,
                    "longitude": 11.8285289,
                    "south_bound": 44.5023545,
                    "north_bound": 44.5205233,
                    "west_bound": 11.8173704
                }
            },
            {
                "_id": {
                    "$oid": "55f052bb6ca5bb47f62bdd81"
                },
                "ID": "14.0078",
                "location": {
                    "east_bound": 8.3369037,
                    "latitude": 49.4743257,
                    "longitude": 8.3291758,
                    "south_bound": 49.4662254,
                    "north_bound": 49.4816991,
                    "west_bound": 8.3181314
                }
            },
            {
                "_id": {
                    "$oid": "55f052bb6ca5bb47f62bdd83"
                },
                "ID": "14.0079",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052bb6ca5bb47f62bdd85"
                },
                "ID": "14.0080",
                "location": {
                    "east_bound": 8.3369037,
                    "latitude": 49.4743257,
                    "longitude": 8.3291758,
                    "south_bound": 49.4662254,
                    "north_bound": 49.4816991,
                    "west_bound": 8.3181314
                }
            },
            {
                "_id": {
                    "$oid": "55f052bc6ca5bb47f62bdd87"
                },
                "ID": "14.0081",
                "location": {
                    "east_bound": 6.6317787,
                    "latitude": 51.0183609,
                    "longitude": 6.6282129,
                    "south_bound": 51.0162460197085,
                    "north_bound": 51.0189439802915,
                    "west_bound": 6.6231467
                }
            },
            {
                "_id": {
                    "$oid": "55f052bc6ca5bb47f62bdd89"
                },
                "ID": "14.0082",
                "location": {
                    "east_bound": 6.6317787,
                    "latitude": 51.0183609,
                    "longitude": 6.6282129,
                    "south_bound": 51.0162460197085,
                    "north_bound": 51.0189439802915,
                    "west_bound": 6.6231467
                }
            },
            {
                "_id": {
                    "$oid": "55f052bc6ca5bb47f62bdd8b"
                },
                "ID": "14.0083",
                "location": {
                    "east_bound": 8.3798176,
                    "latitude": 49.3609433,
                    "longitude": 8.3229786,
                    "south_bound": 49.3160238,
                    "north_bound": 49.4053318,
                    "west_bound": 8.2670589
                }
            },
            {
                "_id": {
                    "$oid": "55f052bc6ca5bb47f62bdd8d"
                },
                "ID": "14.0084",
                "location": {
                    "east_bound": 12.3899742,
                    "latitude": 51.1534049,
                    "longitude": 12.2833389,
                    "south_bound": 51.0902314,
                    "north_bound": 51.1831438,
                    "west_bound": 12.2202744
                }
            },
            {
                "_id": {
                    "$oid": "55f052bc6ca5bb47f62bdd8f"
                },
                "ID": "14.0085",
                "location": {
                    "east_bound": 12.3899742,
                    "latitude": 51.1534049,
                    "longitude": 12.2833389,
                    "south_bound": 51.0902314,
                    "north_bound": 51.1831438,
                    "west_bound": 12.2202744
                }
            },
            {
                "_id": {
                    "$oid": "55f052bd6ca5bb47f62bdd91"
                },
                "ID": "14.0086",
                "location": {
                    "east_bound": 11.1423731,
                    "latitude": 51.19551,
                    "longitude": 11.06812,
                    "south_bound": 51.1700795,
                    "north_bound": 51.2283898,
                    "west_bound": 10.9727872
                }
            },
            {
                "_id": {
                    "$oid": "55f052bd6ca5bb47f62bdd93"
                },
                "ID": "14.0087",
                "location": {
                    "east_bound": 11.1423731,
                    "latitude": 51.19551,
                    "longitude": 11.06812,
                    "south_bound": 51.1700795,
                    "north_bound": 51.2283898,
                    "west_bound": 10.9727872
                }
            },
            {
                "_id": {
                    "$oid": "55f052bd6ca5bb47f62bdd95"
                },
                "ID": "14.0088",
                "location": {
                    "east_bound": 11.1423731,
                    "latitude": 51.19551,
                    "longitude": 11.06812,
                    "south_bound": 51.1700795,
                    "north_bound": 51.2283898,
                    "west_bound": 10.9727872
                }
            },
            {
                "_id": {
                    "$oid": "55f052bd6ca5bb47f62bdd97"
                },
                "ID": "14.0089",
                "location": {
                    "east_bound": 9.3873997,
                    "latitude": 48.6489361,
                    "longitude": 9.3846809,
                    "south_bound": 48.6475793197085,
                    "north_bound": 48.6502772802915,
                    "west_bound": 9.3824947
                }
            },
            {
                "_id": {
                    "$oid": "55f052be6ca5bb47f62bdd99"
                },
                "ID": "14.0090",
                "location": {
                    "east_bound": 10.9648589,
                    "latitude": 49.5403995,
                    "longitude": 10.9613024,
                    "south_bound": 49.537496,
                    "north_bound": 49.5455354,
                    "west_bound": 10.9558679
                }
            },
            {
                "_id": {
                    "$oid": "55f052be6ca5bb47f62bdd9b"
                },
                "ID": "14.0091",
                "location": {
                    "east_bound": 10.9648589,
                    "latitude": 49.5403995,
                    "longitude": 10.9613024,
                    "south_bound": 49.537496,
                    "north_bound": 49.5455354,
                    "west_bound": 10.9558679
                }
            },
            {
                "_id": {
                    "$oid": "55f052be6ca5bb47f62bdd9d"
                },
                "ID": "14.0092",
                "location": {
                    "east_bound": 19.469782,
                    "latitude": 48.5603755,
                    "longitude": 19.4191434,
                    "south_bound": 48.4820204,
                    "north_bound": 48.6277324,
                    "west_bound": 19.3666726
                }
            },
            {
                "_id": {
                    "$oid": "55f052be6ca5bb47f62bdd9f"
                },
                "ID": "14.0093",
                "location": {
                    "east_bound": 19.469782,
                    "latitude": 48.5603755,
                    "longitude": 19.4191434,
                    "south_bound": 48.4820204,
                    "north_bound": 48.6277324,
                    "west_bound": 19.3666726
                }
            },
            {
                "_id": {
                    "$oid": "55f052bf6ca5bb47f62bdda1"
                },
                "ID": "14.0094",
                "location": {
                    "east_bound": 9.5597934,
                    "latitude": 46.227638,
                    "longitude": 2.213749,
                    "south_bound": 41.3423276,
                    "north_bound": 51.0891658,
                    "west_bound": -5.1421419
                }
            },
            {
                "_id": {
                    "$oid": "55f052bf6ca5bb47f62bdda3"
                },
                "ID": "14.0095",
                "location": {
                    "east_bound": 2.7570899,
                    "latitude": 51.1055159,
                    "longitude": 2.6501419,
                    "south_bound": 51.0813299,
                    "north_bound": 51.14511,
                    "west_bound": 2.60417
                }
            },
            {
                "_id": {
                    "$oid": "55f052bf6ca5bb47f62bdda5"
                },
                "ID": "14.0096",
                "location": {
                    "east_bound": 3.4577501,
                    "latitude": 50.8129259,
                    "longitude": 3.332698,
                    "south_bound": 50.73748,
                    "north_bound": 50.82814,
                    "west_bound": 3.3048401
                }
            },
            {
                "_id": {
                    "$oid": "55f052bf6ca5bb47f62bdda7"
                },
                "ID": "14.0097",
                "location": {
                    "east_bound": 3.5232999,
                    "latitude": 50.7760145,
                    "longitude": 3.445404,
                    "south_bound": 50.74038,
                    "north_bound": 50.81466,
                    "west_bound": 3.39019
                }
            },
            {
                "_id": {
                    "$oid": "55f052bf6ca5bb47f62bdda9"
                },
                "ID": "14.0098",
                "location": {
                    "east_bound": 4.1691374,
                    "latitude": 50.528,
                    "longitude": 4.15313,
                    "south_bound": 50.5209063,
                    "north_bound": 50.5350926,
                    "west_bound": 4.1371226
                }
            },
            {
                "_id": {
                    "$oid": "55f052c06ca5bb47f62bddab"
                },
                "ID": "14.0101",
                "location": {
                    "east_bound": 44.8178449,
                    "latitude": 38.963745,
                    "longitude": 35.243322,
                    "south_bound": 35.808592,
                    "north_bound": 42.1062391,
                    "west_bound": 25.664893
                }
            },
            {
                "_id": {
                    "$oid": "55f052c06ca5bb47f62bddad"
                },
                "ID": "14.0102",
                "location": {
                    "east_bound": 44.8178449,
                    "latitude": 38.963745,
                    "longitude": 35.243322,
                    "south_bound": 35.808592,
                    "north_bound": 42.1062391,
                    "west_bound": 25.664893
                }
            },
            {
                "_id": {
                    "$oid": "55f052c06ca5bb47f62bddaf"
                },
                "ID": "14.0103",
                "location": {
                    "east_bound": 23.0063095,
                    "latitude": 44.016521,
                    "longitude": 21.005859,
                    "south_bound": 42.2315029,
                    "north_bound": 46.190032,
                    "west_bound": 18.8385221
                }
            },
            {
                "_id": {
                    "$oid": "55f052c16ca5bb47f62bddb1"
                },
                "ID": "14.0104",
                "location": {
                    "east_bound": 23.0063095,
                    "latitude": 44.016521,
                    "longitude": 21.005859,
                    "south_bound": 42.2315029,
                    "north_bound": 46.190032,
                    "west_bound": 18.8385221
                }
            },
            {
                "_id": {
                    "$oid": "55f052c16ca5bb47f62bddb3"
                },
                "ID": "14.0105",
                "location": {
                    "east_bound": -85.4354029,
                    "latitude": 43.4908606,
                    "longitude": -85.4439283,
                    "south_bound": 43.483625,
                    "north_bound": 43.4980229,
                    "west_bound": -85.455566
                }
            },
            {
                "_id": {
                    "$oid": "55f052c16ca5bb47f62bddb5"
                },
                "ID": "14.0106",
                "location": {
                    "east_bound": -85.4354029,
                    "latitude": 43.4908606,
                    "longitude": -85.4439283,
                    "south_bound": 43.483625,
                    "north_bound": 43.4980229,
                    "west_bound": -85.455566
                }
            },
            {
                "_id": {
                    "$oid": "55f052c26ca5bb47f62bddb7"
                },
                "ID": "14.0107",
                "location": {
                    "east_bound": -85.4354029,
                    "latitude": 43.4908606,
                    "longitude": -85.4439283,
                    "south_bound": 43.483625,
                    "north_bound": 43.4980229,
                    "west_bound": -85.455566
                }
            },
            {
                "_id": {
                    "$oid": "55f052c26ca5bb47f62bddb9"
                },
                "ID": "14.0108",
                "location": {
                    "east_bound": 9.5597934,
                    "latitude": 46.227638,
                    "longitude": 2.213749,
                    "south_bound": 41.3423276,
                    "north_bound": 51.0891658,
                    "west_bound": -5.1421419
                }
            },
            {
                "_id": {
                    "$oid": "55f052c26ca5bb47f62bddbb"
                },
                "ID": "14.0109",
                "location": {
                    "east_bound": 9.5597934,
                    "latitude": 46.227638,
                    "longitude": 2.213749,
                    "south_bound": 41.3423276,
                    "north_bound": 51.0891658,
                    "west_bound": -5.1421419
                }
            },
            {
                "_id": {
                    "$oid": "55f052c26ca5bb47f62bddbd"
                },
                "ID": "14.0110",
                "location": {
                    "east_bound": 9.5597934,
                    "latitude": 46.227638,
                    "longitude": 2.213749,
                    "south_bound": 41.3423276,
                    "north_bound": 51.0891658,
                    "west_bound": -5.1421419
                }
            },
            {
                "_id": {
                    "$oid": "55f052c26ca5bb47f62bddbf"
                },
                "ID": "14.0111",
                "location": {
                    "east_bound": 9.5597934,
                    "latitude": 46.227638,
                    "longitude": 2.213749,
                    "south_bound": 41.3423276,
                    "north_bound": 51.0891658,
                    "west_bound": -5.1421419
                }
            },
            {
                "_id": {
                    "$oid": "55f052c36ca5bb47f62bddc1"
                },
                "ID": "14.0112",
                "location": {
                    "east_bound": 9.5597934,
                    "latitude": 46.227638,
                    "longitude": 2.213749,
                    "south_bound": 41.3423276,
                    "north_bound": 51.0891658,
                    "west_bound": -5.1421419
                }
            },
            {
                "_id": {
                    "$oid": "55f052c36ca5bb47f62bddc3"
                },
                "ID": "14.0113",
                "location": {
                    "east_bound": 9.5597934,
                    "latitude": 46.227638,
                    "longitude": 2.213749,
                    "south_bound": 41.3423276,
                    "north_bound": 51.0891658,
                    "west_bound": -5.1421419
                }
            },
            {
                "_id": {
                    "$oid": "55f052c36ca5bb47f62bddc5"
                },
                "ID": "14.0114",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c36ca5bb47f62bddc7"
                },
                "ID": "14.0115",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c36ca5bb47f62bddc9"
                },
                "ID": "14.0116",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c46ca5bb47f62bddcb"
                },
                "ID": "14.0117",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c46ca5bb47f62bddcd"
                },
                "ID": "14.0118",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c46ca5bb47f62bddcf"
                },
                "ID": "14.0119",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c46ca5bb47f62bddd1"
                },
                "ID": "14.0120",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c46ca5bb47f62bddd3"
                },
                "ID": "14.0121",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c56ca5bb47f62bddd5"
                },
                "ID": "14.0122",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c56ca5bb47f62bddd7"
                },
                "ID": "14.0123",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c56ca5bb47f62bddd9"
                },
                "ID": "14.0124",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c56ca5bb47f62bdddb"
                },
                "ID": "14.0125",
                "location": {
                    "east_bound": 12.5418018,
                    "latitude": 52.2024014,
                    "longitude": 12.4757793,
                    "south_bound": 52.1621099,
                    "north_bound": 52.2306637,
                    "west_bound": 12.4341461
                }
            },
            {
                "_id": {
                    "$oid": "55f052c56ca5bb47f62bdddd"
                },
                "ID": "14.0126",
                "location": {
                    "east_bound": -3.5250057,
                    "latitude": 51.504286,
                    "longitude": -3.576945,
                    "south_bound": 51.4821997,
                    "north_bound": 51.5336115,
                    "west_bound": -3.6716169
                }
            },
            {
                "_id": {
                    "$oid": "55f052c66ca5bb47f62bdddf"
                },
                "ID": "14.0128",
                "location": {
                    "east_bound": -0.4830176,
                    "latitude": 53.845481,
                    "longitude": -0.499025,
                    "south_bound": 53.8388977,
                    "north_bound": 53.8520633,
                    "west_bound": -0.5150324
                }
            },
            {
                "_id": {
                    "$oid": "55f052c76ca5bb47f62bdde1"
                },
                "ID": "14.0131",
                "location": {
                    "east_bound": 0.4720174,
                    "latitude": 52.827926,
                    "longitude": 0.45601,
                    "south_bound": 52.8211837,
                    "north_bound": 52.8346673,
                    "west_bound": 0.4400026
                }
            },
            {
                "_id": {
                    "$oid": "55f052c76ca5bb47f62bdde3"
                },
                "ID": "14.0132",
                "location": {
                    "east_bound": 0.4720174,
                    "latitude": 52.827926,
                    "longitude": 0.45601,
                    "south_bound": 52.8211837,
                    "north_bound": 52.8346673,
                    "west_bound": 0.4400026
                }
            },
            {
                "_id": {
                    "$oid": "55f052c76ca5bb47f62bdde5"
                },
                "ID": "14.0133",
                "location": {
                    "east_bound": -2.8052157,
                    "latitude": 55.8841334,
                    "longitude": -2.8210238,
                    "south_bound": 55.8735151,
                    "north_bound": 55.8948776,
                    "west_bound": -2.829246
                }
            },
            {
                "_id": {
                    "$oid": "55f052c76ca5bb47f62bdde7"
                },
                "ID": "14.0134",
                "location": {
                    "east_bound": -1.4463496197085,
                    "latitude": 52.0941927,
                    "longitude": -1.4476986,
                    "south_bound": 52.0928437197085,
                    "north_bound": 52.0955416802915,
                    "west_bound": -1.4490475802915
                }
            },
            {
                "_id": {
                    "$oid": "55f052c76ca5bb47f62bdde9"
                },
                "ID": "14.0135",
                "location": {
                    "east_bound": -2.8052157,
                    "latitude": 55.8841334,
                    "longitude": -2.8210238,
                    "south_bound": 55.8735151,
                    "north_bound": 55.8948776,
                    "west_bound": -2.829246
                }
            },
            {
                "_id": {
                    "$oid": "55f052c86ca5bb47f62bddeb"
                },
                "ID": "14.0136",
                "location": {
                    "east_bound": -2.8052157,
                    "latitude": 55.8841334,
                    "longitude": -2.8210238,
                    "south_bound": 55.8735151,
                    "north_bound": 55.8948776,
                    "west_bound": -2.829246
                }
            },
            {
                "_id": {
                    "$oid": "55f052c86ca5bb47f62bdded"
                },
                "ID": "14.0137",
                "location": {
                    "east_bound": 0.4720174,
                    "latitude": 52.827926,
                    "longitude": 0.45601,
                    "south_bound": 52.8211837,
                    "north_bound": 52.8346673,
                    "west_bound": 0.4400026
                }
            },
            {
                "_id": {
                    "$oid": "55f052c86ca5bb47f62bddef"
                },
                "ID": "14.0139",
                "location": {
                    "east_bound": 0.4720174,
                    "latitude": 52.827926,
                    "longitude": 0.45601,
                    "south_bound": 52.8211837,
                    "north_bound": 52.8346673,
                    "west_bound": 0.4400026
                }
            },
            {
                "_id": {
                    "$oid": "55f052c86ca5bb47f62bddf1"
                },
                "ID": "14.0140",
                "location": {
                    "east_bound": -2.8052157,
                    "latitude": 55.8841334,
                    "longitude": -2.8210238,
                    "south_bound": 55.8735151,
                    "north_bound": 55.8948776,
                    "west_bound": -2.829246
                }
            },
            {
                "_id": {
                    "$oid": "55f052c96ca5bb47f62bddf3"
                },
                "ID": "14.0141",
                "location": {
                    "east_bound": 0.4720174,
                    "latitude": 52.827926,
                    "longitude": 0.45601,
                    "south_bound": 52.8211837,
                    "north_bound": 52.8346673,
                    "west_bound": 0.4400026
                }
            },
            {
                "_id": {
                    "$oid": "55f052c96ca5bb47f62bddf5"
                },
                "ID": "14.0142",
                "location": {
                    "east_bound": -2.8052157,
                    "latitude": 55.8841334,
                    "longitude": -2.8210238,
                    "south_bound": 55.8735151,
                    "north_bound": 55.8948776,
                    "west_bound": -2.829246
                }
            },
            {
                "_id": {
                    "$oid": "55f052c96ca5bb47f62bddf7"
                },
                "ID": "14.0143",
                "location": {
                    "east_bound": 0.810065180291502,
                    "latitude": 52.5954739,
                    "longitude": 0.8087162,
                    "south_bound": 52.5941249197085,
                    "north_bound": 52.5968228802915,
                    "west_bound": 0.807367219708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052c96ca5bb47f62bddf9"
                },
                "ID": "14.0144",
                "location": {
                    "east_bound": -1.4463496197085,
                    "latitude": 52.0941927,
                    "longitude": -1.4476986,
                    "south_bound": 52.0928437197085,
                    "north_bound": 52.0955416802915,
                    "west_bound": -1.4490475802915
                }
            },
            {
                "_id": {
                    "$oid": "55f052ca6ca5bb47f62bddfb"
                },
                "ID": "14.0145",
                "location": {
                    "east_bound": -1.0139137,
                    "latitude": 53.9599651,
                    "longitude": -1.0872979,
                    "south_bound": 53.9259345,
                    "north_bound": 53.9912585,
                    "west_bound": -1.1472695
                }
            },
            {
                "_id": {
                    "$oid": "55f052ca6ca5bb47f62bddfd"
                },
                "ID": "14.0146",
                "location": {
                    "east_bound": -1.0139137,
                    "latitude": 53.9599651,
                    "longitude": -1.0872979,
                    "south_bound": 53.9259345,
                    "north_bound": 53.9912585,
                    "west_bound": -1.1472695
                }
            },
            {
                "_id": {
                    "$oid": "55f052ca6ca5bb47f62bddff"
                },
                "ID": "14.0147",
                "location": {
                    "east_bound": -0.742702119708498,
                    "latitude": 52.0661226,
                    "longitude": -0.743808,
                    "south_bound": 52.0650014197085,
                    "north_bound": 52.0676993802915,
                    "west_bound": -0.745400080291502
                }
            },
            {
                "_id": {
                    "$oid": "55f052ca6ca5bb47f62bde01"
                },
                "ID": "14.0149",
                "location": {
                    "east_bound": 1.1645884,
                    "latitude": 52.569354,
                    "longitude": 1.115305,
                    "south_bound": 52.5116196,
                    "north_bound": 52.6107024,
                    "west_bound": 1.0613391
                }
            },
            {
                "_id": {
                    "$oid": "55f052ca6ca5bb47f62bde03"
                },
                "ID": "14.0150",
                "location": {
                    "east_bound": -0.0094296,
                    "latitude": 52.259814,
                    "longitude": -0.025437,
                    "south_bound": 52.2529839,
                    "north_bound": 52.2666431,
                    "west_bound": -0.0414444
                }
            },
            {
                "_id": {
                    "$oid": "55f052cb6ca5bb47f62bde05"
                },
                "ID": "14.0151",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052cb6ca5bb47f62bde07"
                },
                "ID": "14.0152",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052cb6ca5bb47f62bde09"
                },
                "ID": "14.0153",
                "location": {
                    "east_bound": -0.5201319,
                    "latitude": 52.3997829,
                    "longitude": -0.5278754,
                    "south_bound": 52.3965739,
                    "north_bound": 52.4035338,
                    "west_bound": -0.5356592
                }
            },
            {
                "_id": {
                    "$oid": "55f052cb6ca5bb47f62bde0b"
                },
                "ID": "14.0154",
                "location": {
                    "east_bound": -0.3238716,
                    "latitude": 52.5202937,
                    "longitude": -0.3285052,
                    "south_bound": 52.5175002,
                    "north_bound": 52.5223839,
                    "west_bound": -0.3346427
                }
            },
            {
                "_id": {
                    "$oid": "55f052cc6ca5bb47f62bde0d"
                },
                "ID": "14.0155",
                "location": {
                    "east_bound": -1.1056635,
                    "latitude": 51.5974177,
                    "longitude": -1.1335613,
                    "south_bound": 51.5817425,
                    "north_bound": 51.6133738,
                    "west_bound": -1.152584
                }
            },
            {
                "_id": {
                    "$oid": "55f052cc6ca5bb47f62bde0f"
                },
                "ID": "14.0157",
                "location": {
                    "east_bound": -0.3238716,
                    "latitude": 52.5202937,
                    "longitude": -0.3285052,
                    "south_bound": 52.5175002,
                    "north_bound": 52.5223839,
                    "west_bound": -0.3346427
                }
            },
            {
                "_id": {
                    "$oid": "55f052cc6ca5bb47f62bde11"
                },
                "ID": "14.0158",
                "location": {
                    "east_bound": -1.1348185,
                    "latitude": 51.5249619,
                    "longitude": -1.1698006,
                    "south_bound": 51.4967786,
                    "north_bound": 51.5427621,
                    "west_bound": -1.2092813
                }
            },
            {
                "_id": {
                    "$oid": "55f052cc6ca5bb47f62bde13"
                },
                "ID": "14.0159",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052cd6ca5bb47f62bde15"
                },
                "ID": "14.0160",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052cd6ca5bb47f62bde17"
                },
                "ID": "14.0161",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052cd6ca5bb47f62bde19"
                },
                "ID": "14.0162",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052cd6ca5bb47f62bde1b"
                },
                "ID": "14.0163",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052cd6ca5bb47f62bde1d"
                },
                "ID": "14.0164",
                "location": {
                    "east_bound": -1.3152364,
                    "latitude": 53.8685544,
                    "longitude": -1.3258639,
                    "south_bound": 53.8632474,
                    "north_bound": 53.8742161,
                    "west_bound": -1.3412462
                }
            },
            {
                "_id": {
                    "$oid": "55f052ce6ca5bb47f62bde1f"
                },
                "ID": "14.0165",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052ce6ca5bb47f62bde21"
                },
                "ID": "14.0166",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052ce6ca5bb47f62bde23"
                },
                "ID": "14.0167",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052ce6ca5bb47f62bde25"
                },
                "ID": "14.0168",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052cf6ca5bb47f62bde27"
                },
                "ID": "14.0170",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052cf6ca5bb47f62bde29"
                },
                "ID": "14.0171",
                "location": {
                    "east_bound": -2.4078095,
                    "latitude": 52.678419,
                    "longitude": -2.445258,
                    "south_bound": 52.6530124,
                    "north_bound": 52.6831574,
                    "west_bound": -2.4823035
                }
            },
            {
                "_id": {
                    "$oid": "55f052cf6ca5bb47f62bde2b"
                },
                "ID": "14.0172",
                "location": {
                    "east_bound": 0.173454780291502,
                    "latitude": 51.8697435,
                    "longitude": 0.1724057,
                    "south_bound": 51.8682809697085,
                    "north_bound": 51.8709789302915,
                    "west_bound": 0.170756819708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052cf6ca5bb47f62bde2d"
                },
                "ID": "14.0174",
                "location": {
                    "east_bound": -2.2891981,
                    "latitude": 50.925142,
                    "longitude": -2.304642,
                    "south_bound": 50.9140697,
                    "north_bound": 50.9396488,
                    "west_bound": -2.3241882
                }
            },
            {
                "_id": {
                    "$oid": "55f052d06ca5bb47f62bde2f"
                },
                "ID": "14.0175",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052d06ca5bb47f62bde31"
                },
                "ID": "14.0176",
                "location": {
                    "east_bound": -0.4485956,
                    "latitude": 52.845835,
                    "longitude": -0.464603,
                    "south_bound": 52.8390955,
                    "north_bound": 52.8525735,
                    "west_bound": -0.4806104
                }
            },
            {
                "_id": {
                    "$oid": "55f052d06ca5bb47f62bde33"
                },
                "ID": "14.0177",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d06ca5bb47f62bde35"
                },
                "ID": "14.0178",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d06ca5bb47f62bde37"
                },
                "ID": "14.0179",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052d16ca5bb47f62bde39"
                },
                "ID": "14.0180",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052d16ca5bb47f62bde3b"
                },
                "ID": "14.0181",
                "location": {
                    "east_bound": -1.3152364,
                    "latitude": 53.8685544,
                    "longitude": -1.3258639,
                    "south_bound": 53.8632474,
                    "north_bound": 53.8742161,
                    "west_bound": -1.3412462
                }
            },
            {
                "_id": {
                    "$oid": "55f052d16ca5bb47f62bde3d"
                },
                "ID": "14.0182",
                "location": {
                    "east_bound": 0.0098269,
                    "latitude": 52.048142,
                    "longitude": -0.024066,
                    "south_bound": 52.0334602,
                    "north_bound": 52.0636001,
                    "west_bound": -0.0542409
                }
            },
            {
                "_id": {
                    "$oid": "55f052d16ca5bb47f62bde3f"
                },
                "ID": "14.0183",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052d16ca5bb47f62bde41"
                },
                "ID": "14.0184",
                "location": {
                    "east_bound": 0.0729251,
                    "latitude": 52.4535208,
                    "longitude": 0.0611192,
                    "south_bound": 52.4487856,
                    "north_bound": 52.4543399,
                    "west_bound": 0.0598593
                }
            },
            {
                "_id": {
                    "$oid": "55f052d26ca5bb47f62bde43"
                },
                "ID": "14.0186",
                "location": {
                    "east_bound": -2.5004662,
                    "latitude": 50.811319,
                    "longitude": -2.532481,
                    "south_bound": 50.7972159,
                    "north_bound": 50.8254178,
                    "west_bound": -2.5644958
                }
            },
            {
                "_id": {
                    "$oid": "55f052d26ca5bb47f62bde45"
                },
                "ID": "14.0187",
                "location": {
                    "east_bound": -2.5004662,
                    "latitude": 50.811319,
                    "longitude": -2.532481,
                    "south_bound": 50.7972159,
                    "north_bound": 50.8254178,
                    "west_bound": -2.5644958
                }
            },
            {
                "_id": {
                    "$oid": "55f052d36ca5bb47f62bde47"
                },
                "ID": "14.0189",
                "location": {
                    "east_bound": -2.2891981,
                    "latitude": 50.925142,
                    "longitude": -2.304642,
                    "south_bound": 50.9140697,
                    "north_bound": 50.9396488,
                    "west_bound": -2.3241882
                }
            },
            {
                "_id": {
                    "$oid": "55f052d36ca5bb47f62bde49"
                },
                "ID": "14.0190",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052d36ca5bb47f62bde4b"
                },
                "ID": "14.0191",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052d36ca5bb47f62bde4d"
                },
                "ID": "14.0192",
                "location": {
                    "east_bound": -0.5688846,
                    "latitude": 53.021631,
                    "longitude": -0.6045819,
                    "south_bound": 53.0174137,
                    "north_bound": 53.0322775,
                    "west_bound": -0.6114799
                }
            },
            {
                "_id": {
                    "$oid": "55f052d36ca5bb47f62bde4f"
                },
                "ID": "14.0193",
                "location": {
                    "east_bound": 1.0510701,
                    "latitude": 51.1961742,
                    "longitude": 1.0447069,
                    "south_bound": 51.190281,
                    "north_bound": 51.2039176,
                    "west_bound": 1.0360411
                }
            },
            {
                "_id": {
                    "$oid": "55f052d46ca5bb47f62bde51"
                },
                "ID": "14.0195",
                "location": {
                    "east_bound": 0.2404329,
                    "latitude": 52.18268,
                    "longitude": 0.222039,
                    "south_bound": 52.1706581,
                    "north_bound": 52.196281,
                    "west_bound": 0.1813609
                }
            },
            {
                "_id": {
                    "$oid": "55f052d46ca5bb47f62bde53"
                },
                "ID": "14.0196",
                "location": {
                    "east_bound": 0.5144548,
                    "latitude": 52.2052973,
                    "longitude": 0.1218195,
                    "south_bound": 52.005779,
                    "north_bound": 52.7399809,
                    "west_bound": -0.4999075
                }
            },
            {
                "_id": {
                    "$oid": "55f052d46ca5bb47f62bde55"
                },
                "ID": "14.0197",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d46ca5bb47f62bde57"
                },
                "ID": "14.0198",
                "location": {
                    "east_bound": 0.1955669,
                    "latitude": 51.8097823,
                    "longitude": -0.2376744,
                    "south_bound": 51.5996179,
                    "north_bound": 52.0805364,
                    "west_bound": -0.7457891
                }
            },
            {
                "_id": {
                    "$oid": "55f052d56ca5bb47f62bde59"
                },
                "ID": "14.0199",
                "location": {
                    "east_bound": 1.4496433,
                    "latitude": 51.2787075,
                    "longitude": 0.5217254,
                    "south_bound": 50.9105289,
                    "north_bound": 51.4803103,
                    "west_bound": 0.0335197
                }
            },
            {
                "_id": {
                    "$oid": "55f052d56ca5bb47f62bde5b"
                },
                "ID": "14.0201",
                "location": {
                    "east_bound": 0.2404329,
                    "latitude": 52.18268,
                    "longitude": 0.222039,
                    "south_bound": 52.1706581,
                    "north_bound": 52.196281,
                    "west_bound": 0.1813609
                }
            },
            {
                "_id": {
                    "$oid": "55f052d56ca5bb47f62bde5d"
                },
                "ID": "14.0202",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d56ca5bb47f62bde5f"
                },
                "ID": "14.0203",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d66ca5bb47f62bde61"
                },
                "ID": "14.0204",
                "location": {
                    "east_bound": 1.0378962,
                    "latitude": 52.5539247,
                    "longitude": 1.029127,
                    "south_bound": 52.5462202,
                    "north_bound": 52.5583002,
                    "west_bound": 1.0220689
                }
            },
            {
                "_id": {
                    "$oid": "55f052d66ca5bb47f62bde63"
                },
                "ID": "14.0205",
                "location": {
                    "east_bound": 0.810065180291502,
                    "latitude": 52.5954739,
                    "longitude": 0.8087162,
                    "south_bound": 52.5941249197085,
                    "north_bound": 52.5968228802915,
                    "west_bound": 0.807367219708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052d66ca5bb47f62bde65"
                },
                "ID": "14.0206",
                "location": {
                    "east_bound": 0.5144548,
                    "latitude": 52.2052973,
                    "longitude": 0.1218195,
                    "south_bound": 52.005779,
                    "north_bound": 52.7399809,
                    "west_bound": -0.4999075
                }
            },
            {
                "_id": {
                    "$oid": "55f052d76ca5bb47f62bde67"
                },
                "ID": "14.0207",
                "location": {
                    "east_bound": 0.2404329,
                    "latitude": 52.18268,
                    "longitude": 0.222039,
                    "south_bound": 52.1706581,
                    "north_bound": 52.196281,
                    "west_bound": 0.1813609
                }
            },
            {
                "_id": {
                    "$oid": "55f052d76ca5bb47f62bde69"
                },
                "ID": "14.0208",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d76ca5bb47f62bde6b"
                },
                "ID": "14.0209",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d76ca5bb47f62bde6d"
                },
                "ID": "14.0210",
                "location": {
                    "east_bound": -1.3245149197085,
                    "latitude": 53.8685544,
                    "longitude": -1.3258639,
                    "south_bound": 53.8672054197085,
                    "north_bound": 53.8699033802915,
                    "west_bound": -1.3272128802915
                }
            },
            {
                "_id": {
                    "$oid": "55f052d86ca5bb47f62bde6f"
                },
                "ID": "14.0211",
                "location": {
                    "east_bound": 0.810065180291502,
                    "latitude": 52.5954739,
                    "longitude": 0.8087162,
                    "south_bound": 52.5941249197085,
                    "north_bound": 52.5968228802915,
                    "west_bound": 0.807367219708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052d86ca5bb47f62bde71"
                },
                "ID": "14.0213",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052d86ca5bb47f62bde73"
                },
                "ID": "14.0214",
                "location": {
                    "east_bound": 0.810065180291502,
                    "latitude": 52.5954739,
                    "longitude": 0.8087162,
                    "south_bound": 52.5941249197085,
                    "north_bound": 52.5968228802915,
                    "west_bound": 0.807367219708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052d96ca5bb47f62bde75"
                },
                "ID": "14.0215",
                "location": {
                    "east_bound": 0.810065180291502,
                    "latitude": 52.5954739,
                    "longitude": 0.8087162,
                    "south_bound": 52.5941249197085,
                    "north_bound": 52.5968228802915,
                    "west_bound": 0.807367219708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052d96ca5bb47f62bde77"
                },
                "ID": "14.0216",
                "location": {
                    "east_bound": 0.810065180291502,
                    "latitude": 52.5954739,
                    "longitude": 0.8087162,
                    "south_bound": 52.5941249197085,
                    "north_bound": 52.5968228802915,
                    "west_bound": 0.807367219708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052d96ca5bb47f62bde79"
                },
                "ID": "14.0217",
                "location": {
                    "east_bound": -1.0492984,
                    "latitude": 51.9237619,
                    "longitude": -1.0566857,
                    "south_bound": 51.9159346,
                    "north_bound": 51.9276638,
                    "west_bound": -1.0583726
                }
            },
            {
                "_id": {
                    "$oid": "55f052da6ca5bb47f62bde7b"
                },
                "ID": "14.0219",
                "location": {
                    "east_bound": -1.3209118,
                    "latitude": 51.1679846,
                    "longitude": -1.3322212,
                    "south_bound": 51.1642756,
                    "north_bound": 51.1758942,
                    "west_bound": -1.339582
                }
            },
            {
                "_id": {
                    "$oid": "55f052da6ca5bb47f62bde7d"
                },
                "ID": "14.0220",
                "location": {
                    "east_bound": 0.5144548,
                    "latitude": 52.2052973,
                    "longitude": 0.1218195,
                    "south_bound": 52.005779,
                    "north_bound": 52.7399809,
                    "west_bound": -0.4999075
                }
            },
            {
                "_id": {
                    "$oid": "55f052da6ca5bb47f62bde7f"
                },
                "ID": "14.0221",
                "location": {
                    "east_bound": 0.1955669,
                    "latitude": 51.8097823,
                    "longitude": -0.2376744,
                    "south_bound": 51.5996179,
                    "north_bound": 52.0805364,
                    "west_bound": -0.7457891
                }
            },
            {
                "_id": {
                    "$oid": "55f052da6ca5bb47f62bde81"
                },
                "ID": "14.0222",
                "location": {
                    "east_bound": 0.810065180291502,
                    "latitude": 52.5954739,
                    "longitude": 0.8087162,
                    "south_bound": 52.5941249197085,
                    "north_bound": 52.5968228802915,
                    "west_bound": 0.807367219708498
                }
            },
            {
                "_id": {
                    "$oid": "55f052db6ca5bb47f62bde83"
                },
                "ID": "14.0223",
                "location": {
                    "east_bound": -3.0922357,
                    "latitude": 52.2883942,
                    "longitude": -3.1159884,
                    "south_bound": 52.2786045,
                    "north_bound": 52.2953078,
                    "west_bound": -3.1519497
                }
            },
            {
                "_id": {
                    "$oid": "55f052db6ca5bb47f62bde85"
                },
                "ID": "14.0224",
                "location": {
                    "east_bound": -3.0922357,
                    "latitude": 52.2883942,
                    "longitude": -3.1159884,
                    "south_bound": 52.2786045,
                    "north_bound": 52.2953078,
                    "west_bound": -3.1519497
                }
            },
            {
                "_id": {
                    "$oid": "55f052db6ca5bb47f62bde87"
                },
                "ID": "14.0228",
                "location": {
                    "east_bound": 1.2830765302915,
                    "latitude": 52.6216521,
                    "longitude": 1.281785,
                    "south_bound": 52.6202322197085,
                    "north_bound": 52.6229301802915,
                    "west_bound": 1.2803785697085
                }
            },
            {
                "_id": {
                    "$oid": "55f052db6ca5bb47f62bde89"
                },
                "ID": "14.0228a",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052db6ca5bb47f62bde8b"
                },
                "ID": "14.0229",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052dc6ca5bb47f62bde8d"
                },
                "ID": "14.0230",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052dc6ca5bb47f62bde8f"
                },
                "ID": "14.0231",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052dc6ca5bb47f62bde91"
                },
                "ID": "14.0232",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052dc6ca5bb47f62bde93"
                },
                "ID": "14.0233",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052dc6ca5bb47f62bde95"
                },
                "ID": "14.0234",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052dd6ca5bb47f62bde97"
                },
                "ID": "14.0235",
                "location": {
                    "east_bound": 15.0418962,
                    "latitude": 51.165691,
                    "longitude": 10.451526,
                    "south_bound": 47.2701115,
                    "north_bound": 55.0738232,
                    "west_bound": 5.8663425
                }
            },
            {
                "_id": {
                    "$oid": "55f052dd6ca5bb47f62bde99"
                },
                "ID": "14.0236",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052dd6ca5bb47f62bde9b"
                },
                "ID": "14.0237",
                "location": {
                    "east_bound": 39.4179996,
                    "latitude": 9.416172,
                    "longitude": 39.3539699,
                    "south_bound": 9.3721386,
                    "north_bound": 9.4601998,
                    "west_bound": 39.2899402
                }
            },
            {
                "_id": {
                    "$oid": "55f052dd6ca5bb47f62bde9d"
                },
                "ID": "14.0238",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052dd6ca5bb47f62bde9f"
                },
                "ID": "14.0239",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052de6ca5bb47f62bdea1"
                },
                "ID": "14.0240",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052de6ca5bb47f62bdea3"
                },
                "ID": "14.0241",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052de6ca5bb47f62bdea5"
                },
                "ID": "14.0242",
                "location": {
                    "east_bound": 48.0010561,
                    "latitude": 9.145,
                    "longitude": 40.489673,
                    "south_bound": 3.4041369,
                    "north_bound": 14.8942141,
                    "west_bound": 32.997734
                }
            },
            {
                "_id": {
                    "$oid": "55f052de6ca5bb47f62bdea7"
                },
                "ID": "14.0243",
                "location": {
                    "east_bound": 39.9440161,
                    "latitude": 7.2488142,
                    "longitude": 39.9247429,
                    "south_bound": 7.2361887,
                    "north_bound": 7.262795,
                    "west_bound": 39.9127231
                }
            },
            {
                "_id": {
                    "$oid": "55f052de6ca5bb47f62bdea9"
                },
                "ID": "14.0244",
                "location": {
                    "east_bound": 39.6450233,
                    "latitude": 7.8625672,
                    "longitude": 39.6260058,
                    "south_bound": 7.8488425,
                    "north_bound": 7.8841271,
                    "west_bound": 39.6162702
                }
            },
            {
                "_id": {
                    "$oid": "55f052df6ca5bb47f62bdeab"
                },
                "ID": "14.0245",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052df6ca5bb47f62bdead"
                },
                "ID": "14.0246",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052df6ca5bb47f62bdeaf"
                },
                "ID": "14.0247",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052df6ca5bb47f62bdeb1"
                },
                "ID": "14.0248",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052e06ca5bb47f62bdeb3"
                },
                "ID": "14.0249",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052e06ca5bb47f62bdeb5"
                },
                "ID": "14.0250",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052e06ca5bb47f62bdeb7"
                },
                "ID": "14.0251",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052e06ca5bb47f62bdeb9"
                },
                "ID": "14.0252",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            },
            {
                "_id": {
                    "$oid": "55f052e06ca5bb47f62bdebb"
                },
                "ID": "14.0253",
                "location": {
                    "east_bound": 1.2274933,
                    "latitude": 52.6218743,
                    "longitude": 1.2223058,
                    "south_bound": 52.6202730697085,
                    "north_bound": 52.6229710302915,
                    "west_bound": 1.218157
                }
            }
        ]
    };
</script>

<%@ include file="footer.jsp" %>