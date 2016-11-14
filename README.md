# useful.lovetoken package in R
<a href = "https://lovetoken.github.io">lovetoken</a>  
`r Sys.Date()`  

<style type="text/css">@import url("https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/yeti/bootstrap.min.css")</style>



# Overview

For my self `useful.lovetoken` package

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

open working directory or file


```r
opendf() # 
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

# Install


```r
devtools::install_github("lovetoken/useful.lovetoken")
```

# License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
