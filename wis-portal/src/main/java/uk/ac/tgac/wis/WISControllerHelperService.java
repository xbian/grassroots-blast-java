
package uk.ac.tgac.wis;

import net.sf.json.JSON;
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
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.servlet.http.HttpSession;
import javax.xml.bind.Element;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
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

  public JSONObject sendBlastRequest(HttpSession session, JSONObject json) {
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

      String url = "http://v0214.nbi.ac.uk/wheatis";


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


        responses.put("response", body);
      }
      catch (Exception e) {
        e.printStackTrace();
        return null;
      }
      finally {
        httpClient.getConnectionManager().shutdown();
      }

      return responses;
//      return JSONObject.fromObject("{" +
//                                   "  \"operations\": {" +
//                                   "    \"operationId\": 5" +
//                                   "  }," +
//                                   "  \"services\": [" +
//                                   "    \"702e00cc-ff7f-0000-88ce-dc7976fc45b5\"," +
//                                   "    \"702e00cc-ff7f-0000-f1dc-bb658a664f0d\"" +
//                                   "  ]" +
//                                   "}");
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

  public JSONObject checkBlastResult(HttpSession session, JSONObject json) {
    JSONObject responses = new JSONObject();
    String uuid = json.getString("uuid");
    String url = "http://v0214.nbi.ac.uk/wheatis";
    String result = "{" +
                    "  \"operations\": {" +
                    "    \"operationId\": 5" +
                    "  }," +
                    "  \"services\": [" +
                    "    \""+uuid+"\"," +
                    "  ]" +
                    "}";

    HttpClient httpClient = new DefaultHttpClient();

    try {
      HttpPost request = new HttpPost(url);
      StringEntity params = new StringEntity(result);
      request.addHeader("content-type", "application/x-www-form-urlencoded");
      request.setEntity(params);
      HttpResponse response = httpClient.execute(request);

      ResponseHandler<String> handler = new BasicResponseHandler();
      String body = handler.handleResponse(response);
      // if 6 keep checking
      JSONArray statusArray = JSONArray.fromObject(body);
      int status = statusArray.getJSONObject(0).getInt("status");
      String name = statusArray.getJSONObject(0).getString("status");
      if (status == 1){
        responses.put("html", "Failed to start");
      }
      if (status == 2){
        responses.put("html", "Job started");
      }
      if (status == 3){
        responses.put("html", "Job finished");
      }
      if (status == 4){
        responses.put("html", "Job failed");
      }
      if (status == 5){
        responses.put("html", "Job succeeded");
      }

      responses.put("dbname", name);
      responses.put("status", status);
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

  public JSONObject displayXMLBlastResult(HttpSession session, JSONObject json) {
    StringBuilder sb = new StringBuilder();
    JSONObject responses = new JSONObject();
    String rawResultString;
    String rawResultStringDummy = "<?xml version=\"1.0\"?>" +
                             "<!DOCTYPE BlastOutput PUBLIC \"-//NCBI//NCBI BlastOutput/EN\" \"http://www.ncbi.nlm.nih.gov/dtd/NCBI_BlastOutput.dtd\">" +
                             "<BlastOutput>" +
                             "  <BlastOutput_program>blastn</BlastOutput_program>" +
                             "  <BlastOutput_version>BLASTN 2.2.30+</BlastOutput_version>" +
                             "  <BlastOutput_reference>Zheng Zhang, Scott Schwartz, Lukas Wagner, and Webb Miller (2000), &quot;A greedy algorithm for aligning DNA sequences&quot;, J Comput Biol 2000; 7(1-2):203-14.</BlastOutput_reference>" +
                             "  <BlastOutput_db>/tgac/public/databases/blast/triticum_aestivum/IWGSC/v2/IWGSCv2.0.00</BlastOutput_db>" +
                             "  <BlastOutput_query-ID>Query_1</BlastOutput_query-ID>" +
                             "  <BlastOutput_query-def>C_CSS_1AL_scaff_279</BlastOutput_query-def>" +
                             "  <BlastOutput_query-len>317</BlastOutput_query-len>" +
                             "  <BlastOutput_param>" +
                             "    <Parameters>" +
                             "      <Parameters_expect>10</Parameters_expect>" +
                             "      <Parameters_sc-match>1</Parameters_sc-match>" +
                             "      <Parameters_sc-mismatch>-2</Parameters_sc-mismatch>" +
                             "      <Parameters_gap-open>0</Parameters_gap-open>" +
                             "      <Parameters_gap-extend>0</Parameters_gap-extend>" +
                             "      <Parameters_filter>L;m;</Parameters_filter>" +
                             "    </Parameters>" +
                             "  </BlastOutput_param>" +
                             "<BlastOutput_iterations>" +
                             "<Iteration>" +
                             "  <Iteration_iter-num>1</Iteration_iter-num>" +
                             "  <Iteration_query-ID>Query_1</Iteration_query-ID>" +
                             "  <Iteration_query-def>C_CSS_1AL_scaff_279</Iteration_query-def>" +
                             "  <Iteration_query-len>317</Iteration_query-len>" +
                             "<Iteration_hits>" +
                             "<Hit>" +
                             "  <Hit_num>1</Hit_num>" +
                             "  <Hit_id>IWGSC_CSS_1AL_scaff_279</Hit_id>" +
                             "  <Hit_def>No definition line</Hit_def>" +
                             "  <Hit_accession>IWGSC_CSS_1AL_scaff_279</Hit_accession>" +
                             "  <Hit_len>317</Hit_len>" +
                             "  <Hit_hsps>" +
                             "    <Hsp>" +
                             "      <Hsp_num>1</Hsp_num>" +
                             "      <Hsp_bit-score>586.508</Hsp_bit-score>" +
                             "      <Hsp_score>317</Hsp_score>" +
                             "      <Hsp_evalue>3.05604e-165</Hsp_evalue>" +
                             "      <Hsp_query-from>1</Hsp_query-from>" +
                             "      <Hsp_query-to>317</Hsp_query-to>" +
                             "      <Hsp_hit-from>1</Hsp_hit-from>" +
                             "      <Hsp_hit-to>317</Hsp_hit-to>" +
                             "      <Hsp_query-frame>1</Hsp_query-frame>" +
                             "      <Hsp_hit-frame>1</Hsp_hit-frame>" +
                             "      <Hsp_identity>317</Hsp_identity>" +
                             "      <Hsp_positive>317</Hsp_positive>" +
                             "      <Hsp_gaps>0</Hsp_gaps>" +
                             "      <Hsp_align-len>317</Hsp_align-len>" +
                             "      <Hsp_qseq>TGATCAAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTTATGTATTATTGGTTATCTTTGTAAGTCTCTTCGAATTATCAGTTTGGTTTTACTACATTGGTTGTTCTTGCCATGGTATAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAGGGCACGTATTGTATCATTGACATCGAGGATAACAAAATGGTTTTTTTTACCATATTGCATTAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTTAATACTCTAGATGC</Hsp_qseq>" +
                             "      <Hsp_hseq>TGATCAAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTTATGTATTATTGGTTATCTTTGTAAGTCTCTTCGAATTATCAGTTTGGTTTTACTACATTGGTTGTTCTTGCCATGGTATAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAGGGCACGTATTGTATCATTGACATCGAGGATAACAAAATGGTTTTTTTTACCATATTGCATTAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTTAATACTCTAGATGC</Hsp_hseq>" +
                             "      <Hsp_midline>|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||</Hsp_midline>" +
                             "    </Hsp>" +
                             "  </Hit_hsps>" +
                             "</Hit>" +
                             "<Hit>" +
                             "  <Hit_num>2</Hit_num>" +
                             "  <Hit_id>IWGSC_CSS_2AL_scaff_6437413</Hit_id>" +
                             "  <Hit_def>No definition line</Hit_def>" +
                             "  <Hit_accession>IWGSC_CSS_2AL_scaff_6437413</Hit_accession>" +
                             "  <Hit_len>4396</Hit_len>" +
                             "  <Hit_hsps>" +
                             "    <Hsp>" +
                             "      <Hsp_num>1</Hsp_num>" +
                             "      <Hsp_bit-score>459.089</Hsp_bit-score>" +
                             "      <Hsp_score>248</Hsp_score>" +
                             "      <Hsp_evalue>6.95101e-127</Hsp_evalue>" +
                             "      <Hsp_query-from>1</Hsp_query-from>" +
                             "      <Hsp_query-to>317</Hsp_query-to>" +
                             "      <Hsp_hit-from>4358</Hsp_hit-from>" +
                             "      <Hsp_hit-to>4035</Hsp_hit-to>" +
                             "      <Hsp_query-frame>1</Hsp_query-frame>" +
                             "      <Hsp_hit-frame>-1</Hsp_hit-frame>" +
                             "      <Hsp_identity>301</Hsp_identity>" +
                             "      <Hsp_positive>301</Hsp_positive>" +
                             "      <Hsp_gaps>9</Hsp_gaps>" +
                             "      <Hsp_align-len>325</Hsp_align-len>" +
                             "      <Hsp_qseq>TGATCAAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTT-ATGTATTATTGGTTATCTTTGTAAGTCTCTTCGAATTATCAGTTTGGTTT----TACTACATTGGTTGTTCTTGCCATGGTATAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAG---GGCACGTATTGTATCATTGACATCGAGGATAACAAAATGGTTTTTTTTACCATATTGCATTAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTTAATACTCTAGATGC</Hsp_qseq>" +
                             "      <Hsp_hseq>TGATCAAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTTTATGTATGATTGGTTATCTTTGCAAGTCTCTTCGAATTATCAGTTTGGTTTGGCCTACTAGATTGGTTGTTCTTGCCATGGGAGAAGTGCTTAACTTTGGGTTCGATCTTGTGGTGTCCTTTCATAGTGACAGAAGGGGCAGCAAGGCACGTATTGTATCGTTGCCATCGAGGATAACAAGATGGTTTTTTT-ATCATATTGCATGAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGCGTTACTCTGTTTTTAACTTAATACTCTAGATGC</Hsp_hseq>" +
                             "      <Hsp_midline>||||||||||||||||||||||||||||||||||||||||||||||||| |||||| |||||||||||||| ||||||||||||||||||||||||||||    ||||| |||||||||||||||||||| | ||||||||| ||||||||||||||||| |||||||||||  |||||||||||||||||   ||||||||||||||| ||| ||||||||||||||| ||||||||||| | |||||||||| |||||||||||||||||||||||||||||||||||| |||||||||||||||||||||||||||||||||</Hsp_midline>" +
                             "    </Hsp>" +
                             "  </Hit_hsps>" +
                             "</Hit>" +
                             "<Hit>" +
                             "  <Hit_num>3</Hit_num>" +
                             "  <Hit_id>IWGSC_CSS_3AS_scaff_3392338</Hit_id>" +
                             "  <Hit_def>No definition line</Hit_def>" +
                             "  <Hit_accession>IWGSC_CSS_3AS_scaff_3392338</Hit_accession>" +
                             "  <Hit_len>870</Hit_len>" +
                             "  <Hit_hsps>" +
                             "    <Hsp>" +
                             "      <Hsp_num>1</Hsp_num>" +
                             "      <Hsp_bit-score>453.549</Hsp_bit-score>" +
                             "      <Hsp_score>245</Hsp_score>" +
                             "      <Hsp_evalue>3.23399e-125</Hsp_evalue>" +
                             "      <Hsp_query-from>1</Hsp_query-from>" +
                             "      <Hsp_query-to>317</Hsp_query-to>" +
                             "      <Hsp_hit-from>474</Hsp_hit-from>" +
                             "      <Hsp_hit-to>796</Hsp_hit-to>" +
                             "      <Hsp_query-frame>1</Hsp_query-frame>" +
                             "      <Hsp_hit-frame>1</Hsp_hit-frame>" +
                             "      <Hsp_identity>300</Hsp_identity>" +
                             "      <Hsp_positive>300</Hsp_positive>" +
                             "      <Hsp_gaps>10</Hsp_gaps>" +
                             "      <Hsp_align-len>325</Hsp_align-len>" +
                             "      <Hsp_qseq>TGATCAAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTTATGTATTATTGGTTATCTTTGTAAGTCTCTTCGAATTATCAGTTTGGTTT----TACTACATTGGTTGTTCTTGCCATGGTATAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAG---GGCACGTATTGTATCATTGACATCGAGGATAACAAAATGG-TTTTTTTTACCATATTGCATTAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTTAATACTCTAGATGC</Hsp_qseq>" +
                             "      <Hsp_hseq>TGATCCAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTTATGTATGATTGTTTTTCTTTGCAAGTCTCTTCGAATTATCAGTTTGGTTTGGCATACTAGATTGGTTGTTCTTGCCATGGGAGAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAGCAAGGCACGTATTGTATTGTTGCCATCGAGGATAACAAGATGGGGTTTTTATA--ATATTGCATGAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTTAATACTCTAGATGC</Hsp_hseq>" +
                             "      <Hsp_midline>||||| ||||||||||||||||||||||||||||||||||||||||||||||||| |||| || |||||| ||||||||||||||||||||||||||||    ||||| |||||||||||||||||||| | ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||   ||||||||||||||  ||| ||||||||||||||| ||||  ||||| ||  ||||||||| ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||</Hsp_midline>" +
                             "    </Hsp>" +
                             "  </Hit_hsps>" +
                             "</Hit>" +
                             "<Hit>" +
                             "  <Hit_num>4</Hit_num>" +
                             "  <Hit_id>IWGSC_CSS_2DL_scaff_8000925</Hit_id>" +
                             "  <Hit_def>No definition line</Hit_def>" +
                             "  <Hit_accession>IWGSC_CSS_2DL_scaff_8000925</Hit_accession>" +
                             "  <Hit_len>244</Hit_len>" +
                             "  <Hit_hsps>" +
                             "    <Hsp>" +
                             "      <Hsp_num>1</Hsp_num>" +
                             "      <Hsp_bit-score>451.703</Hsp_bit-score>" +
                             "      <Hsp_score>244</Hsp_score>" +
                             "      <Hsp_evalue>1.16315e-124</Hsp_evalue>" +
                             "      <Hsp_query-from>60</Hsp_query-from>" +
                             "      <Hsp_query-to>303</Hsp_query-to>" +
                             "      <Hsp_hit-from>1</Hsp_hit-from>" +
                             "      <Hsp_hit-to>244</Hsp_hit-to>" +
                             "      <Hsp_query-frame>1</Hsp_query-frame>" +
                             "      <Hsp_hit-frame>1</Hsp_hit-frame>" +
                             "      <Hsp_identity>244</Hsp_identity>" +
                             "      <Hsp_positive>244</Hsp_positive>" +
                             "      <Hsp_gaps>0</Hsp_gaps>" +
                             "      <Hsp_align-len>244</Hsp_align-len>" +
                             "      <Hsp_qseq>GGTTATCTTTGTAAGTCTCTTCGAATTATCAGTTTGGTTTTACTACATTGGTTGTTCTTGCCATGGTATAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAGGGCACGTATTGTATCATTGACATCGAGGATAACAAAATGGTTTTTTTTACCATATTGCATTAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTT</Hsp_qseq>" +
                             "      <Hsp_hseq>GGTTATCTTTGTAAGTCTCTTCGAATTATCAGTTTGGTTTTACTACATTGGTTGTTCTTGCCATGGTATAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAGGGCACGTATTGTATCATTGACATCGAGGATAACAAAATGGTTTTTTTTACCATATTGCATTAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTT</Hsp_hseq>" +
                             "      <Hsp_midline>||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||</Hsp_midline>" +
                             "    </Hsp>" +
                             "  </Hit_hsps>" +
                             "</Hit>" +
                             "<Hit>" +
                             "  <Hit_num>5</Hit_num>" +
                             "  <Hit_id>IWGSC_CSS_1AS_scaff_3294617</Hit_id>" +
                             "  <Hit_def>No definition line</Hit_def>" +
                             "  <Hit_accession>IWGSC_CSS_1AS_scaff_3294617</Hit_accession>" +
                             "  <Hit_len>10985</Hit_len>" +
                             "  <Hit_hsps>" +
                             "    <Hsp>" +
                             "      <Hsp_num>1</Hsp_num>" +
                             "      <Hsp_bit-score>449.856</Hsp_bit-score>" +
                             "      <Hsp_score>243</Hsp_score>" +
                             "      <Hsp_evalue>4.18343e-124</Hsp_evalue>" +
                             "      <Hsp_query-from>1</Hsp_query-from>" +
                             "      <Hsp_query-to>316</Hsp_query-to>" +
                             "      <Hsp_hit-from>10665</Hsp_hit-from>" +
                             "      <Hsp_hit-to>10985</Hsp_hit-to>" +
                             "      <Hsp_query-frame>1</Hsp_query-frame>" +
                             "      <Hsp_hit-frame>1</Hsp_hit-frame>" +
                             "      <Hsp_identity>298</Hsp_identity>" +
                             "      <Hsp_positive>298</Hsp_positive>" +
                             "      <Hsp_gaps>9</Hsp_gaps>" +
                             "      <Hsp_align-len>323</Hsp_align-len>" +
                             "      <Hsp_qseq>TGATCAAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTTATGTATTATTGGTTATCTTTGTAAGTCTCTTCGAATTATCAGTTTGGTTT----TACTACATTGGTTGTTCTTGCCATGGTATAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAGAAGGGGCAG---GGCACGTATTGTATCATTGACATCGAGGATAACAAAATGGTTTTTTTTACCATATTGCATTAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGTGTTACTCTGTTTTTAACTTAATACTCTAGATG</Hsp_qseq>" +
                             "      <Hsp_hseq>TGATCAAGTCTATCTATGAATAATATTTGAATCTTCTCTGAATTCTTTTATGTATGATTGGTTATCTTTGCAAGTCTTTTCGAATTATCAGTTTGGTTTGGCCTACTAGATTGGTTTTTCTTGCCATGGGAGAAGTGCTTAGCTTTGGGTTCGATCTTGCGGTGTCCTTTCCCAGTGACAAAAGGGGCAGCAAGGCACGTATTGTATTGTTGCCATCGAGGATAACAAGATGGTTTTTTAT--CATATTGCGTGAAACTATCCCTCTACATCATGTCATCTTGCTTAAGGCGTTACTCTGTTTTTAACTTAATACTCTAGATG</Hsp_hseq>" +
                             "      <Hsp_midline>||||||||||||||||||||||||||||||||||||||||||||||||||||||| |||||||||||||| |||||| |||||||||||||||||||||    ||||| ||||||| |||||||||||| | |||||||||||||||||||||||||||||||||||||||||||||||| |||||||||   ||||||||||||||  ||| ||||||||||||||| |||||||||| |  |||||||| | |||||||||||||||||||||||||||||||||||| ||||||||||||||||||||||||||||||||</Hsp_midline>" +
                             "    </Hsp>" +
                             "  </Hit_hsps>" +
                             "</Hit>" +
                             "</Iteration_hits>" +
                             "  <Iteration_stat>" +
                             "    <Statistics>" +
                             "      <Statistics_db-num>4602498</Statistics_db-num>" +
                             "      <Statistics_db-len>3955890449</Statistics_db-len>" +
                             "      <Statistics_hsp-len>28</Statistics_hsp-len>" +
                             "      <Statistics_eff-space>662074547365</Statistics_eff-space>" +
                             "      <Statistics_kappa>0.46</Statistics_kappa>" +
                             "      <Statistics_lambda>1.28</Statistics_lambda>" +
                             "      <Statistics_entropy>0.85</Statistics_entropy>" +
                             "    </Statistics>" +
                             "  </Iteration_stat>" +
                             "</Iteration>" +
                             "</BlastOutput_iterations>" +
                             "</BlastOutput>";
    String uuid = json.getString("uuid");
    String url = "http://v0214.nbi.ac.uk/wheatis";
    String result = "{" +
                    "  \"operations\": {" +
                    "    \"operationId\": 6" +
                    "  }," +
                    "  \"services\": [" +
                    "    \""+uuid+"\"," +
                    "  ]" +
                    "}";

    HttpClient httpClient = new DefaultHttpClient();

    try {
      HttpPost request = new HttpPost(url);
      StringEntity params = new StringEntity(result);
      request.addHeader("content-type", "application/x-www-form-urlencoded");
      request.setEntity(params);
      HttpResponse response = httpClient.execute(request);

      ResponseHandler<String> handler = new BasicResponseHandler();
      String body = handler.handleResponse(response);
      JSONArray resultArray = JSONArray.fromObject(body);
      //to be changed depends on result
      rawResultString = body;
//          resultArray.getString("result");
    }
    catch (Exception e) {
      e.printStackTrace();
      return null;
    }
    finally {
      httpClient.getConnectionManager().shutdown();
    }

    try {
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder;

      builder = factory.newDocumentBuilder();
      Document document = builder.parse(new InputSource(new StringReader(rawResultString)));

      sb.append("<h5>Database: " + document.getElementsByTagName("BlastOutput_db").item(0).getTextContent() + "</h5>");

      NodeList hitList = document.getElementsByTagName("Hit");

      NodeList hit_numList = document.getElementsByTagName("Hit_num");
      NodeList idList = document.getElementsByTagName("Hit_id");
      NodeList accessionList = document.getElementsByTagName("Hit_accession");
      NodeList lengthList = document.getElementsByTagName("Hit_len");

      NodeList bit_scoreList = document.getElementsByTagName("Hsp_bit-score");
      NodeList scoreList = document.getElementsByTagName("Hsp_score");
      NodeList evalueList = document.getElementsByTagName("Hsp_evalue");
      NodeList identityList = document.getElementsByTagName("Hsp_identity");

      NodeList query_fromList = document.getElementsByTagName("Hsp_query-from");
      NodeList query_toList = document.getElementsByTagName("Hsp_query-to");
      NodeList hit_fromList = document.getElementsByTagName("Hsp_hit-from");
      NodeList hit_toList = document.getElementsByTagName("Hsp_hit-to");


      NodeList query_strandList = document.getElementsByTagName("Hsp_query-frame");
      NodeList hit_strandList = document.getElementsByTagName("Hsp_query-frame");


      NodeList qseqList = document.getElementsByTagName("Hsp_qseq");
      NodeList midlineList = document.getElementsByTagName("Hsp_midline");
      NodeList hseqList = document.getElementsByTagName("Hsp_hseq");

      NodeList gapsList = document.getElementsByTagName("Hsp_gaps");

      int limit = 5;

      if (limit > hitList.getLength()){
        limit = hitList.getLength();
      }

      for (int i = 0; i < limit; ++i) {
//        Node hit = (Node) hitList.item(i);

        String hit_num = hit_numList.item(i).getTextContent();
        String id = idList.item(i).getTextContent();
        String accession = accessionList.item(i).getTextContent();
        String length = lengthList.item(i).getTextContent();

        String bit_score = bit_scoreList.item(i).getTextContent();
        String score = scoreList.item(i).getTextContent();
        String evalue = evalueList.item(i).getTextContent();
        String identity = identityList.item(i).getTextContent();

        String query_from = query_fromList.item(i).getTextContent();
        String query_to = query_toList.item(i).getTextContent();
        String hit_from = hit_fromList.item(i).getTextContent();
        String hit_to = hit_toList.item(i).getTextContent();

        String query_strand = "plus";
        if ("-1".equals(query_strandList.item(i).getTextContent())){
          query_strand = "minus";
        }
        String hit_strand = "plus";
        if ("-1".equals(hit_strandList.item(i).getTextContent())){
          hit_strand = "minus";
        }

        String qseq = qseqList.item(i).getTextContent();
        String midline = midlineList.item(i).getTextContent();
        String hseq = hseqList.item(i).getTextContent();

        String gaps = gapsList.item(i).getTextContent();



//        Node hit = (Node) hitList.item(i);
//
//        String hit_num = hit.getChildNodes().item(0).getTextContent();
//        String id = hit.getChildNodes().item(1).getTextContent();
//        String accession = hit.getChildNodes().item(3).getTextContent();
////        String length = hit.getChildNodes().item(4).getTextContent();
//
//        Node hit_hsps = (Node) hit.getElementsByTagName("hit_hsps").item(0);
//
//        String bit_score = hsp.getChildNodes().item(1).getTextContent();
//        String score = hsp.getChildNodes().item(2).getTextContent();
//        String evalue = hsp.getChildNodes().item(3).getTextContent();
//        String identity = hsp.getChildNodes().item(10).getTextContent();
//
//
//        System.out.println(bit_score+score+evalue+identity);
//
//        String query_from = hsp.getChildNodes().item(4).getTextContent();
//        String query_to = hsp.getChildNodes().item(5).getTextContent();
//        String hit_from = hsp.getChildNodes().item(6).getTextContent();
//        String hit_to = hsp.getChildNodes().item(7).getTextContent();
//
//
//        System.out.println(query_from+query_to+hit_from+hit_to);
//
//        String query_strand = hsp.getChildNodes().item(8).getTextContent();
//        String hit_strand = hsp.getChildNodes().item(9).getTextContent();
//
//
//        System.out.println(query_strand+hit_strand);
//
//        String qseq = hsp.getChildNodes().item(14).getTextContent();
//        String midline = hsp.getChildNodes().item(16).getTextContent();
//        String hseq = hsp.getChildNodes().item(15).getTextContent();
//
//
//        System.out.println(qseq+midline+hseq);


        sb.append("<div class='blastResultBox ui-corner-all'>");
        sb.append("<p><b>" + hit_num + ". </b>" + id + " | <a target=\"_blank\" href=\"http://www.ensembl.org/Multi/Search/Results?q=" + accession + "\">Ensembl Search</a></p>");
//        sb.append("<p><b>Hit Length</b>: " + length + "</p>");
        sb.append("<b>Bit Score</b>: " + bit_score + " | <b>Hit Length</b>: " + length + " | <b>Gaps</b> "+gaps+"</p>");
        sb.append("<p><b>Score</b>: " + score + " | <b>Evalue</b>: " + evalue + " | <b>Identity</b>: " + identity + "</p><hr/>");
        sb.append("<p class='blastPosition'>Query from: " + query_from + " to: " + query_to + " Strand: " + query_strand + "</p>");
        sb.append(blastResultFormatter(qseq, midline, hseq, 100));
        sb.append("<p class='blastPosition'>Hit from: " + hit_from + " to: " + hit_to + " Strand: " + hit_strand + "</p>");
        sb.append("<hr/>");
        sb.append("</div>");
      }
      responses.put("html", sb.toString());
      return responses;
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

  public JSONObject displayJSONBlastResult(HttpSession session, JSONObject json) {
    StringBuilder sb = new StringBuilder();
    JSONObject responses = new JSONObject();
    JSONObject rawResultJSON = new JSONObject();
    String uuid = json.getString("uuid");
    String url = "http://v0214.nbi.ac.uk/wheatis";
    String result = "{" +
                    "  \"operations\": {" +
                    "    \"operationId\": 6" +
                    "  }," +
                    "  \"services\": [" +
                    "    \""+uuid+"\"," +
                    "  ]" +
                    "}";

    HttpClient httpClient = new DefaultHttpClient();

    try {
      HttpPost request = new HttpPost(url);
      StringEntity params = new StringEntity(result);
      request.addHeader("content-type", "application/x-www-form-urlencoded");
      request.setEntity(params);
      HttpResponse response = httpClient.execute(request);

      ResponseHandler<String> handler = new BasicResponseHandler();
      String body = handler.handleResponse(response);
      JSONArray resultArray = JSONArray.fromObject(body);
      //to be changed depends on result
      rawResultJSON = resultArray.getJSONObject(0).getJSONObject("result");
    }
    catch (Exception e) {
      e.printStackTrace();
      return null;
    }
    finally {
      httpClient.getConnectionManager().shutdown();
    }

    try {
      JSONArray resultsHits = rawResultJSON.getJSONObject("BlastOutput").getJSONObject("report")
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
      responses.put("html",sb.toString());
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
