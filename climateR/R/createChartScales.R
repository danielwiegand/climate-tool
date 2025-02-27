#' Create Chart scales
#' @details Creates numbers used for a color scale in charts. If the vector contains negative values, seven colors are used, center is zero. Otherwise, different colors and center is not zero.
#' @param data Atomic numeric vector
#' @import dplyr, ggplot2
#' @export

createChartScales <- function(data) {

  createScales <- function(input, props, neg) {

    if(neg == T) {
      scales::rescale(c(
        min(data, na.rm = T),
        quantile(input[input < 0], probs = props[1], na.rm = T),
        quantile(input[input < 0], probs = props[2], na.rm = T),
        0,
        quantile(input[input > 0], probs = props[3], na.rm = T),
        quantile(input[input > 0], probs = props[4], na.rm = T),
        max(input, na.rm = T)))
    } else {
      scales::rescale(c(
        min(input, na.rm = T) * 0.999, # Very small factor for cases where all probs are same (then ggplot scale_fill_gradientn does not work)
        quantile(input, probs = props[1], na.rm = T),
        quantile(input, probs = props[2], na.rm = T),
        quantile(input, probs = props[3], na.rm = T),
        quantile(input, probs = props[4], na.rm = T),
        quantile(input, probs = props[5], na.rm = T),
        max(input, na.rm = T) * 1.111)) # Very small factor for cases where all probs are same (then ggplot scale_fill_gradientn does not work)
    }

    # This still provoques the warning "Warning in regularize.values(x, y, ties, missing(ties)) collapsing to unique 'x' values", which is not critical however

  }


  if(sum(data < 0, na.rm = T) > 0) {
    scale_fill_gradientn(colours = c("slateblue4", "red", "orange", "white", "lightgreen", "chartreuse3", "darkgreen"),
                         values = createScales(data, props = c(.4, .9, .1, .2), neg = T),
                         na.value = "grey", name = "% budget left")

  } else {
    scale_fill_gradientn(colours = c("tan1", "khaki", "lightgreen", "green3", "forestgreen", "darkgreen"),
                         # values = c(100, 100, 100, 100, 100, 100, 100),
                         values = createScales(data, props = c(.1, .2, .4, .6, .9), neg = F),
                         na.value = "grey", name = "% budget left")
  }

}
