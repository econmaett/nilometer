# clean-data.R ----
## load packages ----
library(tidyverse)

## load data ----
# Source: https://www.itia.ntua.gr/en/docinfo/1351/
nilometer <- readxl::read_excel(path = "RodaNilometerData.xlsx", skip = 10) |> 
  select(2:6) |> 
  setNames(c("year", "min_level", "max_level", "min_depth", "max_depth"))

write_csv(x = nilometer, file = "nilometer.csv")

## plot ----
nilometer_caption <- "D. Koutsoyiannis, Hydrology and Change, Hydrological Sciences Journal, 58 (6), 1177–1197, doi:10.1080/02626667.2013.804626, 2013."

p <- ggplot(data = nilometer, mapping = aes(x = year, y = min_level)) +
  geom_smooth(method = "loess", formula = "y ~ x", se = TRUE, colour = "#00b4d8", fill = "#00b4d8", alpha = 0.1, span = 0.1) +
  geom_line(linewidth = 0.5, colour = "gray", alpha = 0.25) +
  geom_point(size = 0.75) +
  scale_x_continuous(breaks = seq(600, 1950, 50), limits = c(600, 1950)) +
  scale_y_continuous(breaks = seq(8, 16, 2), limits = c(8, 16)) +
  labs(
    title = "Annual minimum water levels of the river Nile, 622-1921",
    subtitle = "Measured at the Roda water gauge near Cairo, Egypt",
    x = NULL, y = NULL,
    caption = str_wrap(nilometer_caption)
  ) +
  theme_minimal(base_size = 8) +
  theme(panel.grid.minor = element_blank())

print(p)

ggsave(filename = "nilometer.png", path = ".", plot = p, width = 24, height = 10, units = "cm", bg = "white")

