# load(D1)
imp1.graph<-D1 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DA1000", "DA2100", "DA3001", "DN3001", "DNNLA", "DNHW")

#load(D2)
imp2.graph<-D2 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DA1000", "DA2100", "DA3001", "DN3001", "DNNLA", "DNHW")

#load(D3)
imp3.graph<-D3 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DA1000", "DA2100", "DA3001", "DN3001", "DNNLA", "DNHW")

#load(D4)
imp4.graph<-D4 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DA1000", "DA2100", "DA3001", "DN3001", "DNNLA", "DNHW")

#load(D5)
imp5.graph<-D5 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DA1000", "DA2100", "DA3001", "DN3001", "DNNLA", "DNHW")

D.complete.graph <- rbind(imp1.graph, imp2.graph, imp3.graph, imp4.graph, imp5.graph) #combine multiple imputated datasets
write_xlsx(D.complete.graph,"G:\\Andere Computer\\Mein Laptop\\Dokumente\\Master VWL\\Thesis\\Data\\Graph_data\\merge_D_graph.xlsx")

#import dataset merge_D_graph 
merge_D_graph <- read_excel("G:/Andere Computer/Mein Laptop/Dokumente/Master VWL/Thesis/Data/Graph_data/merge_D_graph.xlsx")

D.complete.graph <- merge_D_graph

#load packages 
library(ggplot2)
library(tidyverse)
library(showtext)
library(ggthemes)
library(ggtext)

# create single frames
real_assets <- D.complete.graph %>% select("SA0010", "DA1000")
real_assets <- real_assets[order(real_assets$DA1000), ]
real_assets <- real_assets %>% mutate(decile = ntile(DA1000, 10))
real_assets_p <- real_assets %>% mutate(decile = ntile(DA1000, 100)) #ordered real assets / percentile 

fin_assets <- D.complete.graph %>% select("SA0010", "DA2100")
fin_assets <- fin_assets[order(fin_assets$DA2100), ]
fin_assets <- fin_assets %>% mutate(decile = ntile(DA2100, 10))
fin_assets_p <- fin_assets %>% mutate(decile = ntile(DA2100, 100)) #ordered financial assets / percentile 

tot_assets <- D.complete.graph %>% select("SA0010", "DA3001")
tot_assets <- tot_assets[order(tot_assets$DA3001), ]
tot_assets <- tot_assets %>% mutate(decile = ntile(DA3001, 10))
tot_assets_p <- tot_assets %>% mutate(decile = ntile(DA3001, 100)) #ordered total assets / percentile 

net_wealth <- D.complete.graph %>% select("SA0010", "DN3001")
net_wealth <- net_wealth[order(net_wealth$DN3001), ]
net_wealth <- net_wealth %>% mutate(decile = ntile(DN3001, 10))
net_wealth_p <- net_wealth %>% mutate(decile = ntile(DN3001, 100)) #ordered net wealth / percentile

net_real_as <- D.complete.graph %>% select("SA0010", "DNNLA")
net_real_as <- net_real_as[order(net_real_as$DNNLA), ]
net_real_as <- net_real_as %>% mutate(decile = ntile(DNNLA, 10))
net_real_as_p <- net_real_as %>% mutate(decile = ntile(DNNLA, 100))# ordered net liquid assets / percentile 

# maybe include net financial wealth 

net_fin_as <- D.complete.graph %>% select("SA0010", "DNHW")
net_fin_as <- net_fin_as[order(net_fin_as$DNHW), ]
net_fin_as <- net_fin_as %>% mutate(decile = ntile(DNHW, 10))
net_fin_as_p <- net_fin_as %>% mutate(decile = ntile(DNHW, 100)) # ordered net housing wealth / percentile 

# Plots
ggplot(real_assets_p, aes(x=decile, y=DA1000)) + geom_line(color= "red", size = 0.8) + geom_smooth(color="blue", linewidth =0.8) + labs(x = "Percentile", y = "EUR thousand", title = "Distribution of real assets", 
subtitle = "incl. business wealth, vehicles and valuables", caption = "Data: HFCS 2017") + theme(plot.title = element_text(face="bold", hjust=1, size = 10), plot.caption = element_text(hjust = 0)) + scale_x_continuous(breaks=seq(0, 100, 5)) + 
scale_y_continuous(breaks=seq(0, 4000000, 1000000), labels = function(x){paste0(x/1000)}) + coord_cartesian(ylim = c(0, 4000000)) + theme_minimal()

# total real assets
g_ra <- ggplot(real_assets_p, aes(x=decile, y=DA1000))
g_ra + geom_point(color = "#FF6666", size = .8) + labs(x = "Percentile", y = "EUR thousand") + theme(plot.subtitle = element_text(size = 10, face = "italic")) + theme(axis.title = element_text(size = 8)) + coord_cartesian(ylim = c(-10000,700000)) + scale_x_continuous(breaks = seq(5,100, 5)) + scale_y_continuous(breaks = seq(0, 700000, 100000), labels = function(x){paste0(x/1000)}) + labs(title = "Distribution of total real assets", subtitle = "incl. business wealth, vehicles and valuables", caption = "Data: HFCS 2017") + theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) + theme(panel.grid.minor = element_blank()) +  geom_hline(aes(yintercept = median(real_assets_p$DA1000, na.rm = TRUE)), linewidth = 1, color = "#9999FF") + geom_hline(aes(yintercept = mean(real_assets_p$DA1000, na.rm = TRUE)), linewidth = 1, color = "#00CC99") + annotate("text", x=80, y=80000, label="Median", size= 4, color = "#9999FF") + annotate("text", x=25, y=265000, label="Mean", size= 4, color = "#00CC99")

# total financial assets 
g_fa <- ggplot(fin_assets_p, aes(x=decile, y=DA2100))
g_fa + geom_point(color = "#FF6666", size = .7) + labs(x = "Percentile", y = "EUR thousand") + theme(plot.subtitle = element_text(size = 10, face = "italic")) + theme(axis.title = element_text(size = 8)) + coord_cartesian(ylim = c(0,250000)) + scale_x_continuous(breaks = seq(5,100, 5)) + scale_y_continuous(breaks = seq(0, 500000, 50000), labels = function(x){paste0(x/1000)}) + labs(title = "Distribution of total financial assets", subtitle = "excl. public & occupational pension plans", caption = "Data: HFCS 2017") + theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) + theme(panel.grid.minor = element_blank()) +  geom_hline(aes(yintercept = median(fin_assets_p$DA2100, na.rm = TRUE)), linewidth = 1, color = "#9999FF") + geom_hline(aes(yintercept = mean(fin_assets_p$DA2100, na.rm = TRUE)), linewidth = 1, color = "#00CC99") + annotate("text", x=80, y=25000, label="Median", size= 3.5, color = "#9999FF") + annotate("text", x=25, y=47000, label="Mean", size= 3.5, color = "#00CC99")

# total assets
g_ta <- ggplot(tot_assets_p, aes(x=decile, y=DA3001))
g_ta + geom_point(color = "#FF6666", size = .7) + labs(x = "Percentile", y = "EUR thousand") + theme(plot.subtitle = element_text(size = 10, face = "italic")) + theme(axis.title = element_text(size = 8)) + coord_cartesian(ylim = c(0,700000)) + scale_x_continuous(breaks = seq(5,100, 5)) + scale_y_continuous(breaks = seq(0, 700000, 100000), labels = function(x){paste0(x/1000)}) + labs(title = "Distribution of total assets", subtitle = "excl. public & occupational pension plans", caption = "Data: HFCS 2017") + theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) + theme(panel.grid.minor = element_blank()) +  geom_hline(aes(yintercept = median(tot_assets_p$DA3001, na.rm = TRUE)), linewidth = 1, color = "#9999FF") + geom_hline(aes(yintercept = mean(tot_assets_p$DA3001, na.rm = TRUE)), linewidth = 1, color = "#00CC99") + annotate("text", x=80, y=73000, label="Median", size= 3.5, color = "#9999FF") + annotate("text", x=25, y=260000, label="Mean", size= 3.5, color = "#00CC99")

# net wealth 
g_nw <- ggplot(net_wealth_p, aes(x=decile, y=DN3001))
g_nw + geom_point(color = "#FF6666", size = .7) + labs(x = "Percentile", y = "EUR thousand") + theme(plot.subtitle = element_text(size = 10, face = "italic")) + theme(axis.title = element_text(size = 8)) + coord_cartesian(ylim = c(-100000,1000000)) + scale_x_continuous(breaks = seq(5,100, 5)) + scale_y_continuous(breaks = seq(-200000, 1000000, 100000), labels = function(x){paste0(x/1000)}) + labs(title = "Distribution of net wealth", subtitle = "excl. public & occupational pension plans", caption = "Data: HFCS 2017") + theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) + theme(panel.grid.minor = element_blank()) +  geom_hline(aes(yintercept = median(net_wealth_p$DN3001, na.rm = TRUE)), linewidth = 1, color = "#9999FF") + geom_hline(aes(yintercept = mean(net_wealth_p$DN3001, na.rm = TRUE)), linewidth = 1, color = "#00CC99") + annotate("text", x=80, y=100000, label="Median", size= 3.5, color = "#9999FF") + annotate("text", x=25, y=260000, label="Mean", size= 3.5, color = "#00CC99")

# net liquid assets -> not sure if usable -> probably not 
g_nra <- ggplot(net_real_as_p, aes(x=decile, y=DNNLA))
g_nra + geom_point(color = "#FF6666", size = .7) + labs(x = "Percentile", y = "EUR thousand") + theme(plot.subtitle = element_text(size = 10, face = "italic")) + theme(axis.title = element_text(size = 8)) + coord_cartesian(ylim = c(-100000,1000000)) + scale_x_continuous(breaks = seq(5,100, 5)) + scale_y_continuous(breaks = seq(-200000, 1000000, 100000), labels = function(x){paste0(x/1000)}) + labs(title = "Distribution of net wealth", subtitle = "excl. public & occupational pension plans", caption = "Data: HFCS 2017") + theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) + theme(panel.grid.minor = element_blank()) +  geom_hline(aes(yintercept = median(net_wealth_p$DN3001, na.rm = TRUE)), linewidth = 1, color = "#9999FF") + geom_hline(aes(yintercept = mean(net_wealth_p$DN3001, na.rm = TRUE)), linewidth = 1, color = "#00CC99") + annotate("text", x=80, y=100000, label="Median", size= 3.5, color = "#9999FF") + annotate("text", x=25, y=260000, label="Mean", size= 3.5, color = "#00CC99")

# net housing wealth -> probably also not usable -> nope
g_nhw <- ggplot(net_fin_as_p, aes(x=decile, y=DNHW))
g_nhw + geom_point(color = "#FF6666", size = .7) + labs(x = "Percentile", y = "EUR thousand") + theme(plot.subtitle = element_text(size = 10, face = "italic")) + theme(axis.title = element_text(size = 8)) + coord_cartesian(ylim = c(-100000,800000)) + scale_x_continuous(breaks = seq(5,100, 5)) + scale_y_continuous(breaks = seq(-200000, 1000000, 100000), labels = function(x){paste0(x/1000)}) + labs(title = "Distribution of net housing wealth", caption = "Data: HFCS 2017") + theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) + theme(panel.grid.minor = element_blank()) +  geom_hline(aes(yintercept = median(net_fin_as_p$DNHW, na.rm = TRUE)), linewidth = 1, color = "#9999FF") + geom_hline(aes(yintercept = mean(net_fin_as_p$DNHW, na.rm = TRUE)), linewidth = 1, color = "#00CC99") + annotate("text", x=80, y=40000, label="Median", size= 3.5, color = "#9999FF") + annotate("text", x=25, y=150000, label="Mean", size= 3.5, color = "#00CC99")

