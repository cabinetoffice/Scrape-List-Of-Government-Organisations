## This code scrapes all the organisations currently present on https://www.gov.uk/government/organisations and writes them to a dataset.

library(magrittr)

url <- "https://www.gov.uk/government/organisations"

webpage <- rvest::read_html(url)

raw_items <- 
  webpage %>% 
  rvest::html_elements(".organisations-list__item") %>% 
  rvest::html_text()

clean_items <- 
  raw_items %>% 
  stringr::str_trim() %>% 
  stringr::str_squish() %>% 
  stringr::str_replace(pattern = " Works with.*", replacement = "")

## Write a csv file to the working directory.

sysdatetime <- Sys.time() %>% 
  format("%Y-%m-%d_%H-%M-%S_%Z")

readr::write_excel_csv(
  clean_items %>% tibble::tibble(),
  file = paste0(sysdatetime, " Organisations on gov UK.csv")
)
