<%@ include file="header.jsp" %>


<script src="<c:url value='/scripts/jquery/datatables/js/jquery.dataTables.min.js'/>" type="text/javascript"></script>
<link href="<c:url value='/scripts/jquery/datatables/css/jquery.dataTables.css'/>" rel="stylesheet" type="text/css">
<script src="<c:url value='/scripts/yrdata.js'/>" type="text/javascript"></script>

<div class="container center-block" style="width:95%!important;">

    <h2>Yellow Rust Phenotype Data</h2>


    <div id="tableWrapper">
        <table id="resultTable" class="phenotype"></table>
    </div>
</div>
<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('#resultTable').dataTable({
            data: sample_phenotyping,
            "columns": [
                {data: "Batch", title: "Batch", "sDefaultContent": ""},
                {data: "No of isols tested", title: "No of isols tested", "sDefaultContent": ""},
                {data: "Isolate", title: "Isolate", "sDefaultContent": ""},
                {data: "Host", title: "Host", "sDefaultContent": ""},
                {
                    data: "Chinese 166 Gene:1",
                    title: "Chinese 166 Gene:1",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Kalyansona Gene:2",
                    title: "Kalyansona Gene:2",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Vilmorin 23 Gene:3a+",
                    title: "Vilmorin 23 Gene:3a+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Nord Desprez Gene:3a+",
                    title: "Nord Desprez Gene:3a+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Hybrid 46 Gene:(3b)4b", title: "Hybrid 46 Gene:(3b)4b", "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Heines Kolben Gene:2,6",
                    title: "Heines Kolben Gene:2,6",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Heines Peko Gene:2,6",
                    title: "Heines Peko Gene:2,6",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Lee Gene:7",
                    title: "Lee Gene:7",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Av x Yr7 NIL Gene:7",
                    title: "Av x Yr7 NIL Gene:7",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Compair Gene:8",
                    title: "Compair Gene:8",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Kavkaz x 4 Fed Gene:9",
                    title: "Kavkaz x 4 Fed Gene:9",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Clement Gene:9",
                    title: "Clement Gene:9",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "AVS x Yr 15 Gene:15",
                    title: "AVS x Yr 15 Gene:15",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "VPM 1 Gene:17",
                    title: "VPM 1 Gene:17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Rendezvous Gene:17",
                    title: "Rendezvous Gene:17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Av x Yr17 Gene:17",
                    title: "Av x Yr17 Gene:17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Carstens V Gene:32",
                    title: "Carstens V Gene:32",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Talon Gene:32",
                    title: "Talon Gene:32",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Av x Yr32 Gene:32",
                    title: "Av x Yr32 Gene:32",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Spaldings Prolific Gene:sp",
                    title: "Spaldings Prolific Gene:sp",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Robigus Gene:Rob\'",
                    title: "Robigus Gene:Rob'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Solstice Gene:\'Sol\'",
                    title: "Solstice Gene:\'Sol\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Timber Gene:\'Tim\'",
                    title: "Timber Gene:\'Tim\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Warrior Gene:War\'",
                    title: "Warrior Gene:War\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "KWS-Sterling Gene:Ste\'",
                    title: "KWS-Sterling Gene:Ste\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Cadenza Gene:6 7",
                    title: "Cadenza Gene:6 7",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Claire Gene:Claire",
                    title: "Claire Gene:Claire",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Crusoe Gene:Crusoe",
                    title: "Crusoe Gene:Crusoe",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Ambition Gene:Amb\'",
                    title: "Ambition Gene:Amb\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Heines VII Gene:Yr2 Yr25+",
                    title: "Heines VII Gene:Yr2 Yr25+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Suwon Omar Gene:Yr(Su)",
                    title: "Suwon Omar Gene:Yr(Su)",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Avocet Yr5 Gene:Yr5",
                    title: "Avocet Yr5 Gene:Yr5",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Avocet Yr6 Gene:Yr6",
                    title: "Avocet Yr6 Gene:Yr6",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Moro Gene:Yr10",
                    title: "Moro Gene:Yr10",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Avocet Yr24 Gene:Yr24",
                    title: "Avocet Yr24 Gene:Yr24",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Opata Gene:Yr27+",
                    title: "Opata Gene:Yr27+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Strubes Dickkopf Gene:YrSd Yr25",
                    title: "Strubes Dickkopf Gene:YrSd Yr25",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Avocet Yr27 Gene:Yr27",
                    title: "Avocet Yr27 Gene:Yr27",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Apache Gene:7 17",
                    title: "Apache Gene:7 17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Vuka",
                    title: "Vuka",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Grenado",
                    title: "Grenado",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Benetto",
                    title: "Benetto",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Tradiro",
                    title: "Tradiro",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Tribeca",
                    title: "Tribeca",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Tulus",
                    title: "Tulus",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Dublet",
                    title: "Dublet",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "KWS Fido",
                    title: "KWS Fido",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Brigadier",
                    title: "Brigadier",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                },
                {
                    data: "Stigg", title: "Stigg", "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        color_coding(cellData, cell);
                    }
                }
            ]
        });
    });

    function color_coding(cellData, cell) {
        if (parseFloat(cellData) < 1) {
            jQuery(cell).addClass("pheno_1");
        }
        if (parseFloat(cellData) >= 1 && parseFloat(cellData) < 2) {
            jQuery(cell).addClass("pheno_12");
        }
        if (parseFloat(cellData) >= 2 && parseFloat(cellData) < 3) {
            jQuery(cell).addClass("pheno_23");
        }
        if (parseFloat(cellData) >= 3) {
            jQuery(cell).addClass("pheno_3");
        }
    }

</script>

<%@ include file="footer.jsp" %>