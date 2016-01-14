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
    if (validateJobID(jQuery('#sequence').val())) {
        var uuid = jQuery('#sequence').val();
        jQuery('#blastResult').html('Retrieving job id: ' + uuid + ' <img src=\"/images/ajax-loader.gif\"/>');
        Utils.ui.disableButton('blastButton1');
        Utils.ui.disableButton('blastButton2');
        Fluxion.doAjax(
            'wisControllerHelperService',
            'getPreviousJob',
            {
                'id': jQuery('#sequence').val(),
                'url': ajaxurl
            },
            {
                'doOnSuccess': function (json) {
                    jQuery('#blastResult').html('');
                    Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                    Utils.ui.reenableButton('blastButton2', 'BLAST Search');
                    jQuery('#blastResult').append('<b>Job ID: ' + uuid + '</b><br/>');
                    jQuery('#blastResult').append(json.html);
                },
                'doOnError': function (json) {
                    console.info(json.error);
                    jQuery('#blastResult').html('Failed to retrieve job id: ' + uuid);
                    Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                    Utils.ui.reenableButton('blastButton2', 'BLAST Search');
                }
            }
        );
        console.log('job id: ' + uuid);
    }
    else if (validateFasta(jQuery('#sequence').val()) || blastfilecontent != '') {
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
                        var uuid = job['job_uuid'];
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
                                jQuery('#' + uuid).html(json.html);
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
    id = id.trim();
    return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(id);
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
    jQuery('#' + id + 'status').html('<img src=\"/images/ajax-loader.gif\"/>');
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
                jQuery('#' + id).attr('onclick', 'downloadFileFromServer(\'' + id + '\')');
            },
            'doOnError': function (json) {
                console.info(json.error);
                jQuery('#' + id + 'status').html('Failed download the sequence, please try again.');
                jQuery('#' + id).attr('onclick', 'downloadFileFromServer(\'' + id + '\')');
            }
        }
    );

}


function downloadFile(text, filename) {
    var blob = new Blob([text], {type: "text/plain;charset=utf-8"});
    saveAs(blob, filename + ".txt");
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
