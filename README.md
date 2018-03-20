useful.lovetoken
----------------

개인적으로 자주 활용하는 사용자 정의함수를 모아놓은 R 패키지 입니다.

    library(useful.lovetoken)

`paste2()`
----------

`paste0()` 과 다르게 NA 를 문자열로 인지하지 않고 paste 를 수행합니다.

    A <- "Hello "
    B <- c("world", "world!", NA)
    paste0(A, B)

    ## [1] "Hello world"  "Hello world!" "Hello NA"

    paste2(A, B)

    ## [1] "Hello world"  "Hello world!" "Hello "

`psum()`
--------

병렬합계의 함수입니다.

    sum(1:5, c(1, 2, 3, 4, NA), c(1, NA, 3, 4, 5), na.rm = T)

    ## [1] 38

    psum(1:5, c(1, 2, 3, 4, NA), c(1, NA, 3, 4, 5), na.rm = T)

    ## [1]  3  4  9 12 10

`which_._matrix()`
------------------

    (m <- matrix(sample(c(T,F), 30, T), 5, 6))

    ##       [,1]  [,2]  [,3]  [,4]  [,5]  [,6]
    ## [1,] FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [2,]  TRUE  TRUE  TRUE FALSE  TRUE FALSE
    ## [3,] FALSE FALSE  TRUE  TRUE FALSE FALSE
    ## [4,]  TRUE  TRUE  TRUE FALSE  TRUE FALSE
    ## [5,] FALSE  TRUE  TRUE  TRUE FALSE  TRUE

    which(m)

    ##  [1]  2  4  7  9 10 12 13 14 15 18 20 22 24 26 30

    which_matrix(m)

    ##    row col
    ## 1    2   1
    ## 2    4   1
    ## 3    2   2
    ## 4    4   2
    ## 5    5   2
    ## 6    2   3
    ## 7    3   3
    ## 8    4   3
    ## 9    5   3
    ## 10   3   4
    ## 11   5   4
    ## 12   2   5
    ## 13   4   5
    ## 14   1   6
    ## 15   5   6

Install
=======

    devtools::install_github("lovetoken/useful.lovetoken")

License
=======

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
