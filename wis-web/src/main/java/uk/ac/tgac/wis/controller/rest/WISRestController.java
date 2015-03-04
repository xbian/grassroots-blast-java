package uk.ac.tgac.wis.controller.rest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sourceforge.fluxion.ajax.util.JSONUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 *
// @SessionAttributes("services")
 * @author bianx
 */
@Controller
@RequestMapping("/rest")
public class WISRestController {

  @RequestMapping(value = "services", method = RequestMethod.GET)
  public
  @ResponseBody
  String jsonRest() throws IOException {
    StringBuilder sb = new StringBuilder();
    sb.append(" {\n" +
              "   \"service\": \"Solr indexing search service\",\n" +
              "   \"status\": 5,\n" +
              "   \"results\": [\n" +
              "     {\n" +
              "       \"protocol\": \"http\",\n" +
              "       \"value\": \"http://v0214.nbi.ac.uk:8080/wis-web/wis-web/rest/searchsolr/query\"\n" +
              "     }\n" +
              "   ]\n" +
              " }");
    sb.append(" {\n" +
              "   \"service\": \"ElasticSearch indexing search service\",\n" +
              "   \"status\": 5,\n" +
              "   \"results\": [\n" +
              "     {\n" +
              "       \"protocol\": \"http\",\n" +
              "       \"value\": \"http://v0214.nbi.ac.uk:8080/wis-web/wis-web/rest/searchelasticsearch/name/value\"\n" +
              "     }\n" +
              "   ]\n" +
              " }");
    return "[" + sb.toString() + "]";
  }

  @RequestMapping(value = "searchsolr/{query}", method = RequestMethod.GET)
  public
  @ResponseBody
  String searchsolr(@PathVariable String query) throws IOException {
    JSONObject response = new JSONObject();
    JSONObject jsonObject = new JSONObject();
    JSONArray jarray = new JSONArray();
    try {
      String solrSearch = "http://v0214.nbi.ac.uk:8983/solr/select?q="+query+"&wt=json";
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
      response.put("service", "Solr indexing search service");
      response.put("status", 5);
      response.put("results",jarray);
      return response.toString();
    }
    catch (Exception e) {
      return ("Failed: " + e.getMessage());
    }
  }

  @RequestMapping(value = "searchelasticsearch/{name}/{value}", method = RequestMethod.GET)
  public
  @ResponseBody
  String searchelasticsearch(@PathVariable String name, @PathVariable String value) throws IOException {
    StringBuilder response = new StringBuilder();
    String esresult = "";
    try {
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
      response.append("{{'service': 'ElasticSearch indexing search service'},");
      response.append("{'status': 5},");
      response.append("{'results': [" + esresult + "]}}");

      return response.toString();
    }
    catch (Exception e) {
      return ("Failed: " + e.getMessage());
    }
  }


}
