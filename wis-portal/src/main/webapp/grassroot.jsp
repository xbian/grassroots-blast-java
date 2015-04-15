<%@ include file="tgacHeader.jsp" %>
<div class="breadcrumbs">&raquo; <a href="http://www.tgac.ac.uk/">Home</a> &raquo; <a
        href="http://www.tgac.ac.uk/grassroots-genomics/">Grassroots Genomics</a>
    &raquo; <a href="<c:url value='/grassroot.jsp'/>">Blast Search</a></div>
<h2>Grassroots Genomics Blast Search</h2>
<form id="blastSearchForm">
<p/>
Enter sequence below in FASTA format
<br/>
<textarea name="sequence" id="sequence" rows=6 cols=60>
</textarea>
<br/>
<%--Or load it from disk--%>
<%--<input type="file" name="SEQFILE">--%>
<p/>
<%--Set subsequence: From <input type="text" name="QUERY_FROM" value="" size="10">--%>
<%--To <input type="text" name="QUERY_TO" value="" size="10">--%>
<%--<p/>--%>
<button type="button" onclick="doBlast();">Blast Search</button>
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
</select>
<br/>

<span class="nonDefPar"><span class="acPromt">Expect threshold non-default value</span></span>
<input name="EXPECT" id="expect" class="reset checkDef opts" size="10" type="text" value="10" defval="10">
<br/>

<span class="nonDefPar"><span class="acPromt">Word size non-default value</span></span>
<select name="WORD_SIZE" id="wordsize" class="reset checkDef opts" defval="28">
    <option value="16">16</option>
    <option value="20">20</option>
    <option value="24">24</option>
    <option value="28" selected="selected">28</option>
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
<button type="button" onclick="doBlast();">Blast Search</button>
</form>

<div id="blastStatus"></div>
<div id="blastResult"></div>

<script type="text/javascript">
    var blastdummy = {
    "BlastOutput": {
        "report": {
            "program": "blastn",
                    "version": "BLASTN 2.2.31+",
                    "reference": "Zheng Zhang, Scott Schwartz, Lukas Wagner, and Webb Miller (2000), \"A greedy algorithm for aligning DNA sequences\", J Comput Biol 2000; 7(1-2):203-14.",
                    "search_target": {
                "db": "nr"
            },
            "params": {
                "expect": 10,
                        "sc_match": 1,
                        "sc_mismatch": -2,
                        "gap_open": 0,
                        "gap_extend": 0,
                        "filter": "L;m;"
            },
            "results": {
                "search": {
                    "query_id": "Query_51745",
                            "query_len": 180,
                            "hits": [
                        {
                            "num": 1,
                            "description": [
                                {
                                    "id": "gi|219814405|gb|FJ436986.1|",
                                    "accession": "FJ436986",
                                    "title": "Aegilops tauschii Lr34 locus, partial sequence",
                                    "taxid": 37682,
                                    "sciname": "Aegilops tauschii"
                                }
                            ],
                            "len": 192638,
                            "hsps": [
                                {
                                    "num": 1,
                                    "bit_score": 274.424,
                                    "score": 148,
                                    "evalue": 3.21578e-70,
                                    "identity": 164,
                                    "query_from": 6,
                                    "query_to": 177,
                                    "query_strand": "Plus",
                                    "hit_from": 119096,
                                    "hit_to": 119267,
                                    "hit_strand": "Plus",
                                    "align_len": 172,
                                    "gaps": 0,
                                    "qseq": "AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG",
                                    "hseq": "AAAGTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTCGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG",
                                    "midline": "||||||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||||||||| |||||||  ||||||||||||||||||||||||||||||||  ||||||||||||||||||||||||| |||||||||||||||"
                                }
                            ]
                        },
                        {
                            "num": 2,
                            "description": [
                                {
                                    "id": "gi|241986938|dbj|AK334199.1|",
                                    "accession": "AK334199",
                                    "title": "Triticum aestivum cDNA, clone: WT009_G16, cultivar: Chinese Spring",
                                    "taxid": 4565,
                                    "sciname": "Triticum aestivum"
                                }
                            ],
                            "len": 2261,
                            "hsps": [
                                {
                                    "num": 1,
                                    "bit_score": 257.805,
                                    "score": 139,
                                    "evalue": 3.23861e-65,
                                    "identity": 161,
                                    "query_from": 6,
                                    "query_to": 177,
                                    "query_strand": "Plus",
                                    "hit_from": 1821,
                                    "hit_to": 1992,
                                    "hit_strand": "Plus",
                                    "align_len": 172,
                                    "gaps": 0,
                                    "qseq": "AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG",
                                    "hseq": "AAATTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGCATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTTGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG",
                                    "midline": "||| ||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||| ||||| |||||||  |||||||||||||||||||||| |||||||||  ||||||||||||||||||||||||| |||||||||||||||"
                                }
                            ]
                        },
                        {
                            "num": 3,
                            "description": [
                                {
                                    "id": "gi|224365600|gb|FJ436983.1|",
                                    "accession": "FJ436983",
                                    "title": "Triticum aestivum cultivar Chinese Spring hexose carrier, LR34, cytochrome P450, lectin receptor kinases, and cytochrome P450 genes, complete cds",
                                    "taxid": 4565,
                                    "sciname": "Triticum aestivum"
                                }
                            ],
                            "len": 207179,
                            "hsps": [
                                {
                                    "num": 1,
                                    "bit_score": 257.805,
                                    "score": 139,
                                    "evalue": 3.23861e-65,
                                    "identity": 161,
                                    "query_from": 6,
                                    "query_to": 177,
                                    "query_strand": "Plus",
                                    "hit_from": 104832,
                                    "hit_to": 105003,
                                    "hit_strand": "Plus",
                                    "align_len": 172,
                                    "gaps": 0,
                                    "qseq": "AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG",
                                    "hseq": "AAATTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGCATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTTGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG",
                                    "midline": "||| ||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||| ||||| |||||||  |||||||||||||||||||||| |||||||||  ||||||||||||||||||||||||| |||||||||||||||"
                                }
                            ]
                        },
                        {
                            "num": 4,
                            "description": [
                                {
                                    "id": "gi|219814397|gb|FJ436984.1|",
                                    "accession": "FJ436984",
                                    "title": "Triticum aestivum cultivar Glenlea Lr34 locus, partial sequence",
                                    "taxid": 4565,
                                    "sciname": "Triticum aestivum"
                                }
                            ],
                            "len": 147171,
                            "hsps": [
                                {
                                    "num": 1,
                                    "bit_score": 257.805,
                                    "score": 139,
                                    "evalue": 3.23861e-65,
                                    "identity": 161,
                                    "query_from": 6,
                                    "query_to": 177,
                                    "query_strand": "Plus",
                                    "hit_from": 44450,
                                    "hit_to": 44621,
                                    "hit_strand": "Plus",
                                    "align_len": 172,
                                    "gaps": 0,
                                    "qseq": "AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG",
                                    "hseq": "AAATTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGCATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTTGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG",
                                    "midline": "||| ||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||| ||||| |||||||  |||||||||||||||||||||| |||||||||  ||||||||||||||||||||||||| |||||||||||||||"
                                }
                            ]
                        },
                        {
                            "num": 5,
                            "description": [
                                {
                                    "id": "gi|326503961|dbj|AK371569.1|",
                                    "accession": "AK371569",
                                    "title": "Hordeum vulgare subsp. vulgare mRNA for predicted protein, complete cds, clone: NIASHv2137F13",
                                    "taxid": 112509,
                                    "sciname": "Hordeum vulgare subsp. vulgare"
                                }
                            ],
                            "len": 2214,
                            "hsps": [
                                {
                                    "num": 1,
                                    "bit_score": 255.958,
                                    "score": 138,
                                    "evalue": 1.16481e-64,
                                    "identity": 160,
                                    "query_from": 7,
                                    "query_to": 177,
                                    "query_strand": "Plus",
                                    "hit_from": 1806,
                                    "hit_to": 1976,
                                    "hit_strand": "Plus",
                                    "align_len": 171,
                                    "gaps": 0,
                                    "qseq": "AAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG",
                                    "hseq": "AAGTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGGAAGGTTACGCAATACCTAGATCGTGGGCAATCTGTTCCTGACCTGTCACCGACGTACATGAGCTACAGTATGTTGGTGATGATG",
                                    "midline": "|||||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||||||||| ||||||| ||||||||||||||||||||| || ||||||||| |||| ||||| |||||||||||||||||||||| | |||||"
                                }
                            ]
                        }
                    ],
                            "stat": {
                        "db_num": 29047329,
                                "db_len": 89443855465,
                                "hsp_len": 32,
                                "eff_space": 13100122458676,
                                "kappa": 0.46,
                                "lambda": 1.28,
                                "entropy": 0.85
                    }
                }
            }
        }
    }
    };

    function doBlast(){
        jQuery('#blastResult').html('<img src=\"/images/ajax-loader.gif\"/>');
        Fluxion.doAjax(
                'wisControllerHelperService',
                'blastSearch',
                {
                    'dummy': blastdummy,
                    'sequence': jQuery('#sequence').val(),
                    'url': ajaxurl
                },
                {
                    'doOnSuccess': function (json) {
                        jQuery('#blastSearchForm').hide("slide", { direction: "up" }, 1000);
                        jQuery('#blastResult').html(json.html);
                    }
                }
        );
    };

    jQuery(document).ready(function () {
    });
</script>

<%@ include file="tgacFooter.jsp" %>