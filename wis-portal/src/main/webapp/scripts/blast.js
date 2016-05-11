var blastfilecontent = '';
var synchronous = true;

function getBlastDBs() {
    jQuery('#blastDBs').html('Loading available BLAST databases <img src=\"../images/ajax-loader.gif\"/>');
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
                //synchronous = json.synchronousbool;
                Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                Utils.ui.reenableButton('blastButton2', 'BLAST Search');
            }
        }
    );

}

function sendBlastRequest() {
    if (validateJobID(jQuery('#sequence').val())) {
        Utils.ui.disableButton('blastButton1');
        Utils.ui.disableButton('blastButton2');
        jQuery('#blastResult').html('');
        jQuery('#output_format_div').show();

        var id = jQuery('#sequence').val();
        id = id.replace(/\s+/g, '');
        id = id.replace(/\r?\n|\r/g, '');
        var uuids = id.split(',');

        for (var j = 0; j < uuids.length; j++) {
            var uuid = uuids[j];
            jQuery('#blastResult').append('<div id=\"' + uuid + '_c\">Retrieving job id: ' + uuid + ' <img src=\"../images/ajax-loader.gif\"/></div>');
            Fluxion.doAjax(
                'wisControllerHelperService',
                'getPreviousJob',
                {
                    'id': uuid,
                    'url': ajaxurl
                },
                {
                    'doOnSuccess': function (json) {
                        jQuery('#' + uuid + '_c').html('');
                        jQuery('#' + uuid + '_c').append('<b>Job ID: ' + uuid + '</b> ');
                        jQuery('#' + uuid + '_c').append('<a href="javascript:;" id=\"' + uuid + 'dl\" onclick=\"downloadJobFromServer(\'' + uuid + '\');\">Download Job</a> in <span class="dlformat">Pairwise</span> format <span id=\"' + uuid + 'status\"></span><br/>');
                        jQuery('#' + uuid + '_c').append(json.html);
                    },
                    'doOnError': function (json) {
                        console.info(json.error);
                        jQuery('#' + uuid + '_c').html('Failed to retrieve job id: ' + uuid);
                    }
                }
            );
        }

        Utils.ui.reenableButton('blastButton1', 'BLAST Search');
        Utils.ui.reenableButton('blastButton2', 'BLAST Search');
    }
    else if (validateFasta(jQuery('#sequence').val()) || blastfilecontent != '') {
        jQuery('#blastResult').html('BLAST request submitted <img src=\"../images/ajax-loader.gif\"/>');
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
                        var job_in_response = response[i];
                        var uuid = job_in_response["job_uuid"];
                        var dbname = job_in_response["description"];

                        if (synchronous) {
                            var  blastHTML;
                            var result = job_in_response['results'][0];
                            Fluxion.doAjax(
                                'wisControllerHelperService',
                                'formatXMLBlastResultFrontend',
                                {
                                    'rawResultString': result['data'],
                                    'url': ajaxurl
                                },
                                {
                                    'doOnSuccess': function (json) {
                                        blastHTML = json.html;
                                        jQuery('#blastResult').append(
                                            '<fieldset><legend>' + dbname + '</legend><div><p><b>Job ID: '
                                            + uuid + '</b></p><div id=\"' + uuid + '\">' + blastHTML + '</div></div></br></fieldset>');
                                    }
                                }
                            );
                            Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                            Utils.ui.reenableButton('blastButton2', 'BLAST Search');
                        } else {
                            jQuery('#blastResult').append(
                                '<fieldset><legend>' + dbname + '</legend><div><p><b>Job ID: '
                                + uuid + '</b></p><div id=\"' + uuid + '\">Job Submitted <img src=\"../images/ajax-loader.gif\"/></div></div></br></fieldset>');
                            checkBlastResult(uuid);
                        }
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
                if (json.status == 4 || json.status == 5) {
                    Fluxion.doAjax(
                        'wisControllerHelperService',
                        'displayNewXMLBlastResult',
                        {
                            'uuid': uuid,
                            'url': ajaxurl
                        },
                        {
                            'doOnSuccess': function (json) {
                                jQuery('#output_format_div').show();
                                jQuery('#' + uuid).append('<a href="javascript:;" id=\"' + uuid + 'dl\" onclick=\"downloadJobFromServer(\'' + uuid + '\');\">Download Job</a> in <span class="dlformat">Pairwise</span> format <span id=\"' + uuid + 'status\"></span><br/>');
                                jQuery('#' + uuid).append(json.html);
                                Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                                Utils.ui.reenableButton('blastButton2', 'BLAST Search');
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
                }
            }
        }
    );
}


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

function validateJobID(id) {
    if (!id) { // check there is something first of all
        return false;
    }

    // immediately remove trailing spaces
    id = id.replace(/\s+/g, '');
    id = id.replace(/\r?\n|\r/g, '');
    return /^([0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12})+(,[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12})*$/g.test(id);
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


function downloadFileFromServer(id, db) {
    jQuery('#' + id + 'status').html('<img src=\"../images/ajax-loader.gif\"/>');
    jQuery('#' + id).removeAttr('onclick');
    Fluxion.doAjax(
        'wisControllerHelperService',
        'downloadFile',
        {
            'id': id,
            'db': db,
            'url': ajaxurl
        },
        {
            'doOnSuccess': function (json) {
                downloadFile(json.file, id);
                jQuery('#' + id + 'status').html('');
                jQuery('#' + id).attr('onclick', 'downloadFileFromServer(\'' + id + '\',\'' + db + '\')');
            },
            'doOnError': function (json) {
                console.info(json.error);
                jQuery('#' + id + 'status').html('Failed download the sequence, please try again.');
                jQuery('#' + id).attr('onclick', 'downloadFileFromServer(\'' + id + '\',\'' + db + '\')');
            }
        }
    );

}


function downloadFile(text, filename) {
    var blob = new Blob([text], {type: "text/plain;charset=utf-8"});
    saveAs(blob, filename + ".txt");
}


function downloadJobFromServer(id) {
    jQuery('#' + id + 'status').html('<img src=\"../images/ajax-loader.gif\"/>');
    jQuery('#' + id + 'dl').removeAttr('onclick');
    Fluxion.doAjax(
        'wisControllerHelperService',
        'downloadPreviousJob',
        {
            'id': id,
            'format': jQuery('#output_format').val(),
            'url': ajaxurl
        },
        {
            'doOnSuccess': function (json) {
                downloadFile(json["file"], id);
                jQuery('#' + id + 'status').html('');
                jQuery('#' + id + 'dl').attr('onclick', 'downloadJobFromServer(\'' + id + '\')');
            },
            'doOnError': function (json) {
                console.info(json.error);
                jQuery('#' + id + 'status').html('Failed download the sequence, please try again.');
                jQuery('#' + id + 'dl').attr('onclick', 'downloadJobFromServer(\'' + id + '\')');
            }
        }
    );

}

function handleFileSelect(evt) {
    evt.stopPropagation();
    evt.preventDefault();

    var files = evt.dataTransfer.files; // FileList object.

    // files is a FileList of File objects. List some properties.
    var output = [];
    var f = files[0];
    output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
        f.size, ' bytes, last modified: ',
        f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a',
        '</li>');
    document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
    //var f = files[0];
    if (f) {
        var r = new FileReader();
        r.onload = function (e) {
            var contents = e.target.result;
            blastfilecontent = contents;
        }
        r.readAsText(f);
    }
    else {
        alert("Failed to load file");
    }
}

function handleDragOver(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    evt.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
}

function changeDownloadFormat() {
    jQuery('.dlformat').html(jQuery("#output_format option:selected").text());
}