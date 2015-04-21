
package uk.ac.tgac.wis;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sourceforge.fluxion.ajax.Ajaxified;
import net.sourceforge.fluxion.ajax.util.JSONUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;

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
      String solrSearch = "http://v0214.nbi.ac.uk:8983/solr/select?q=" + searchStr + "&wt=json";
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
      response.put("docs", jarray);
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
      String esSearch = "http://v0214.nbi.ac.uk:9200/_search?q=" + name + ":" + value;
      HttpClient client = new DefaultHttpClient();
      HttpGet get = new HttpGet(esSearch);
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
    JSONArray formJSON = JSONArray.fromObject(json.get("form"));
    JSONObject blastResultJSON = json.getJSONObject("dummy");
    JSONObject response = new JSONObject();
    StringBuilder sb = new StringBuilder();
    try {
      JSONArray resultsHits = blastResultJSON.getJSONObject("BlastOutput").getJSONObject("report")
          .getJSONObject("results").getJSONObject("search").getJSONArray("hits");

      for (JSONObject hit : (Iterable<JSONObject>) resultsHits) {
        String id = hit.getJSONArray("description").getJSONObject(0).getString("id");
        String title = hit.getJSONArray("description").getJSONObject(0).getString("title");
        String taxid = hit.getJSONArray("description").getJSONObject(0).getString("taxid");
        String sciname = hit.getJSONArray("description").getJSONObject(0).getString("sciname");


        String bit_score = hit.getJSONArray("hsps").getJSONObject(0).getString("bit_score");
        String score = hit.getJSONArray("hsps").getJSONObject(0).getString("score");
        String evalue = hit.getJSONArray("hsps").getJSONObject(0).getString("evalue");
        String identity = hit.getJSONArray("hsps").getJSONObject(0).getString("identity");


        String query_from = hit.getJSONArray("hsps").getJSONObject(0).getString("query_from");
        String query_to = hit.getJSONArray("hsps").getJSONObject(0).getString("query_to");
        String hit_from = hit.getJSONArray("hsps").getJSONObject(0).getString("hit_from");
        String hit_to = hit.getJSONArray("hsps").getJSONObject(0).getString("hit_to");

        String query_strand = hit.getJSONArray("hsps").getJSONObject(0).getString("query_strand");
        String hit_strand = hit.getJSONArray("hsps").getJSONObject(0).getString("hit_strand");

        String qseq = hit.getJSONArray("hsps").getJSONObject(0).getString("qseq");
        String midline = hit.getJSONArray("hsps").getJSONObject(0).getString("midline");
        String hseq = hit.getJSONArray("hsps").getJSONObject(0).getString("hseq");
        sb.append("<div class='blastResultBox ui-corner-all'>");
        sb.append("<p><b>" + hit.getString("num") + ". Title</b>: " + title + " <a target=\"_blank\" href=\"http://www.ensembl.org/Multi/Search/Results?q=" + id + "\">Ensembl</a></p>");
        sb.append("<p><b>Sequence ID</b>: " + id + "</p>");
        sb.append("<p><b>Taxonomy ID</b>: " + taxid + " | <b>Scientific Name</b>: " + sciname + " | <b>Bit Score</b>: " + bit_score + "</p>");
        sb.append("<p><b>Score</b>: " + score + " | <b>Evalue</b>: " + evalue + " | <b>Identity</b>: " + identity + "</p><hr/>");
        sb.append("<p class='blastPosition'>Query from: " + query_from + " to: " + query_to + " Strand: " + query_strand + "</p>");
        sb.append(blastResultFormatter(qseq, midline, hseq, 100));
        sb.append("<p class='blastPosition'>Hit from: " + hit_from + " to: " + hit_to + " Strand: " + hit_strand + "</p>");
        sb.append("<hr/>");
        sb.append("</div>");
      }
      response.put("html", sb.toString());
      return response;
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }


  public JSONObject checkV0214(HttpSession session, JSONObject json) {
    JSONArray formJSON = JSONArray.fromObject(json.get("form"));
    String sequence = "";
    String query_from = "0";
    String query_to = "0";
    String max_target_sequences = "100";
    String short_queries = "false";
    String expect_threshold = "10";
    String word_size = "28";
    String max_matches_query_range = "0";
    String match = "2";
    String mismatch = "-3";

    for (JSONObject j : (Iterable<JSONObject>) formJSON) {
      if (j.getString("name").equals("sequence")) {
        sequence = j.getString("value");
      }
      if (j.getString("name").equals("query_from")) {
        query_from = j.getString("value");
      }
      if (j.getString("name").equals("query_to")) {
        query_to = j.getString("value");
      }
      if (j.getString("name").equals("max_target_sequences")) {
        max_target_sequences = j.getString("value");
      }
      if (j.getString("name").equals("short_queries")) {
        short_queries = j.getString("value");
      }
      if (j.getString("name").equals("expect_threshold")) {
        expect_threshold = j.getString("value");
      }
      if (j.getString("name").equals("word_size")) {
        word_size = j.getString("value");
      }
      if (j.getString("name").equals("max_matches_query_range")) {
        max_matches_query_range = j.getString("value");
      }if (j.getString("name").equals("match")) {
        match = j.getString("value");
      }if (j.getString("name").equals("mismatch")) {
        mismatch = j.getString("value");
      }
    }
    String service = "{" +
                     "  \"services\": [" +
                     "    {" +
                     "      \"services\": \"Blast service\"," +
                     "      \"run\": true," +
                     "      \"parameter_set\": {" +
                     "        \"parameters\": [" +
                     "{" +
                     "            \"default\": {" +
                     "              \"value\": \"\"," +
                     "              \"protocol\": \"\"" +
                     "            }," +
                     "            \"name\": \"Input\"," +
                     "            \"param\": \"input\"," +
                     "            \"group\": \"Query Sequence Parameters\"," +
                     "            \"wheatis_type\": 7," +
                     "            \"current_value\": {" +
                     "              \"value\": \"\"," +
                     "              \"protocol\": \"\"" +
                     "            }," +
                     "            \"tag\": 1112100422," +
                     "            \"level\": 7," +
                     "            \"description\": \"The input file to read\"," +
                     "            \"type\": \"string\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": {" +
                     "              \"value\": \"\"," +
                     "              \"protocol\": \"\"" +
                     "            }," +
                     "            \"name\": \"Output\"," +
                     "            \"param\": \"output\"," +
                     "            \"group\": \"Query Sequence Parameters\"," +
                     "            \"wheatis_type\": 6," +
                     "            \"current_value\": {" +
                     "              \"value\": \"\"," +
                     "              \"protocol\": \"\"" +
                     "            }," +
                     "            \"tag\": 1112495430," +
                     "            \"level\": 7," +
                     "            \"description\": \"The output file to write\"," +
                     "            \"type\": \"string\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": \"\"," +
                     "            \"name\": \"Query Sequence(s)\"," +
                     "            \"param\": \"query_sequence\"," +
                     "            \"group\": \"Query Sequence Parameters\"," +
                     "            \"wheatis_type\": 5," +
                     "            \"current_value\": \""+sequence+"\"," +
                     "            \"tag\": 1112626521," +
                     "            \"level\": 7," +
                     "            \"description\": \"Query sequence(s) to be used for a BLAST search should be pasted in the 'Search' text area. It accepts a number of different types of input and automatically determines the format or the input. To allow this feature there are certain conventions required with regard to the input of identifiers (e.g., accessions or gi's)\"," +
                     "            \"type\": \"string\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": 0," +
                     "            \"name\": \"From\"," +
                     "            \"param\": \"from\"," +
                     "            \"group\": \"Query Sequence Parameters\"," +
                     "            \"wheatis_type\": 2," +
                     "            \"current_value\": "+query_from+"," +
                     "            \"tag\": 1112622674," +
                     "            \"level\": 6," +
                     "            \"description\": \"Coordinates for a subrange of the query sequence. The BLAST search will apply only to the residues in the range. Valid sequence coordinates are from 1 to the sequence length. Set either From or To to 0 to ignore the range. The range includes the residue at the To coordinate.\"," +
                     "            \"type\": \"integer\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": 0," +
                     "            \"name\": \"To\"," +
                     "            \"param\": \"to\"," +
                     "            \"group\": \"Query Sequence Parameters\"," +
                     "            \"wheatis_type\": 2," +
                     "            \"current_value\": "+query_to+"," +
                     "            \"tag\": 1112626255," +
                     "            \"level\": 6," +
                     "            \"description\": \"Coordinates for a subrange of the query sequence. The BLAST search will apply only to the residues in the range. Valid sequence coordinates are from 1 to the sequence length. Set either From or To to 0 to ignore the range. The range includes the residue at the To coordinate.\"," +
                     "            \"type\": \"integer\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": 100," +
                     "            \"name\": \"Max target sequences\"," +
                     "            \"param\": \"max_target_sequences\"," +
                     "            \"group\": \"General Algorithm Parameters\"," +
                     "            \"wheatis_type\": 2," +
                     "            \"current_value\": "+max_target_sequences+"," +
                     "            \"tag\": 1112495430," +
                     "            \"level\": 7," +
                     "            \"description\": \"Select the maximum number of aligned sequences to display (the actual number of alignments may be greater than this).\"," +
                     "            \"type\": \"integer\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": true," +
                     "            \"name\": \"Short queries\"," +
                     "            \"param\": \"short_queries\"," +
                     "            \"group\": \"General Algorithm Parameters\"," +
                     "            \"wheatis_type\": 0," +
                     "            \"current_value\": "+short_queries+"," +
                     "            \"tag\": 1112754257," +
                     "            \"level\": 7," +
                     "            \"description\": \"Automatically adjust parameters for short input sequences\"," +
                     "            \"type\": \"boolean\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": 10.0," +
                     "            \"name\": \"Expect threshold\"," +
                     "            \"param\": \"expect_threshold\"," +
                     "            \"group\": \"General Algorithm Parameters\"," +
                     "            \"wheatis_type\": 4," +
                     "            \"current_value\": "+expect_threshold+"," +
                     "            \"tag\": 1111840852," +
                     "            \"level\": 7," +
                     "            \"description\": \"Expected number of chance matches in a random model\"," +
                     "            \"type\": \"number\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": 28," +
                     "            \"name\": \"Word size\"," +
                     "            \"param\": \"word_size\"," +
                     "            \"group\": \"General Algorithm Parameters\"," +
                     "            \"wheatis_type\": 2," +
                     "            \"current_value\": "+word_size+"," +
                     "            \"tag\": 1113015379," +
                     "            \"level\": 7," +
                     "            \"description\": \"Expected number of chance matches in a random model\"," +
                     "            \"type\": \"integer\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": 0," +
                     "            \"name\": \"Max matches in a query range\"," +
                     "            \"param\": \"max_matches_in_a_query_range\"," +
                     "            \"group\": \"General Algorithm Parameters\"," +
                     "            \"wheatis_type\": 2," +
                     "            \"current_value\": "+max_matches_query_range+"," +
                     "            \"tag\": 1113015379," +
                     "            \"level\": 7," +
                     "            \"description\": \"Limit the number of matches to a query range. This option is useful if many strong matches to one part of a query may prevent BLAST from presenting weaker matches to another part of the query\"," +
                     "            \"type\": \"integer\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": 2," +
                     "            \"name\": \"Match\"," +
                     "            \"param\": \"match\"," +
                     "            \"group\": \"Scoring Parameters\"," +
                     "            \"wheatis_type\": 1," +
                     "            \"current_value\": "+match+"," +
                     "            \"tag\": 1112364099," +
                     "            \"level\": 6," +
                     "            \"description\": \"Reward for a nucleotide match.\"," +
                     "            \"type\": \"integer\"" +
                     "          }," +
                     "          {" +
                     "            \"default\": -3," +
                     "            \"name\": \"Mismatch\"," +
                     "            \"param\": \"mismatch\"," +
                     "            \"group\": \"Scoring Parameters\"," +
                     "            \"wheatis_type\": 1," +
                     "            \"current_value\": "+mismatch+"," +
                     "            \"tag\": 1112363853," +
                     "            \"level\": 6," +
                     "            \"description\": \"Penalty for a nucleotide mismatch.\"," +
                     "            \"type\": \"integer\"" +
                     "          }" +
                     "        ]" +
                     "      }" +
                     "    }" +
                     "  ]" +
                     "}";
    JSONObject responses = new JSONObject();
    try {

      String url = "http://n79610.nbi.ac.uk:8080/wheatis";


      HttpClient httpClient = new DefaultHttpClient();
      System.out.println(service);

      try {
        HttpPost request = new HttpPost(url);
        StringEntity params = new StringEntity(service);
        request.addHeader("content-type", "application/x-www-form-urlencoded");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);

        ResponseHandler<String> handler = new BasicResponseHandler();
        String body = handler.handleResponse(response);
        System.out.println(response + "<<<header:body>>>" + body);


        responses.put("html", body);
      }
      catch (Exception e) {
        e.printStackTrace();
        return null;
      }
      finally {
        httpClient.getConnectionManager().shutdown();
      }
      return responses;
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

  public String blastResultFormatter(String qseq, String midline, String hseq, int size) {
    ArrayList<String> qseqList = splitEqually(qseq, size);
    ArrayList<String> midlineList = splitEqually(midline, size);
    ArrayList<String> hseqList = splitEqually(hseq, size);

    StringBuilder sb = new StringBuilder();

    if (qseqList.size() == midlineList.size() && qseqList.size() == hseqList.size()) {
      for (int i = 0; i < qseqList.size(); i++) {
        sb.append("<pre>" + qseqList.get(i) + "</pre>");
        sb.append("<pre>" + midlineList.get(i) + "</pre>");
        sb.append("<pre>" + hseqList.get(i) + "</pre>");
      }
      return sb.toString();
    }
    else {
      return "strands don't match";
    }
  }

  public static ArrayList<String> splitEqually(String text, int size) {
    ArrayList<String> list = new ArrayList<String>((text.length() + size - 1) / size);
    for (int start = 0; start < text.length(); start += size) {
      list.add(text.substring(start, Math.min(text.length(), start + size)));
    }
    return list;
  }
}
