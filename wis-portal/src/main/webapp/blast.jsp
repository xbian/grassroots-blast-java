<%@ include file="header.jsp" %>

<script type="text/javascript" src="<c:url value='/scripts/blast.js?ts=${timestamp.time}'/>"></script>
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
        Enter sequence below in FASTA format or a previous job id
        <br/>
<textarea name="sequence" id="sequence" rows="10" cols="80">
</textarea>
        <br/>
        <%--Or load it from disk--%>
        <%--<input type="file" name="seqfile" onchange="readSingleFile();" id="seqfile"/>--%>
        <div id="seqfile" class="dropzone">Drop file here</div>
        <output id="list"></output>

        <%--<p/>--%>


        <%--<p/>--%>
        <fieldset>
            <legend>BLAST Databases</legend>
            <div id="blastDBs"></div>
        </fieldset>
        <button id="blastButton1" type="button" onclick="sendBlastRequest();">BLAST Search</button>
        <%--<hr/>--%>
        <%--<h3></h3>--%>
        <div class="sectionDivider"
             onclick="Utils.ui.toggleLeftInfo(jQuery('#parameter_arrowclick'), 'blast_parameters');">Algorithm
            parameters
            <div id="parameter_arrowclick" class="toggleLeft"></div>
        </div>
        <div id="blast_parameters" class="note" style="display:none;">
            <fieldset>
                <legend>Algorithm parameters</legend>
                <table border="0">
                    <tr>
                        <td>Set subsequence:</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="padding-left:20px;">From</td>
                        <td><input type="text" name="query_from" id="query_from" value="0" size="10"></td>
                    </tr>
                    <tr>
                        <td style="padding-left:20px;"> To</td>
                        <td><input type="text" name="query_to" id="query_to" value="0" size="10"></td>
                    </tr>
                    <tr>
                        <td><span class="blastFormTitle">Short queries</span></td>
                        <td><select name="short_queries" id="short_queries">
                            <option value="false" selected="selected">false</option>
                            <option value="true">true</option>
                        </select></td>

                    </tr>
                    <tr>
                        <td><span class="blastFormTitle">Word size</span></td>
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
                        <td><span class="blastFormTitle">Max matches</span></td>
                        <td><input name="max_matches_query_range" id="max_matches_query_range" size="10" type="text"
                                   value="0"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="blastFormTitle">Match reward</span></td>
                        <td><input name="match" id="match" size="10" type="text" value="2"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="blastFormTitle">Mismatch penalty</span></td>
                        <td><input name="mismatch" id="mismatch" size="10" type="text" value="-3" param="test"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <button id="blastButton2" type="button" onclick="sendBlastRequest();">BLAST Search</button>
        </div>
    </form>
    <div id="output_format_div" style="display:none; float:right;">
        <p>Download job format
            <select id="output_format" onchange="changeDownloadFormat();">
                <option value="0" selected="selected">Pairwise</option>
                <option value="1">Query-anchored showing identities</option>
                <option value="2">Query-anchored no identities</option>
                <option value="3">Flat query-anchored, show identities</option>
                <option value="4">Flat query-anchored, no identities</option>
                <option value="5">XML Blast output</option>
                <option value="6">Tabular</option>
                <option value="7">Tabular with comment lines</option>
                <option value="8">Text ASN.1</option>
                <option value="9">Binary ASN.1</option>
                <option value="10">Comma-separated values</option>
                <option value="11">BLAST archive format (ASN.1)</option>
                <option value="12">JSON Seqalign output</option>
                <%--<option value="13">JSON Blast output</option>--%>
                <%--<option value="14">XML2 Blast output</option>--%>
            </select>
        </p>
    </div>
    <div style="clear:both;"></div>

    <div id="blastResult"></div>

    <script type="text/javascript">
        var dropZone = document.getElementById('seqfile');

        dropZone.addEventListener('dragover', handleDragOver, false);
        dropZone.addEventListener('drop', handleFileSelect, false);
        jQuery(document).ready(function () {
            getBlastDBs();
        });

    </script>
</div>

<%@ include file="footer.jsp" %>