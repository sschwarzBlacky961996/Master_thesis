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
#View(D.complete.graph)

D.compl.ord.graph.1 <- D.complete.graph[order(D.complete.graph$DA1000), ] #ordered real assets
#write_xlsx(D.compl.ord.graph.1,"G:\\Andere Computer\\Mein Laptop\\Dokumente\\Master VWL\\Thesis\\Data\\Graph_data\\real_assets.xlsx")

D.compl.ord.graph.2 <- D.complete.graph[order(D.complete.graph$DA2100), ] #ordered financial assets
#write_xlsx(D.compl.ord.graph.2,"G:\\Andere Computer\\Mein Laptop\\Dokumente\\Master VWL\\Thesis\\Data\\Graph_data\\financial_assets.xlsx")

D.compl.ord.graph.3 <- D.complete.graph[order(D.complete.graph$DA3001), ] #ordered total assets
#write_xlsx(D.compl.ord.graph.3,"G:\\Andere Computer\\Mein Laptop\\Dokumente\\Master VWL\\Thesis\\Data\\Graph_data\\total_assets.xlsx")

D.compl.ord.graph.4 <- D.complete.graph[order(D.complete.graph$DN3001), ] #ordered net wealth
#write_xlsx(D.compl.ord.graph.4,"G:\\Andere Computer\\Mein Laptop\\Dokumente\\Master VWL\\Thesis\\Data\\Graph_data\\net_wealth.xlsx")

D.compl.ord.graph.5 <- D.complete.graph[order(D.complete.graph$DNNLA), ] #ordered net real assets
#write_xlsx(D.compl.ord.graph.5,"G:\\Andere Computer\\Mein Laptop\\Dokumente\\Master VWL\\Thesis\\Data\\Graph_data\\net_real_assets.xlsx")

D.compl.ord.graph.6 <- D.complete.graph[order(D.complete.graph$DNHW), ] #ordered net financial assets
#write_xlsx(D.compl.ord.graph.6,"G:\\Andere Computer\\Mein Laptop\\Dokumente\\Master VWL\\Thesis\\Data\\Graph_data\\net_financial_assets.xlsx")
