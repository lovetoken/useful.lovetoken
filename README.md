# useful.lovetoken package in R
`r Sys.Date()`  



For my self package

# Overview

제가 자주 사용하는 코드를 간편하게 사용하기 위한 개인적인 패키지 입니다.  

* `.rmd` 포맷을 랜더링 한 이후 그 결과를 바로 볼 수 있게 하는 `rendering()`
* 특정파일 혹은 폴더를 실행하는 `opendf()`
* Summary 결과를 데이터프레임 형식으로 반환하는 `desc()`

등의 함수를 주로 사용하고 있습니다.  
그외의 간편함수들도 있으며 아래 예제들을 통해 쓰임을 알 수 있습니다.  

# Example

## `window()`

경계문제로 인한 indexing 불가시 `window()` 를 이용하여 경계를 초과하는 부분을 절단합니다.


```r
window(2, c = 3, min = 1, max = 9)
```

```
## [1] 1 2 3 4 5
```

```r
# 1 2 3 4 5 6 7 8 9  
# |---c---|
# 1 2 3 4 5
```


```r
window(3, 8, 1, 9)
```

```
## [1] 5 6 7 8 9
```

```r
# 1 2 3 4 5 6 7 8 9  
#         |-----c-----|
#         5 6 7 8 9
```

## `desc()` function

Summary 결과를 데이터프레임 형식으로 반환합니다.  


```r
desc(mtcars)
```

```
##      vars  n   mean     sd median   min    max  range
## mpg     1 32  20.09   6.03  19.20 10.40  33.90  23.50
## cyl     2 32   6.19   1.79   6.00  4.00   8.00   4.00
## disp    3 32 230.72 123.94 196.30 71.10 472.00 400.90
## hp      4 32 146.69  68.56 123.00 52.00 335.00 283.00
## drat    5 32   3.60   0.53   3.70  2.76   4.93   2.17
## wt      6 32   3.22   0.98   3.33  1.51   5.42   3.91
## qsec    7 32  17.85   1.79  17.71 14.50  22.90   8.40
## vs      8 32   0.44   0.50   0.00  0.00   1.00   1.00
## am      9 32   0.41   0.50   0.00  0.00   1.00   1.00
## gear   10 32   3.69   0.74   4.00  3.00   5.00   2.00
## carb   11 32   2.81   1.62   2.00  1.00   8.00   7.00
```

## `psum()`

`pmax()`, `pmin()` 등의 함수와 비슷한 쓰임의 parallel 합계를 계산합니다.  


```r
pmin(1:5, 5:1, c(1, NA, 3, 4, 5))
```

```
## [1]  1 NA  3  2  1
```

```r
pmin(1:5, 5:1, c(1, NA, 3, 4, 5), na.rm = T)
```

```
## [1] 1 2 3 2 1
```

```r
psum(1:5, 5:1, c(1, NA, 3, 4, 5))
```

```
## [1]  7 NA  9 10 11
```

```r
psum(1:5, 5:1, c(1, NA, 3, 4, 5), na.rm = T)
```

```
## [1]  7  6  9 10 11
```

## `which_matrix()`


```r
(m <- matrix(sample(c(T,F), 25, T), 5, 5))
```

```
##       [,1]  [,2]  [,3]  [,4]  [,5]
## [1,]  TRUE FALSE  TRUE  TRUE FALSE
## [2,] FALSE FALSE FALSE FALSE FALSE
## [3,] FALSE  TRUE  TRUE FALSE FALSE
## [4,]  TRUE FALSE  TRUE FALSE FALSE
## [5,] FALSE FALSE FALSE FALSE  TRUE
```

```r
which(m)
```

```
## [1]  1  4  8 11 13 14 16 25
```

```r
which_matrix(m)
```

```
##   row col
## 1   1   1
## 2   4   1
## 3   3   2
## 4   1   3
## 5   3   3
## 6   4   3
## 7   1   4
## 8   5   5
```

## `NA_paste0()`

`NA`를 문자열로 인식하지 않고 공란으로 `paste0()` 을 수행합니다.


```r
NA_paste0(c(3,6,NA,NA), c(NA,6,9,NA))
```

```
## [1] "3"  "66" "9"  ""
```


```r
A <- "Hello "
B <- c("world", "world!", NA)
paste0(A, B)
```

```
## [1] "Hello world"  "Hello world!" "Hello NA"
```

```r
NA_paste0(A, B)
```

```
## [1] "Hello world"  "Hello world!" "Hello "
```

# Install


```r
devtools::install_github("lovetoken/useful.lovetoken")
```

# License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
