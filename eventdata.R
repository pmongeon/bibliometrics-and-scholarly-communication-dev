library(httr)
library(stringr)
library(dplyr)

email <- "pmongeon@dal.ca"
doi <- "https://doi.org/10.1371/journal.pone.0127502"
filename <- "event_data_example.csv"

events_raw <- content(GET(str_c("https://api.eventdata.crossref.org/v1/events?mailto=",
                    email,"&obj-id=",doi,"&rows=1000", sep = "")))$message$event

events <- tibble()
for (i in 1:length(events_raw)) {
  data<-tibble()
  subj_id <- events_raw[[i]]$subj_id
  relation <- events_raw[[i]]$relation_type_id
  obj_id <- events_raw[[i]]$obj_id
  date <- events_raw[[i]]$occurred_at
  events <- bind_rows(events, tibble(subj_id, relation, obj_id, date))
  
#  data <- data.frame(matrix(unlist(events_raw[[i]])))
#  row.names(data)<-names(unlist(events_raw[[i]]))
#  data<-tibble::rownames_to_column(data)
#  data<-pivot_wider(data, names_from = 1, values_from = 2)
#  events <- bind_rows(events, data)

  }

write.csv(events, filename, row.names = F)
