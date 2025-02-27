#' Bar Chart: Emissions of continents
#' @details Prepares the bar chart displaying the continents' emissions over time
#' @param data Data frame containing the emission data for continents. Needs to have the columns continent, emissions, data_id
#' @import dplyr, ggplot2
#' @export

prepareBarChartContinents <- function(data, theme) {

  barchart <- data %>%
    mutate(continent = reorder(continent, emissions, sum), # Order according to the sum over all historical emissions
           emissions = emissions / 1000000000) %>% # Convert to gt
    ggplot() +
    geom_bar_interactive(aes(x = year, y = emissions, fill = continent, data_id = data_id,
                             tooltip = paste0(continent, " ", year, ": ", round(emissions, 1), "Gt CO2")), stat = "identity") +
    scale_fill_brewer(palette = "OrRd", name = "Continent") +
    scale_x_continuous(breaks = seq(1950, 2020, 5)) +
    theme_test() +
    theme +
    theme(
      axis.text.x = element_text(angle = 90),
      legend.background = element_rect(fill = "transparent", colour = NA), # get rid of legend bg
      legend.box.background = element_rect(fill = "transparent", colour = NA), # get rid of legend panel bg
      legend.text = element_text(colour = "white", size = 8),
      legend.key = element_blank(), # Removes frame around boxes
      legend.key.size = unit(.3, "cm") # Box size
    ) +
    labs(x = "Year", y = "Emissions (Gt carbon dioxide)", title = "Global emissions", subtitle = "Development of the world's CO2 emissions over time")
  return(barchart)

}
