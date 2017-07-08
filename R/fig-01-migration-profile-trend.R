################################################################################
#
# demrev-2017. 2017-07-07
# Figure 1
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#
################################################################################


d1 <- read.csv("data/data-fig-01.csv")

d1 <- gather(d1, year, value, 2:12)

d1$age <- factor(as.numeric(paste(d1$age)))

mycol <- viridis(11)

gg1 <- ggplot(d1) +
        geom_line(aes(
                x = age,
                y = value,
                color = year,
                group = year
        ), lwd = 1) +
        scale_color_manual("", values = rev(mycol), 
                           labels = paste(2003:2013)) +
        ylab("Интенсивность притока, чел./тыс. жителей") +
        xlab("Возраст, лет") +
        scale_y_continuous(breaks = seq(0, 100, 20), 
                           labels = paste(seq(0, 100, 20))) +
        scale_x_discrete(breaks = seq(0, 80, 5)) +
        geom_point(
                data = filter(d1, year == "y2011"),
                aes(x = age, y = value),
                pch = 16,
                color = mycol[3],
                size = 3
        ) +
        geom_point(
                data = filter(d1, year == "y2012"),
                aes(x = age, y = value),
                pch = 17,
                color = mycol[2],
                size = 3
        ) +
        geom_point(
                data = filter(d1, year == "y2013"),
                aes(x = age, y = value),
                pch = 18,
                color = mycol[1],
                size = 3
        ) +
        theme_few(base_size = 20, base_family = myfont) +
        theme(legend.position = "none") +
        #create legend
        annotate(
                "segment",
                x = 70,
                xend = 74,
                y = seq(60, 110, length.out = 11),
                yend = seq(60, 110, length.out = 11),
                color = mycol,
                size = 1
        ) +
        annotate(
                "text",
                x = 75,
                y = seq(60, 110, length.out = 11),
                label = paste(2013:2003),
                hjust = 0,
                family = myfont,
                size = 5
        ) +
        annotate(
                "point",
                x = 72,
                y = c(60, 65, 70),
                pch = 18:16,
                color = mycol[1:3],
                size = 3
        )

ggsave("figures/fig-01.png", gg1, width = 10, height = 7)
