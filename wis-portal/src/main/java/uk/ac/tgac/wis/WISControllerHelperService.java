
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
      String solrSearch = "http://v0214.nbi.ac.uk:9200/_search?q=" + name + ":" + value;
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
    JSONObject blastResultJSON = json.getJSONObject("dummy");
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
        sb.append("<p>Number: " + hit.getString("num") + "</p>");
        sb.append("<p>Sequence ID: " + id + "</p>");
        sb.append("<p>Title: " + title + "</p>");
        sb.append("<p>Taxid: " + taxid + "</p>");
        sb.append("<p>Scientific Name: " + sciname + "</p>");
        sb.append("<p>bit_score: " + bit_score + "</p>");
        sb.append("<p>score: " + score + " | evalue: " + evalue + " | identity: " + identity + "</p><br/>");
        sb.append("<p>Query from: " + query_from + " to: " + query_to + " Strand: " + query_strand + "</p>");
        sb.append("<pre>" + qseq + "</pre>");
        sb.append("<pre>" + midline + "</pre>");
        sb.append("<pre>" + hseq + "</pre>");
        sb.append("<p>Hit from: " + hit_from + " to: " + hit_to + " Strand: " + hit_strand + "</p>");
        sb.append("");
        sb.append("");
        sb.append("");
        sb.append("");
        sb.append("");
        sb.append("</div>");
      }
      response.put("html", sb.toString());
      return response;
    }
    catch (Exception e) {
      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
    }
  }

}
