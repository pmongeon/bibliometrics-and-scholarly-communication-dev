install.packages(scholar)
pubs<- scholar::get_publications("bRj8KHYAAAAJ")
write.csv(pubs, "c:/data/lspiteri_google_scholar.csv")

install.packages("openalexR")
library(openalexR)

pubs <- openalexR::oaApiRequest()


email <- "pmongeon@dal.ca"
author_id <- "https://openalex.org/A1923114979"

# This code sets the URL for the API call.
author_url <- stringr::str_replace(author_id,"https://openalex.org","https://api.openalex.org") 

# This makes the API call and stores the data into a list.
author_data <- openalexR::oaApiRequest(author_url, mailto = email)
publication_data <- openalexR::oaApiRequest("https://api.openalex.org/works?filter=author.id:A1923114979", mailto = email)
publication_data <- openalexR::oa2df(publication_data)

write.csv(publication_data, "test.csv")
