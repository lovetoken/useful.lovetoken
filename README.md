# `useful.lovetoken` package in R

R에서 제가 개인적 만든 사용자정의 함수를 모아놓은 패키지 입니다.      
제공되는 함수들의 간략 설명입니다.    

함수명칭            | 설명
--------------------|------------------------------------------------------------------
`bound_trim()`      | Bound trim the sequence vector
`librarys()`	      | 복수의 패키지들을 간편히 로드하며, 이전 패키지를 업데이트 합니다.
`NA_paste0()`       |	결측치 NA를 문자열로 paste 하지않고 무시하여 paste 합니다.
`recent_weekday()`  |	최근 평일기준 날짜열을 반환합니다.
`recent_weekend()`  |	최근 주말기준 날짜열을 반환합니다.
`window()`	        | Bandwidth indexing with Bound trim

## Install

R에서 아래의 코드를 실행함으로써 패키지를 설치할 수 있습니다.

```r
devtools::install_github("lovetoken/useful.lovetoken")
```

## Help

package 를 위의 코드를 통해 설치가 되었다면 제공되는 함수들의 도움말을 참고할 수 있습니다. 

```r
help(package="useful.lovetoken")
```

를 통해 확인 가능합니다. 
현 0.12 Version 기준 6개의 함수를 제공합니다. 
