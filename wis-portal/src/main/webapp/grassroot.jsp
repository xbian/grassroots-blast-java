<%@ include file="tgacHeader.jsp" %>
<div class="breadcrumbs">&raquo; <a href="http://www.tgac.ac.uk/">Home</a> &raquo; <a
        href="http://www.tgac.ac.uk/grassroots-genomics/">Grassroots Genomics</a>
    &raquo; <a href="<c:url value='/grassroot.jsp'/>">Blast Search</a></div>
<h2>Grassroots Genomics Blast Search</h2>

<p/>
Enter sequence below in FASTA format
<br/>
<textarea name="SEQUENCE" id="sequence" rows=6 cols=60>
</textarea>
<br/>
<%--Or load it from disk--%>
<%--<input type="file" name="SEQFILE">--%>
<p/>
<%--Set subsequence: From <input type="text" name="QUERY_FROM" value="" size="10">--%>
<%--To <input type="text" name="QUERY_TO" value="" size="10">--%>
<%--<p/>--%>
<input type="submit" value="Blast Search">
<hr/>
<h3>Algorithm parameters</h3>
<h4>General Parameters</h4>

<span class="nonDefPar"><span class="acPromt">Max target sequences non-default value</span></span>
<select name="MAX_NUM_SEQ" class="reset checkDef opts" id="NUM_SEQ" defval="100">
    <option value="10">10</option>
    <option value="50">50</option>
    <option value="100" selected="selected">100</option>
    <option value="250">250</option>
    <option value="500">500</option>
    <option value="1000">1000</option>
    <option value="5000">5000</option>
    <option value="10000">10000</option>
    <option value="20000">20000</option>
</select><br/>

<br/>
<input type="checkbox" name="SHORT_QUERY_ADJUST" class="reset" id="adjparam" checked="checked">
<label class="right inlinelabel" for="adjparam">Automatically adjust parameters for short input sequences</label>
<br/>

<span class="nonDefPar"><span class="acPromt">Expect threshold non-default value</span></span>
<input name="EXPECT" id="expect" class="reset checkDef opts" size="10" type="text" value="10" defval="10">
<br/>

<span class="nonDefPar"><span class="acPromt">Word size non-default value</span></span>
<select name="WORD_SIZE" id="wordsize" class="reset checkDef opts" defval="28">
    <option value="16">16</option>
    <option value="20">20</option>
    <option value="24">24</option>
    <option value="28" class="Deflt" selected="selected">28</option>
    <option value="32">32</option>
    <option value="48">48</option>
    <option value="64">64</option>
    <option value="128">128</option>
    <option value="256">256</option>
</select>
<br/>

<span class="nonDefPar"><span class="acPromt">Max matches in a query range non-default value</span></span>
<input name="HSP_RANGE_MAX" id="hsp_range_max" class="reset checkDef opts" size="10" type="text" value="0"
       defval="0">
<br/>
<hr/>
<p/>
<input type="submit" value="Blast Search">
</form>

<div id="blastStatus"></div>
<div id="blastResult"></div>
<%@ include file="tgacFooter.jsp" %>