# Load required libraries
library(rvest)
library(writexl)

# Function to scrape iron ore data for a specific date
scrape_iron_ore_data <- function(date) {
  # Construct URL
  base_url <- "https://tradingeconomics.com/commodity/iron-ore/historical-data"
  formatted_date <- format(date, "%Y-%m-%d")
  url <- paste(base_url, formatted_date, sep = "/")
  
  # Scrape data
  webpage <- read_html(url)
  date <- webpage %>% html_node(".floatleft .date") %>% html_text() %>% trimws()
  price <- webpage %>% html_node(".floatleft .dollar") %>% html_text() %>% trimws()
  
  # Return scraped data as a data frame
  return(data.frame(Date = date, Price = price))
}

# Function to scrape iron ore data for a range of dates and save to Excel
scrape_iron_ore_data_range_and_save_to_excel <- function(start_date, end_date, excel_file) {
  # Initialize empty data frame to store scraped data
  all_data <- data.frame(Date = character(), Price = character(), stringsAsFactors = FALSE)
  
  # Loop through each day in the range
  for (date in seq(start_date, end_date, by = "days")) {
    # Scrape data for the current date
    scraped_data <- scrape_iron_ore_data(date)
    
    # Append scraped data to the data frame
    all_data <- rbind(all_data, scraped_data)
  }
  
  # Save data to Excel file
  write_xlsx(all_data, excel_file)
  print(paste("Data saved to", excel_file))
}

# Define start and end dates
start_date <- as.Date("2023-01-01")
end_date <- as.Date("2024-12-31")

# Specify the Excel file path
excel_file <- "iron_ore_data.xlsx"

# Scrape iron ore data for the specified date range and save to Excel
scrape_iron_ore_data_range_and_save_to_excel(start_date, end_date, excel_file)
