
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

}
