## `hangle`

library(tidyverse)

hangle <- read.csv(text = "
  이름, 성별, 점수
  홍길동, 남, 98
  김철수, 남, 96
  김영희, 여, 99") %>% tbl_df

write.csv(hangle, "hangle.csv", fileEncoding = "UTF-8")
save(hangle, file = "hangle.rda")
