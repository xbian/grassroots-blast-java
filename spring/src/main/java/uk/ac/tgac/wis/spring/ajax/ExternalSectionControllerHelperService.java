
package uk.ac.tgac.wis.spring.ajax;

import net.sf.json.JSONObject;
import net.sourceforge.fluxion.ajax.Ajaxified;
import net.sourceforge.fluxion.ajax.util.JSONUtils;
import javax.servlet.http.HttpSession;

/**
 * Created by IntelliJ IDEA.
 * User: bianx
 * Date: 02/11/11
 * Time: 15:59
 * To change this template use File | Settings | File Templates.
 */
@Ajaxified
public class ExternalSectionControllerHelperService {


  public JSONObject listProjects(HttpSession session, JSONObject json) {
//    try {
      return JSONUtils.JSONObjectResponse("html", "test");
//    }
//    catch (IOException e) {
//      return JSONUtils.SimpleJSONError("Failed: " + e.getMessage());
//    }
  }

}
