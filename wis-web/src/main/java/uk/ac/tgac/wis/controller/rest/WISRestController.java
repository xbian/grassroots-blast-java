package uk.ac.tgac.wis.controller.rest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

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
              "       \"value\": \"http://v0214.nbi.ac.uk:8080/wis-web/wis-web/rest/searchsolor/query\"\n" +
              "     }\n" +
              "   ]\n" +
              " }");
    sb.append(" {\n" +
              "   \"service\": \"ElasticSearch indexing search service\",\n" +
              "   \"status\": 5,\n" +
              "   \"results\": [\n" +
              "     {\n" +
              "       \"protocol\": \"http\",\n" +
              "       \"value\": \"http://v0214.nbi.ac.uk:8080/wis-web/wis-web/rest/searchelasticsearch/query\"\n" +
              "     }\n" +
              "   ]\n" +
              " }");
    return "[" + sb.toString() + "]";
  }

  @RequestMapping(value = "searchsolr", method = RequestMethod.GET)
  public
  @ResponseBody
  String searchsolr() throws IOException {
    StringBuilder sb = new StringBuilder();
    sb.append("");
    return "[" + sb.toString() + "]";
  }

  @RequestMapping(value = "searchelasticsearch", method = RequestMethod.GET)
  public
  @ResponseBody
  String searchelasticsearch() throws IOException {
    StringBuilder sb = new StringBuilder();
    sb.append("");
    return "[" + sb.toString() + "]";
  }

//  public String jsonRestProjectList(Long projectId) throws IOException {
//    StringBuilder sb = new StringBuilder();
//
//    return "{" + sb.toString() + "}";
//  }

}
