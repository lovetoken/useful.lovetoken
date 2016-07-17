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
`rendering()`		| Open files after rmarkdown::render()

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

********


