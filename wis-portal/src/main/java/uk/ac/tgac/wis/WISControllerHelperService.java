
package uk.ac.tgac.wis;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sourceforge.fluxion.ajax.Ajaxified;
import net.sourceforge.fluxion.ajax.util.JSONUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.*;
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

  String blastURL = "http://v0214.nbi.ac.uk/wheatis";
  String blastTestURL = "http://v0214.nbi.ac.uk:1888/grassroots/controller";

  public JSONObject getBlastService(HttpSession session, JSONObject json) {
    StringBuilder dbHTML = new StringBuilder();
    JSONObject responses = new JSONObject();
    String url = blastURL;
    String result = "{  \"operations\": {    \"operationId\": 4  },  \"services\": [    \"Blast service\"  ]}";

    HttpClient httpClient = new DefaultHttpClient();


    try {
      HttpPost request = new HttpPost(url);
      StringEntity params = new StringEntity(result);
      request.addHeader("content-type", "application/x-www-form-urlencoded");
      request.setEntity(params);
      HttpResponse response = httpClient.execute(request);

      ResponseHandler<String> handler = new BasicResponseHandler();
      String body = handler.handleResponse(response);

      JSONArray serviceArray = JSONArray.fromObject(body);
      JSONArray dbArray = new JSONArray();
      JSONArray parametersArray = serviceArray.getJSONObject(0).getJSONObject("operations").getJSONObject("parameter_set").getJSONArray("parameters");

      for (int i = 0; i < parametersArray.size(); i++) {
        JSONObject parameter = parametersArray.getJSONObject(i);
        if ("Available Databases".equals(parameter.getString("group"))) {
          String name = parameter.getString("name").split(";")[0];
          String param = parameter.getString("param");
          String tag = parameter.getString("tag");
          dbArray.add(parameter);
          if ("/tgac/public/databases/blast/triticum_aestivum/TGAC/v1/Triticum_aestivum_CS42_TGACv1_all".equals(param)) {
            dbHTML.append("<input type=\"checkbox\" name=\"database\" value=\"" + param + "^" + tag + "\" checked=\"checked\" /><b>" + name + "</b><a href=\"/images/Blast_database announcement_v11.pdf\">README<a><br/>");
          }
          else {
            dbHTML.append("<input type=\"checkbox\" name=\"database\" value=\"" + param + "^" + tag + "\" />" + name + "<br/>");
          }
        }
      }

      responses.put("blastdbs", parametersArray);
      responses.put("html", dbHTML.toString());
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

  public JSONObject sendBlastRequest(HttpSession session, JSONObject json) {
    String blastfile = json.getString("blastfile");
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
    StringBuilder databaseParameters = new StringBuilder();

    for (JSONObject j : (Iterable<JSONObject>) formJSON) {
      if (j.getString("name").equals("sequence")) {

        sequence = j.getString("value");

        if ("".equals(sequence) && !"".equals(blastfile)) {
          sequence = blastfile;
        }
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
      }
      if (j.getString("name").equals("match")) {
        match = j.getString("value");
      }
      if (j.getString("name").equals("mismatch")) {
        mismatch = j.getString("value");
      }
      if (j.getString("name").equals("database")) {
        String databasevalue = j.getString("value");
        String[] databasevaluelist = databasevalue.split("\\^");
        databaseParameters.append(",{");
        databaseParameters.append("\"param\": \"" + databasevaluelist[0] + "\",");
        databaseParameters.append("\"current_value\": true,");
        databaseParameters.append("\"tag\": " + databasevaluelist[1] + ",");
        databaseParameters.append("\"wheatis_type\": 0,");
        databaseParameters.append("\"concise\": true");
        databaseParameters.append("}");
      }
    }
    String service = "{" +
                     "    \"services\": [" +
                     "        {" +
                     "            \"services\": \"Blast service\"," +
                     "            \"run\": true," +
                     "            \"parameter_set\": {" +
                     "      \"parameters\": [" +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"input\"," +
                     "          \"current_value\": {" +
                     "            \"protocol\": \"\"," +
                     "            \"value\": \"\"" +
                     "          }," +
                     "          \"tag\": 1112100422," +
                     "          \"wheatis_type\": 7," +
                     "          \"default\": {" +
                     "            \"protocol\": \"\"," +
                     "            \"value\": \"\"" +
                     "          }," +
                     "          \"type\": \"string\"," +
                     "          \"description\": \"The input file to read\"," +
                     "          \"name\": \"Input\"," +
                     "          \"group\": \"Query Sequence Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"output\"," +
                     "          \"current_value\": {" +
                     "            \"protocol\": \"\"," +
                     "            \"value\": \"\"" +
                     "          }," +
                     "          \"tag\": 1112495430," +
                     "          \"wheatis_type\": 6," +
                     "          \"default\": {" +
                     "            \"protocol\": \"\"," +
                     "            \"value\": \"\"" +
                     "          }," +
                     "          \"type\": \"string\"," +
                     "          \"description\": \"The output file to write\"," +
                     "          \"name\": \"Output\"," +
                     "          \"group\": \"Query Sequence Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"query_sequence\"," +
                     "          \"current_value\": \"" + sequence + "\"," +
                     "          \"tag\": 1112626521," +
                     "          \"wheatis_type\": 5," +
                     "          \"default\": \"\"," +
                     "          \"type\": \"string\"," +
                     "          \"description\": \"Query sequence(s) to be used for a BLAST search should be pasted in the 'Search' text area. It accepts a number of different types of input and automatically determines the format or the input. To allow this feature there are certain conventions required with regard to the input of identifiers (e.g., accessions or gi's)\"," +
                     "          \"name\": \"Query Sequence(s)\"," +
                     "          \"group\": \"Query Sequence Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 6," +
                     "          \"param\": \"from\"," +
                     "          \"current_value\": " + query_from + "," +
                     "          \"tag\": 1112622674," +
                     "          \"wheatis_type\": 2," +
                     "          \"default\": 0," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Coordinates for a subrange of the query sequence. The BLAST search will apply only to the residues in the range. Valid sequence coordinates are from 1 to the sequence length. Set either From or To to 0 to ignore the range. The range includes the residue at the To coordinate.\"," +
                     "          \"name\": \"From\"," +
                     "          \"group\": \"Query Sequence Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 6," +
                     "          \"param\": \"to\"," +
                     "          \"current_value\": " + query_to + "," +
                     "          \"tag\": 1112626255," +
                     "          \"wheatis_type\": 2," +
                     "          \"default\": 0," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Coordinates for a subrange of the query sequence. The BLAST search will apply only to the residues in the range. Valid sequence coordinates are from 1 to the sequence length. Set either From or To to 0 to ignore the range. The range includes the residue at the To coordinate.\"," +
                     "          \"name\": \"To\"," +
                     "          \"group\": \"Query Sequence Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"max_target_sequences\"," +
                     "          \"current_value\": " + max_target_sequences + "," +
                     "          \"tag\": 1112363857," +
                     "          \"wheatis_type\": 2," +
                     "          \"default\": 100," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Select the maximum number of aligned sequences to display (the actual number of alignments may be greater than this).\"," +
                     "          \"name\": \"Max target sequences\"," +
                     "          \"group\": \"General Algorithm Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"short_queries\"," +
                     "          \"current_value\": " + short_queries + "," +
                     "          \"tag\": 1112754257," +
                     "          \"wheatis_type\": 0," +
                     "          \"default\": true," +
                     "          \"type\": \"boolean\"," +
                     "          \"description\": \"Automatically adjust parameters for short input sequences\"," +
                     "          \"name\": \"Short queries\"," +
                     "          \"group\": \"General Algorithm Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"expect_threshold\"," +
                     "          \"current_value\": " + expect_threshold + "," +
                     "          \"tag\": 1111840852," +
                     "          \"wheatis_type\": 2," +
                     "          \"default\": 10," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Expected number of chance matches in a random model\"," +
                     "          \"name\": \"Expect threshold\"," +
                     "          \"group\": \"General Algorithm Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"word_size\"," +
                     "          \"current_value\": " + word_size + "," +
                     "          \"tag\": 1113015379," +
                     "          \"wheatis_type\": 2," +
                     "          \"default\": 28," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Expected number of chance matches in a random model\"," +
                     "          \"name\": \"Word size\"," +
                     "          \"group\": \"General Algorithm Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"max_matches_in_a_query_range\"," +
                     "          \"current_value\": " + max_matches_query_range + "," +
                     "          \"tag\": 1112363591," +
                     "          \"wheatis_type\": 2," +
                     "          \"default\": 0," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Limit the number of matches to a query range. This option is useful if many strong matches to one part of a query may prevent BLAST from presenting weaker matches to another part of the query\"," +
                     "          \"name\": \"Max matches in a query range\"," +
                     "          \"group\": \"General Algorithm Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 7," +
                     "          \"param\": \"output_format\"," +
                     "          \"current_value\": 5," +
                     "          \"tag\": 1111903572," +
                     "          \"wheatis_type\": 2," +
                     "          \"default\": 5," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"The output format for the results\"," +
                     "          \"name\": \"Output format\"," +
                     "          \"group\": \"General Algorithm Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 6," +
                     "          \"param\": \"match\"," +
                     "          \"current_value\": " + match + "," +
                     "          \"tag\": 1112364099," +
                     "          \"wheatis_type\": 1," +
                     "          \"default\": 2," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Reward for a nucleotide match.\"," +
                     "          \"name\": \"Match\"," +
                     "          \"group\": \"Scoring Parameters\"" +
                     "        }," +
                     "        {" +
                     "          \"level\": 6," +
                     "          \"param\": \"mismatch\"," +
                     "          \"current_value\": " + mismatch + "," +
                     "          \"tag\": 1112363853," +
                     "          \"wheatis_type\": 1," +
                     "          \"default\": -3," +
                     "          \"type\": \"integer\"," +
                     "          \"description\": \"Penalty for a nucleotide mismatch.\"," +
                     "          \"name\": \"Mismatch\"," +
                     "          \"group\": \"Scoring Parameters\"" +
                     "        }" +
                     databaseParameters.toString() +
                     "      ]" +
                     "            }" +
                     "        }" +
                     "    ]" +
                     "}";
    JSONObject responses = new JSONObject();
    try {

      String url = blastURL;


      HttpClient httpClient = new DefaultHttpClient();

      try {
        HttpPost request = new HttpPost(url);
        StringEntity params = new StringEntity((service.replaceAll("\\n", "\\\\n")).replaceAll("\\r", "\\\\n"));
        request.addHeader("content-type", "application/x-www-form-urlencoded");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);

        ResponseHandler<String> handler = new BasicResponseHandler();
        String body = handler.handleResponse(response);

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

    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

  public JSONObject checkBlastResult(HttpSession session, JSONObject json) {
    JSONObject responses = new JSONObject();
    String uuid = json.getString("uuid");
    String url = blastURL;
    String result = "{" +
                    "  \"operations\": {" +
                    "    \"operationId\": 5" +
                    "  }," +
                    "  \"services\": [" +
                    "    \"" + uuid + "\"" +
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
      JSONObject statusJSON = JSONObject.fromObject(body);
      JSONArray statusArray = statusJSON.getJSONArray("services");
          if(statusArray.getJSONObject(0)!=null) {
            if (statusArray.getJSONObject(0).has("status")) {
              int status = statusArray.getJSONObject(0).getInt("status");

              if (status == -3) {
                responses.put("html", "Job failed");
              }
              if (status == -2) {
                responses.put("html", "Failed to start");
              }
              if (status == -1) {
                responses.put("html", "Job error");
              }
              if (status == 0) {
                responses.put("html", "Job idle <img src=\"/images/ajax-loader.gif\">");
              }
              if (status == 1) {
                responses.put("html", "Job pending <img src=\"/images/ajax-loader.gif\">");
              }
              if (status == 2) {
                responses.put("html", "Job started <img src=\"/images/ajax-loader.gif\">");
              }
              if (status == 3) {
                responses.put("html", "Job finished <img src=\"/images/ajax-loader.gif\">");
              }
              if (status == 4) {
                responses.put("html", "Job succeeded");
              }

              responses.put("status", status);
            }else {
              responses.put("html", "Job error");
              responses.put("status", -1);
            }
          }else {
            responses.put("html", "Job error");
        responses.put("status", -1);
      }

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

    String uuid = json.getString("uuid");
    String url = blastURL;
    String result = "{" +
                    "  \"operations\": {" +
                    "    \"operationId\": 6" +
                    "  }," +
                    "  \"services\": [" +
                    "    \"" + uuid + "\"" +
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
      JSONObject xmlJSON = JSONObject.fromObject(body);
      JSONArray xmlJSONArray = xmlJSON.getJSONArray("services");
      rawResultString = xmlJSONArray.getJSONObject(0).getString("data");
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

      String databaseString = document.getElementsByTagName("BlastOutput_db").item(0).getTextContent();

      String databaseName = databaseString;
      if (databaseString.contains("/")) {
        String[] databaseSplitString = databaseString.split("/");
        databaseName = databaseSplitString[databaseSplitString.length - 1];
      }

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

      if (hitList.getLength() == 0) {
        sb.append("<p>No hits found</p>");
      }

      int limit = 5;

      if (limit > hitList.getLength()) {
        limit = hitList.getLength();
      }

      for (int i = 0; i < limit; ++i) {
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
        if ("-1".equals(query_strandList.item(i).getTextContent())) {
          query_strand = "minus";
        }
        String hit_strand = "plus";
        if ("-1".equals(hit_strandList.item(i).getTextContent())) {
          hit_strand = "minus";
        }

        String qseq = qseqList.item(i).getTextContent();
        String midline = midlineList.item(i).getTextContent();
        String hseq = hseqList.item(i).getTextContent();

        String gaps = gapsList.item(i).getTextContent();

        String alignmentDiv = Long.toHexString(Double.doubleToLongBits(Math.random()));
        ;

        String linktoensembl = "";

        String ensemblLink = "http://www.ensembl.org/Multi/Search/Results?q=";

        String taestivumLink = "http://plants.ensembl.org/Triticum_aestivum/Search/Results?species=Triticum%20aestivum;idx=;q=";

        String aegilopsTauschiiLink = "http://plants.ensembl.org/Aegilops_tauschii/Search/Results?species=Aegilops%20tauschii;idx=;q=";

        String turartuLink = "http://plants.ensembl.org/Triticum_urartu/Search/Results?species=Triticum%20urartu;idx=;q=";

        if ("Aegilops_tauschii.GCA_000347335.1.26.dna.genome".equals(databaseName)) {
          ensemblLink = aegilopsTauschiiLink;
          linktoensembl = " | <a target=\"_blank\" href=\"" + ensemblLink + accession + "\">Ensembl Search</a>";
        }
        if ("allCdnaFinalAssemblyAllContigs_vs_TREPalle05_notHits_gt100bp".equals(databaseName)) {
          ensemblLink = taestivumLink;
        }
        if ("CS_5xDNA_all".equals(databaseName)) {
          ensemblLink = taestivumLink;
        }
        if ("subassemblies_TEcleaned_Hv80Bd75Sb70Os70_30aa_firstBestHit_assembly_ml40_mi99".equals(databaseName)) {
          ensemblLink = taestivumLink;
        }
        if ("IWGSCv2.0".equals(databaseName)) {
          ensemblLink = taestivumLink;
          linktoensembl = " | <a target=\"_blank\" href=\"" + ensemblLink + accession + "\">Ensembl Search</a>";
        }
        if ("Triticum_urartu.GCA_000347455.1.26.dna.genome".equals(databaseName)) {
          ensemblLink = turartuLink;
          linktoensembl = " | <a target=\"_blank\" href=\"" + ensemblLink + accession + "\">Ensembl Search</a>";
        }
        if ("w7984.meraculous.scaffolds.Mar28_contamination_removed".equals(databaseName)) {
          ensemblLink = taestivumLink;
        }

        if ("Triticum_aestivum_CS42_TGACv1_all".equals(databaseName)) {
          id = "<a href='javascript:;' onclick=\"downloadFileFromServer('" + id + "')\">"+id+"</a><div id='" + id + "status'></div>";
        }

        sb.append("<div class='blastResultBox ui-corner-all'>");
        sb.append("<p><b>" + hit_num + ". </b>" + databaseName + " - " + id + " " + linktoensembl + "</p>");
        sb.append("<b>Bit Score</b>: " + bit_score + " | <b>Hit Length</b>: " + length + " | <b>Gaps:</b> " + gaps + "</p>");
        sb.append("<p><b>Score</b>: " + score + " | <b>Evalue</b>: " + evalue); // + " | <b>Identity</b>: " + identity + "</p>");
        sb.append("<div class=\"sectionDivider\" onclick=\"Utils.ui.toggleLeftInfo(jQuery('#" + alignmentDiv + "_arrowclick'), '" + alignmentDiv + "');\">Alignment view" +
                  "        <div id=\"" + alignmentDiv + "_arrowclick\" class=\"toggleLeft\"></div>" +
                  "      </div>" +
                  "      <div id=\"" + alignmentDiv + "\" class=\"note\" style=\"display:none;\">");
        sb.append("<p class='blastPosition'>Query from: " + query_from + " to: " + query_to + " Strand: " + query_strand + "</p>");
        sb.append(blastResultFormatter(qseq, midline, hseq, 100));
        sb.append("<p class='blastPosition'>Hit from: " + hit_from + " to: " + hit_to + " Strand: " + hit_strand + "</p>");
        sb.append("</div>");
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
    String url = blastURL;
    String result = "{" +
                    "  \"operations\": {" +
                    "    \"operationId\": 6" +
                    "  }," +
                    "  \"services\": [" +
                    "    \"" + uuid + "\"" +
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
        sb.append("<p><b>Score</b>: " + score + " | <b>Evalue</b>: " + evalue ); //+ " | <b>Identity</b>: " + identity + "</p><hr/>");
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

  public String blastResultFormatter(String qseq, String midline, String hseq, int size) {
    ArrayList<String> qseqList = splitEqually(qseq, size);
    ArrayList<String> midlineList = splitEqually(midline, size);
    ArrayList<String> hseqList = splitEqually(hseq, size);

    StringBuilder sb = new StringBuilder();

    if (qseqList.size() == midlineList.size() && qseqList.size() == hseqList.size()) {
      for (int i = 0; i < qseqList.size(); i++) {
        sb.append("<pre>" + qseqList.get(i) + "<br/>");
        sb.append(midlineList.get(i) + "<br/>");
        sb.append(hseqList.get(i) + "</pre>");
      }
      return sb.toString();
    }
    else {
      return "strands don't match";
    }
  }

  public JSONObject stopJob(HttpSession session, JSONObject json) {
    String uuid = json.getString("uuid");
    String url = blastURL;
    String result = "{" +
                    "  \"operations\": {" +
                    "    \"operationId\": 7" +
                    "  }," +
                    "  \"services\": [" +
                    "    \"" + uuid + "\"" +
                    "  ]" +
                    "}";

    HttpClient httpClient = new DefaultHttpClient();

    try {
      HttpPost request = new HttpPost(url);
      StringEntity params = new StringEntity(result);
      request.addHeader("content-type", "application/x-www-form-urlencoded");
      request.setEntity(params);
    }
    catch (Exception e) {
      e.printStackTrace();
      return null;
    }
    finally {
      httpClient.getConnectionManager().shutdown();
    }
    return JSONUtils.SimpleJSONResponse("ok");
  }

  public JSONObject getEnsemblInfo(HttpSession session, JSONObject json) {
    HttpClient httpclient = new DefaultHttpClient();
    String species = json.getString("species");
    String symbol = json.getString("symbol");
    String query = "http://rest.ensemblgenomes.org/symbol/" + species + "/" + symbol
                   + "?content-type=application/json;expand=1";

    HttpGet httpget = new HttpGet(query);
    try {
      HttpResponse response = httpclient.execute(httpget);
      String out = parseEntity(response.getEntity());
      JSONObject j = JSONObject.fromObject(out);
      return j;
    }
    catch (ClientProtocolException e) {
      e.printStackTrace();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    return null;
  }

  public static ArrayList<String> splitEqually(String text, int size) {
    ArrayList<String> list = new ArrayList<String>((text.length() + size - 1) / size);
    for (int start = 0; start < text.length(); start += size) {
      list.add(text.substring(start, Math.min(text.length(), start + size)));
    }
    return list;
  }

  private String parseEntity(HttpEntity entity) throws IOException {
    if (entity != null) {
      return EntityUtils.toString(entity, "UTF-8");
    }
    else {
      throw new IOException("Null entity in REST response");
    }
  }

  public JSONObject downloadFile(HttpSession session, JSONObject json) {
    JSONObject responses = new JSONObject();
    String id = json.getString("id");
    String url = blastTestURL;
//    String fa = "/tgac/references/internal/assembly/triticum_aestivum/TGAC/v1/Triticum_aestivum_CS42_TGACv1_all.fa";
    String result = "{\"services\":" +
                    "[" +
                    "  {" +
                    "    \"run\": true," +
                    "    \"services\": \"SamTools service\"," +
                    "    \"parameter_set\": {" +
                    "      \"parameters\": [" +
                    "        {" +
                    "          \"param\": \"Index\"," +
                    "          \"type\": \"string\"," +
                    "          \"tag\": 1398031948," +
                    "          \"current_value\": \"/tgac/references/internal/assembly/triticum_aestivum/TGAC/v1/Triticum_aestivum_CS42_TGACv1_all.fa\"," +
                    "          \"level\": 7," +
                    "          \"grassroots_type\": 5," +
                    "          \"concise\": true" +
                    "        }," +
                    "        {" +
                    "          \"param\": \"Scaffold\"," +
                    "          \"type\": \"string\"," +
                    "          \"tag\": 1398035267," +
                    "          \"current_value\": \""+id+"\"," +
                    "          \"level\": 7," +
                    "          \"grassroots_type\": 5," +
                    "          \"concise\": true" +
                    "        }" +
                    "      ]" +
                    "    }" +
                    "  }" +
                    "]}";

    HttpClient httpClient = new DefaultHttpClient();

    try {
      HttpPost request = new HttpPost(url);
      StringEntity params = new StringEntity(result);
      request.addHeader("content-type", "application/x-www-form-urlencoded");
      request.setEntity(params);
      HttpResponse response = httpClient.execute(request);

      ResponseHandler<String> handler = new BasicResponseHandler();
//      String body = handler.handleResponse(response);


      JSONArray jobsArray = JSONArray.fromObject(handler.handleResponse(response));
      JSONObject jobsObject = jobsArray.getJSONObject(0);


      JSONArray resultArray = jobsObject.getJSONArray("jobs");

      String text = resultArray.getJSONObject(0).getJSONObject("results").getString("scaffold");



      responses.put("file", fastaFileFormatter(text, 60));
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

  public String fastaFileFormatter(String seq, int size) {
    String[] lines = seq.split("\\n");
    String line2 = lines[1];
    ArrayList<String> seqList = splitEqually(line2, size);

    StringBuilder sb = new StringBuilder();
    sb.append(lines[0]+"\n");

    for (int i = 0; i < seqList.size(); i++) {
      sb.append(seqList.get(i) + "\n");
    }
    return sb.toString();
  }



}
