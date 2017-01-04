## `sample_index`

set.seed(777)
index <- matrix(rnorm(60, 1000, 8^2), 20, 3)
sample_index <- xts(round(index, 1), as.Date(16001:16020))
names(sample_index) <- paste0("Fund_", 1:3)

save(sample_index, file = "data/sample_index.rda")

## `sample_index2`

set.seed(777)
index <- matrix(rnorm(3000, 1000, 8^2), 1000, 3)
sample_index2 <- xts(round(index, 1), as.Date(16001:17000))
names(sample_index2) <- paste0("Fund_", 1:3)
sample_index2[1:100, 1] <- NA
sample_index2[sample(1:1000, 100), 2] <- NA
sample_index2[980:1000, 3] <- NA

save(sample_index2, file = "data/sample_index2.rda")
