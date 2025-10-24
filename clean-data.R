## load packages ----
library(tidyverse)

## load data ----
# Source: https://www.itia.ntua.gr/en/docinfo/1351/
nilometer <- readxl::read_excel(path = "RodaNilometerData.xlsx", skip = 10) |> 
  select(2:6) |> 
  setNames(c("year", "min_level", "max_level", "min_depth", "max_depth"))

write_csv(x = nilometer, file = "nilometer.csv")

View(nilometer) 

## plot ----
nilometer_caption <- "D. Koutsoyiannis, Hydrology and Change, Hydrological Sciences Journal, 58 (6), 1177–1197, doi:10.1080/02626667.2013.804626, 2013."

p <- ggplot(data = nilometer, mapping = aes(x = year)) +
  geom_line(mapping = aes(y = min_level), linewidth = 0.25) +
  geom_point(mapping = aes(y = min_level), size = 0.25) +
  scale_x_continuous(breaks = seq(600, 1950, 150), limits = c(600, 1950)) +
  scale_y_continuous(breaks = seq(8, 16, 2), limits = c(8, 16)) +
  labs(
    title = "Annual minimum water levels of the river Nile, 622-1921",
    subtitle = "Measured at the Roda water gauge near Cairo, Egypt",
    x = NULL, y = NULL,
    caption = str_wrap(nilometer_caption)
  ) +
  theme_minimal(base_size = 8)

print(p)

ggsave(filename = "nilometer.png", path = ".", plot = p, width = 14, height = 8, units = "cm", bg = "white")

