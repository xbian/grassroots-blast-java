

 var project_info=[
    {
        "uuid":"ffc3e90f-7f89-4934-8e35-943bb64d1789",
        "authors": ["Anthony Hall", "Laura-Jayne Gardiner"],
        "projectName": "Integrating genomic resources to present full gene and promoter capture probe sets for bread wheat",
        "description": "Whole genome shotgun re-sequencing of wheat is expensive because of its large, repetitive genome. Moreover, sequence data can fail to map uniquely to the reference genome making it difficult to unambiguously assign variation. Re-sequencing using target capture enables sequencing of large numbers of individuals at high coverage to reliably identify variants associated with important agronomic traits. We present two gold standard capture probe sets for hexaploid bread wheat, a gene and a promoter capture, which are designed using recently developed genome sequence and annotation resources. The captures can be combined or used independently. The capture probe sets effectively enrich the high confidence genes and promoters that were identified in the genome alongside a large proportion of the low confidence genes and promoters. We use a capture design employing an 'island strategy' to enable analysis of the large gene/promoter space of wheat with only 2x160 Mb NimbelGen probe sets. Furthermore, these assays extend the regions of the wheat genome that are amenable to analyses beyond its exome, providing tools for detailed characterization of these regulatory regions in large populations. Here, we release the targeted sequence of the capture probe sets on the wheat RefSeqv1, the design space that was used to tile our capture probes across and finally the positions of the probes themselves across this design space for both the gene and promoter capture probe sets. This project was supported by the BBSRC via an ERA-CAPS grant BB/N005104/1, BB/N005155/1 and BBSRC Designing Future Wheat BB/P016855/1.",
        "license" : {"so:name": "toronto", "so:url": "https://www.nature.com/articles/461168a#Sec2" },
        "project_codes":["BB/N005104/1", "BB/N005155/1", "BB/P016855/1"],
        "url":"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Gardiner_2018-07-04_Wheat-gene-promoter-capture/",
        "irods_path":"/grassrootsZone/public/under_license/toronto/Gardiner_2018-07-04_Wheat-gene-promoter-capture",
        "@type": "grassroots:project"
    },
    {
        "uuid":"fd22c6a9-5692-4bbd-bb77-e04567fe3bc0",
        "authors": ["Ji Zhou", "Joshua Ball"],
        "projectName": "DFW RobigusxClaire UAV Image Data",
        "description": "Working with the Griffiths group at JIC we have collected UAV image data for the RobigusxClaire population across the 2019 season. Divided into early, mid, and late drilling dates. Raw images from UAV capture are pre-processed using Pix4DMapper software to create a large, high-detail, orthomosaic images providing a single image for analysis and extraction of wheat traits for QTL analysis. Single whole field images are also captured to account for light and colour variations, This project is supported by the BBSRC Designing Future Wheat grant sub-work package BBS/E/T/000PR9785",
        "license" : {"so:name": "toronto", "so:url": "https://www.nature.com/articles/461168a#Sec2" },
        "project_codes":["BBS/E/T/000PR9785"],
        "url":"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Zhou_2019_RobxCla_UAV_Image_Data/",
        "irods_path":"/grassrootsZone/public/under_license/toronto/Zhou_2019_RobxCla_UAV_Image_Data",
        "@type": "grassroots:project"
    },
    {
        "uuid":"4c53dd08-39d6-4d3a-bfc0-c6a5f32b609f",
        "authors": ["Azahara Carmen Martín", "AbdulKader Alabdullah", "Philippa Borrill", "Ricardo H. Ramírez-González", "Janet Higgins", "David Swarbreck", "Cristobal Uauy", "Peter Shaw", "Graham Moore"],
        "projectName": "Meiosis transcriptome and co-expression network in hexaploid wheat",
        "description": "Polyploidization is a fundamental process in plant evolution. One of the biggest challenges faced by a new polyploid is meiosis, particularly discriminating between multiple related chromosomes so that only homologous chromosomes synapse and recombine to ensure regular chromosome segregation and balanced gametes. Despite its large genome size, high DNA repetitive content and similarity between homoeologous chromosomes, hexaploid wheat completes meiosis in a shorter period than diploid species with a much smaller genome. Therefore, during wheat meiosis, mechanisms additional to the classical model based on DNA sequence homology, must facilitate more efficient homologous recognition. One such mechanism could involve exploitation of differences in chromosome structure between homologs and homoeologs at the onset of meiosis. In turn, these chromatin changes, can be expected to be linked to transcriptional gene activity. In this study, we present an extensive analysis of a large RNA-seq data derived from six different genotypes: wheat, wheat?rye hybrids and newly synthesized octoploid triticale, both in the presence and absence of the Ph1 locus. Plant material was collected at early prophase, at the transition leptotene-zygotene, when the telomere bouquet is forming and synapsis between homologs is beginning. The six genotypes exhibit different levels of synapsis and chromatin structure at this stage; therefore, recombination and consequently segregation, are also different. Unexpectedly, our study reveals that neither synapsis, whole genome duplication nor the absence of the Ph1 locus are associated with major changes in gene expression levels during early meiotic prophase. Overall wheat transcription at this meiotic stage is therefore highly resilient to such alterations, even in the presence of major chromatin structural changes. Further studies in wheat and other polyploid species will be required to reveal whether these observations are specific to wheat meiosis. The genetic mechanisms regulating meiotic progression in plants are still not fully understood. Our knowledge of the genes involved in meiosis in many crop species such as wheat is largely based on studies on model species. The latest advances of wheat genomics in particular the high-quality genome reference sequence and a developmental gene expression atlas, together with the gene expression data collected from meiotic samples have provided the prerequisite resources for building a co-expression gene network to facilitate wheat meiotic studies. We used the WGCNA package in R to build a meiotic gene co-expression network in wheat based on 130 wheat RNA-seq samples collected from a range of tissues including meiotic tissue (anthers at different meiotic stages). A set of 50,387 genes were expressed during meiosis (TPM ? 0.5 in one meiosis sample at least) and assigned to 66 modules according to their expression patterns. Three of the modules (modules 2, 28 and 41 containing 4940 genes, 544 genes and 313 genes, respectively) were significantly correlated with meiotic tissue samples (r > 0.5, FDR adjusted p < 0.001) but not with any other type of tissue. Gene Ontology (GO) term enrichment analysis showed that GO terms related to cell cycle, DNA replication, chromatin modifications and other processes occurring during meiosis were highly enriched (FDR adjusted p < 0.001) in the three modules. We also applied orthology informed approaches to evaluate the genes in the meiosis-related modules and found that wheat orthologs of meiosis genes were found in modules 2, 28 and 41. Module 2, in particular, was significantly enriched possessing 166 meiosis orthologs. The combination of co-expression network analysis in tandem with orthologue information will contribute to the discovery of new meiosis genes and greatly empowers reverse genetics approaches to validate the function of candidate genes. Ultimately this will lead to better understanding of the regulation of meiosis in wheat (and other polyploid plants) and subsequently improve wheat production. To our knowledge, this study represents the first meiotic co-expression gene network built in polyploids. Project Code: BB/J007188/1",
        "license" : {"so:name": "toronto", "so:url": "https://www.nature.com/articles/461168a#Sec2" },
        "project_codes":["BB/J007188/1"],
        "url":"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Martin_etal_2018_Alabdullah_etal_2019_wheat_meiosis_transcriptome_and_co-expression_network/",
        "irods_path":"/grassrootsZone/public/under_license/toronto/Martin_etal_2018_Alabdullah_etal_2019_wheat_meiosis_transcriptome_and_co-expression_network",
        "@type": "grassroots:project"
    },
    {
        "uuid":"844c0d71-5288-4f85-ae66-cc7d66596ab1",
        "authors": ["Brande Wulff", "Burkhard Steuernagel"],
        "projectName": "Aegilops tauschii diversity panel",
        "description": "This is the raw data from whole genome shotgun sequencing of 150 accessions of Aegilops tauschii, a wild relative of wheat. This data was generated by the open wild wheat consortium. Financial support for this project includes (but is not excluded to) the BBSRC (Designing Future Wheat BB/P016855/1), KWS, Syngenta, Bayer and Limagrain. In kind support was received from CLC Bio, Novogene and 2Blades.",
        "license" : {"so:name": "toronto", "so:url": "https://www.nature.com/articles/461168a#Sec2" },
        "project_codes":["BB/P016855/1"],
        "url":"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Wulff_2018-01-31_OWWC/",
        "irods_path":"/grassrootsZone/public/under_license/toronto/Wulff_2018-01-31_OWWC",
        "@type": "grassroots:project"
    },
    {
        "uuid":"1e949203-127e-4d5d-8738-fa1e98fb4b82",
        "authors": ["Ricardo Ramirez-Gonzalez", "Philippa Borrill", "Cristobal.Uauy"],
        "projectName": "The transcriptional landscape of hexaploid wheat across tissues, cultivars, and stress conditions",
        "description": "The coordinated expression of highly related homoeologous genes in polyploid species underlies the phenotypes of many of the world?s major crops. However, the balance of homoeolog expression across diverse tissues, stress conditions, and cultivars remains poorly understood. Here we combine extensive gene expression datasets with the fully annotated genome sequence to produce a comprehensive, genome-wide analysis of homoeolog expression patterns in hexaploid bread wheat. Bias in homoeolog expression varied between tissues, with ~30% of wheat homoeologs showing unbalanced expression. We found expression asymmetries along wheat chromosomes, with genes showing the largest inter-tissue, inter-cultivar, and coding sequence variation most often located in the high-recombination distal ends of chromosomes. These transcriptionally dynamic genes potentially represent the first steps towards neo/sub- functionalization of wheat homoeologs. Co-expression networks revealed extensive coordination of homoeologs throughout development and, alongside a detailed expression atlas, provide a framework to target candidate genes underpinning agronomic traits in polyploid wheat. Project Code: BB/P016855/1",
        "license" : {"so:name": "toronto", "so:url": "https://www.nature.com/articles/461168a#Sec2" },
        "project_codes":["BB/P016855/1"],
        "url":"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Ramirez-Gonzalez_etal_2018-06025-Transcriptome-Landscape/",
        "irods_path":"/grassrootsZone/public/under_license/toronto/Ramirez-Gonzalez_etal_2018-06025-Transcriptome-Landscape",
        "@type": "grassroots:project"
    },{
        "uuid":"5dd4fd26-56f7-4ae6-a046-70969f084ce8",
        "authors": ["Anthony Hall", "Laura-Jayne Gardiner"],
        "projectName": "Using 12Mb capture to profile the Watkins bread wheat landrace diversity collection",
        "description": "Wheat has been domesticated into a large number of agricultural environments and has a remarkable ability to adapt to diverse environments. To understand this process, we survey genotype and DNA methylation across the Watkins bread wheat landrace collection, representing global genetic diversity. For each accession, we use gene based sequence capture (12Mb) to focus on the functionally relevant portion of the genome, followed by paired end sequencing on the Hiseq4000. All Watkins accessions therefore have genotypic data available plus sequence data generated after bisulfite treatment to allow methylation calls. This project was supported by the BBSRC via an ERA-CAPS grant BB/N005104/1, BB/N005155/1 and BBSRC Designing Future Wheat BB/P016855/1.",
        "license" : {"so:name": "toronto", "so:url": "https://www.nature.com/articles/461168a#Sec2" },
        "project_codes":["BB/N005104/1", "BB/N005155/1", "BB/P016855/1"],
        "url":"https://opendata.earlham.ac.uk/wheat/under_license/toronto/Gardiner_2018-01-29_Watkins-diversity-12Mb/",
        "irods_path":"/grassrootsZone/public/under_license/toronto/Gardiner_2018-01-29_Watkins-diversity-12Mb",
        "@type": "grassroots:project"
    }
]
