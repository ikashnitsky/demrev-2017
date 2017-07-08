################################################################################
#
# demrev-2017. 2017-07-07
# Figure 4. ECDF lines for all regions - ICMGR
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#
################################################################################


load("data/df-78-results.RData")


ggplot(df) +
        stat_ecdf(aes(icmgr0310), size = 1, color = brbg[2]) +
        stat_ecdf(aes(icmgr1113), size = 1, color = brbg[8]) +
        theme_minimal()


df_plot <- df %>% transmute(id_OKATO,
                            `2003-2010` = icmgr0310 %>% scale,
                            `2011-2013` = icmgr1113 %>% scale) %>%
        gather("period", "value", 2:3)


gg4a <- ggplot(df_plot) +
        stat_ecdf(aes(value, color = period), size = 1) +
        scale_color_manual("Период", values = brbg[c(2, 8)]) +
        xlab("Z-стандартизированное распределение (стандартные отклонения от среднего)") +
        ylab("Накопленная плотность распределения") +
        ggtitle("А. Эмпирические накопленные плотности распределения") +
        theme_minimal(base_family = myfont, base_size = 15) +
        theme(legend.position = c(.15, .85))


gg4b <- ggplot(df_plot) +
        stat_qq(aes(sample = value, color = period), size = 1) +
        scale_color_manual("Период", values = brbg[c(2, 8)]) +
        xlab("Теоретические квантили") +
        ylab("Наблюдаемые квантили") +
        ggtitle("Б. Диаграмма квантить-квантиль (QQ-plot)") +
        theme_minimal(base_family = myfont, base_size = 15) +
        theme(legend.position = c(.15, .85))


gg4 <- cowplot::plot_grid(gg4a, gg4b, align = "hv")

ggsave("figures/fig-04.png", gg4, width = 12, height = 6)

