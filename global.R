library(ggplot2)
library(readr)


ind <- readr::read_csv("indicator_14-1-1.csv",
                       na = c("", " ", "NA", "N/A", "NULL"),
                       col_types = list(Year = "i", Value = "d"))

cat_cols <- names(ind[,-which(names(ind) %in% c("Year", "Value"))])


filter_dissagg <- function(ind, on) {
  
  # Don't look at year or value
  cats <- ind[,cat_cols]
  keep_mat <- t(is.na(cats))
  
  stopifnot(length(on) == length(cats))
  
  # If switch is on we keep all rows. If off we only keep NA
  keep <- apply(keep_mat | on, 2, all)
  
  ind[keep, ]
}


make_plot <- function(indp, group1, group2) {
  
  pntaes <- if(!is.null(group2)) aes_string(shape = group2) else NULL
  
  linaes <- if(!is.null(group1) && is.null(group2)) {
    aes_string(colour = group1) 
  } else if(is.null(group1) && !is.null(group2)) {
    aes_string(group = group2)
  } else if(!is.null(group1) && !is.null(group2)) {
    aes_string(colour = group1, linetype = group2)
  } else NULL
  

  ggplot2::ggplot(data = indp, mapping = aes(x = Year, y = Value)) +
    ggplot2::geom_line(mapping = linaes) #+
  #  ggplot2::geom_point(mapping = pntaes)
    
}
# 
# on <- rep(FALSE, length(cat_cols))
# names(on) <- cat_cols
# on[c("Category1", "Category2")] <- TRUE
# indf <- filter_dissagg(ind, on)
# indp <- plot_frame(indf)
# make_plot(indp, "Category1", "Category2")
