<%@ include file="header.jsp" %>


<script src="<c:url value='/scripts/jquery/datatables/js/jquery.dataTables.min.js'/>" type="text/javascript"></script>
<link href="<c:url value='/scripts/jquery/datatables/css/jquery.dataTables.css'/>" rel="stylesheet" type="text/css">

<script src="<c:url value='/scripts/yrdata.js'/>" type="text/javascript"></script>

<div class="container center-block">

    <h2>Yellow Rust Map</h2>

    <div id="map"></div>
    <br/>

    <div class="row">
        <div class="col-lg-6">

            <div class="input-group">
               <span class="input-group-btn">
                   <button type="button" class="btn btn-default"
                           onclick="mapFitBounds([[49.781264,-7.910156],[61.100789, -0.571289]]);">Zoom UK
                   </button>
                   <button type="button" class="btn btn-default"
                           onclick="mapFitBounds([[36.738884,-14.765625],[56.656226, 32.34375]]);">Zoom Europe
                   </button>
               </span>
            </div>
        </div>
    </div>
    <br/>

    <div id="tableWrapper">
        <table id="resultTable"></table>
    </div>

    <a href="<c:url value='/wis-portal/phenotype'/>">Phenotype Data</a>
</div>

<script type="text/javascript">

    jQuery(document).ready(function () {
        makeYRJSON();
        displayYRLocations(sample_list);
        var yrtable = jQuery('#resultTable').dataTable({
            data: sample_list,
            "columns": [
                {data: "ID", title: "ID"},
                {data: "Country", title: "Country", "sDefaultContent": ""},
                {
                    title: "UKCPVS ID",
                    "render": function (data, type, full, meta) {
                        return '<u onclick="phenotype(\'' + full['UKCPVS ID'] + '\');" style="cursor: pointer;">' + full['UKCPVS ID'] + '</u>';
                    }
                },
                {data: "Rust (YR/SR/LR)", title: "Rust (YR/SR/LR)", "sDefaultContent": "Unknown"},
                {data: "Name/Collector", title: "Name/Collector", "sDefaultContent": ""},
                {data: "Date collected", title: "Date collected", "sDefaultContent": ""},
                {data: "Host", title: "Host", "sDefaultContent": ""},
                {data: "RNA-seq? (Selected/In progress/Completed/Failed)", title: "RNA-seq", "sDefaultContent": ""},
                {data: "Further Location information", title: "Further Location info", "sDefaultContent": ""},
                {data: "Postal code", title: "Postal code", "sDefaultContent": ""},
                {
                    title: "Coordinates",
                    "render": function (data, type, full, meta) {
                        return full.location.latitude + ', ' + full.location.longitude;
                    }
                }
            ]
        });
        jQuery('#resultTable').on('search.dt', function () {
            removePointers();
            var filteredData = yrtable._('tr', {"filter": "applied"});
            displayYRLocations(filteredData);
        });
    });


    var markers = new Array();

    var markersGroup = new L.MarkerClusterGroup();

    var map = L.map('map').setView([52.621615, 10.219470], 5);

    L.tileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
        maxZoom: 18
    }).addTo(map);

    function displayYRLocations(array) {
        for (i = 0; i < array.length; i++) {
            var la = array[i]['location']['latitude'];
            var lo = array[i]['location']['longitude'];
            var note = '<b>ID: </b>' + array[i]['ID'] + '<br/>'
                       + '<b>Country: </b>' + array[i]['Country'] + '<br/>'
                       + '<b>UKCPVS ID: </b><u onclick="phenotype(\'' + array[i]['UKCPVS ID'] + '\');" style="cursor: pointer;">' + array[i]['UKCPVS ID'] + '</u><br/>'
                       + '<b>Rust (YR/SR/LR): </b>' + array[i]['Rust (YR/SR/LR)'] + '<br/>'
                       + '<b>Name/Collector: </b>' + array[i]['Name/Collector'] + '<br/>'
                       + '<b>Date collected: </b>' + array[i]['Date collected'] + '<br/>'
                       + '<b>Host: </b>' + array[i]['Host'] + '<br/>'
                       + '<b>RNA-seq: </b>' + array[i]['RNA-seq? (Selected/In progress/Completed/Failed)'] + '<br/>'
                       + '<b>Coordinates: </b>' + array[i]['location']['latitude'] + ', ' + array[i]['location']['longitude'] + '<br/>'
                       + '<b>Postal code: </b>' + array[i]['Postal code'] + '<br/>'
                       + '<b>Further Location info: </b>' + array[i]['Further Location information'];
            addPointer(la, lo, note);
        }
    }


    function phenotype(id) {
        var phynotype_data = "No Phynotype Data";
        if (id != '' && id != undefined && id != 'undefined') {
            for (i = 0; i < sample_phenotyping.length; i++) {
                if (id == sample_phenotyping[i]['Isolate']) {
                    phynotype_data = '<div style="margin:20px;"><b>Batch: </b>' + sample_phenotyping[i]['Batch'] + '<br/>'
                                     + '<b>No of isols tested: </b>' + sample_phenotyping[i]['No of isols tested'] + '<br/>'
                                     + '<b>Isolate: </b>' + sample_phenotyping[i]['Isolate'] + '<br/>'
                                     + '<b>Host: </b>' + sample_phenotyping[i]['Host'] + '<br/>'
                                     + '<b>Chinese 166 Gene:1: </b>' + divbgcolor(sample_phenotyping[i]['Chinese 166 Gene:1']) + '<br/>'
                                     + '<b>Kalyansona Gene:2: </b>' + divbgcolor(sample_phenotyping[i]['Kalyansona Gene:2']) + '<br/>'
                                     + '<b>Vilmorin 23 Gene:3a+: </b>' + divbgcolor(sample_phenotyping[i]['Vilmorin 23 Gene:3a+']) + '<br/>'
                                     + '<b>Nord Desprez Gene:3a+: </b>' + divbgcolor(sample_phenotyping[i]['Nord Desprez Gene:3a+']) + '<br/>'
                                     + '<b>Hybrid 46 Gene:(3b)4b: </b>' + divbgcolor(sample_phenotyping[i]['Hybrid 46 Gene:(3b)4b']) + '<br/>'
                                     + '<b>Heines Kolben Gene:2,6: </b>' + divbgcolor(sample_phenotyping[i]['Heines Kolben Gene:2,6']) + '<br/>'
                                     + '<b>Heines Peko Gene:2,6: </b>' + divbgcolor(sample_phenotyping[i]['Heines Peko Gene:2,6']) + '<br/>'
                                     + '<b>Lee Gene:7: </b>' + divbgcolor(sample_phenotyping[i]['Lee Gene:7']) + '<br/>'
                                     + '<b>Av x Yr7 NIL Gene:7: </b>' + divbgcolor(sample_phenotyping[i]['Av x Yr7 NIL Gene:7']) + '<br/>'
                                     + '<b>Compair Gene:8: </b>' + divbgcolor(sample_phenotyping[i]['Compair Gene:8']) + '<br/>'
                                     + '<b>Kavkaz x 4 Fed Gene:9: </b>' + divbgcolor(sample_phenotyping[i]['Kavkaz x 4 Fed Gene:9']) + '<br/>'
                                     + '<b>Clement Gene:9: </b>' + divbgcolor(sample_phenotyping[i]['Clement Gene:9']) + '<br/>'
                                     + '<b>AVS x Yr 15 Gene:15: </b>' + divbgcolor(sample_phenotyping[i]['AVS x Yr 15 Gene:15']) + '<br/>'
                                     + '<b>VPM 1 Gene:17: </b>' + divbgcolor(sample_phenotyping[i]['VPM 1 Gene:17']) + '<br/>'
                                     + '<b>Rendezvous Gene:17: </b>' + divbgcolor(sample_phenotyping[i]['Rendezvous Gene:17']) + '<br/>'
                                     + '<b>Av x Yr17 Gene:17: </b>' + divbgcolor(sample_phenotyping[i]['Av x Yr17 Gene:17']) + '<br/>'
                                     + '<b>Carstens V Gene:32: </b>' + divbgcolor(sample_phenotyping[i]['Carstens V Gene:32']) + '<br/>'
                                     + '<b>Talon Gene:32: </b>' + divbgcolor(sample_phenotyping[i]['Talon Gene:32']) + '<br/>'
                                     + '<b>Av x Yr32 Gene:32: </b>' + divbgcolor(sample_phenotyping[i]['Av x Yr32 Gene:32']) + '<br/>'
                                     + '<b>Spaldings Prolific Gene:sp: </b>' + divbgcolor(sample_phenotyping[i]['Spaldings Prolific Gene:sp']) + '<br/>'
                                     + '<b>Robigus Gene:Rob\': </b>' + divbgcolor(sample_phenotyping[i]['Robigus Gene:Rob\'']) + '<br/>'
                                     + '<b>Solstice Gene:\'Sol\': </b>' + divbgcolor(sample_phenotyping[i]['Solstice Gene:\'Sol\'']) + '<br/>'
                                     + '<b>Timber Gene:\'Tim\': </b>' + divbgcolor(sample_phenotyping[i]['Timber Gene:\'Tim\'']) + '<br/>'
                                     + '<b>Warrior Gene:War\': </b>' + divbgcolor(sample_phenotyping[i]['Warrior Gene:War\'']) + '<br/>'
                                     + '<b>KWS-Sterling Gene:Ste\': </b>' + divbgcolor(sample_phenotyping[i]['KWS-Sterling Gene:Ste\'']) + '<br/>'
                                     + '<b>Cadenza Gene:6 7: </b>' + divbgcolor(sample_phenotyping[i]['Cadenza Gene:6 7']) + '<br/>'
                                     + '<b>Claire Gene:Claire: </b>' + divbgcolor(sample_phenotyping[i]['Claire Gene:Claire']) + '<br/>'
                                     + '<b>Crusoe Gene:Crusoe: </b>' + divbgcolor(sample_phenotyping[i]['Crusoe Gene:Crusoe']) + '<br/>'
                                     + '<b>Ambition Gene:Amb\': </b>' + divbgcolor(sample_phenotyping[i]['Ambition Gene:Amb\'']) + '<br/>'
                                     + '<b>Heines VII Gene:Yr2 Yr25+: </b>' + divbgcolor(sample_phenotyping[i]['Heines VII Gene:Yr2 Yr25+']) + '<br/>'
                                     + '<b>Suwon Omar Gene:Yr(Su): </b>' + divbgcolor(sample_phenotyping[i]['Suwon Omar Gene:Yr(Su)']) + '<br/>'
                                     + '<b>Avocet Yr5 Gene:Yr5: </b>' + divbgcolor(sample_phenotyping[i]['Avocet Yr5 Gene:Yr5']) + '<br/>'
                                     + '<b>Avocet Yr6 Gene:Yr6: </b>' + divbgcolor(sample_phenotyping[i]['Avocet Yr6 Gene:Yr6']) + '<br/>'
                                     + '<b>Moro Gene:Yr10: </b>' + divbgcolor(sample_phenotyping[i]['Moro Gene:Yr10']) + '<br/>'
                                     + '<b>Avocet Yr24 Gene:Yr24: </b>' + divbgcolor(sample_phenotyping[i]['Avocet Yr24 Gene:Yr24']) + '<br/>'
                                     + '<b>Opata Gene:Yr27+: </b>' + divbgcolor(sample_phenotyping[i]['Opata Gene:Yr27+']) + '<br/>'
                                     + '<b>Strubes Dickkopf Gene:YrSd Yr25: </b>' + divbgcolor(sample_phenotyping[i]['Strubes Dickkopf Gene:YrSd Yr25']) + '<br/>'
                                     + '<b>Avocet Yr27 Gene:Yr27: </b>' + divbgcolor(sample_phenotyping[i]['Avocet Yr27 Gene:Yr27']) + '<br/>'
                                     + '<b>Apache Gene:7 17: </b>' + divbgcolor(sample_phenotyping[i]['Apache Gene:7 17']) + '<br/>'
                                     + '<b>Vuka: </b>' + divbgcolor(sample_phenotyping[i]['Vuka']) + '<br/>'
                                     + '<b>Grenado: </b>' + divbgcolor(sample_phenotyping[i]['Grenado']) + '<br/>'
                                     + '<b>Benetto: </b>' + divbgcolor(sample_phenotyping[i]['Benetto']) + '<br/>'
                                     + '<b>Tradiro: </b>' + divbgcolor(sample_phenotyping[i]['Tradiro']) + '<br/>'
                                     + '<b>Tribeca: </b>' + divbgcolor(sample_phenotyping[i]['Tribeca']) + '<br/>'
                                     + '<b>Tulus: </b>' + divbgcolor(sample_phenotyping[i]['Tulus']) + '<br/>'
                                     + '<b>Dublet: </b>' + divbgcolor(sample_phenotyping[i]['Dublet']) + '<br/>'
                                     + '<b>KWS Fido: </b>' + divbgcolor(sample_phenotyping[i]['KWS Fido']) + '<br/>'
                                     + '<b>Brigadier: </b>' + divbgcolor(sample_phenotyping[i]['Brigadier']) + '<br/>'
                                     + '<b>Stigg: </b>' + divbgcolor(sample_phenotyping[i]['Stigg']) + '</div>';

                }
            }
        }
        jQuery.colorbox({width: "80%", html: phynotype_data});
    }

    function makeTable() {
        makeYRJSON();
    }

    function divbgcolor(value) {
        if (parseFloat(value) < 1) {
            return "<span class='pheno_1 in_box'>" + value + "</span>";
        }
        if (parseFloat(value) >= 1 && parseFloat(value) < 2) {
            return "<span class='pheno_12 in_box'>" + value + "</span>";
        }
        if (parseFloat(value) >= 2 && parseFloat(value) < 3) {
            return "<span class='pheno_23 in_box'>" + value + "</span>";
        }
        if (parseFloat(value) >= 3) {
            return "<span class='pheno_3 in_box'>" + value + "</span>";
        }
    }

    function getDate(yyyymmdd) {
        console.log(yyyymmdd);
        if (yyyymmdd == undefined || yyyymmdd.length < 7) {
            return "Not Known"
        }
        else {
            var dt = yyyymmdd.substring(6, 7);
            var mon = yyyymmdd.substring(4, 5);
            var yr = yyyymmdd.substring(0, 3);
            return yr + '-' + mon + '-' + dt;
        }
    }

    function makeYRJSON() {
        for (i = 0; i < sample_list.length; i++) {
            for (j = 0; j < location_list.length; j++)
                if (sample_list[i]['ID'] == location_list[j]['ID']) {
                    sample_list[i]['location'] = location_list[j]['location'];
                }
        }
    }

    function addRandomPointer() {
        var la = randomNumberFromInterval(45, 60);
        var lo = randomNumberFromInterval(0, 25);

        addPointer(la, lo, "Hey, random! la: " + la + " lo: " + lo);
    }

    function addPointer(la, lo, note) {
        var markerLayer = L.marker([la, lo]).bindPopup(note);
        markers.push(markerLayer);
        markersGroup.addLayer(markerLayer);
        map.addLayer(markersGroup);
    }

    function removePointers() {
        map.removeLayer(markersGroup);
        markersGroup = new L.MarkerClusterGroup();
    }

    function removeTable() {
        jQuery('#resultTable').dataTable().fnDestroy();
        jQuery('#tableWrapper').html('<table id="resultTable"></table>');
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

    function randomNumberFromInterval(min, max) {
        return Math.random() * (max - min + 1) + min;
    }


</script>

<%@ include file="footer.jsp" %>