<%@ include file="header.jsp" %>

<script type="text/javascript" src="<c:url value='/scripts/blast.js'/>"></script>
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
        <%--or previous job id--%>
        <br/>
<textarea name="sequence" id="sequence" rows="10" cols="80">
</textarea>
        <br/>
        <%--Or load it from disk--%>
        <%--<input type="file" name="seqfile" onchange="readSingleFile();" id="seqfile"/>--%>
        <div id="seqfile" class="dropzone">Drop file here</div>
        <output id="list"></output>

        <p/>


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
                <%--<tr>--%>
                <%--<td><span class="blastFormTitle">Max target sequences non-default value</span></td>--%>
                <%--<td><select name="max_target_sequences" id="max_target_sequences">--%>
                <%--<option value="10">10</option>--%>
                <%--<option value="50">50</option>--%>
                <%--<option value="100" selected="selected">100</option>--%>
                <%--<option value="250">250</option>--%>
                <%--<option value="500">500</option>--%>
                <%--<option value="1000">1000</option>--%>
                <%--<option value="5000">5000</option>--%>
                <%--<option value="10000">10000</option>--%>
                <%--<option value="20000">20000</option>--%>
                <%--</select></td>--%>
                <%--</tr>--%>
                <tr>
                    <td><span class="blastFormTitle">Short queries</span></td>
                    <td><select name="short_queries" id="short_queries">
                        <option value="false" selected="selected">false</option>
                        <option value="true">true</option>
                    </select></td>

                </tr>
                <%--<tr>--%>
                <%--<td><span class="blastFormTitle">Expect threshold non-default value</span></td>--%>
                <%--<td><input name="expect_threshold" id="expect_threshold" size="10" type="text" value="10"/></td>--%>

                <%--</tr>--%>
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
        var dropZone = document.getElementById('seqfile');

        dropZone.addEventListener('dragover', handleDragOver, false);
        dropZone.addEventListener('drop', handleFileSelect, false);
        jQuery(document).ready(function () {
            getBlastDBs();
        });

    </script>
</div>

<%@ include file="footer.jsp" %>