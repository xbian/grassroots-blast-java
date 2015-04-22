package uk.ac.tgac.wis.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*;


@Controller
@RequestMapping("/upload")
public class UploadController {

  public void uploadFile(String qualifier, MultipartFile fileItem) throws IOException {
    File dir = new File("/storage/wheatis");
    if (checkDirectory(dir, true)) {
      fileItem.transferTo(new File(dir + File.separator + fileItem.getOriginalFilename().replaceAll("\\s", "_")));
    }
    else {
      throw new IOException("Cannot upload file - check that the directory specified in miso.properties exists and is writable");
    }
  }

  public void uploadFile(Object type, String qualifier, MultipartFile fileItem) throws IOException {
    uploadFile(type.getClass(), qualifier, fileItem);
  }


  @RequestMapping(value = "/blastfile", method = RequestMethod.POST)
  public void uploadProjectDocument(MultipartHttpServletRequest request) throws IOException {
    String name = request.getParameter("name");

    for (MultipartFile fileItem : getMultipartFiles(request)) {
      uploadFile(name, fileItem);
    }
  }

  public static boolean checkDirectory(File path, boolean attemptMkdir) throws IOException {
    boolean storageOk;

    if (attemptMkdir) {
      storageOk = path.exists() || path.mkdirs();
    }
    else {
      storageOk = path.exists();
    }

    if (!storageOk) {
      StringBuilder sb = new StringBuilder("The directory ["+path.toString()+"] doesn't exist");
      if (attemptMkdir) {
        sb.append(" or is not creatable");
      }
      sb.append(". Please create this directory and ensure that it is writable.");
      throw new IOException(sb.toString());
    }
    else {
      if (attemptMkdir) {
        log.info("Directory (" + path + ") exists.");
      }
      else {
        log.info("Directory (" + path + ") OK.");
      }
    }
    return storageOk;
  }

  private List<MultipartFile> getMultipartFiles(MultipartHttpServletRequest request) {
    List<MultipartFile> files = new ArrayList<MultipartFile>();
    Map<String, MultipartFile> fMap = request.getFileMap();
    for (String fileName : fMap.keySet()) {
      MultipartFile fileItem = fMap.get(fileName);
      if (fileItem.getSize() > 0) {
        files.add(fileItem);
      }
    }
    return files;
  }
}