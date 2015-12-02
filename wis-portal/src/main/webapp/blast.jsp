<%@ include file="header.jsp" %>

<div class="container center-block">
    <h2 id="blastTitle">Grassroots Genomics BLAST Search </h2>

    <p>
        <small>If you have any queries about this service, please email the <a href="mailto:grasshelpdesk@tgac.ac.uk">Grassroots
            Helpdesk</a></small>
    </p>
    <%--<p>--%>
        <%--<small><i>We are experiencing some issues with the connection to our HPC cluster, this might affect some users.--%>
            <%--If you see a job error, please could you wait for a few minutes and then resubmit your job.</i></small>--%>
    <%--</p>--%>
    <%--<p><font color="red">Please note: TGAC's high-performance cluster that powers this service will be undergoing--%>
        <%--maintenance from 08:00 to 18:00 GMT on the 28th November. As such this service will be offline during this--%>
        <%--period.</font></p>--%>

    <form id="blastSearchForm">
        <p/>
        Enter sequence below in FASTA format
        <br/>
<textarea name="sequence" id="sequence" rows="10" cols="80">
</textarea>
        <br/>
        Or load it from disk
        <input type="file" name="seqfile" onchange="readSingleFile();" id="seqfile"/>

        <p/>
        Set subsequence: From <input type="text" name="query_from" id="query_from" value="0" size="10">
        To <input type="text" name="query_to" id="query_to" value="0" size="10">

        <p/>
        <fieldset>
            <legend>BLAST Databases</legend>
            <div id="blastDBs"></div>
        </fieldset>
        <button id="blastButton1" type="button" onclick="sendBlastRequest();">BLAST Search</button>
        <hr/>
        <h3>Algorithm parameters</h3>
        <fieldset>
            <legend>General Parameters</legend>
            <table border="0">
                <tr>
                    <td><span class="blastFormTitle">Max target sequences non-default value</span></td>
                    <td><select name="max_target_sequences" id="max_target_sequences">
                        <option value="10">10</option>
                        <option value="50">50</option>
                        <option value="100" selected="selected">100</option>
                        <option value="250">250</option>
                        <option value="500">500</option>
                        <option value="1000">1000</option>
                        <option value="5000">5000</option>
                        <option value="10000">10000</option>
                        <option value="20000">20000</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="blastFormTitle">Short queries</span></td>
                    <td><select name="short_queries" id="short_queries">
                        <option value="false" selected="selected">false</option>
                        <option value="true">true</option>
                    </select></td>

                </tr>
                <tr>
                    <td><span class="blastFormTitle">Expect threshold non-default value</span></td>
                    <td><input name="expect_threshold" id="expect_threshold" size="10" type="text" value="10"/></td>

                </tr>
                <tr>
                    <td><span class="blastFormTitle">Word size non-default value</span></td>
                    <td><select name="word_size" id="word_size" class="reset checkDef opts" defval="28">
                        <option value="16">16</option>
                        <option value="20">20</option>
                        <option value="24">24</option>
                        <option value="28" selected="selected">28</option>
                        <option value="32">32</option>
                        <option value="48">48</option>
                        <option value="64">64</option>
                        <option value="128">128</option>
                        <option value="256">256</option>
                    </select></td>

                </tr>
                <tr>
                    <td><span class="blastFormTitle">Max matches in a query range non-default value</span></td>
                    <td><input name="max_matches_query_range" id="max_matches_query_range" size="10" type="text"
                               value="0"/>
                    </td>
                </tr>
                <tr>
                    <td><span class="blastFormTitle">Match</span></td>
                    <td><input name="match" id="match" size="10" type="text" value="2"/>
                    </td>
                </tr>
                <tr>
                    <td><span class="blastFormTitle">Mismatch</span></td>
                    <td><input name="mismatch" id="mismatch" size="10" type="text" value="-3" param="test"/>
                    </td>
                </tr>
            </table>
        </fieldset>
        <p/>
        <button id="blastButton2" type="button" onclick="sendBlastRequest();">BLAST Search</button>
    </form>

    <div id="blastResult"></div>

    <script type="text/javascript">

        jQuery(document).ready(function () {
            getBlastDBs();
        });
        var blastfilecontent = '';

        function getBlastDBs() {
            jQuery('#blastDBs').html('Loading available BLAST databases <img src=\"/grassroots-portal/images/ajax-loader.gif\"/>');
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
            if (validateFasta(jQuery('#sequence').val()) || (jQuery('#sequence').val() == '' && jQuery('#seqfile').val() != '')) {
//            if (jQuery('#sequence').val()=='' && jQuery('#seqfile').val()!='') {
//                readSingleFile('seqfile');
//            }
                jQuery('#blastResult').html('BLAST request submitted <img src=\"/grassroots-portal/images/ajax-loader.gif\"/>');
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
                                            + uuid + '</b></p><div id=\"' + uuid + '\">Job Submitted <img src=\"/grassroots-portal/images/ajax-loader.gif\"/></div></div></br></fieldset>');
                                    checkBlastResult(uuid);
                                }
                            }
                        }
                );
            }
            else {
                alert('Not valid FASTA format in the text area!');
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
                                                stopJob(uuid);
//                                                clearTimeout(timer);
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
                                }, 5000);
                            }
                            else {
                                Utils.ui.reenableButton('blastButton1', 'BLAST Search');
                                Utils.ui.reenableButton('blastButton2', 'BLAST Search');
                                stopJob(uuid);
//                                clearTimeout(timer);
                            }
                        }
                    }
            );
        }


        function stopJob(uuid) {
            Fluxion.doAjax(
                    'wisControllerHelperService',
                    'stopJob',
                    {
                        'uuid': uuid,
                        'url': ajaxurl
                    },
                    {
                        'doOnSuccess': function (json) {
                            console.log("Stopped job: " + uuid);
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
            jQuery('#' + id + 'status').html('<img src=\"/grassroots-portal/images/ajax-loader.gif\"/>');
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
                        }
                    }
            );

        }


        function downloadFile(text, filename) {
            var blob = new Blob([text], {type: "text/plain;charset=utf-8"});
            saveAs(blob, filename + ".txt");
        }

    </script>
</div>

<%@ include file="footer.jsp" %>