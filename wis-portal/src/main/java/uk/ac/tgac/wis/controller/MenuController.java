/*
 * Copyright (c) 2012. The Genome Analysis Centre, Norwich, UK
 * MISO project contacts: Robert Davey, Mario Caccamo @ TGAC
 * *********************************************************************
 *
 * This file is part of MISO.
 *
 * MISO is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * MISO is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MISO.  If not, see <http://www.gnu.org/licenses/>.
 *
 * *********************************************************************
 */

package uk.ac.tgac.wis.controller;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sourceforge.fluxion.ajax.util.JSONUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Controller
public class MenuController implements ServletContextAware {

    ServletContext servletContext;

    @RequestMapping("/")
    public String indexPage() {
        return "/index.jsp";
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }


    @RequestMapping("/about")
    public String about() {
        return "/about.jsp";
    }

    @RequestMapping("/contact")
    public String contact() {
        return "/contact.jsp";
    }

    @RequestMapping("/indexer")
    public String indexer() {
        return "/indexer.jsp";
    }

    @RequestMapping("/services")
    public String services() {
        return "/services.jsp";
    }

    @RequestMapping("/blast")
    public String grassRootBlast() {
        return "/blast.jsp";
    }

    @RequestMapping("/hordeum_vulgare")
    public String grassRootBlast2() {
        return "/blast2.jsp";
    }

    @RequestMapping("/irods-files")
    public String irodsFiles(@RequestParam("key") String key, @RequestParam("value") String value) {

        JSONObject responseJSON = new JSONObject();
        StringBuilder esresult = new StringBuilder();

        String elasticsearch_url = "https://grassroots.tools/elastic-search/irods/_search?q=" + key + ":" + value;
        String redirectUrl = "https://opendata.earlham.ac.uk/wheat/views/list?ids=";


        try {
            HttpClient client = new DefaultHttpClient();
            HttpGet get = new HttpGet(elasticsearch_url);
            HttpResponse responseGet = client.execute(get);
            HttpEntity resEntityGet = responseGet.getEntity();
            if (resEntityGet != null) {
                BufferedReader rd = new BufferedReader(new InputStreamReader(resEntityGet.getContent()));
                String line = "";
                while ((line = rd.readLine()) != null) {
                    esresult.append(line);
                }
            }
            responseJSON = JSONObject.fromObject(esresult.toString());
            if (responseJSON != null && responseJSON.get("hits") != null) {
                JSONObject hitsJSON = responseJSON.getJSONObject("hits");
                if (hitsJSON != null && hitsJSON.get("total") != null)
                    if (hitsJSON.getInt("total") > 0) {
                        if (hitsJSON.get("hits") != null) {
                            JSONArray hitsArray = hitsJSON.getJSONArray("hits");
                            for (int i = 0; i < hitsArray.size(); i++) {
                                if (hitsArray.getJSONObject(i).get("_source") != null) {
                                    if (hitsArray.getJSONObject(i).getJSONObject("_source").get("irods_id") != null) {
                                        if (i == 0) {
                                            redirectUrl = redirectUrl + hitsArray.getJSONObject(i).getJSONObject("_source").getString("irods_id");
                                        } else {
                                            redirectUrl = redirectUrl + "," + hitsArray.getJSONObject(i).getJSONObject("_source").getString("irods_id");

                                        }
                                    }
                                }
                            }
                        }

                    }
            }

            return "redirect:" + redirectUrl;
        } catch (Exception e) {
            return "Failed: " + e.getMessage();
        }
    }

//    @RequestMapping("/elasticsearch")
//    public String elasticsearch(@RequestParam("key") String key, @RequestParam("value") String value) {
//
//        JSONObject responseJSON = new JSONObject();
//        StringBuilder esresult = new StringBuilder();
//
//        String elasticsearch_url = "https://grassroots.tools/elastic-search/_search?q=" + key + ":" + value;
//
//
//        try {
//            HttpClient client = new DefaultHttpClient();
//            HttpGet get = new HttpGet(elasticsearch_url);
//            HttpResponse responseGet = client.execute(get);
//            HttpEntity resEntityGet = responseGet.getEntity();
//            if (resEntityGet != null) {
//                BufferedReader rd = new BufferedReader(new InputStreamReader(resEntityGet.getContent()));
//                String line = "";
//                while ((line = rd.readLine()) != null) {
//                    esresult.append(line);
//                }
//            }
//            responseJSON = JSONObject.fromObject(esresult.toString());
//            if (responseJSON != null && responseJSON.get("hits") != null) {
//                JSONObject hitsJSON = responseJSON.getJSONObject("hits");
//                if (hitsJSON != null && hitsJSON.get("total") != null)
//                    if (hitsJSON.getInt("total") > 0) {
//                        if (hitsJSON.get("hits") != null) {
//                            JSONArray hitsArray = hitsJSON.getJSONArray("hits");
//                            for (int i = 0; i < hitsArray.size(); i++) {
//                                if (hitsArray.getJSONObject(i).get("_source") != null) {
//                                    if (hitsArray.getJSONObject(i).getJSONObject("_source").get("irods_id") != null) {
//                                        if (i == 0) {
////                                            redirectUrl = redirectUrl + hitsArray.getJSONObject(i).getJSONObject("_source").getString("irods_id");
//                                        } else {
////                                            redirectUrl = redirectUrl + "," + hitsArray.getJSONObject(i).getJSONObject("_source").getString("irods_id");
//
//                                        }
//                                    }
//                                }
//                            }
//                        }
//
//                    }
//            }
//
//            return "redirect:" + redirectUrl;
//        } catch (Exception e) {
//            return "Failed: " + e.getMessage();
//        }
//    }

    @RequestMapping("/eirods-dav-header/")
    public ModelAndView getHeaderforiRODSObj(@RequestParam("uuid") String uuid, ModelMap model) throws IOException {
//        String projectInfoStr = "[\n" +
//                "    {\n" +
//                "        \"uuid\":\"ffc3e90f-7f89-4934-8e35-943bb64d1789\",\n" +
//                "        \"authors\": [\"Anthony Hall\", \"Laura-Jayne Gardiner\"],\n" +
//                "        \"projectName\": \"Integrating genomic resources to present full gene and promoter capture probe sets for bread wheat\",\n" +
//                "        \"description\": \"Whole genome shotgun re-sequencing of wheat is expensive because of its large, repetitive genome. Moreover, sequence data can fail to map uniquely to the reference genome making it difficult to unambiguously assign variation. Re-sequencing using target capture enables sequencing of large numbers of individuals at high coverage to reliably identify variants associated with important agronomic traits. We present two gold standard capture probe sets for hexaploid bread wheat, a gene and a promoter capture, which are designed using recently developed genome sequence and annotation resources. The captures can be combined or used independently. The capture probe sets effectively enrich the high confidence genes and promoters that were identified in the genome alongside a large proportion of the low confidence genes and promoters. We use a capture design employing an 'island strategy' to enable analysis of the large gene/promoter space of wheat with only 2x160 Mb NimbelGen probe sets. Furthermore, these assays extend the regions of the wheat genome that are amenable to analyses beyond its exome, providing tools for detailed characterization of these regulatory regions in large populations. Here, we release the targeted sequence of the capture probe sets on the wheat RefSeqv1, the design space that was used to tile our capture probes across and finally the positions of the probes themselves across this design space for both the gene and promoter capture probe sets. This project was supported by the BBSRC via an ERA-CAPS grant BB/N005104/1, BB/N005155/1 and BBSRC Designing Future Wheat BB/P016855/1.\",\n" +
//                "        \"license\" : {\"so:name\": \"toronto\", \"so:url\": \"https://www.nature.com/articles/461168a#Sec2\" },\n" +
//                "        \"project_codes\":[\"BB/N005104/1\", \"BB/N005155/1\", \"BB/P016855/1\"],\n" +
//                "        \"url\":\"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Gardiner_2018-07-04_Wheat-gene-promoter-capture/\",\n" +
//                "        \"irods_path\":\"/grassrootsZone/public/under_license/toronto/Gardiner_2018-07-04_Wheat-gene-promoter-capture\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "        \"uuid\":\"fd22c6a9-5692-4bbd-bb77-e04567fe3bc0\",\n" +
//                "        \"authors\": [\"Ji Zhou\", \"Joshua Ball\"],\n" +
//                "        \"projectName\": \"DFW RobigusxClaire UAV Image Data\",\n" +
//                "        \"description\": \"Working with the Griffiths group at JIC we have collected UAV image data for the RobigusxClaire population across the 2019 season. Divided into early, mid, and late drilling dates. Raw images from UAV capture are pre-processed using Pix4DMapper software to create a large, high-detail, orthomosaic images providing a single image for analysis and extraction of wheat traits for QTL analysis. Single whole field images are also captured to account for light and colour variations, This project is supported by the BBSRC Designing Future Wheat grant sub-work package BBS/E/T/000PR9785\",\n" +
//                "        \"license\" : {\"so:name\": \"toronto\", \"so:url\": \"https://www.nature.com/articles/461168a#Sec2\" },\n" +
//                "        \"project_codes\":[\"BBS/E/T/000PR9785\"],\n" +
//                "        \"url\":\"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Zhou_2019_RobxCla_UAV_Image_Data/\",\n" +
//                "        \"irods_path\":\"/grassrootsZone/public/under_license/toronto/Zhou_2019_RobxCla_UAV_Image_Data\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "        \"uuid\":\"4c53dd08-39d6-4d3a-bfc0-c6a5f32b609f\",\n" +
//                "        \"authors\": [\"Azahara Carmen Martín\", \"AbdulKader Alabdullah\", \"Philippa Borrill\", \"Ricardo H. Ramírez-González\", \"Janet Higgins\", \"David Swarbreck\", \"Cristobal Uauy\", \"Peter Shaw\", \"Graham Moore\"],\n" +
//                "        \"projectName\": \"Meiosis transcriptome and co-expression network in hexaploid wheat\",\n" +
//                "        \"description\": \"Polyploidization is a fundamental process in plant evolution. One of the biggest challenges faced by a new polyploid is meiosis, particularly discriminating between multiple related chromosomes so that only homologous chromosomes synapse and recombine to ensure regular chromosome segregation and balanced gametes. Despite its large genome size, high DNA repetitive content and similarity between homoeologous chromosomes, hexaploid wheat completes meiosis in a shorter period than diploid species with a much smaller genome. Therefore, during wheat meiosis, mechanisms additional to the classical model based on DNA sequence homology, must facilitate more efficient homologous recognition. One such mechanism could involve exploitation of differences in chromosome structure between homologs and homoeologs at the onset of meiosis. In turn, these chromatin changes, can be expected to be linked to transcriptional gene activity. In this study, we present an extensive analysis of a large RNA-seq data derived from six different genotypes: wheat, wheat?rye hybrids and newly synthesized octoploid triticale, both in the presence and absence of the Ph1 locus. Plant material was collected at early prophase, at the transition leptotene-zygotene, when the telomere bouquet is forming and synapsis between homologs is beginning. The six genotypes exhibit different levels of synapsis and chromatin structure at this stage; therefore, recombination and consequently segregation, are also different. Unexpectedly, our study reveals that neither synapsis, whole genome duplication nor the absence of the Ph1 locus are associated with major changes in gene expression levels during early meiotic prophase. Overall wheat transcription at this meiotic stage is therefore highly resilient to such alterations, even in the presence of major chromatin structural changes. Further studies in wheat and other polyploid species will be required to reveal whether these observations are specific to wheat meiosis. The genetic mechanisms regulating meiotic progression in plants are still not fully understood. Our knowledge of the genes involved in meiosis in many crop species such as wheat is largely based on studies on model species. The latest advances of wheat genomics in particular the high-quality genome reference sequence and a developmental gene expression atlas, together with the gene expression data collected from meiotic samples have provided the prerequisite resources for building a co-expression gene network to facilitate wheat meiotic studies. We used the WGCNA package in R to build a meiotic gene co-expression network in wheat based on 130 wheat RNA-seq samples collected from a range of tissues including meiotic tissue (anthers at different meiotic stages). A set of 50,387 genes were expressed during meiosis (TPM ? 0.5 in one meiosis sample at least) and assigned to 66 modules according to their expression patterns. Three of the modules (modules 2, 28 and 41 containing 4940 genes, 544 genes and 313 genes, respectively) were significantly correlated with meiotic tissue samples (r > 0.5, FDR adjusted p < 0.001) but not with any other type of tissue. Gene Ontology (GO) term enrichment analysis showed that GO terms related to cell cycle, DNA replication, chromatin modifications and other processes occurring during meiosis were highly enriched (FDR adjusted p < 0.001) in the three modules. We also applied orthology informed approaches to evaluate the genes in the meiosis-related modules and found that wheat orthologs of meiosis genes were found in modules 2, 28 and 41. Module 2, in particular, was significantly enriched possessing 166 meiosis orthologs. The combination of co-expression network analysis in tandem with orthologue information will contribute to the discovery of new meiosis genes and greatly empowers reverse genetics approaches to validate the function of candidate genes. Ultimately this will lead to better understanding of the regulation of meiosis in wheat (and other polyploid plants) and subsequently improve wheat production. To our knowledge, this study represents the first meiotic co-expression gene network built in polyploids. Project Code: BB/J007188/1\",\n" +
//                "        \"license\" : {\"so:name\": \"toronto\", \"so:url\": \"https://www.nature.com/articles/461168a#Sec2\" },\n" +
//                "        \"project_codes\":[\"BB/J007188/1\"],\n" +
//                "        \"url\":\"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Martin_etal_2018_Alabdullah_etal_2019_wheat_meiosis_transcriptome_and_co-expression_network/\",\n" +
//                "        \"irods_path\":\"/grassrootsZone/public/under_license/toronto/Martin_etal_2018_Alabdullah_etal_2019_wheat_meiosis_transcriptome_and_co-expression_network\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "        \"uuid\":\"844c0d71-5288-4f85-ae66-cc7d66596ab1\",\n" +
//                "        \"authors\": [\"Brande Wulff\", \"Burkhard Steuernagel\"],\n" +
//                "        \"projectName\": \"Aegilops tauschii diversity panel\",\n" +
//                "        \"description\": \"This is the raw data from whole genome shotgun sequencing of 150 accessions of Aegilops tauschii, a wild relative of wheat. This data was generated by the open wild wheat consortium. Financial support for this project includes (but is not excluded to) the BBSRC (Designing Future Wheat BB/P016855/1), KWS, Syngenta, Bayer and Limagrain. In kind support was received from CLC Bio, Novogene and 2Blades.\",\n" +
//                "        \"license\" : {\"so:name\": \"toronto\", \"so:url\": \"https://www.nature.com/articles/461168a#Sec2\" },\n" +
//                "        \"project_codes\":[\"BB/P016855/1\"],\n" +
//                "        \"url\":\"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Wulff_2018-01-31_OWWC/\",\n" +
//                "        \"irods_path\":\"/grassrootsZone/public/under_license/toronto/Wulff_2018-01-31_OWWC\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "        \"uuid\":\"1e949203-127e-4d5d-8738-fa1e98fb4b82\",\n" +
//                "        \"authors\": [\"Ricardo Ramirez-Gonzalez\", \"Philippa Borrill\", \"Cristobal.Uauy\"],\n" +
//                "        \"projectName\": \"The transcriptional landscape of hexaploid wheat across tissues, cultivars, and stress conditions\",\n" +
//                "        \"description\": \"The coordinatronto\", \"so:url\": \"https://www.nature.com/articles/461168a#Sec2\" },\n" +
//                "        \"project_codes\":[\"BB/P016855/1\"],\n" +
//                "        \"url\":\"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Ramirez-Gonzalez_etal_2018-06025-Transcriptome-Landscape/\",\n" +
//                "        \"irods_path\":\"/grassrootsZone/public/under_license/toronto/Ramirez-Gonzalez_etal_2018-06025-Transcriptome-Landscape\"\n" +
//                "    }\n" +
//                "]";
//        JSONArray projectInfo = new JSONArray();
//        projectInfo = JSONArray.fromObject(projectInfoStr);

//        String G_METADATA_API_URL_S = "https://grassroots.tools/test-insecure/data/api/metadata/";
//        String elasticsearch_url = "https://grassroots.tools/elastic-search/irods/project/";

        String toronto = "All of the data listed here is available under the prepublication data sharing principle of the <a\n" +
                "            href=\"https://www.nature.com/articles/461168a\">Toronto agreement</a>.\n" +
                "        By using this data, you agree to:\n" +
                "\n" +
                "        <ul>\n" +
                "            <li>respect the rights of the data producers and contributors to analyze and publish the first\n" +
                "                global\n" +
                "                analyses and certain other reserved analyses of this data set in a peer-reviewed publication.\n" +
                "            </li>\n" +
                "            <li>not redistribute, release, or otherwise provide access to the data to anyone outside of the\n" +
                "                group, until\n" +
                "                the data has been published &amp; submitted to the public data repositories.\n" +
                "            </li>\n" +
                "            <li>contact the authors to discuss any plans to publish data or analyses that utilize this data to\n" +
                "                avoid the\n" +
                "                overlap of any planned analyses.\n" +
                "            </li>\n" +
                "            <li>fully cite the prepublication data along with any applicable versioning details.</li>\n" +
                "            <li>understand that this data as accessed is precompetitive and is not patentable in its present\n" +
                "                state.\n" +
                "            </li>\n" +
                "        </ul>\n" +
                "        This agreement does not expire by time but only upon publication of the first global analysis by the\n" +
                "        data\n" +
                "        producers and contributors.";


//            JSONArray imetaArray = new JSONArray();
        JSONObject esObject = new JSONObject();

        try {
//            String projectName = "";
//            String poi = "";
//            String license = "";
//            String license_detail = "";
//            String description = "";
//            String license_style = "display:none ! important; ";
//            String projectStyle = "";
//            if (uuid != null || !uuid.equals("null") || !uuid.equals("")) {
//                HttpClient client = new DefaultHttpClient();
//                HttpGet esGet = new HttpGet(elasticsearch_url + uuid);
//                HttpResponse responseGet = client.execute(esGet);
//                HttpEntity resEntityGet = responseGet.getEntity();
//                if (resEntityGet != null) {
//                    BufferedReader rd = new BufferedReader(new InputStreamReader(resEntityGet.getContent()));
//                    String line = "";
//                    while ((line = rd.readLine()) != null) {
//                        if (line.startsWith("{")) {
//                            esObject = JSONObject.fromObject(line);
//                            if (esObject.get("_source") != null) {
//                                JSONObject sourceObject = esObject.getJSONObject("_source");
//                                if (sourceObject.get("projectName") != null) {
//                                    projectName = sourceObject.getString("projectName");
//                                    projectStyle = "style=\"padding: 100px 0px 0px 0px ! important;\"";
//                                }
//                                if (sourceObject.get("poi") != null) {
//                                    poi = sourceObject.getString("poi");
//                                }
//                                if (sourceObject.get("description") != null) {
//                                    description = sourceObject.getString("description");
//                                }
//                                if (sourceObject.get("license") != null) {
//                                    license = "License - " + sourceObject.getString("license");
//                                    license_style = "";
//                                    if (license.equals("License - toronto")) {
//                                        license = "Toronto Agreement";
//                                        license_detail = toronto;
//                                    }
//                                } else {
//                                    license_style = "display:none ! important; ";
//                                }
//
//                            }
//                        }
//                    }
//                }
//            }

            String projectName = "";
            String poi = "";
            String license = "Toronto Agreement";
            String license_detail = "";
            String description = "";
            String license_style = "";
            String projectStyle = "style=\"padding: 100px 0px 0px 0px ! important;\"";


            model.put("projectName", projectName);
            model.put("poi", poi);
            model.put("description", description);
            model.put("license", license);
            model.put("license_detail", license_detail);
            model.put("license_style", license_style);
            model.put("projectStyle", projectStyle);

            return new ModelAndView("/eirodsdavheader.jsp", model);
        } catch (Exception ex) {
            throw ex;
        }
    }

    @RequestMapping("/eirods-dav-header-test/")
    public ModelAndView getHeaderforiRODSObjTest(@RequestParam("uuid") String uuid, ModelMap model) throws IOException {

        String G_METADATA_API_URL_S = "https://grassroots.tools/test-insecure/data/api/metadata/";
        String elasticsearch_url = "https://grassroots.tools/elastic-search/irods/project/";

        String toronto = "All of the data listed here is available under the prepublication data sharing principle of the <a\n" +
                "            href=\"https://www.nature.com/articles/461168a\">Toronto agreement</a>.\n" +
                "        By using this data, you agree to:\n" +
                "\n" +
                "        <ul>\n" +
                "            <li>respect the rights of the data producers and contributors to analyze and publish the first\n" +
                "                global\n" +
                "                analyses and certain other reserved analyses of this data set in a peer-reviewed publication.\n" +
                "            </li>\n" +
                "            <li>not redistribute, release, or otherwise provide access to the data to anyone outside of the\n" +
                "                group, until\n" +
                "                the data has been published &amp; submitted to the public data repositories.\n" +
                "            </li>\n" +
                "            <li>contact the authors to discuss any plans to publish data or analyses that utilize this data to\n" +
                "                avoid the\n" +
                "                overlap of any planned analyses.\n" +
                "            </li>\n" +
                "            <li>fully cite the prepublication data along with any applicable versioning details.</li>\n" +
                "            <li>understand that this data as accessed is precompetitive and is not patentable in its present\n" +
                "                state.\n" +
                "            </li>\n" +
                "        </ul>\n" +
                "        This agreement does not expire by time but only upon publication of the first global analysis by the\n" +
                "        data\n" +
                "        producers and contributors.";


//            JSONArray imetaArray = new JSONArray();
        JSONObject esObject = new JSONObject();

        try {
            String projectName = "";
            String poi = "";
            String license = "";
            String license_detail = "";
            String description = "";
            String license_style = "display:none ! important; ";
            String projectStyle = "";
            if (uuid != null || !uuid.equals("null") || !uuid.equals("")) {
                HttpClient client = new DefaultHttpClient();
                HttpGet esGet = new HttpGet(elasticsearch_url + uuid);
                HttpResponse responseGet = client.execute(esGet);
                HttpEntity resEntityGet = responseGet.getEntity();
                if (resEntityGet != null) {
                    BufferedReader rd = new BufferedReader(new InputStreamReader(resEntityGet.getContent()));
                    String line = "";
                    while ((line = rd.readLine()) != null) {
                        esObject = JSONObject.fromObject(line);
                        if (esObject.get("_source") != null) {
                            JSONObject sourceObject = esObject.getJSONObject("_source");
                            if (sourceObject.get("projectName") != null) {
                                projectName = sourceObject.getString("projectName");
                                projectStyle = "style=\"padding: 100px 0px 0px 0px ! important;\"";
                            }
                            if (sourceObject.get("poi") != null) {
                                poi = sourceObject.getString("poi");
                            }
                            if (sourceObject.get("description") != null) {
                                description = sourceObject.getString("description");
                            }
                            if (sourceObject.get("license") != null) {
                                license = "License - " + sourceObject.getString("license");
                                license_style = "";
                                if (license.equals("License - toronto")) {
                                    license = "Toronto Agreement";
                                    license_detail = toronto;
                                }
                            } else {
                                license_style = "display:none ! important; ";
                            }

                        }
                    }
                }
            }
            model.put("projectName", projectName);
            model.put("poi", poi);
            model.put("description", description);
            model.put("license", license);
            model.put("license_detail", license_detail);
            model.put("license_style", license_style);
            model.put("projectStyle", projectStyle);

            return new ModelAndView("/eirodsdavheadertest.jsp", model);
        } catch (Exception ex) {
            throw ex;
        }
    }
}
