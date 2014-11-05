

package uk.ac.tgac.wis.spring.ajax.multipart;

import net.sourceforge.fluxion.ajax.beans.util.FileUploadListener;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * uk.ac.bbsrc.tgac.miso.spring.ajax.multipart
 * <p/>
 * Info
 *
 * @author Rob Davey
 * @since 0.0.2
 */
public class AjaxMultipartResolver extends CommonsMultipartResolver {
  private FileUploadListener fileUploadListener;

  @Override
  public MultipartHttpServletRequest resolveMultipart(HttpServletRequest request) throws MultipartException {
    String encoding = determineEncoding(request);
    FileUpload fileUpload = prepareFileUpload(encoding);
    if (fileUploadListener != null) {
      fileUpload.setProgressListener(fileUploadListener);
      request.getSession(false).setAttribute("upload_listener", fileUploadListener);
    }
    try {
      List fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
      MultipartParsingResult parsingResult = parseFileItems(fileItems, encoding);
      Map<String, String> multipartContentTypes = new HashMap<String, String>();
      for (List<MultipartFile> files : parsingResult.getMultipartFiles().values()) {
        for (MultipartFile f : files) {
          multipartContentTypes.put(f.getName(), f.getContentType());
        }
      }
      return new DefaultMultipartHttpServletRequest(request, parsingResult.getMultipartFiles(), parsingResult.getMultipartParameters(), multipartContentTypes);
    }
    catch (FileUploadBase.SizeLimitExceededException ex) {
      throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
    }
    catch (FileUploadException ex) {
      throw new MultipartException("Could not parse multipart servlet request", ex);
    }
  }

  public FileUploadListener getFileUploadListener() {
    return fileUploadListener;
  }

  public void setFileUploadListener(FileUploadListener fileUploadListener) {
    this.fileUploadListener = fileUploadListener;
  }
}

