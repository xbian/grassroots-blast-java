var blastfilecontent = '';

function getBlastDBs() {
    jQuery('#blastDBs').html('Loading available BLAST databases <img src=\"/images/ajax-loader.gif\"/>');
    Utils.ui.disableButton('blastButton1');
    Utils.ui.disableButton('blastButton2');
    Fluxion.doAjax(
        'wisControllerHelperService',
        'getBlastService',
        {
            'url': ajaxurl
        },
        {
            'doOnSuccess': function (json) {
                jQuery('#blastDBs').html(json.html);
                Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                Utils.ui.reenableButton('blastButton2', 'BLAST Search');
            }
        }
    );

}

function sendBlastRequest() {
    if (validateFasta(jQuery('#sequence').val()) || (jQuery('#sequence').val() == '' && (jQuery('#seqfile').val() != '' && blastfilecontent != ''))) {
//            if (jQuery('#sequence').val()=='' && jQuery('#seqfile').val()!='') {
//                readSingleFile('seqfile');
//            }
        jQuery('#blastResult').html('BLAST request submitted <img src=\"/images/ajax-loader.gif\"/>');
        Utils.ui.disableButton('blastButton1');
        Utils.ui.disableButton('blastButton2');
        Fluxion.doAjax(
            'wisControllerHelperService',
            'sendBlastRequest',
            {
                'form': jQuery('#blastSearchForm').serializeArray(), 'blastfile': blastfilecontent,
                'url': ajaxurl
            },
            {
                'doOnSuccess': function (json) {
                    jQuery('#blastResult').html('');
                    var response = json.response;
                    for (var i = 0; i < response.length; i++) {
                        var job = response[i];
                        var uuid = job['service_uuid'];
                        var name = job['description'].split(";", 1);
                        jQuery('#blastResult').append(
                            '<fieldset><legend>' + name + '</legend><div><p><b>Job ID: '
                            + uuid + '</b></p><div id=\"' + uuid + '\">Job Submitted <img src=\"/images/ajax-loader.gif\"/></div></div></br></fieldset>');
                        checkBlastResult(uuid);
                    }
                }
            }
        );
    }
    else {
        alert('Not valid FASTA format in the text area! Or blast file isn\'t supplied');
    }

}

function checkBlastResult(uuid) {
    Fluxion.doAjax(
        'wisControllerHelperService',
        'checkBlastResult',
        {
            'uuid': uuid,
            'url': ajaxurl
        },
        {
            'doOnSuccess': function (json) {
                jQuery('#' + uuid).html(json.html);
                if (json.status == 4) {
                    Fluxion.doAjax(
                        'wisControllerHelperService',
                        'displayNewXMLBlastResult',
                        {
                            'uuid': uuid,
                            'url': ajaxurl
                        },
                        {
                            'doOnSuccess': function (json) {
                                jQuery('#' + uuid).html(json.html);
                                Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                                Utils.ui.reenableButton('blastButton2', 'BLAST Search');
//                                                stopJob(uuid);
                            }
                        }
                    );
                }
                else if (json.status == 0 || json.status == 1 || json.status == 2 || json.status == 3) {
                    jQuery('#' + uuid).html(json.html);
                    var timer;
                    clearTimeout(timer);
                    timer = setTimeout(function () {
                        checkBlastResult(uuid);
                    }, 6500);
                }
                else {
                    Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                    Utils.ui.reenableButton('blastButton2', 'BLAST Search');
//                                stopJob(uuid);
                }
            }
        }
    );
}

//
//function stopJob(uuid) {
//    Fluxion.doAjax(
//        'wisControllerHelperService',
//        'stopJob',
//        {
//            'uuid': uuid,
//            'url': ajaxurl
//        },
//        {
//            'doOnSuccess': function (json) {
//                console.log(json);
//            }
//        }
//    );
//
//}

function validateFasta(fasta) {

    if (!fasta) { // check there is something first of all
        return false;
    }

    // immediately remove trailing spaces
    fasta = fasta.trim();

    // split on newlines...
    var lines = fasta.split('\n');

    // check for header
    if (fasta[0] == '>') {
        // remove one line, starting at the first position
        lines.splice(0, 1);
    }

    // join the array back into a single string without newlines and
    // trailing or leading spaces
    fasta = lines.join('').trim();

    if (!fasta) { // is it empty whatever we collected ? re-check not efficient
        return false;
    }

    // note that the empty string is caught above
    // allow for Selenocysteine (U)
    return /^[ACDEFGHIKLMNPQRSTUVWY\s]+$/i.test(fasta);
}

function readSingleFile() {
    if (window.File && window.FileReader && window.FileList && window.Blob) {

        var f = document.getElementById('seqfile').files[0];

        if (f) {
            var r = new FileReader();
            r.onload = function (e) {
                var contents = e.target.result;
                blastfilecontent = contents;
//                    alert(contents);
            }
            r.readAsText(f);
        }
        else {
            alert("Failed to load file");
        }
    }
    else {
        alert('The File APIs are not fully supported by your browser.');
    }
}


function downloadFileFromServer(id) {
    jQuery('#' + id + 'status').html('<img src=\"/images/ajax-loader.gif\"/>');
    jQuery('#' + id ).removeAttr('onclick');
    Fluxion.doAjax(
        'wisControllerHelperService',
        'downloadFile',
        {
            'id': id,
            'url': ajaxurl
        },
        {
            'doOnSuccess': function (json) {
                downloadFile(json.file, id);
                jQuery('#' + id + 'status').html('');
                jQuery('#' + id ).attr('onclick','downloadFileFromServer(\''+id+'\')');
            },
            'doOnError': function (json) {
                alert(json.error);
                jQuery('#' + id + 'status').html('');
                jQuery('#' + id).attr('onclick', 'downloadFileFromServer(\'' + id + '\')');
            }
        }
    );

}


function downloadFile(text, filename) {
    var blob = new Blob([text], {type: "text/plain;charset=utf-8"});
    saveAs(blob, filename + ".txt");
}
