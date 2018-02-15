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
    ## [1,]  TRUE  TRUE FALSE FALSE FALSE FALSE
    ## [2,]  TRUE  TRUE FALSE  TRUE FALSE  TRUE
    ## [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE
    ## [4,] FALSE  TRUE  TRUE FALSE  TRUE  TRUE
    ## [5,]  TRUE FALSE  TRUE FALSE  TRUE FALSE

    which(m)

    ##  [1]  1  2  5  6  7  9 13 14 15 17 18 23 24 25 27 28 29

    which_matrix(m)

    ##    row col
    ## 1    1   1
    ## 2    2   1
    ## 3    5   1
    ## 4    1   2
    ## 5    2   2
    ## 6    4   2
    ## 7    3   3
    ## 8    4   3
    ## 9    5   3
    ## 10   2   4
    ## 11   3   4
    ## 12   3   5
    ## 13   4   5
    ## 14   5   5
    ## 15   2   6
    ## 16   3   6
    ## 17   4   6

`swap()`
--------

두 객체의 할당값을 바꿉니다.

    x <- 1
    y <- 2
    swap("x", "y")
    cat(x, y)

    ## 2 1

Install
=======

    devtools::install_github("lovetoken/useful.lovetoken")

License
=======

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
