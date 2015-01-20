package uk.ac.tgac.wis;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author bianx
 */
@Controller
@RequestMapping("/rest/")
@SessionAttributes("rest")
public class WISRestController {

  @RequestMapping(value = "services", method = RequestMethod.GET)
  public
  @ResponseBody
  String jsonRest() throws IOException {
    StringBuilder sb = new StringBuilder();
    sb.append("");
    return "[" + sb.toString() + "]";
  }

  public String jsonRestProjectList(Long projectId) throws IOException {
    StringBuilder sb = new StringBuilder();

    return "{" + sb.toString() + "}";
  }

}
