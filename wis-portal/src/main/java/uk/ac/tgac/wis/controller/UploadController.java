package uk.ac.tgac.wis.controller;

import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
      StringBuilder sb = new StringBuilder("The directory [" + path.toString() + "] doesn't exist");
      if (attemptMkdir) {
        sb.append(" or is not creatable");
      }
      sb.append(". Please create this directory and ensure that it is writable.");
      throw new IOException(sb.toString());
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

  protected File getFile(String qualifier, String fileName, boolean createIfNotExist) throws IOException {
    File path = new File("/storage/wheatis" + "/" + qualifier + "/");
    File file = new File(path, fileName);
    if (path.exists()) {
      if (file.exists()) {
        if (file.canRead()) {
          //      if (profile.userCanRead(user)) {
          return file;
        }
        else {
          throw new IOException("Access denied. Please check file permissions.");
        }
      }
      else {
        if (createIfNotExist && file.createNewFile()) {
          return file;
        }
        throw new IOException("No such file.");
      }
    }
    else {
      if (path.mkdirs()) {
        return getFile(qualifier, fileName, createIfNotExist);
      }
      else {
        throw new IOException("Could not create file directory (" + path + "). Please create this directory or allow the parent to be writable to MISO.");
      }
    }
  }

  public File getNewFile(Class type, String qualifier, String fileName) throws IOException {
    return getFile(qualifier, fileName, true);
  }

  public File getFile(Class type, String qualifier, String fileName) throws IOException {
    return getFile(qualifier, fileName, false);
  }


  @RequestMapping(value = "/importyr/sheet", method = RequestMethod.POST)
  public void uploadYRSheet(MultipartHttpServletRequest request, HttpServletResponse response) throws IOException {
    try {
      JSONArray jsonArray = new JSONArray();
      for (MultipartFile fileItem : getMultipartFiles(request)) {
        uploadFile("forms", fileItem);
        File f = getFile("forms", fileItem.getOriginalFilename().replaceAll("\\s+", "_"));
        jsonArray = preProcessYRSheetImport(f);
      }
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();
      out.println("<input type='hidden' id='uploadresponsebody' value='" + jsonArray + "'/>");
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static JSONArray preProcessYRSheetImport(File inPath) throws Exception {
    if (inPath.getName().endsWith(".xlsx")) {
      XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(inPath));
      JSONArray jsonArray = new JSONArray();
      XSSFSheet sheet = wb.getSheetAt(0);
      int rows = sheet.getPhysicalNumberOfRows();
      for (int ri = 5; ri < rows; ri++) {
        XSSFRow row = sheet.getRow(ri);
        XSSFCell sampleAliasCell = row.getCell(3);
        if (getCellValueAsString(sampleAliasCell) != null) {
          String salias = getCellValueAsString(sampleAliasCell);

        }
        else {
          break;
        }

        //sample OK - good to go
        if (s != null) {
          JSONArray sampleArray = new JSONArray();

          XSSFCell projectNameCell = row.getCell(0);
          XSSFCell projectAliasCell = row.getCell(1);
          XSSFCell sampleNameCell = row.getCell(2);
          XSSFCell wellCell = row.getCell(4);
          XSSFCell adaptorCell = row.getCell(5);
          XSSFCell qcPassedCell = row.getCell(13);

          sampleArray.add(getCellValueAsString(projectNameCell));
          sampleArray.add(getCellValueAsString(projectAliasCell));
          sampleArray.add(getCellValueAsString(sampleNameCell));
          sampleArray.add(getCellValueAsString(sampleAliasCell));
          sampleArray.add(getCellValueAsString(wellCell));
          if ((getCellValueAsString(adaptorCell)) != null) {
            sampleArray.add(getCellValueAsString(adaptorCell));
          }
          else {
            sampleArray.add("");

          }

          XSSFCell qcResultCell = null;



            if (!"NA".equals(getCellValueAsString(row.getCell(6)))) {
              qcResultCell = row.getCell(6);
            }
            else if (!"NA".equals(getCellValueAsString(row.getCell(7)))) {
              qcResultCell = row.getCell(7);
            }


          XSSFCell rinCell = row.getCell(8);
          XSSFCell sample260280Cell = row.getCell(9);
          XSSFCell sample260230Cell = row.getCell(10);
          Date date = new Date();

          try {
            if (getCellValueAsString(qcResultCell) != null && !"NA".equals(getCellValueAsString(qcResultCell))) {

              sampleArray.add(Double.valueOf(getCellValueAsString(qcResultCell)));
              if (getCellValueAsString(qcPassedCell) != null) {
                if ("Y".equals(getCellValueAsString(qcPassedCell)) || "y".equals(getCellValueAsString(qcPassedCell))) {
                  sampleArray.add("true");
                }
                else if ("N".equals(getCellValueAsString(qcPassedCell)) || "n".equals(getCellValueAsString(qcPassedCell))) {
                  sampleArray.add("false");
                }

              }
            }
            else {
              sampleArray.add("");
              sampleArray.add("");
            }

            StringBuilder noteSB = new StringBuilder();
            if (getCellValueAsString(rinCell) != null && !"".equals(getCellValueAsString(rinCell)) && !"NA".equals(getCellValueAsString(rinCell))) {
              noteSB.append("RIN:" + getCellValueAsString(rinCell) + ";");
            }
            if (getCellValueAsString(sample260280Cell) != null && !"".equals(getCellValueAsString(sample260280Cell))) {
              noteSB.append("260/280:" + getCellValueAsString(sample260280Cell) + ";");
            }
            if (getCellValueAsString(sample260230Cell) != null && !"".equals(getCellValueAsString(sample260230Cell))) {
              noteSB.append("260/230:" + getCellValueAsString(sample260230Cell) + ";");
            }
            sampleArray.add(noteSB.toString());
          }
          catch (NumberFormatException nfe) {
            throw new Exception("invalid", nfe);
          }
          jsonArray.add(sampleArray);
        }
      }
      return jsonArray;
    }
    else {
      throw new UnsupportedOperationException("Cannot process bulk input files other than xls, xlsx, and ods.");
    }
  }


}

  private static String getCellValueAsString(XSSFCell cell) {
    if (cell != null) {
      switch (cell.getCellType()) {
        case XSSFCell.CELL_TYPE_BLANK:
          return null;
        case XSSFCell.CELL_TYPE_BOOLEAN:
          return String.valueOf(cell.getBooleanCellValue());
        case XSSFCell.CELL_TYPE_ERROR:
          return cell.getErrorCellString();
        case XSSFCell.CELL_TYPE_FORMULA:
          return cell.getRawValue();
        case XSSFCell.CELL_TYPE_NUMERIC:
          return String.valueOf(cell.getNumericCellValue());
        case XSSFCell.CELL_TYPE_STRING:
          return cell.getStringCellValue();
        default:
          return null;
      }
    }
    return null;
  }
}