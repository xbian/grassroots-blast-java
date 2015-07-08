package uk.ac.tgac.wis.controller;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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
    File dir = new File("/storage/wheatis" + File.separator + qualifier);
    if (checkDirectory(dir, true)) {
      fileItem.transferTo(new File(dir + File.separator + fileItem.getOriginalFilename().replaceAll("\\s", "_")));
    }
    else {
      throw new IOException("Cannot upload file - check that the directory specified in miso.properties exists and is writable");
    }
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
    File path = new File("/storage/wheatis/" + qualifier + "/");
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

  public File getNewFile(String qualifier, String fileName) throws IOException {
    return getFile(qualifier, fileName, true);
  }

  public File getFile(String qualifier, String fileName) throws IOException {
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
    if (inPath.getName().endsWith(".xlsx") || inPath.getName().endsWith(".xls")) {
      XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(inPath));
      JSONArray jsonArray = new JSONArray();
      XSSFSheet sheet = wb.getSheetAt(0);
      int rows = sheet.getPhysicalNumberOfRows();
      for (int ri = 1; ri < rows; ri++) {
        XSSFRow row = sheet.getRow(ri);

        XSSFCell cellID = row.getCell(0);
        XSSFCell cellUKCPVSID = row.getCell(1);
        XSSFCell cellDate = row.getCell(2);
        XSSFCell cellName = row.getCell(3);
        XSSFCell cellCompany = row.getCell(4);
        XSSFCell cellCountry = row.getCell(5);
        XSSFCell cellCounty = row.getCell(6);
        XSSFCell cellTown = row.getCell(7);
        XSSFCell cellPostCode = row.getCell(8);
        XSSFCell cellGPS = row.getCell(9);
        XSSFCell cellFurtherLocationInformation = row.getCell(10);
        XSSFCell cellRustType = row.getCell(11);
        XSSFCell cellHost = row.getCell(12);
        XSSFCell cellVariety = row.getCell(13);
        XSSFCell cellKASP = row.getCell(14);
        XSSFCell cellRNAseq = row.getCell(15);
        XSSFCell cellLibName = row.getCell(16);
        XSSFCell cellPublicComments = row.getCell(17);
        XSSFCell cellPrivateComments = row.getCell(18);
        JSONObject rowJSON = new JSONObject();

        rowJSON.put("ID", getCellValueAsString(cellID));
        rowJSON.put("UKCPVS_ID", getCellValueAsString(cellUKCPVSID));
        rowJSON.put("Date", getCellValueAsString(cellDate));
        rowJSON.put("Name", getCellValueAsString(cellName));
        rowJSON.put("Company", getCellValueAsString(cellCompany));
        rowJSON.put("Country", getCellValueAsString(cellCountry));
        rowJSON.put("County", getCellValueAsString(cellCounty));
        rowJSON.put("Town", getCellValueAsString(cellTown));
        rowJSON.put("Post_Code", getCellValueAsString(cellPostCode));
        rowJSON.put("GPS", getCellValueAsString(cellGPS));
        rowJSON.put("Further_Location_Information", getCellValueAsString(cellFurtherLocationInformation));
        rowJSON.put("Rust", getCellValueAsString(cellRustType));
        rowJSON.put("Host", getCellValueAsString(cellHost));
        rowJSON.put("Variety", getCellValueAsString(cellVariety));
        rowJSON.put("KASP_assays", getCellValueAsString(cellKASP));
        rowJSON.put("RNA-seq", getCellValueAsString(cellRNAseq));
        rowJSON.put("Library_name", getCellValueAsString(cellLibName));
        rowJSON.put("Public_Comments", getCellValueAsString(cellPublicComments));
        rowJSON.put("Private_comments", getCellValueAsString(cellPrivateComments));

        jsonArray.add(rowJSON);

      }
      return jsonArray;
    }
    else {
      throw new UnsupportedOperationException("Cannot process bulk input files other than xls, xlsx, and ods.");
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