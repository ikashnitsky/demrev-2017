################################################################################
#
# demrev-2017. 2017-07-07
# Figure 5. rank plot - lines
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#
################################################################################



load("df-78-results.RData")

df <- df %>%
        mutate(rank0310 = row_number(icmgr0310),
               rank1113 = row_number(icmgr1113))



gg5a <- ggplot(df) +
        expand_limits(
                xmin = 0,
                xmax = 6,
                ymin = -6,
                ymax = 81
        ) +
        coord_cartesian(expand = c(0, 0)) +
        geom_segment(
                aes(y = rank0310, yend = rank1113, color = fed_dist),
                x = 2,
                xend = 4,
                size = 1,
                alpha = .5
        ) +
        geom_point(aes(y = rank0310, color = fed_dist), x = 2) +
        geom_point(aes(y = rank1113, color = fed_dist), x = 4) +
        geom_text(
                aes(
                        x = 1.8,
                        y = rank0310,
                        label = region,
                        color = fed_dist
                ),
                size = 5,
                hjust = 1,
                family = myfont
        ) +
        geom_text(
                aes(
                        x = 4.2,
                        y = rank1113,
                        label = region,
                        color = fed_dist
                ),
                size = 5,
                hjust = 0,
                family = myfont
        ) +
        scale_color_colorblind("Федеральный\nокруг") +
        scale_y_continuous(breaks = c(1, seq(10, 70, 10), 78), labels = rev(c(1, seq(10, 70, 10), 78))) +
        xlab(NULL) +
        ylab("Место в рейтинге миграционной привлекательности (порядковый номер)") +
        theme_minimal(base_family = myfont, base_size = 20) +
        theme(
                legend.position = c(0.4, 0),
                legend.justification = c(0, 0),
                legend.direction = "horizontal",
                axis.text.x = element_blank(),
                axis.title.x = element_blank(),
                axis.ticks.x = element_blank(),
                panel.grid.major.x = element_blank(),
                panel.grid.minor.x = element_blank()
        ) +
        annotate(
                "text",
                x = 2,
                y = 79.5,
                family = myfont,
                size = 7,
                label = "2003-2010",
                hjust = 1,
                vjust = 0
        ) +
        annotate(
                "text",
                x = 4,
                y = 79.5,
                family = myfont,
                size = 7,
                label = "2011-2013",
                hjust = 0,
                vjust = 0
        )


gg5b <- ggplot(df) +
        expand_limits(xmin = 0, xmax = 5) +
        coord_cartesian(expand = c(0, 0)) +
        geom_segment(
                aes(
                        y = scale(icmgr0310),
                        yend = scale(icmgr1113),
                        color = fed_dist
                ),
                x = 1,
                xend = 4,
                size = 1,
                alpha = .5
        ) +
        geom_point(aes(y = scale(icmgr0310), color = fed_dist), x = 1) +
        geom_point(aes(y = scale(icmgr1113), color = fed_dist), x = 4) +
        scale_color_colorblind() +
        scale_y_continuous(
                "Z-стандартизированное распределение (стандартные отклонения от среднего)",
                position = "right",
                limits = c(-4.8, 4.3),
                breaks = seq(-4, 3, 1),
                labels = seq(-4, 3, 1)
        ) +
        theme_minimal(base_family = myfont, base_size = 20) +
        theme(
                legend.position = "none",
                axis.text.x = element_blank(),
                axis.title.x = element_blank(),
                axis.ticks.x = element_blank(),
                panel.grid.major.x = element_blank(),
                panel.grid.minor.x = element_blank()
        ) +
        annotate(
                "text",
                x = 1,
                y = 4.25,
                family = myfont,
                size = 7,
                label = "2003-\n-2010",
                hjust = .5,
                vjust = 1
        ) +
        annotate(
                "text",
                x = 4,
                y = 4.25,
                family = myfont,
                size = 7,
                label = "2011-\n-2013",
                hjust = .5,
                vjust = 1
        )



gg5 <- cowplot::plot_grid(gg5a, gg5b, align = "hv", rel_widths = c(.7, .3))

ggsave("figures/fig-05.png", gg5, width = 10.5, height = 14)





# average change by federal districts
library("scales")
library(broom)

df %>% group_by(fed_dist) %>% summarise(
        mean_rank_0310 = mean(rank0310),
        mean_rank_1113 = mean(rank1113),
        mean_icmgr_0310 = median(icmgr0310 %>% rescale()) ,
        mean_icmgr_1113 = median(icmgr1113 %>% rescale)
) %>%
        View()


# changes in the standard deviations

sd(df$icmgr0310)
sd(df$icmgr1113)

sd(df$icmgr1113) / sd(df$icmgr0310)


# regression models

df_lm <- df %>% transmute(id_OKATO,
                          fed_dist,
                          `2003-2010` = icmgr0310,
                          `2011-2013` = icmgr1113) %>%
        gather("period", "value", 3:4) %>%
        #mutate(value = value %>% rescale) %>%
        mutate(fed_dist = fed_dist %>% factor %>%  relevel("ЦФО"))

broom::tidy(glm(data = df_lm, family = poisson, value ~ period + fed_dist)) %>% View

lm(data = df_lm, value ~ period + fed_dist) %>% tidy %>% View
lm(data = df_lm, value ~ period + fed_dist) %>% glance
