
package uk.ac.tgac.wis;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sourceforge.fluxion.ajax.Ajaxified;
import net.sourceforge.fluxion.ajax.util.JSONUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

/**
 * Created by IntelliJ IDEA.
 * User: bianx
 * Date: 02/11/11
 * Time: 15:59
 * To change this template use File | Settings | File Templates.
 */
@Ajaxified
public class WISControllerHelperService {


  public JSONObject searchSolr(HttpSession session, JSONObject json) {
    JSONObject response = new JSONObject();
    JSONObject jsonObject = new JSONObject();
    JSONArray jarray = new JSONArray();
    try {
    String searchStr = json.getString("searchStr");
      String solrSearch = "http://v0214.nbi.ac.uk:8983/solr/select?q="+searchStr+"&wt=json";
      HttpClient client = new DefaultHttpClient();
      HttpGet get = new HttpGet(solrSearch);
      HttpResponse responseGet = client.execute(get);
      HttpEntity resEntityGet = responseGet.getEntity();
      if (resEntityGet != null) {
        BufferedReader rd = new BufferedReader(new InputStreamReader(resEntityGet.getContent()));
        String line = "";
        while ((line = rd.readLine()) != null) {
          jsonObject = JSONObject.fromObject(line);
        }
      }

      jarray = jsonObject.getJSONObject("response").getJSONArray("docs");

      response.put("numFound", jsonObject.getJSONObject("response").getInt("numFound"));
      response.put("docs",jarray);
      return response;
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

  public JSONObject searchElasticSearch(HttpSession session, JSONObject json) {
    JSONObject response = new JSONObject();
    String esresult = "";
    try {
      String name = json.getString("name");
      String value = json.getString("value");
      String solrSearch = "http://v0214.nbi.ac.uk:9200/_search?q="+name+":"+value;
      HttpClient client = new DefaultHttpClient();
      HttpGet get = new HttpGet(solrSearch);
      HttpResponse responseGet = client.execute(get);
      HttpEntity resEntityGet = responseGet.getEntity();
      if (resEntityGet != null) {
        BufferedReader rd = new BufferedReader(new InputStreamReader(resEntityGet.getContent()));
        String line = "";
        while ((line = rd.readLine()) != null) {
          esresult = line;
        }
      }


      response.put("json", esresult);
      return response;
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

  public JSONObject blastSearch(HttpSession session, JSONObject json) {
    JSONObject blastResultJSON = JSONObject.fromObject("{ \"BlastOutput\": { \"report\": { \"program\": \"blastn\", \"version\": \"BLASTN 2.2.31+\", \"reference\": \"Zheng Zhang, Scott Schwartz, Lukas Wagner, and Webb Miller (2000), \\\"A greedy algorithm for aligning DNA sequences\\\", J Comput Biol 2000; 7(1-2):203-14.\", \"search_target\": { \"db\": \"nr\" }, \"params\": { \"expect\": 10, \"sc_match\": 1, \"sc_mismatch\": -2, \"gap_open\": 0, \"gap_extend\": 0, \"filter\": \"L;m;\" }, \"results\": { \"search\": { \"query_id\": \"Query_51745\", \"query_len\": 180, \"hits\": [ { \"num\": 1, \"description\": [ { \"id\": \"gi|219814405|gb|FJ436986.1|\", \"accession\": \"FJ436986\", \"title\": \"Aegilops tauschii Lr34 locus, partial sequence\", \"taxid\": 37682, \"sciname\": \"Aegilops tauschii\" } ], \"len\": 192638, \"hsps\": [ { \"num\": 1, \"bit_score\": 274.424, \"score\": 148, \"evalue\": 3.21578e-70, \"identity\": 164, \"query_from\": 6, \"query_to\": 177, \"query_strand\": \"Plus\", \"hit_from\": 119096, \"hit_to\": 119267, \"hit_strand\": \"Plus\", \"align_len\": 172, \"gaps\": 0, \"qseq\": \"AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG\", \"hseq\": \"AAAGTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTCGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG\", \"midline\": \"||||||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||||||||| ||||||| |||||||||||||||||||||||||||||||| ||||||||||||||||||||||||| |||||||||||||||\" } ] }, { \"num\": 2, \"description\": [ { \"id\": \"gi|241986938|dbj|AK334199.1|\", \"accession\": \"AK334199\", \"title\": \"Triticum aestivum cDNA, clone: WT009_G16, cultivar: Chinese Spring\", \"taxid\": 4565, \"sciname\": \"Triticum aestivum\" } ], \"len\": 2261, \"hsps\": [ { \"num\": 1, \"bit_score\": 257.805, \"score\": 139, \"evalue\": 3.23861e-65, \"identity\": 161, \"query_from\": 6, \"query_to\": 177, \"query_strand\": \"Plus\", \"hit_from\": 1821, \"hit_to\": 1992, \"hit_strand\": \"Plus\", \"align_len\": 172, \"gaps\": 0, \"qseq\": \"AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG\", \"hseq\": \"AAATTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGCATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTTGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG\", \"midline\": \"||| ||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||| ||||| ||||||| |||||||||||||||||||||| ||||||||| ||||||||||||||||||||||||| |||||||||||||||\" } ] }, { \"num\": 3, \"description\": [ { \"id\": \"gi|224365600|gb|FJ436983.1|\", \"accession\": \"FJ436983\", \"title\": \"Triticum aestivum cultivar Chinese Spring hexose carrier, LR34, cytochrome P450, lectin receptor kinases, and cytochrome P450 genes, complete cds\", \"taxid\": 4565, \"sciname\": \"Triticum aestivum\" } ], \"len\": 207179, \"hsps\": [ { \"num\": 1, \"bit_score\": 257.805, \"score\": 139, \"evalue\": 3.23861e-65, \"identity\": 161, \"query_from\": 6, \"query_to\": 177, \"query_strand\": \"Plus\", \"hit_from\": 104832, \"hit_to\": 105003, \"hit_strand\": \"Plus\", \"align_len\": 172, \"gaps\": 0, \"qseq\": \"AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG\", \"hseq\": \"AAATTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGCATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTTGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG\", \"midline\": \"||| ||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||| ||||| ||||||| |||||||||||||||||||||| ||||||||| ||||||||||||||||||||||||| |||||||||||||||\" } ] }, { \"num\": 4, \"description\": [ { \"id\": \"gi|219814397|gb|FJ436984.1|\", \"accession\": \"FJ436984\", \"title\": \"Triticum aestivum cultivar Glenlea Lr34 locus, partial sequence\", \"taxid\": 4565, \"sciname\": \"Triticum aestivum\" } ], \"len\": 147171, \"hsps\": [ { \"num\": 1, \"bit_score\": 257.805, \"score\": 139, \"evalue\": 3.23861e-65, \"identity\": 161, \"query_from\": 6, \"query_to\": 177, \"query_strand\": \"Plus\", \"hit_from\": 44450, \"hit_to\": 44621, \"hit_strand\": \"Plus\", \"align_len\": 172, \"gaps\": 0, \"qseq\": \"AAAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG\", \"hseq\": \"AAATTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGCATGCGAAAGGTTACACAATACCTAGATCGTGGGCAGTTGGTTCCTGATCTGTCGCCGACTTACATGAGCTACAGCATGTTGGCGCTGATG\", \"midline\": \"||| ||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||| ||||| ||||||| |||||||||||||||||||||| ||||||||| ||||||||||||||||||||||||| |||||||||||||||\" } ] }, { \"num\": 5, \"description\": [ { \"id\": \"gi|326503961|dbj|AK371569.1|\", \"accession\": \"AK371569\", \"title\": \"Hordeum vulgare subsp. vulgare mRNA for predicted protein, complete cds, clone: NIASHv2137F13\", \"taxid\": 112509, \"sciname\": \"Hordeum vulgare subsp. vulgare\" } ], \"len\": 2214, \"hsps\": [ { \"num\": 1, \"bit_score\": 255.958, \"score\": 138, \"evalue\": 1.16481e-64, \"identity\": 160, \"query_from\": 7, \"query_to\": 177, \"query_strand\": \"Plus\", \"hit_from\": 1806, \"hit_to\": 1976, \"hit_strand\": \"Plus\", \"align_len\": 171, \"gaps\": 0, \"qseq\": \"AAGTTTGACACACAGGAGGTTACCCTCGTGCTACAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGCAAGGTTATGCAATACCTAGATCGTGGGCAGTCGGTTCCTGACTTGTCGCCGACTTACATGAGCTACAGTATGTTGGCGCTGATG\", \"hseq\": \"AAGTTTGACACAGAGGAGGTTACCCTCGTGCTGCAACTAGGTTTGTTGTGCTCGCACCCATTGCCTGATGCAAGGCCTAGTATGCGGAAGGTTACGCAATACCTAGATCGTGGGCAATCTGTTCCTGACCTGTCACCGACGTACATGAGCTACAGTATGTTGGTGATGATG\", \"midline\": \"|||||||||||| ||||||||||||||||||| ||||||||||||||||||||||||||||||||||||||||||||||||||||| ||||||| ||||||||||||||||||||| || ||||||||| |||| ||||| |||||||||||||||||||||| | |||||\" } ] } ], \"stat\": { \"db_num\": 29047329, \"db_len\": 89443855465, \"hsp_len\": 32, \"eff_space\": 13100122458676, \"kappa\": 0.46, \"lambda\": 1.28, \"entropy\": 0.85 } } } } } }");
    JSONObject response = new JSONObject();
    String esresult = "";
    StringBuilder sb = new StringBuilder();
    try {
//      String name = json.getString("sequence");
//      String value = json.getString("value");
//      String solrSearch = "http://v0214.nbi.ac.uk:9200/_search?q="+name+":"+value;
//      HttpClient client = new DefaultHttpClient();
//      HttpGet get = new HttpGet(solrSearch);
//      HttpResponse responseGet = client.execute(get);
//      HttpEntity resEntityGet = responseGet.getEntity();
//      if (resEntityGet != null) {
//        BufferedReader rd = new BufferedReader(new InputStreamReader(resEntityGet.getContent()));
//        String line = "";
//        while ((line = rd.readLine()) != null) {
//          esresult = line;
//        }
//      }
//
//
//      response.put("json", esresult);


      sb.append("");
      response.put("html",sb.toString());
      return response;
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

}
