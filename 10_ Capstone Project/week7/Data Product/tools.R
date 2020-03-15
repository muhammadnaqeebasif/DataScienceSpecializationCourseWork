# Load the models

profanity <- readLines("https://www.cs.cmu.edu/~biglou/resources/bad-words.txt")
clean.text <- function(doc) {
  library(tm)
  doc <- iconv(doc, "latin1", "ASCII", sub="")
  # "won't" is a special case as it does not expand to "wo not"
  doc <- gsub("won't", "will not", doc)
  doc <- gsub("can't", "can not", doc)
  doc <- gsub("n't", " not", doc)
  doc <- gsub("'ll", " will", doc)
  doc <- gsub("'re", " are", doc)
  doc <- gsub("'ve", " have", doc)
  doc <- gsub("'m", " am", doc)
  doc <- gsub("'d", " would", doc)
  # 's could be 'is' or could be possessive: it has no expansion
  doc <- gsub("'s", "", doc)
  doc <- tolower(doc)
  
  doc <- removeWords(doc,profanity)
  
  doc <- gsub("http[[:alnum:][:punct:]]*","",doc)
  doc <- gsub("[[:punct:]]*","",doc)
  doc <- gsub("[[:digit:]]*","",doc)
  doc <- gsub("\\s+"," ",doc)
  
  return(doc)
}


predict <- function(line,keras=FALSE){
  library(purrr)
  library(dplyr)
  
  line.clean = clean.text(line)
  line.split <- strsplit(line.clean,split = " ")[[1]]
  line.length <- length(line.split)
  line.model_lines <- map(0:3,function(x){
                          if(line.length <= x){
                            return("")
                          }
                          res <- line.split[(line.length - x):line.length]
                          paste(res,collapse = " ")
                        }
                    )
  
  predictions <- list(unigram$sentence[[1]])
  line.next_prediction <- map2(line.model_lines,list(bigram,
                                                     trigram,
                                                     fourgram,
                                                     fivegram),
                               function(line,n_gram_model){
                                 prediction <- n_gram_model %>% 
                                                filter(sentence == line) %>%
                                                head(1)
                                 prediction$output      
                               }
                          )
  predictions <- c(predictions,line.next_prediction)
  
  if(keras){
    pred_index <- predict_classes(model,pad_sequences(texts_to_sequences(tokenizer,line.clean),4))
    predictions <- c(predictions,list(tokenizer$index_word[[pred_index]]))
  }
  
  return(predictions)
  
}
