#load(D1)
imp1<-D1 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DH0001", "DH0006", "DN3001", "DNHW", "DNNLA")

#load(D2)
imp2<-D2 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DH0001", "DH0006", "DN3001", "DNHW", "DNNLA")

#load(D3)
imp3<-D3 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DH0001", "DH0006", "DN3001", "DNHW", "DNNLA")

#load(D4)
imp4<-D4 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DH0001", "DH0006", "DN3001", "DNHW", "DNNLA")

#load(D5)
imp5<-D5 %>% filter( SA0100=="AT")%>%
  select("SA0010","SA0100", "DH0001", "DH0006", "DN3001", "DNHW", "DNNLA")

D.complete <- rbind(imp1, imp2, imp3, imp4, imp5) #combine multiple imputated datasets
#View(D.complete)

D.compl.order <- D.complete[order(D.complete$DN3001), ] #rearrange data frame in increasing order
#View(D.compl.order)

