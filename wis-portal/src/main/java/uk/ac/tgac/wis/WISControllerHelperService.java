
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
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
    protected static final Logger log = LoggerFactory.getLogger(WISControllerHelperService.class);


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
        } catch (Exception e) {
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
        } catch (Exception e) {
            return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
        }
    }

    String blastURL = "http://v0214.nbi.ac.uk/wheatis";
    String blastTestURL = "http://v0214.nbi.ac.uk:1888/grassroots/controller";
    String simonURL = "http://n79610.nbi.ac.uk:8080/grassroots/controller";

    public JSONObject getBlastService(HttpSession session, JSONObject json) {
        StringBuilder dbHTML = new StringBuilder();
        JSONObject responses = new JSONObject();
//        String url = blastURL;
        String url = blastTestURL;

        JSONObject requestObject = new JSONObject();
        JSONObject operationsObject = new JSONObject();
        JSONArray servicesArray = new JSONArray();

        servicesArray.add("Blast service");
        requestObject.put("services", servicesArray);

        operationsObject.put("operationId", 4);
        requestObject.put("operations", operationsObject);

        HttpClient httpClient = new DefaultHttpClient();


        try {
            HttpPost request = new HttpPost(url);
            StringEntity params = new StringEntity(requestObject.toString());
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
                        dbHTML.append("<input type=\"checkbox\" name=\"database\" value=\"" + param + "^" + tag + "\" checked=\"checked\" /><b>" + name + "</b> <a target=\"_blank\" href=\"/images/Blast_database_announcement_v11.pdf\">README</a><br/>");
                    } else {
                        dbHTML.append("<input type=\"checkbox\" name=\"database\" value=\"" + param + "^" + tag + "\" />" + name + "<br/>");
                    }
                }
            }

            responses.put("blastdbs", parametersArray);
            responses.put("html", dbHTML.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
//    finally {
//      httpClient.getConnectionManager().shutdown();
//    }
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

        JSONObject requestObject = new JSONObject();
        JSONArray servicesArray = new JSONArray();

        JSONObject service1 = new JSONObject();

        JSONObject parameterSetObject = new JSONObject();

        JSONArray parametersArray = new JSONArray();

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
//            if (j.getString("name").equals("max_target_sequences")) {
//                max_target_sequences = j.getString("value");
//            }
            if (j.getString("name").equals("short_queries")) {
                short_queries = j.getString("value");
            }
//            if (j.getString("name").equals("expect_threshold")) {
//                expect_threshold = j.getString("value");
//            }
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
                JSONObject parameter = new JSONObject();

                parameter.put("param", databasevaluelist[0]);
                parameter.put("tag", Integer.parseInt(databasevaluelist[1]));
                parameter.put("current_value", true);
                parameter.put("grassroots_type", 0);
                parameter.put("concise", true);

                parametersArray.add(parameter);

                databaseParameters.append(",{");
                databaseParameters.append("\"param\": \"" + databasevaluelist[0] + "\",");
                databaseParameters.append("\"current_value\": true,");
                databaseParameters.append("\"tag\": " + databasevaluelist[1] + ",");
                databaseParameters.append("\"grassroots_type\": 0,");
                databaseParameters.append("\"concise\": true");
                databaseParameters.append("}");
            }
        }


        JSONObject p1 = new JSONObject();
        JSONObject p2 = new JSONObject();
        JSONObject p3 = new JSONObject();
        JSONObject p4 = new JSONObject();
        JSONObject p5 = new JSONObject();
        JSONObject p6 = new JSONObject();
        JSONObject p7 = new JSONObject();
        JSONObject p8 = new JSONObject();
        JSONObject p9 = new JSONObject();
        JSONObject p10 = new JSONObject();
        JSONObject p11 = new JSONObject();
        JSONObject p12 = new JSONObject();
        JSONObject p13 = new JSONObject();
        JSONObject p14 = new JSONObject();

        JSONObject p1CurrentValue = new JSONObject();
        p1.put("param", "input");
        p1CurrentValue.put("protocol", "");
        p1CurrentValue.put("value", "");
        p1.put("current_value", p1CurrentValue);
        p1.put("tag", 1112100422);
        p1.put("grassroots_type", 7);
        p2.put("type", "string");
        p1.put("concise", true);

        parametersArray.add(p1);


        JSONObject p2CurrentValue = new JSONObject();
        p2.put("param", "output");
        p2.put("type", "string");
        p2.put("tag", 1112495430);
        p2CurrentValue.put("protocol", "");
        p2CurrentValue.put("value", "");
        p2.put("current_value", p2CurrentValue);
        p2.put("level", 7);
        p2.put("grassroots_type", 6);
        p2.put("concise", true);

        parametersArray.add(p2);

        p3.put("param", "query_sequence");
        p3.put("type", "string");
        p3.put("tag", 1112626521);
        p3.put("current_value", sequence.replaceAll("\\n", "\\\\n").replaceAll("\\r", "\\\\n"));
        p3.put("level", 7);
        p3.put("grassroots_type", 5);
        p3.put("concise", true);

        parametersArray.add(p3);

        p4.put("param", "from");
        p4.put("type", "integer");
        p4.put("tag", 1112622674);
        p4.put("current_value", Integer.parseInt(query_from));
        p4.put("level", 6);
        p4.put("grassroots_type", 2);
        p4.put("concise", true);

        parametersArray.add(p4);

        p5.put("param", "to");
        p5.put("type", "integer");
        p5.put("tag", 1112626255);
        p5.put("current_value", Integer.parseInt(query_to));
        p5.put("level", 6);
        p5.put("grassroots_type", 2);
        p5.put("concise", true);

        parametersArray.add(p5);

        p6.put("param", "max_target_sequences");
        p6.put("type", "integer");
        p6.put("tag", 1112363857);
        p6.put("current_value", Integer.parseInt(max_target_sequences));
        p6.put("level", 7);
        p6.put("grassroots_type", 2);
        p6.put("concise", true);

        parametersArray.add(p6);

        p7.put("param", "short_queries");
        p7.put("type", "boolean");
        p7.put("tag", 1112754257);
        p7.put("current_value", Boolean.valueOf(short_queries));
        p7.put("level", 7);
        p7.put("grassroots_type", 0);
        p7.put("concise", true);

        parametersArray.add(p7);

        p8.put("param", "expect_threshold");
        p8.put("type", "integer");
        p8.put("tag", 1111840852);
        p8.put("current_value", Integer.parseInt(expect_threshold));
        p8.put("level", 7);
        p8.put("grassroots_type", 2);
        p8.put("concise", true);

        parametersArray.add(p8);

        p9.put("param", "word_size");
        p9.put("type", "integer");
        p9.put("tag", 1113015379);
        p9.put("current_value", Integer.parseInt(word_size));
        p9.put("level", 7);
        p9.put("grassroots_type", 2);
        p9.put("concise", true);

        parametersArray.add(p9);

        p10.put("param", "max_matches_in_a_query_range");
        p10.put("type", "integer");
        p10.put("tag", 1112363591);
        p10.put("current_value", Integer.parseInt(max_matches_query_range));
        p10.put("level", 7);
        p10.put("grassroots_type", 2);
        p10.put("concise", true);

        parametersArray.add(p10);

        p11.put("param", "output_format");
        p11.put("type", "integer");
        p11.put("tag", 1111903572);
        p11.put("current_value", 5);
        p11.put("level", 7);
        p11.put("grassroots_type", 2);
        p11.put("concise", true);

        parametersArray.add(p11);

        p12.put("param", "match");
        p12.put("type", "integer");
        p12.put("tag", 1112364099);
        p12.put("current_value", Integer.parseInt(match));
        p12.put("level", 6);
        p12.put("grassroots_type", 1);
        p12.put("concise", true);

        parametersArray.add(p12);

        p13.put("param", "mismatch");
        p13.put("type", "integer");
        p13.put("tag", 1112363853);
        p13.put("current_value", Integer.parseInt(mismatch));
        p13.put("grassroots_type", 1);
        p13.put("level", 6);
        p13.put("concise", true);

        parametersArray.add(p13);

        p14.put("param", "output_format");
        p14.put("tag", 1111903572);
        p14.put("current_value", 5);
        p14.put("grassroots_type", 2);
        p14.put("type", "integer");
        p14.put("level", 7);
        p14.put("concise", true);
        parametersArray.add(p14);

        parameterSetObject.put("parameters", parametersArray);

        service1.put("run", true);
        service1.put("services", "Blast service");
        service1.put("parameter_set", parameterSetObject);
        servicesArray.add(service1);
        requestObject.put("services", servicesArray);

//        String service = "{" +
//                "    \"services\": [" +
//                "        {" +
//                "            \"services\": \"Blast service\"," +
//                "            \"run\": true," +
//                "            \"parameter_set\": {" +
//                "      \"parameters\": [" +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"input\"," +
//                "          \"current_value\": {" +
//                "            \"protocol\": \"\"," +
//                "            \"value\": \"\"" +
//                "          }," +
//                "          \"tag\": 1112100422," +
//                "          \"grassroots_type\": 7," +
//                "          \"default\": {" +
//                "            \"protocol\": \"\"," +
//                "            \"value\": \"\"" +
//                "          }," +
//                "          \"type\": \"string\"," +
//                "          \"description\": \"The input file to read\"," +
//                "          \"name\": \"Input\"," +
//                "          \"group\": \"Query Sequence Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"output\"," +
//                "          \"current_value\": {" +
//                "            \"protocol\": \"\"," +
//                "            \"value\": \"\"" +
//                "          }," +
//                "          \"tag\": 1112495430," +
//                "          \"grassroots_type\": 6," +
//                "          \"default\": {" +
//                "            \"protocol\": \"\"," +
//                "            \"value\": \"\"" +
//                "          }," +
//                "          \"type\": \"string\"," +
//                "          \"description\": \"The output file to write\"," +
//                "          \"name\": \"Output\"," +
//                "          \"group\": \"Query Sequence Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"query_sequence\"," +
//                "          \"current_value\": \"" + sequence + "\"," +
//                "          \"tag\": 1112626521," +
//                "          \"grassroots_type\": 5," +
//                "          \"default\": \"\"," +
//                "          \"type\": \"string\"," +
//                "          \"description\": \"Query sequence(s) to be used for a BLAST search should be pasted in the 'Search' text area. It accepts a number of different types of input and automatically determines the format or the input. To allow this feature there are certain conventions required with regard to the input of identifiers (e.g., accessions or gi's)\"," +
//                "          \"name\": \"Query Sequence(s)\"," +
//                "          \"group\": \"Query Sequence Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 6," +
//                "          \"param\": \"from\"," +
//                "          \"current_value\": " + query_from + "," +
//                "          \"tag\": 1112622674," +
//                "          \"grassroots_type\": 2," +
//                "          \"default\": 0," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Coordinates for a subrange of the query sequence. The BLAST search will apply only to the residues in the range. Valid sequence coordinates are from 1 to the sequence length. Set either From or To to 0 to ignore the range. The range includes the residue at the To coordinate.\"," +
//                "          \"name\": \"From\"," +
//                "          \"group\": \"Query Sequence Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 6," +
//                "          \"param\": \"to\"," +
//                "          \"current_value\": " + query_to + "," +
//                "          \"tag\": 1112626255," +
//                "          \"grassroots_type\": 2," +
//                "          \"default\": 0," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Coordinates for a subrange of the query sequence. The BLAST search will apply only to the residues in the range. Valid sequence coordinates are from 1 to the sequence length. Set either From or To to 0 to ignore the range. The range includes the residue at the To coordinate.\"," +
//                "          \"name\": \"To\"," +
//                "          \"group\": \"Query Sequence Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"max_target_sequences\"," +
//                "          \"current_value\": " + max_target_sequences + "," +
//                "          \"tag\": 1112363857," +
//                "          \"grassroots_type\": 2," +
//                "          \"default\": 100," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Select the maximum number of aligned sequences to display (the actual number of alignments may be greater than this).\"," +
//                "          \"name\": \"Max target sequences\"," +
//                "          \"group\": \"General Algorithm Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"short_queries\"," +
//                "          \"current_value\": " + short_queries + "," +
//                "          \"tag\": 1112754257," +
//                "          \"grassroots_type\": 0," +
//                "          \"default\": true," +
//                "          \"type\": \"boolean\"," +
//                "          \"description\": \"Automatically adjust parameters for short input sequences\"," +
//                "          \"name\": \"Short queries\"," +
//                "          \"group\": \"General Algorithm Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"expect_threshold\"," +
//                "          \"current_value\": " + expect_threshold + "," +
//                "          \"tag\": 1111840852," +
//                "          \"grassroots_type\": 2," +
//                "          \"default\": 10," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Expected number of chance matches in a random model\"," +
//                "          \"name\": \"Expect threshold\"," +
//                "          \"group\": \"General Algorithm Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"word_size\"," +
//                "          \"current_value\": " + word_size + "," +
//                "          \"tag\": 1113015379," +
//                "          \"grassroots_type\": 2," +
//                "          \"default\": 28," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Expected number of chance matches in a random model\"," +
//                "          \"name\": \"Word size\"," +
//                "          \"group\": \"General Algorithm Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"max_matches_in_a_query_range\"," +
//                "          \"current_value\": " + max_matches_query_range + "," +
//                "          \"tag\": 1112363591," +
//                "          \"grassroots_type\": 2," +
//                "          \"default\": 0," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Limit the number of matches to a query range. This option is useful if many strong matches to one part of a query may prevent BLAST from presenting weaker matches to another part of the query\"," +
//                "          \"name\": \"Max matches in a query range\"," +
//                "          \"group\": \"General Algorithm Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 7," +
//                "          \"param\": \"output_format\"," +
//                "          \"current_value\": 5," +
//                "          \"tag\": 1111903572," +
//                "          \"grassroots_type\": 2," +
//                "          \"default\": 5," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"The output format for the results\"," +
//                "          \"name\": \"Output format\"," +
//                "          \"group\": \"General Algorithm Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 6," +
//                "          \"param\": \"match\"," +
//                "          \"current_value\": " + match + "," +
//                "          \"tag\": 1112364099," +
//                "          \"grassroots_type\": 1," +
//                "          \"default\": 2," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Reward for a nucleotide match.\"," +
//                "          \"name\": \"Match\"," +
//                "          \"group\": \"Scoring Parameters\"" +
//                "        }," +
//                "        {" +
//                "          \"level\": 6," +
//                "          \"param\": \"mismatch\"," +
//                "          \"current_value\": " + mismatch + "," +
//                "          \"tag\": 1112363853," +
//                "          \"grassroots_type\": 1," +
//                "          \"default\": -3," +
//                "          \"type\": \"integer\"," +
//                "          \"description\": \"Penalty for a nucleotide mismatch.\"," +
//                "          \"name\": \"Mismatch\"," +
//                "          \"group\": \"Scoring Parameters\"" +
//                "        }" +
//                databaseParameters.toString() +
//                "      ]" +
//                "            }" +
//                "        }" +
//                "    ]" +
//                "}";
        JSONObject responses = new JSONObject();
        try {

//        String url = blastURL;
            String url = blastTestURL;


            HttpClient httpClient = new DefaultHttpClient();

            try {
                HttpPost request = new HttpPost(url);
                StringEntity params = new StringEntity(requestObject.toString());
//                StringEntity params = new StringEntity(service.replaceAll("\\n", "\\\\n").replaceAll("\\r", "\\\\n"));
                request.addHeader("content-type", "application/x-www-form-urlencoded");
                request.setEntity(params);
                HttpResponse response = httpClient.execute(request);

                ResponseHandler<String> handler = new BasicResponseHandler();
                String body = handler.handleResponse(response);

                responses.put("response", body);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
//      finally {
//        httpClient.getConnectionManager().shutdown();
//      }

            return responses;

        } catch (Exception e) {
            return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
        }
    }

    public JSONObject checkBlastResult(HttpSession session, JSONObject json) {
        JSONObject responses = new JSONObject();
        String uuid = json.getString("uuid");
//        String url = blastURL;
        String url = blastTestURL;
        JSONObject requestObject = new JSONObject();
        JSONObject operationsObject = new JSONObject();
        JSONArray servicesArray = new JSONArray();

        servicesArray.add(uuid);
        requestObject.put("services", servicesArray);

        operationsObject.put("operationId", 5);
        requestObject.put("operations", operationsObject);

        HttpClient httpClient = new DefaultHttpClient();

        try {
            HttpPost request = new HttpPost(url);
            StringEntity params = new StringEntity(requestObject.toString());
            request.addHeader("content-type", "application/x-www-form-urlencoded");
            request.setEntity(params);
            HttpResponse response = httpClient.execute(request);

            ResponseHandler<String> handler = new BasicResponseHandler();
            String body = handler.handleResponse(response);
            // if 6 keep checking
            JSONObject statusJSON = JSONObject.fromObject(body);
            JSONArray statusArray = statusJSON.getJSONArray("services");
            if (statusArray.getJSONObject(0) != null) {
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
                    if (status == 4 || status == 5) {
                        responses.put("html", "Job succeeded");
                    }

                    responses.put("status", status);
                } else {
                    responses.put("html", "Job error");
                    responses.put("status", -1);
                }
            } else {
                responses.put("html", "Job error");
                responses.put("status", -1);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
//    finally {
//      httpClient.getConnectionManager().shutdown();
//    }
        return responses;
    }

    public JSONObject displayNewXMLBlastResult(HttpSession session, JSONObject json) {
        String rawResultString;

        String uuid = json.getString("uuid");
//        String url = blastURL;
        String url = blastTestURL;
        JSONObject requestObject = new JSONObject();
        JSONObject operationsObject = new JSONObject();
        JSONArray servicesArray = new JSONArray();

        servicesArray.add(uuid);
        requestObject.put("services", servicesArray);

        operationsObject.put("operationId", 6);
        requestObject.put("operations", operationsObject);

        HttpClient httpClient = new DefaultHttpClient();

        try {
            HttpPost request = new HttpPost(url);
            StringEntity params = new StringEntity(requestObject.toString());
            request.addHeader("content-type", "application/x-www-form-urlencoded");
            request.setEntity(params);
            HttpResponse response = httpClient.execute(request);

            ResponseHandler<String> handler = new BasicResponseHandler();
            String body = handler.handleResponse(response);
            JSONObject xmlJSON = JSONObject.fromObject(body);
            JSONArray xmlJSONArray = xmlJSON.getJSONArray("services");
            rawResultString = xmlJSONArray.getJSONObject(0).getString("data");
            return formatXMLBlastResult(rawResultString);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
//    finally {
//      httpClient.getConnectionManager().shutdown();
//    }

    }

    public JSONObject formatXMLBlastResult(String rawResultString) {
        StringBuilder sb = new StringBuilder();
        JSONObject responses = new JSONObject();
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder;

            builder = factory.newDocumentBuilder();
            Document document = builder.parse(new InputSource(new StringReader(rawResultString)));

            document.getDocumentElement().normalize();

            String databaseString = document.getElementsByTagName("BlastOutput_db").item(0).getTextContent();

            String databaseName = databaseString;
            if (databaseString.contains("/")) {
                String[] databaseSplitString = databaseString.split("/");
                databaseName = databaseSplitString[databaseSplitString.length - 1];
            }

            NodeList iterationList = document.getElementsByTagName("Iteration");
            int iteration_limit = 5;

            if (iteration_limit > iterationList.getLength()) {
                iteration_limit = iterationList.getLength();
            }


            for (int ii = 0; ii < iteration_limit; ++ii) {

                Element iteration = (Element) iterationList.item(ii);

                NodeList hitList = iteration.getElementsByTagName("Hit");


                String iterationIDString = iteration.getElementsByTagName("Iteration_query-ID").item(0).getTextContent();
                String iterationDefString = iteration.getElementsByTagName("Iteration_query-def").item(0).getTextContent();
                String iterationLenString = iteration.getElementsByTagName("Iteration_query-len").item(0).getTextContent();

                sb.append("<p><b>" + iterationIDString + " : " + iterationDefString + " (Length: " + iterationLenString + ")</b></p>");

                if (hitList.getLength() == 0) {
                    sb.append("<p>No hits found</p>");
                }

                NodeList hit_numList = iteration.getElementsByTagName("Hit_num");
                NodeList idList = iteration.getElementsByTagName("Hit_id");
                NodeList accessionList = iteration.getElementsByTagName("Hit_accession");
                NodeList lengthList = iteration.getElementsByTagName("Hit_len");


                int limit = 5;

                if (limit > hitList.getLength()) {
                    limit = hitList.getLength();
                }

                for (int i = 0; i < limit; ++i) {

                    Element hitElement = (Element) hitList.item(i);


                    String hit_num = hit_numList.item(i).getTextContent();
                    String id = idList.item(i).getTextContent();
                    String accession = accessionList.item(i).getTextContent();
                    String length = lengthList.item(i).getTextContent();


                    NodeList hspList = hitElement.getElementsByTagName("Hsp");
                    Element hspElement = (Element) hspList.item(0);


                    NodeList bit_scoreList = hspElement.getElementsByTagName("Hsp_bit-score");
                    NodeList scoreList = hspElement.getElementsByTagName("Hsp_score");
                    NodeList evalueList = hspElement.getElementsByTagName("Hsp_evalue");
                    NodeList identityList = hspElement.getElementsByTagName("Hsp_identity");

                    NodeList query_fromList = hspElement.getElementsByTagName("Hsp_query-from");
                    NodeList query_toList = hspElement.getElementsByTagName("Hsp_query-to");
                    NodeList hit_fromList = hspElement.getElementsByTagName("Hsp_hit-from");
                    NodeList hit_toList = hspElement.getElementsByTagName("Hsp_hit-to");


                    NodeList query_strandList = hspElement.getElementsByTagName("Hsp_query-frame");
                    NodeList hit_strandList = hspElement.getElementsByTagName("Hsp_query-frame");


                    NodeList qseqList = hspElement.getElementsByTagName("Hsp_qseq");
                    NodeList midlineList = hspElement.getElementsByTagName("Hsp_midline");
                    NodeList hseqList = hspElement.getElementsByTagName("Hsp_hseq");

                    NodeList gapsList = hspElement.getElementsByTagName("Hsp_gaps");


                    String bit_score = bit_scoreList.item(0).getTextContent();
                    String score = scoreList.item(0).getTextContent();
                    String evalue = evalueList.item(0).getTextContent();
                    String identity = identityList.item(0).getTextContent();

                    String query_from = query_fromList.item(0).getTextContent();
                    String query_to = query_toList.item(0).getTextContent();
                    String hit_from = hit_fromList.item(0).getTextContent();
                    String hit_to = hit_toList.item(0).getTextContent();

                    String query_strand = "plus";
                    if ("-1".equals(query_strandList.item(0).getTextContent())) {
                        query_strand = "minus";
                    }
                    String hit_strand = "plus";
                    if ("-1".equals(hit_strandList.item(0).getTextContent())) {
                        hit_strand = "minus";
                    }

                    String qseq = qseqList.item(0).getTextContent();
                    String midline = midlineList.item(0).getTextContent();
                    String hseq = hseqList.item(0).getTextContent();

                    String gaps = gapsList.item(0).getTextContent();

                    String alignmentDiv = Long.toHexString(Double.doubleToLongBits(Math.random()));

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

                    if ("/tgac/public/databases/blast/triticum_aestivum/TGAC/v1/Triticum_aestivum_CS42_TGACv1_all".equals(databaseString) ||
                            "/tgac/public/databases/blast/aegilops_tauschii/GCA_000347335.1/Aegilops_tauschii.GCA_000347335.1.26.dna.genome".equals(databaseString) ||
                            "/tgac/public/databases/blast/triticum_aestivum/brenchley_CS42/subassemblies_TEcleaned_Hv80Bd75Sb70Os70_30aa_firstBestHit_assembly_ml40_mi99".equals(databaseString) ||
                            "/tgac/public/databases/blast/triticum_aestivum/IWGSC/v2/IWGSCv2.0".equals(databaseString) ||
                            "/tgac/public/databases/blast/triticum_aestivum/W7984/w7984.meraculous.scaffolds.Mar28_contamination_removed".equals(databaseString) ||
                            "/tgac/public/databases/blast/triticum_monococcum/spp_aegilopoides/Triticum_monococcum_G3116".equals(databaseString) ||
                            "/tgac/public/databases/blast/triticum_monococcum/spp_monococcum/Triticum_monococcum_DV92".equals(databaseString)
                            ) {
                        id = "<a href='javascript:;' id='" + id.replaceAll("\\|", ":") + "' onclick=\"downloadFileFromServer('" + id.replaceAll("\\|", ":") + "','" + databaseString + "')\">" + id + "</a><div id='" + id.replaceAll("\\|", ":") + "status'></div>";
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
            }
            responses.put("html", sb.toString());
            return responses;
        } catch (Exception e) {
            return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
        }
    }


    public String blastResultFormatter(String qseq, String midline, String hseq, int size) {
        ArrayList<String> qseqList = splitEqually(qseq, size);
        ArrayList<String> midlineList = splitEqually(midline, size);
        ArrayList<String> hseqList = splitEqually(hseq, size);

        StringBuilder sb = new StringBuilder();
        sb.append("<pre>");
        if (qseqList.size() == midlineList.size() && qseqList.size() == hseqList.size()) {
            for (int i = 0; i < qseqList.size(); i++) {
                sb.append(qseqList.get(i) + "<br/>");
                sb.append(midlineList.get(i) + "<br/>");
                sb.append(hseqList.get(i) + "<br/>");
            }
            sb.append("</pre>");
            return sb.toString();
        } else {
            return "strands don't match";
        }
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
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
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
        } else {
            throw new IOException("Null entity in REST response");
        }
    }

    public JSONObject downloadFile(HttpSession session, JSONObject json) {
        JSONObject responses = new JSONObject();
        if (json.has("id") && json.has("db")) {
            String id = json.getString("id");
            String db = json.getString("db");
            log.debug(id);
//            String url = blastTestURL;
            String url = blastTestURL;

            JSONObject requestObject = new JSONObject();
            JSONArray servicesArray = new JSONArray();

            JSONObject service1 = new JSONObject();

            JSONObject parameterSetObject = new JSONObject();

            JSONArray parametersArray = new JSONArray();

            JSONObject p1 = new JSONObject();
            JSONObject p2 = new JSONObject();

//            p1.put("param", "Index");
//            p1.put("type", "string");
//            p1.put("tag", 1398031948);
////            p1.put("current_value", "/tgac/references/internal/assembly/triticum_aestivum/TGAC/v1/Triticum_aestivum_CS42_TGACv1_all.fa");
//            p1.put("db", db);
//            p1.put("level", 7);
//            p1.put("grassroots_type", 5);
//            p1.put("concise", true);

            p1.put("param", "Blast database");
            p1.put("type", "string");
            p1.put("tag", 1398030918);
//            p1.put("current_value", "/tgac/references/internal/assembly/triticum_aestivum/TGAC/v1/Triticum_aestivum_CS42_TGACv1_all.fa");
            p1.put("current_value", db);
            p1.put("level", 7);
            p1.put("grassroots_type", 5);
            p1.put("concise", true);


            parametersArray.add(p1);

            p2.put("param", "Scaffold");
            p2.put("type", "string");
            p2.put("tag", 1398035267);
            p2.put("current_value", id.replaceAll(":", "\\|"));
            p2.put("level", 7);
            p2.put("grassroots_type", 5);
            p2.put("concise", true);

            parametersArray.add(p2);

            parameterSetObject.put("parameters", parametersArray);

            service1.put("run", true);
            service1.put("services", "SamTools service");
            service1.put("parameter_set", parameterSetObject);


            servicesArray.add(service1);
            requestObject.put("services", servicesArray);

            log.debug(requestObject.toString());

            HttpClient httpClient = new DefaultHttpClient();


            try {
                HttpPost request = new HttpPost(url);
                StringEntity params = new StringEntity(requestObject.toString());
                request.addHeader("content-type", "application/x-www-form-urlencoded");
                request.setEntity(params);
                HttpResponse response = httpClient.execute(request);
                log.debug(request.toString());

                ResponseHandler<String> handler = new BasicResponseHandler();
                log.debug(handler.toString());

                JSONArray jobsArray = JSONArray.fromObject(handler.handleResponse(response));
                log.debug(response.toString());
                String text = "Not found.";
                if (jobsArray.size() > 0) {
                    JSONObject jobsObject = jobsArray.getJSONObject(0);
                    JSONObject resultObject = jobsObject.getJSONArray("results").getJSONObject(0);

                    text = fastaFileFormatter(resultObject.getString("data"), 60);
                }
                responses.put("file", text);
            } catch (Exception e) {
                e.printStackTrace();
                log.debug(e.toString());
                return null;
            }
//          finally {
//              httpClient.getConnectionManager().shutdown();
//          }
        } else {
            responses.put("file", "Error no id appeared");
        }
        return responses;
    }

    public String fastaFileFormatter(String seq, int size) {
        String[] lines = seq.split("\\n");
        String line2 = lines[1];
        ArrayList<String> seqList = splitEqually(line2, size);

        StringBuilder sb = new StringBuilder();
        sb.append(lines[0] + "\n");

        for (int i = 0; i < seqList.size(); i++) {
            sb.append(seqList.get(i) + "\n");
        }
        return sb.toString();
    }

    public JSONObject getPreviousJob(HttpSession session, JSONObject json) {
        String rawResultString;

        String uuid = json.getString("id");
        String url = blastTestURL;
        JSONObject requestObject = new JSONObject();
        JSONArray servicesArray = new JSONArray();

        JSONObject service1 = new JSONObject();
        JSONObject parameterSetObject = new JSONObject();
        JSONArray parametersArray = new JSONArray();

        JSONObject p1 = new JSONObject();

        p1.put("param", "job_ids");
        p1.put("tag", 1112099401);
        p1.put("current_value", uuid);
        p1.put("grassroots_type", 5);
        p1.put("type", "string");
        p1.put("level", 7);
        p1.put("concise", true);
        parametersArray.add(p1);

        JSONObject p2 = new JSONObject();


        p2.put("param", "output_format");
        p2.put("tag", 1111903572);
        p2.put("current_value", 5);
        p2.put("grassroots_type", 2);
        p2.put("type", "integer");
        p2.put("level", 7);
        p2.put("concise", true);
        parametersArray.add(p2);


        parameterSetObject.put("parameters", parametersArray);

        service1.put("run", true);
        service1.put("services", "Blast service");
        service1.put("parameter_set", parameterSetObject);

        servicesArray.add(service1);
        requestObject.put("services", servicesArray);

        HttpClient httpClient = new DefaultHttpClient();


        JSONObject result = new JSONObject();

        try {
            HttpPost request = new HttpPost(url);
            StringEntity params = new StringEntity(requestObject.toString());
            request.addHeader("content-type", "application/x-www-form-urlencoded");
            request.setEntity(params);
            HttpResponse response = httpClient.execute(request);

            ResponseHandler<String> handler = new BasicResponseHandler();
            String body = handler.handleResponse(response);
            JSONArray resultArray = JSONArray.fromObject(body);
            JSONObject xmlJSON = (JSONObject) resultArray.get(0);

            if (xmlJSON.get("status_text") != null) {
                if (xmlJSON.getString("status_text").equals("Succeeded")) {
                    JSONObject resultData = (JSONObject) xmlJSON.getJSONArray("results").get(0);
                    rawResultString = resultData.getString("data");
                    return formatXMLBlastResult(rawResultString);
                } else {
                    result.put("html", "Error, Not able to retrieve job " + uuid);
                    return result;
                }
            } else {
                result.put("html", "Error, Not able to retrieve job " + uuid);
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", e.toString());
            return result;
        }
//    finally {
//      httpClient.getConnectionManager().shutdown();
//    }

    }


    public JSONObject downloadPreviousJob(HttpSession session, JSONObject json) {
        String rawResultString;

        String uuid = json.getString("id");
        int format = 0;
        if (json.get("format")!=null) {
            format = Integer.parseInt(json.getString("format"));
        }
        String url = blastTestURL;
        JSONObject requestObject = new JSONObject();
        JSONArray servicesArray = new JSONArray();

        JSONObject service1 = new JSONObject();
        JSONObject parameterSetObject = new JSONObject();
        JSONArray parametersArray = new JSONArray();

        JSONObject p1 = new JSONObject();

        p1.put("param", "job_ids");
        p1.put("tag", 1112099401);
        p1.put("current_value", uuid);
        p1.put("grassroots_type", 5);
        p1.put("type", "string");
        p1.put("level", 7);
        p1.put("concise", true);
        parametersArray.add(p1);

        JSONObject p2 = new JSONObject();


        p2.put("param", "output_format");
        p2.put("tag", 1111903572);
        p2.put("current_value", format);
        p2.put("grassroots_type", 2);
        p2.put("type", "integer");
        p2.put("level", 7);
        p2.put("concise", true);
        parametersArray.add(p2);


        parameterSetObject.put("parameters", parametersArray);

        service1.put("run", true);
        service1.put("services", "Blast service");
        service1.put("parameter_set", parameterSetObject);

        servicesArray.add(service1);
        requestObject.put("services", servicesArray);

        HttpClient httpClient = new DefaultHttpClient();


        JSONObject result = new JSONObject();

        try {
            HttpPost request = new HttpPost(url);
            StringEntity params = new StringEntity(requestObject.toString());
            request.addHeader("content-type", "application/x-www-form-urlencoded");
            request.setEntity(params);
            HttpResponse response = httpClient.execute(request);

            ResponseHandler<String> handler = new BasicResponseHandler();
            String body = handler.handleResponse(response);
            JSONArray resultArray = JSONArray.fromObject(body);
            JSONObject xmlJSON = (JSONObject) resultArray.get(0);

            if (xmlJSON.get("status_text") != null) {
                if (xmlJSON.getString("status_text").equals("Succeeded")) {
                    JSONObject resultData = (JSONObject) xmlJSON.getJSONArray("results").get(0);
                    rawResultString = resultData.getString("data");
                    result.put("file", rawResultString.replaceAll("%", " percent"));
                    return result;
                } else {
                    result.put("file", "Error, Not able to retrieve job " + uuid);
                    return result;
                }
            } else {
                result.put("file", "Error, Not able to retrieve job " + uuid);
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", e.toString());
            return result;
        }
//    finally {
//      httpClient.getConnectionManager().shutdown();
//    }

    }

}
