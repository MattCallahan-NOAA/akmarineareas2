#' remove_dateline
#' @description This function removes the annoying dateline artifact from sf objects that cross the dateline
#' Code: x%>%st_buffer(1) %>%st_transform(st_crs(3338)) %>%st_simplify
#' @param x The object from which the dateline should be removed
#'
#' @return
#' @export
#'
#' @examples x<-remove_dateline(x)
remove_dateline<-function(x){
   myproj <- sf::st_crs(x)
   sf::sf_use_s2(FALSE)
  x%>%
    sf::st_transform(sf::st_crs(3338)) %>% #convert to Alaska Albers projection
    #sf::st_buffer(1) %>%
    sf::st_simplify()%>%
    sf::st_transform(sf::st_crs(myproj)) #convert back to original projection
}
