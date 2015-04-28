<%@ include file="tgacHeader.jsp" %>
<div class="breadcrumbs">&raquo; <a href="http://www.tgac.ac.uk/">Home</a> &raquo; <a
        href="http://www.tgac.ac.uk/grassroots-genomics/">Grassroots Genomics</a>
    &raquo; <a href="<c:url value='/wis-portal/blast'/>">Blast Search</a></div>
<h2 id="blastTitle">Grassroots Genomics Blast Search </h2>

<form id="blastSearchForm">
    <p/>
    Enter sequence below in FASTA format
    <br/>
<textarea class="ui-corner-all pie_first-child" name="sequence" id="sequence" rows="10" cols="80">
</textarea>
    <br/>
    <%--Or load it from disk--%>
    <%--<input type="file" name="SEQFILE">--%>
    <p/>
    Set subsequence: From <input type="text" name="query_from" id="query_from" value="0" size="10">
    To <input type="text" name="query_to" id="query_to" value="0" size="10">
    <p/>
    <button type="button" onclick="sendBlastRequest();">Blast Search</button>
    <hr/>
    <h3>Algorithm parameters</h3>
    <fieldset class="ui-corner-all">
        <legend class="ui-corner-all pie_first-child">General Parameters</legend>
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
                <td><input name="mismatch" id="mismatch" size="10" type="text" value="-3"/>
                </td>
            </tr>
        </table>
    </fieldset>
    <p/>
    <button type="button" onclick="sendBlastRequest();">Blast Search</button>
</form>

<div id="blastStatus"></div>
<div id="blastResult"></div>

<script type="text/javascript">
    var timedCall = 5000;
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

    function sendBlastRequest() {
        jQuery('#blastResult').html('<img src=\"/images/ajax-loader.gif\"/>');
        Fluxion.doAjax(
                'wisControllerHelperService',
                'sendBlastRequest',
                {
                    'form': jQuery('#blastSearchForm').serializeArray(),
                    'url': ajaxurl
                },
                {
                    'doOnSuccess': function (json) {
                        for  (var uuid in json['services'])
                        {
                            jQuery('#blastResult').html('<div id=\"' + uuid +'\">Job' + uuid +'Submitted <img src=\"/images/ajax-loader.gif\"/></div></br>');
                            setTimeout(checkBlastResult(uuid),timedCall);
                        }
                    }
                }
        );

    }

    function checkBlastResult(uuid) {
        jQuery('#blastResult').html('<img src=\"/images/ajax-loader.gif\"/>');
        Fluxion.doAjax(
                'wisControllerHelperService',
                'checkBlastResult',
                {
                    'uuid': uuid,
                    'url': ajaxurl
                },
                {
                    'doOnSuccess': function (json) {
                        jQuery('#'+uuid).html(json.html);
                        if (json.status == 5){
                            Fluxion.doAjax(
                                    'wisControllerHelperService',
                                    'displayBlastResult',
                                    {
                                        'uuid': uuid,
                                        'url': ajaxurl
                                    },
                                    {
                                        'doOnSuccess': function (json) {
                                            jQuery('#'+uuid).html(json.html);
                                        }
                                    }
                            );
                        } else if (json.status == 2 || json.status == 3){
                            setTimeout(checkBlastResult(uuid),timedCall);
                        }
                    }
                }
        );
    }

    jQuery(document).ready(function () {
    });
</script>

<%@ include file="tgacFooter.jsp" %>