################################################################################
#
# demrev-2017. 2017-07-07
# Figure 3. Map ICMGR
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#
################################################################################


# load data
load("data/geodata-78.RData")


# icmgr0310

tit1 <-
        "Рост численности\nнаселения\nв возрасте 17-21,\nданные текущего\nмиграционного учета,\n2003-2010,\nизменение в %"

map1 <- ggplot() +
        geom_polygon(data = fortify(Oneib),
                     aes(x = long, y = lat, group = group),
                     fill = "grey90") +
        geom_polygon(
                data = regdata,
                aes(
                        x = long,
                        y = lat,
                        group = group,
                        fill = icmgr0310
                ),
                color = "grey30",
                size = .2
        ) +
        scale_fill_gradient2(
                tit1,
                midpoint = 0,
                low = brbg[1:5],
                mid = brbg[6],
                high = brbg[7:11]
        ) +
        
        geom_point(
                data = cities,
                aes(x = coords.x1, y = coords.x2),
                size = 1.2,
                color = "grey50"
        ) +
        geom_text_repel(
                data = cities,
                aes(label = NameLabel, x = coords.x1, y = coords.x2),
                min.segment.length = unit(0.01, "lines"),
                arrow = arrow(type = "open", length = unit(0.2, "lines")),
                segment.color = "red",
                segment.size = .25,
                force = 7,
                # how long should the arrows be
                size = 3,
                fontface = "italic",
                color = "grey10",
                family = myfont2
        ) +
        
        geom_point(
                data = mosspb,
                aes(x = coords.x1, y = coords.x2),
                size = 4,
                color = "black",
                pch = 1
        ) +
        geom_text(
                data = mosspb,
                aes(label = Name_in_Ru, x = coords.x1, y = coords.x2),
                vjust = -1,
                hjust = 1,
                size = 4,
                fontface = "italic",
                color = "grey10",
                family = myfont2
        ) +
        
        geom_text(
                aes(
                        label = author,
                        x = -4.6e+06,
                        y = 5.1e+06
                ),
                color = "grey30",
                size = 4,
                hjust = 0,
                family = myfont
        ) +
        
        coord_equal(
                xlim = c(-4.7e+06, 3.5e+06),
                ylim = c(5e+06, .97e+07),
                expand = c(0, 0)
        ) +
        guides(fill = guide_colorbar(barwidth = 1.5, barheight = 20)) +
        theme_map(base_family = myfont, base_size = 15) +
        theme(legend.position = "right") +
        ggtitle("А. 2003-2010")




# icmgr1113

tit2 <-
        "Рост численности\nнаселения\nв возрасте 17-21,\nданные текущего\nмиграционного учета,\n2011-2013,\nизменение в %"

map2 <- ggplot() +
        geom_polygon(data = fortify(Oneib),
                     aes(x = long, y = lat, group = group),
                     fill = "grey90") +
        geom_polygon(
                data = regdata,
                aes(
                        x = long,
                        y = lat,
                        group = group,
                        fill = icmgr1113
                ),
                color = "grey30",
                size = .2
        ) +
        scale_fill_gradient2(
                tit2,
                midpoint = 0,
                low = brbg[1:5],
                mid = brbg[6],
                high = brbg[7:11]
        ) +
        
        geom_point(
                data = cities,
                aes(x = coords.x1, y = coords.x2),
                size = 1.2,
                color = "grey50"
        ) +
        geom_text_repel(
                data = cities,
                aes(label = NameLabel, x = coords.x1, y = coords.x2),
                min.segment.length = unit(0.01, "lines"),
                arrow = arrow(type = "open", length = unit(0.2, "lines")),
                segment.color = "red",
                segment.size = .25,
                force = 7,
                # how long should the arrows be
                size = 3,
                fontface = "italic",
                color = "grey10",
                family = myfont2
        ) +
        
        geom_point(
                data = mosspb,
                aes(x = coords.x1, y = coords.x2),
                size = 4,
                color = "black",
                pch = 1
        ) +
        geom_text(
                data = mosspb,
                aes(label = Name_in_Ru, x = coords.x1, y = coords.x2),
                vjust = -1,
                hjust = 1,
                size = 4,
                fontface = "italic",
                color = "grey10",
                family = myfont2
        ) +
        
        geom_text(
                aes(
                        label = author,
                        x = -4.6e+06,
                        y = 5.1e+06
                ),
                color = "grey30",
                size = 4,
                hjust = 0,
                family = myfont
        ) +
        
        coord_equal(
                xlim = c(-4.7e+06, 3.5e+06),
                ylim = c(5e+06, .97e+07),
                expand = c(0, 0)
        ) +
        guides(fill = guide_colorbar(barwidth = 1.5, barheight = 20)) +
        theme_map(base_family = myfont, base_size = 15) +
        theme(legend.position = "right") +
        ggtitle("Б. 2011-2013")



map <- cowplot::plot_grid(map1, map2, ncol = 1, align = "hv")

ggsave("figures/fig-03.png", map, width = 12, height = 12)

