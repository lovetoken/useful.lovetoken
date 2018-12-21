#' Absolutly fuzzy left join
#' @description 정확히 매칭되는 Key value 를 찾아서 병합하는 것이 아닌 유사도를 통한 매칭 병합을 수행합니다. 단 Key value 의 타입이 numeric 형일 때 Key variable 간 유사도를 정확히 계산하여 매칭하며, 최근접매칭값이 복수개일 때는 가장 맨 처음으로 찾은 최근접 record 를 바인딩 합니다. Key variable 은 하나이어야 하며 복수개의 Key를 지원하지 않습니다. left table 과 맵핑을 시킬 right table 의 공통 Key variable 의 변수명은 "key" 임을 약속합니다.
#' @seealso \code{fuzzyjoin::difference_join()}, \code{fuzzyjoin::fuzzy_join()}
#' @export
#' @examples
#' left <- data.frame(key = c(20171001, 20171021, 20172001, 20172002, 20161001))
#' right <- data.frame(key = c(20171002, 20171020, 20172000), value1 = c("A", "B", "C"))
#' fuzzy_join2(left, right)

fuzzy_join2 <- function(x, y){

  fullfuzzy <- fuzzyjoin::difference_join(x, y, by = "key", max_dist = Inf, distance_col = "dist") %>%
    dplyr::select(-key.y) %>% dplyr::rename(key = key.x)
  uniquefuzzy <- dplyr::group_by(fullfuzzy, key) %>% dplyr::filter(dist == min(dist)) %>% dplyr::select(-dist)
  return(uniquefuzzy)

}
