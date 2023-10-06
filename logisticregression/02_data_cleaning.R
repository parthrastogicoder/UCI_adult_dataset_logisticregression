
# Purpose: Clean categorical columns and handle missing values

# Clean type_employer column
clean_type_employer <- function(job) 
  {
  job <- as.character(job)
  if (job == 'Never-worked' | job == 'Without-pay') 
  {
    return('Unemployed')
  } 
  else 
  {
    return(job)
  }
}

# Clean marital column
clean_marital <- function(marital_status) 
  {
  marital_status <- as.character(marital_status)
  if (marital_status %in% c('Separated', 'Divorced', 'Widowed')) 
  {
    return('Not-Married')
  } 
  else if (marital_status == 'Never-married') 
  {
    return('Never-Married')
  } 
  else 
  {
    return('Married')
  }
}

# Clean country column
clean_country <- function(country) 
{
  asia <- c('China', 'Hong', 'India', 'Iran', 'Cambodia', 'Japan', 'Laos',
            'Philippines', 'Vietnam', 'Taiwan', 'Thailand')
  
  north_america <- c('Canada', 'United-States', 'Puerto-Rico')
  
  europe <- c('England', 'France', 'Germany', 'Greece', 'Holand-Netherlands', 'Hungary',
              'Ireland', 'Italy', 'Poland', 'Portugal', 'Scotland', 'Yugoslavia')
  
  latin_and_south_america <- c('Columbia', 'Cuba', 'Dominican-Republic', 'Ecuador',
                               'El-Salvador', 'Guatemala', 'Haiti', 'Honduras',
                               'Mexico', 'Nicaragua', 'Outlying-US(Guam-USVI-etc)', 'Peru',
                               'Jamaica', 'Trinadad&Tobago')
  
  if (country %in% asia) 
  {
    return('Asia')
  } 
  else if (country %in% north_america) 
  {
    return('North.America')
  }
  else if (country %in% europe) 
  {
    return('Europe')
  } 
  else if (country %in% latin_and_south_america) 
  {
    return('Latin.and.South.America')
  } 
  else 
  {
    return('Other')
  }
}

# Handle missing values
adult$type_employer <- sapply(adult$type_employer, clean_type_employer)
adult$marital <- sapply(adult$marital, clean_marital)
adult$country <- sapply(adult$country, clean_country)

# Convert columns to factors
adult$type_employer <- factor(adult$type_employer)
adult$marital <- factor(adult$marital)
adult$country <- factor(adult$country)
