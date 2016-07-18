# useful.lovetoken package in R

********

# Overview

R에서 제가 개인적으로 만든 편의함수를 모아놓은 패키지 입니다.  
제공되는 함수들의 리스트는 다음과 같습니다.  

함수명칭 | 설명
--------------------|-----------------
`bound_trim()`      | Bound trim the sequence vector
`NA_paste0()`       | 결측치 NA를 문자열로 paste 하지않고 무시하여 paste 합니다.
`recent_weekday()`  | 최근 평일기준 날짜열을 반환합니다.
`recent_weekend()`  | 최근 주말기준 날짜열을 반환합니다.
`window()`	        | Bandwidth indexing with Bound trim
`openfd()`			| Open the file or directory directly on R console
`rendering()`		| Open files after `rmarkdown::render()`
`desc()`		    | alias `psych::describe()`

# Install

R에서 아래의 코드를 실행함으로써 패키지를 설치할 수 있습니다.


```r
# install.packages("devtools")
devtools::install_github("lovetoken/useful.lovetoken")
```

# Example

## `window()` function


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
window(3, c = 8, min = 1, max = 9)
```

```
## [1] 5 6 7 8 9
```

```r
# 1 2 3 4 5 6 7 8 9  
#         |-----c-----|
#         5 6 7 8 9
```

## `openfd()` function

R console 에서 워킹디렉토리를 직접 실행하여 열 수 있습니다.  
혹은 특정파일을 여는것도 가능합니다.  


```r
opendf() # open working dir
```

## `desc()` function


```r
desc(mtcars)
```

```
## Loading required package: psych
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

```r
knitr::kable(desc(mtcars))
```

        vars    n         mean            sd    median      min       max     range
-----  -----  ---  -----------  ------------  --------  -------  --------  --------
mpg        1   32    20.090625     6.0269481    19.200   10.400    33.900    23.500
cyl        2   32     6.187500     1.7859216     6.000    4.000     8.000     4.000
disp       3   32   230.721875   123.9386938   196.300   71.100   472.000   400.900
hp         4   32   146.687500    68.5628685   123.000   52.000   335.000   283.000
drat       5   32     3.596563     0.5346787     3.695    2.760     4.930     2.170
wt         6   32     3.217250     0.9784574     3.325    1.513     5.424     3.911
qsec       7   32    17.848750     1.7869432    17.710   14.500    22.900     8.400
vs         8   32     0.437500     0.5040161     0.000    0.000     1.000     1.000
am         9   32     0.406250     0.4989909     0.000    0.000     1.000     1.000
gear      10   32     3.687500     0.7378041     4.000    3.000     5.000     2.000
carb      11   32     2.812500     1.6152000     2.000    1.000     8.000     7.000

********


