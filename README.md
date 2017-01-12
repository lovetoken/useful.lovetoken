# useful.lovetoken package in R

<style type="text/css">@import url("https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/yeti/bootstrap.min.css")</style>



# Overview

자주사용하는 사용자 정의 함수를 모은 저만의 패키지 입니다.

# Example


```r
library(useful.lovetoken)
```

## `paste2()`

`paste0()` 과 다르게 NA 를 문자열로 인지하지 않고 paste 를 수행합니다.  


```r
A <- "Hello "
B <- c("world", "world!", NA)
paste0(A, B)
```

```
## [1] "Hello world"  "Hello world!" "Hello NA"
```

```r
paste2(A, B)
```

```
## [1] "Hello world"  "Hello world!" "Hello "
```

## `psum()`


```r
sum(1:5, c(1, 2, 3, 4, NA), c(1, NA, 3, 4, 5), na.rm = T)
```

```
## [1] 38
```

```r
psum(1:5, c(1, 2, 3, 4, NA), c(1, NA, 3, 4, 5), na.rm = T)
```

```
## [1]  3  4  9 12 10
```

## `which_matrix()`


```r
(m <- matrix(sample(c(T,F), 30, T), 5, 6))
```

```
##       [,1]  [,2]  [,3]  [,4]  [,5]  [,6]
## [1,]  TRUE FALSE  TRUE  TRUE  TRUE FALSE
## [2,]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE
## [3,] FALSE  TRUE  TRUE FALSE FALSE  TRUE
## [4,] FALSE FALSE  TRUE FALSE  TRUE FALSE
## [5,]  TRUE  TRUE FALSE  TRUE FALSE  TRUE
```

```r
which(m)
```

```
##  [1]  1  2  5  7  8 10 11 12 13 14 16 17 20 21 24 27 28 30
```

```r
which_matrix(m)
```

```
##    row col
## 1    1   1
## 2    2   1
## 3    5   1
## 4    2   2
## 5    3   2
## 6    5   2
## 7    1   3
## 8    2   3
## 9    3   3
## 10   4   3
## 11   1   4
## 12   2   4
## 13   5   4
## 14   1   5
## 15   4   5
## 16   2   6
## 17   3   6
## 18   5   6
```

## `trim()`

정규표현식를 이용하여 공백문자에 대한 trimming 을 제공합니다.  


```r
trim("  Wow!  ", "leading")
```

```
## [1] "Wow!  "
```

```r
trim("  Wow!  ", "trailing")
```

```
## [1] "  Wow!"
```

## `swap()`


```r
x <- 1
y <- 2
swap("x", "y")
cat(x, y)
```

```
## 2 1
```

# Install


```r
devtools::install_github("lovetoken/useful.lovetoken")
```

# License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
