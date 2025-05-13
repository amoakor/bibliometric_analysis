##Automated Document Download/ extraction
##Package Installations
install.packages("wosr")
install.packages("rscopus")
install.packages("easyPubMed")
install.packages("bibliometrix")
install.packages("rentrez")


library(wosr)
library(rscopus)
library(easyPubMed)


#Web of Science API (Preferred for Large Datasets)
Sys.setenv(WOS_KEY = "your_api_key_here")
records <- wos_search(query = "data visualization AND evaluation report", database = "WOS", limit = 500)
write.csv(records, "wos_data.csv")


#Scopus API (Preferred for Citation Analysis & Abstracts)
set_api_key("XXXXXXXXXXX")
query <- "data visualization AND evaluation report"
res <- scopus_search(query = query, max_count = 100)
# Extract the data frame from the results
df <- gen_entries_to_df(res$entries)

# Write the results to a CSV file
write.csv(df, "scopus_data.csv")

##############################################################
###PubMed API (For Health-Related Evaluation Studies)
query <- "data visualization AND evaluation report"
pubmed_records <- get_pubmed_data(query)
write.csv(pubmed_records, "pubmed_data.csv")
#########################################################
### PubMed API (For Health-Related Evaluation Studies)

library(rentrez)

# Set up the query
query <- "data visualization AND evaluation report"

# Search PubMed
search_results <- entrez_search(db = "pubmed", term = query, retmax = 120)

# Fetch the records
pubmed_records <- entrez_fetch(db = "pubmed", id = search_results$ids, rettype = "xml")

# Parse the XML data
library(XML)
parsed_records <- xmlToDataFrame(xmlParse(pubmed_records))

# Write the data to a CSV file
write.csv(parsed_records, "pubmed_data.csv")
#############################################################################



# Automated Data Extraction and Preprocessing
#Once the bibliographic records are downloaded, they need cleaning and processing.

# Using R (bibliometrix)
#bibliometrix is the most widely used R package for automated bibliometric extraction.

library(bibliometrix)
data <- convert2df("scopus_data.csv", dbsource = "scopus", format = "csv")
summary(data)



#Advanced Bibliometric Analysis
#Once data is extracted, the following network analyses can be automated:
  #Co-Occurrence and Keyword Analysis
#R (bibliometrix)
keywords <- biblioNetwork(data, analysis = "co-occurrences", network = "keywords")
netplot(keywords, title="Keyword Co-occurrence Map")

#Load tidyverse


