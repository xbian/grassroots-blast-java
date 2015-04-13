<%@ include file="tgacHeader.jsp" %>
<div class="breadcrumbs">» <a href="http://www.tgac.ac.uk/">Home</a> » <a href="http://www.tgac.ac.uk/grassroots-genomics/">Grassroots Genomics</a>
    » <a href="<c:url value='/grassroot.jsp'/>">Blast Search</a></div>
<h2>Grassroots Genomics Blast Search</h2>

<p/>
    Enter sequence below in FASTA format
    <br/>
<textarea name="SEQUENCE" id="sequence" rows=6 cols=60>
</textarea>
    <br/>
    Or load it from disk
    <input type="file" name="SEQFILE">
<p/>
    Set subsequence: From
    &nbsp;&nbsp<input type="text" name="QUERY_FROM" value="" size="10">
    &nbsp;&nbsp&nbsp;&nbsp To
    <input type="text" name="QUERY_TO" value="" size="10">
<p/>
    <input type="button" value="Clear sequence" onClick="jQuery('#sequence').html();">
    <input type="submit" value="Search">
<HR>

The query sequence is
filtered
for low complexity regions by default.
<br/>
Filter
<input type="checkbox" value="L" name="FILTER" checked> Low complexity
<input type="checkbox" value="m" name="FILTER"> Mask for lookup table only
<p/>
    Expect
    <select name = "EXPECT">
        <option> 0.0001
        <option> 0.01
        <option> 1
        <option selected> 10
        <option> 100
        <option> 1000
    </select>

    Matrix
    <select name = "MAT_PARAM">
        <option value = "PAM30	 9	 1"> PAM30 </option>
        <option value = "PAM70	 10	 1"> PAM70 </option>
        <option value = "BLOSUM80	 10	 1"> BLOSUM80 </option>
        <option selected value = "BLOSUM62	 11	 1"> BLOSUM62 </option>
        <option value = "BLOSUM45	 14	 2"> BLOSUM45 </option>
    </select>
    <input type="checkbox" name="UNGAPPED_ALIGNMENT" value="is_set"> Perform ungapped alignment
<p/>
    Query Genetic Codes (blastx only)
    <select name = "GENETIC_CODE">
        <option> Standard (1)
        <option> Vertebrate Mitochondrial (2)
        <option> Yeast Mitochondrial (3)
        <option> Mold Mitochondrial; ... (4)
        <option> Invertebrate Mitochondrial (5)
        <option> Ciliate Nuclear; ... (6)
        <option> Echinoderm Mitochondrial (9)
        <option> Euplotid Nuclear (10)
        <option> Bacterial (11)
        <option> Alternative Yeast Nuclear (12)
        <option> Ascidian Mitochondrial (13)
        <option> Flatworm Mitochondrial (14)
        <option> Blepharisma Macronuclear (15)
    </select>
<p/>
    Database Genetic Codes (tblast[nx] only)
    <select name = "DB_GENETIC_CODE">
        <option> Standard (1)
        <option> Vertebrate Mitochondrial (2)
        <option> Yeast Mitochondrial (3)
        <option> Mold Mitochondrial; ... (4)
        <option> Invertebrate Mitochondrial (5)
        <option> Ciliate Nuclear; ... (6)
        <option> Echinoderm Mitochondrial (9)
        <option> Euplotid Nuclear (10)
        <option> Bacterial (11)
        <option> Alternative Yeast Nuclear (12)
        <option> Ascidian Mitochondrial (13)
        <option> Flatworm Mitochondrial (14)
        <option> Blepharisma Macronuclear (15)
    </select>
<p/>
    Frame shift penalty for blastx
    <select name = "OOF_ALIGN">
        <option> 6
        <option> 7
        <option> 8
        <option> 9
        <option> 10
        <option> 11
        <option> 12
        <option> 13
        <option> 14
        <option> 15
        <option> 16
        <option> 17
        <option> 18
        <option> 19
        <option> 20
        <option> 25
        <option> 30
        <option> 50
        <option> 1000
        <option selected value = "0"> No OOF
    </select>
<p/>
    Other advanced options:

    <input type="text" name="OTHER_ADVANCED" value="" MAXLENGTH="50">
<hr>
<input type="checkbox" name="OVERVIEW"  checked>

Graphical Overview
&nbsp;&nbsp;
Alignment view
<select name = "ALIGNMENT_VIEW">
    <option value=0> Pairwise
    <option value=1> master-slave with identities
    <option value=2> master-slave without identities
    <option value=3> flat master-slave with identities
    <option value=4> flat master-slave without identities
    <option value=7> BLAST XML
    <option value=9> Hit Table
</select>
<br>
<a href="docs/newoptions.html#descriptions">Descriptions</a>
<select name = "DESCRIPTIONS">
    <option> 0
    <option> 10
    <option> 50
    <option selected> 100
    <option> 250
    <option> 500
</select>
Alignments
<select name = "ALIGNMENTS">
    <option> 0
    <option> 10
    <option selected> 50
    <option> 100
    <option> 250
    <option> 500
</select>
Color schema
<select name = "COLOR_SCHEMA">
    <option selected value = 0> No color schema
    <option value = 1> Color schema 1
    <option value = 2> Color schema 2
    <option value = 3> Color schema 3
    <option value = 4> Color schema 4
    <option value = 5> Color schema 5
    <option value = 6> Color schema 6
</select>
<P/>
    <input type="button" value="Clear sequence" onClick="jQuery('#sequence').html();">
    <input type="submit" value="Search">
    </form>
<%@ include file="tgacFooter.jsp" %>