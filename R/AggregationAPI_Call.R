# Script to get data from the Pendo API using an aggregation for a specific end point and output the results into a csv file.
# Author: ST, March 8, 2018

library(rjson)
library(RJSONIO)
library(jsonlite)
library(rjstat)
require(curl)
require(httr)


# Function to access the data from the aggregation endpoint
GetData <- function(agg_endpoint_URL, intg_key, data)
{
  curlgen <- agg_endpoint_URL

  headers <- add_headers("Content-Type"="application/json","x-pendo-integration-key"=intg_key)
  res1 <- POST(curlgen, headers, body=data,encode="json")  
  F1 <- fromJSON(content(res1,"text")) # Dataframe with the json request
  return(F1)
}


######### 

integration_key <- "your_integration_key"   # Insert your integration key here.
agg_endpoint <- "your_aggregation_endpoint_URL"   # Insert your end point here.
data <- "your_json_request" # Insert your JSON request here. 

agg_file <- "your_aggregation_file_path"  # JSON file containing your aggregation request. Example, agg_example.json in this directory.
PC <- GetData(agg_endpoint, integration_key, data)
dfPC <-as.data.frame(PC)
write.csv(dfPC,"your_agg_results.csv")  # Save the dataframe to the file you want to store the results in.
