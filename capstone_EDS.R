
#| echo: false
#| eval: false
#| include: false
#| message: false
#| warning: false
#| error: false
#| results: false
#| setup: false
#| import: false
#| output: false
#| options: false
#| code_folding: false
#| cache: false






library(tidyverse)
library(janitor)
library(psych)


#load data called biblio_data
biblio_df <- read_csv("biblio_data.csv")

#check the structure of the data
str(biblio_df)


#check the first few rows of the data
head(biblio_df)

#Check the column name of DOI to doi
biblio_df <- biblio_df %>% rename(doi = DOI)

#remove duplication rows
biblio_df <- biblio_df %>% distinct()

#calculate number of duplicated rows
nrow(biblio_df) - nrow(biblio_df %>% distinct())

#Screen title and abstract for irrelavant data
biblio_df <- biblio_df %>% filter(!str_detect(Title, "^(?i)abstract"))

#filter by years 2010-2025 and create a new dataframe called rnew_biblio
rnew_biblio <- new_biblio %>% filter(Year >= 2010 & Year <= 2025)
#Clean column names
rnew_biblio <- rnew_biblio %>% clean_names()



#check the number of rows after removing irrelevant data
nrow(new_biblio)


#Load new data called ris1_screened.csv and ris3_screened.csv
ris1_screened <- read_csv("ris1_screened.csv")
ris3_screened <- read_csv("ris3_screened.csv")

#filter by decision column and create a new dataframe called ris1_included and ris3_included
ris1_included <- ris1_screened %>% filter(decision == "Included")
ris3_included <- ris3_screened %>% filter(decision == "Included")
#Combine the two dataframes
combined_ris <- bind_rows(ris1_included, ris3_included)
#drop the decision column
combined_ris <- combined_ris %>% select(-decision)
#remove duplicated rows
combined_ris <- combined_ris %>% distinct()
#check the number of rows
nrow(combined_ris)
#write the combined data to a new csv file
write_csv(combined_ris, "combined_ris.csv")

#Left merge the combined_ris data with the rnew_biblio data based on the DOI column
merged_left <- left_join(combined_ris, rnew_biblio, by = "doi")
#check the number of rows in the merged data
nrow(merged_left)
#write the merged data to a new csv file
write_csv(df_merged, "df_merge.csv")

#install and load the package wordcloud
install.packages("wordcloud")
library(wordcloud)

#install and load the package world map
install.packages("maps")
library(maps)

# Load required libraries
library(ggplot2)
library(dplyr)
library(maps)       # For world map data
library(viridis)    # For color scales

library(rnaturalearthdata)
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")


library(leaflet)
library(leaflet.extras)
install.packages("leaflet.extras")
install.packages("leaflet")
library(leaflet.extras)
library(leaflet)

install.packages("sf")   # Install the package
library(sf)              # Then load it


install.packages("rgdal")
library(rgdal)

saveWidget
library(htmlwidgets)
library(htmltools)
install.packages("htmlwidgets")


df_mergedx <- df_mergedx %>%
  filter(year != 2025)


# Install the ggraph package
install.packages("ggraph", repos="https://cran.rstudio.com/", dependencies = FALSE, Ncpus = 4)

# Let's also install tidygraph which is often used with ggraph
install.packages("tidygraph", repos="https://cran.rstudio.com/", dependencies = FALSE, Ncpus = 4)

install.packages("ggraph")
install.packages("tidystm")
library(tidystm)


# Plot all topics in a grid
plot(prep, 
     covariate = "year", 
     topics = 1:5,  # Display all 5 topics
     model = stm_model, 
     method = "continuous", 
     xlab = "Year", 
     main = "Effect of Year on All Topics",
     labeltype = "frex",  # Optional: label topics with FREX words
     n = 5)  # Number of words in labels

# Extract plotting data
tidydata <- extract.estimateEffect(prep, 
                                   covariate = "year", 
                                   topics = 1:5,  # All topics
                                   method = "continuous")

# Create a combined plot
ggplot(tidydata, aes(x = covariate.value, y = estimate, color = factor(topic))) +
  geom_line(linewidth = 1) +
  geom_ribbon(aes(ymin = ci.lower, ymax = ci.upper, fill = factor(topic)), 
              alpha = 0.1, linetype = "dashed") +
  labs(x = "Year", 
       y = "Expected Topic Proportion", 
       title = "Effect of Year on All Topics",
       color = "Topic",
       fill = "Topic") +
  theme_minimal()

# Conceptual Structure using keywords (method="CA")
# Create a document-term matrix
library(tm)
library(SnowballC)
library(lsa)
library(ggplot2)
library(ggrepel)
library(ggdendro)
library(dendextend)
library(cluster)
library(factoextra)


# Load ggraph for better visualization
library(ggraph)
library(tidygraph)

edge_data <- as_data_frame(g_tidy, what = "edges")
print(edge_data)

# Convert to tidygraph object
g_tidy <- as_tbl_graph(g)


# Plot using ggraph
ggraph(g_tidy, layout = 'fr') +
  geom_edge_link(aes(edge_alpha = 50), show.legend = FALSE) +
  geom_node_point(aes(size = degree), color = 'steelblue', alpha = 0.6) +
  geom_node_text(aes(label = name), repel = TRUE, size = 3) +
  theme_void() +
  labs(title = 'Collaboration Network (Authors)', subtitle = 'Node size by degree centrality')
# Save the plot
#ggsave("collaboration_network.png", width = 10, height = 8, dpi = 300)


# Assuming g_tidy is created using tidygraph or igraph
g_tidy <- as_tbl_graph(graph_from_data_frame(edges = edge_data, vertices = node_data))


# Count the number of publications per country
country_counts <- df_mergedx %>% 
  filter(!is.na(country) & country != "") %>% 
  count(country, sort = TRUE)
# Prepare world map data
world_map <- map_data("world")
# Let's see the structure of world_map
head(world_map)
# For merging, I might need to harmonize the country names in the data with those in the map data
# For simplicity, I assume that country names match; if not they should be adjusted.
# Join the counts with the world map data. Since the map data has region column
country_counts <- country_counts %>% rename(region = country)
map_data_counts <- left_join(world_map, country_counts, by = "region")
# Create the map plot
map_plot <- ggplot() +
  geom_polygon(data = map_data_counts, aes(x = long, y = lat, group = group, fill = n), color = "gray90", size = 0.1) +
  scale_fill_continuous(name = "Publication Count", low = "lightblue", high = "darkblue", na.value = "white") +
  theme_minimal() +
  labs(title = "Geographical Distribution of Publications") +
  theme(panel.background = element_rect(fill = "white"))
print(map_plot)


install.packages("countrycode")
library(countrycode)

install.packages("ggsave")


install.packages("reticulate")
library(reticulate)


#Data extraction using APIs

# #Web of Science API 
# Sys.setenv(WOS_KEY = "xxxxx")
# records <- wos_search(query = "data visualization AND evaluation report", database = "WOS", limit = 250)
# write.csv(records, "wos_data.csv")
# 
# 
# #Scopus API (Preferred for Citation Analysis & Abstracts)
# set_api_key("xxxxxx")
# query <- "data visualization AND evaluation report"
# res <- scopus_search(query = query, max_count = 100)
# # Extract the data frame from the results
# scopus <- gen_entries_to_df(res$entries)
# 
# # Write the results to a CSV file
# write.csv(scopus, "scopus_data.csv")




# Count the number of publications per country
country_counts <- df_mergedx %>% 
  filter(!is.na(country) & country != "") %>% 
  count(country, sort = TRUE)

print(country_counts)

# Prepare world map data
world_map <- map_data("world")

# Let's see the structure of world_map
head(world_map)

# For merging, I might need to harmonize the country names in the data with those in the map data
# For simplicity, I assume that country names match; if not they should be adjusted.

# Join the counts with the world map data. Since the map data has region column
country_counts <- country_counts %>% rename(region = country)
map_data_counts <- left_join(world_map, country_counts, by = "region")

# Create the map plot
map_plot <- ggplot() +
  geom_polygon(data = map_data_counts, aes(x = long, y = lat, group = group, fill = n), color = "gray90", size = 0.1) +
  scale_fill_continuous(name = "Publication Count", low = "lightblue", high = "darkblue", na.value = "white") +
  theme_minimal() +
  labs(title = "Geographical Distribution of Publications") +
  theme(panel.background = element_rect(fill = "white"))

print(map_plot)