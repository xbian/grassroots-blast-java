<%@ include file="header.jsp" %>

<div class="container center-block">
<h2 id="blastTitle">Grassroots Genomics BLAST Search </h2>

<p><small>This is a proof of concept, there are might be hiccups please bear with us and we will keep this system updated..</small></p>

<form id="blastSearchForm">
    <p/>
    Enter sequence below in FASTA format
    <br/>
<textarea name="sequence" id="sequence" rows="10" cols="80">
</textarea>
    <br/>
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
                <td><span class="blastFormTitle">Max target sequences non-default value</span></td>
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
                <td><input name="max_matches_query_range" id="max_matches_query_range" size="10" type="text" value="0"/>
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
        jQuery('#blastResult').html('BLAST request submitted <img src=\"/images/ajax-loader.gif\"/>');
        Utils.ui.disableButton('blastButton1');
        Utils.ui.disableButton('blastButton2');
        Fluxion.doAjax(
                'wisControllerHelperService',
                'sendBlastRequest',
                {
                    'form': jQuery('#blastSearchForm').serializeArray(),
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
                                    'displayXMLBlastResult',
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
                        console.log("Stopped job: "+ uuid);
                    }
                }
        );

    }
</script>
</div>

<%@ include file="footer.jsp" %>