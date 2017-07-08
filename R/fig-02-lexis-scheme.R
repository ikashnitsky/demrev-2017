################################################################################
#
# demrev-2017. 2017-07-07
# Figure 2
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#
################################################################################


lines <- data.frame(
        x = c(rep(2, 5), 3:9),
        xend = c(3:9, rep(10, 5)),
        y = c(4:1, rep(0, 8)),
        yend = c(rep(5, 8), 4:1),
        label = 1981:1992
) %>%
        mutate(lab_x = (xend + x) / 2 - .25,
               lab_y = (yend + y) / 2 + .25)


gg2 <- ggplot() +
        expand_limits(
                xmin = 1,
                xmax = 10,
                ymin = 0,
                ymax = 6.5
        ) +
        coord_equal() +
        #theme_few()+
        theme_void() +
        
        # vertical and horizontal lines
        annotate(
                "segment",
                x = 1,
                xend = 10,
                y = 0:5,
                yend = 0:5,
                colour = "grey80",
                size = .2
        ) +
        annotate(
                "segment",
                x = 2:10,
                xend = 2:10,
                y = 0,
                yend = 6,
                colour = "grey80",
                size = .2
        ) +
        
        # lifelines
        geom_segment(
                data = lines,
                aes(
                        x = x,
                        xend = xend,
                        y = y,
                        yend = yend
                ),
                colour = "grey50",
                size = .5,
                linetype = 2
        ) +
        
        # rect
        annotate(
                "rect",
                xmin = 2,
                xmax = 10,
                ymin = 0,
                ymax = 5,
                fill = NA,
                color = "black"
        ) +
        
        # text
        annotate(
                "text",
                x = 0.5,
                y = 2.5,
                label = "Возраст",
                size = 7,
                angle = 90,
                family = myfont
        ) +
        annotate(
                "text",
                x = 6,
                y = 6.5,
                label = "Календарные годы",
                size = 7,
                family = myfont
        ) +
        
        # age and calendar years
        annotate(
                "text",
                x = 1.5,
                y = seq(.5, 4.5, 1),
                label = c(17:21),
                size = 6,
                family = myfont
        ) +
        annotate(
                "text",
                y = 5.5,
                x = seq(2.5, 9.5, 1),
                label = c(2003:2010),
                size = 6,
                family = myfont
        ) +
        
        # cohort labels
        geom_text(
                data = lines,
                aes(
                        x = lab_x,
                        y = lab_y,
                        label = label,
                        color = factor(label)
                ),
                size = 4.5,
                angle = 45,
                fontface = 3,
                family = myfont
        ) +
        scale_color_viridis(
                option = "B",
                begin = .2,
                end = .8,
                discrete = T,
                direction = -1
        ) +
        annotate(
                "text",
                x = 9.75,
                y = .25,
                label = "1993",
                size = 4.5,
                angle = 45,
                family = myfont,
                fontface = 3
        ) +
        theme(legend.position = "none")



ggsave("figures/fig-02.png", gg2, width = 10, height = 7)
