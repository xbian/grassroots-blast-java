<%@ include file="header.jsp" %>


<script src="<c:url value='/scripts/jquery/datatables/js/jquery.dataTables.min.js'/>" type="text/javascript"></script>
<link href="<c:url value='/scripts/jquery/datatables/css/jquery.dataTables.css'/>" rel="stylesheet" type="text/css">
<script src="<c:url value='/scripts/yrdata.js'/>" type="text/javascript"></script>

<div class="container center-block" style="width:95%!important;">

    <h2>Yellow Rust Phenotype Data</h2>


    <div id="tableWrapper">
        <table id="resultTable"></table>
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
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Kalyansona Gene:2",
                    title: "Kalyansona Gene:2",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Vilmorin 23 Gene:3a+",
                    title: "Vilmorin 23 Gene:3a+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Nord Desprez Gene:3a+",
                    title: "Nord Desprez Gene:3a+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Hybrid 46 Gene:(3b)4b", title: "Hybrid 46 Gene:(3b)4b", "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Heines Kolben Gene:2,6",
                    title: "Heines Kolben Gene:2,6",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Heines Peko Gene:2,6",
                    title: "Heines Peko Gene:2,6",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Lee Gene:7",
                    title: "Lee Gene:7",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Av x Yr7 NIL Gene:7",
                    title: "Av x Yr7 NIL Gene:7",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Compair Gene:8",
                    title: "Compair Gene:8",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Kavkaz x 4 Fed Gene:9",
                    title: "Kavkaz x 4 Fed Gene:9",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Clement Gene:9",
                    title: "Clement Gene:9",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "AVS x Yr 15 Gene:15",
                    title: "AVS x Yr 15 Gene:15",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "VPM 1 Gene:17",
                    title: "VPM 1 Gene:17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Rendezvous Gene:17",
                    title: "Rendezvous Gene:17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Av x Yr17 Gene:17",
                    title: "Av x Yr17 Gene:17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Carstens V Gene:32",
                    title: "Carstens V Gene:32",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Talon Gene:32",
                    title: "Talon Gene:32",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Av x Yr32 Gene:32",
                    title: "Av x Yr32 Gene:32",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Spaldings Prolific Gene:sp",
                    title: "Spaldings Prolific Gene:sp",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Robigus Gene:Rob\'",
                    title: "Robigus Gene:Rob'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Solstice Gene:\'Sol\'",
                    title: "Solstice Gene:\'Sol\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Timber Gene:\'Tim\'",
                    title: "Timber Gene:\'Tim\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Warrior Gene:War\'",
                    title: "Warrior Gene:War\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "KWS-Sterling Gene:Ste\'",
                    title: "KWS-Sterling Gene:Ste\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Cadenza Gene:6 7",
                    title: "Cadenza Gene:6 7",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Claire Gene:Claire",
                    title: "Claire Gene:Claire",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Crusoe Gene:Crusoe",
                    title: "Crusoe Gene:Crusoe",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Ambition Gene:Amb\'",
                    title: "Ambition Gene:Amb\'",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Heines VII Gene:Yr2 Yr25+",
                    title: "Heines VII Gene:Yr2 Yr25+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Suwon Omar Gene:Yr(Su)",
                    title: "Suwon Omar Gene:Yr(Su)",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Avocet Yr5 Gene:Yr5",
                    title: "Avocet Yr5 Gene:Yr5",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Avocet Yr6 Gene:Yr6",
                    title: "Avocet Yr6 Gene:Yr6",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Moro Gene:Yr10",
                    title: "Moro Gene:Yr10",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Avocet Yr24 Gene:Yr24",
                    title: "Avocet Yr24 Gene:Yr24",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Opata Gene:Yr27+",
                    title: "Opata Gene:Yr27+",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Strubes Dickkopf Gene:YrSd Yr25",
                    title: "Strubes Dickkopf Gene:YrSd Yr25",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Avocet Yr27 Gene:Yr27",
                    title: "Avocet Yr27 Gene:Yr27",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Apache Gene:7 17",
                    title: "Apache Gene:7 17",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Vuka",
                    title: "Vuka",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Grenado",
                    title: "Grenado",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Benetto",
                    title: "Benetto",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Tradiro",
                    title: "Tradiro",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Tribeca",
                    title: "Tribeca",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Tulus",
                    title: "Tulus",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Dublet",
                    title: "Dublet",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "KWS Fido",
                    title: "KWS Fido",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Brigadier",
                    title: "Brigadier",
                    "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                },
                {
                    data: "Stigg", title: "Stigg", "sDefaultContent": "",
                    createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                        if (parseFloat(cellData) < 2) {
                            jQuery(cell).css('background-color', 'green');
                        }
                        if (parseFloat(cellData) >= 2) {
                            jQuery(cell).css('background-color', 'red');
                        }
                    }
                }
            ]
//            ,
//            createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
//                console.log(cellData);
//                if ( parseFloat(cellData) < 2 ) {
//                    jQuery(cell).css('background-color','green');

//                }
//                if ( cellData == '3' ) {
//                    console.log('yes');
//                    jQuery(cell).css('background-color','red');
//                }
//            }
//            "createdRow": function ( row, data, index) {
//                if (parseFloat(data['Hybrid 46 Gene:(3b)4b']) < 2) {
//                    jQuery('td', row).eq(8).css('background-color','green');
//                }
//                if (parseFloat(data['Hybrid 46 Gene:(3b)4b']) >= 2) {
//                    jQuery('td', row).eq(8).css('background-color','red');
//                }
//            }
        });
    });


</script>

<%@ include file="footer.jsp" %>