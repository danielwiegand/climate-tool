#' Line Chart: Emissions of continents
#' @details Prepares the line chart displaying the continents' emissions over time
#' @param data Data frame containing the emission data for continents. Needs to have the columns continent, emissions, data_id
#' @import dplyr, ggplot2, RColorBrewer
#' @export

prepareLineChartContinents <- function(data, theme) {

  linechart <- data %>%
    mutate(emissions = emissions / 1000000000) %>% # Convert to Gt
    ggplot() +
    # geom_point_interactive(size = 2, shape = 21, fill = "white", colour = "white",
    #                        aes(x = year, y = emissions, group = continent, data_id = data_id,
    #                            tooltip = paste0(continent, " ", year, ": ", round(emissions, 1), "Gt CO2"))) +
    geom_line_interactive(aes(x = year, y = emissions, group = continent, col = continent, data_id = data_id, tooltip = continent)) +
    scale_color_brewer(palette = "OrRd", name = "Continent") +
    scale_x_continuous(breaks = seq(1950, 2020, 5)) +
    scale_y_continuous(breaks = seq(0, 18, 2)) +
    theme_test() +
    theme +
    theme(
      axis.text.x = element_text(angle = 90),
      legend.background = element_rect(fill = "transparent", colour = NA), # get rid of legend bg
      legend.box.background = element_rect(fill = "transparent", colour = NA), # get rid of legend panel bg
      legend.text = element_text(colour = "white", size = 8),
      legend.key = element_blank(), # Removes frame around boxes
      legend.key.size = unit(.3, "cm"), # Box size
      axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
      axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))
    ) +
    labs(x = "Year", y = "Emissions per year (Gt)", title = "Continent emissions", subtitle = "Development of the continents' CO2 emissions over time")

  return(linechart)

}
