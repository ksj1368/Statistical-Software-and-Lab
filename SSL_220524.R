# 22. 05. 24

rm(list=ls())
?barley
barley
library(lattice)
x11()
# quartz() # MAC OS용 x11()

# trellis display
# ggplot으로 대체
trellis.par.set(theme = col.whitebg())
# 데이터 : barley 사용, 년도 별로 그룹 나눔, col 2개, 축 별 이름 설정
dotplot(variety ~ yield | site, data = barley, groups = year, 
        key = simpleKey(levels(barley$year), space = "bottom", columns = 2),
        xlab = "Barley Yield (bushels/acre) ", ylab = "Variety",
        aspect=0.5, layout = c(2, 3),
        scales = list(alternating = FALSE,
                      y = list(abbreviate = TRUE, minlength = 5),
                      font = 4, col = "blue"),
        main = "dotplot(variety ~ yield | site, data = barley, groups = year)",
        sub = list("arguments = key, aspect, scales, etc", col = "gray")
)
# 1932년의 수율이 좋은 경향을 보이나 Morris에서만 반대 

# insight
attach(anscombe)
anscombe
cal_corr = c(cor(x1,y1),cor(x2,y2),cor(x3,y3),cor(x4,y4))
names(cal_corr) = paste(paste("x",1:4,sep=''),paste("y",1:4,sep=''),sep=' vs. ')
cal_corr

res = list()
res[[1]] = lm(y1~x1)
res[[2]] = lm(y2~x2)
res[[3]] = lm(y3~x3)
res[[4]] = lm(y4~x4)
summ = matrix(0,4,4)
cname = paste(paste("x",1:4,sep=''),paste("y",1:4,sep=''),sep=' vs. ')
colnames(summ) = cname
rownames(summ) = c("estimated beta0", "estmated beta1","estiamted error variance","R-squre")
for(i in 1:4)
{
  temp = summary(res[[i]])
  summ[1:2,i] = temp[[4]][1:2,1]
  summ[3,i] = temp[[6]]
  summ[4,i] = temp[[8]]
}
summ


x11()
par(mfcol=c(2,2))
for(i in 1:4)
{
  plot(anscombe[,i],anscombe[,i+4],pch=16,col=2,main=cname[i],
       xlab=paste("x",i,sep=''),
       ylab=paste("y",i,sep=''),
       xlim=c(4,20),ylim=c(3,13))
  abline(summ[1:2,i],col=4,lwd=2)
}
# x1,y1 : 그래프로 봤을때 회귀분석에 가장 적합한 분포 모델
# x3,y3 : outlier 발생
# x2,y2 : 곡선 형태
# x4,y4 : 직선이지만 outlier가 있고 값이 추가되면 선형성이 무너질 수 있음

x11() 
plot(1:5,rep(1,5),type='n',main='A',
     xlim=c(0,5),ylim=c(0,1))

x11()
plot(1,1,type='n',xlim=c(0,5),ylim=c(0,1),
     main='B')

col.table <- function(cols, main=NULL, fg=NULL) {
  n <- length(cols) # type(n) : NULL
  plot(seq(n), rep(1, n), xlim = c(0, n), ylim = c(0, 1),
       type = "n", xlab = "", ylab = "", axes = F)
  if(is.null(main))  # main이 NULL일 경우
  {  
    main=paste("Color Table by", deparse(substitute(cols)))
  }
  title(main=main)
  
  if(is.null(fg))
  {
    fg = unlist(lapply(cols,
                       function(x)
                         ifelse(mean(col2rgb(x)) > 127 | toupper(x) %in% 
                                  c("WHITE", "#FFFFFF"), "black", "white")))
  } else
    fg = rep(fg, n)
  
  for(i in 1:n)
  {
    polygon(c(i - 1, i - 1, i, i), c(0.05, 1, 1, 0.05), col = cols[i]) # 다각형
    text(mean(c(i - 1, i)), 0.52, labels = cols[i], srt=90, adj=0.5, col=fg[i], cex=1.2)
  }
}

x11()
par(mfrow=c(3,1))
#quartz()

col.table(1:16)
col.table(5:20)
col.table(c('black', 'red', 'green', 'blue'))


col_name = colors()[1:5]
col_name
x11()
col.table(col_name)

col_rgb = col2rgb(col_name) # 색상의 이름만으로 색을 알수 없을 때 사용용
colnames(col_rgb) = col_name
col_rgb
t = grep("red",colors(),value=T)
col.table(t)

cols <- colors()
length(cols)
cols[1:5]
grep("sky", cols, value=TRUE)
col2rgb(grep("sky", cols, value=TRUE))
x11()
par(mfrow=c(2, 1), mar=c(1, 1, 3, 1))
col.table(grep("sky", cols, value=TRUE))
col.table(grep("red", cols, value=TRUE))

x11()
par(mfrow=c(1,1))
col.table(grep("sea", cols, value=TRUE))


col.map <- function(cols=colors())
{
  n <- length(cols)
  cnt <- floor(sqrt(n))
  plot.new()
  plot.window(xlim=c(0, cnt), ylim=c(0, cnt))
  
  for (i in 1:cnt) for (j in 1:cnt) # 아래에서 위로 왼쪽에서 오른쪽으로 그림
    rect(i-1, j-1, i, j, col=cols[(i-1)*cnt +j], border=NA) # 사각형
}
x11()
col.map(colors())



seqs <- seq(0, 255, length = 15); seqs
as.character.hexmode(seqs) # as.character.hexmode() 16진수변환

hexs <- toupper(as.character.hexmode(seqs)); hexs # toupper 대문자로 변환
rev(hexs) # res() : reverse
red <- paste("#", hexs, "0000", sep = "")
green <- paste("#00", hexs, "00", sep = "")
blue <- paste("#0000", hexs, sep = "")
mix1 <- paste("#", hexs, hexs, hexs, sep = "")
mix2 <- paste("#", rev(hexs), hexs, rev(hexs), sep = "")
x11()
par(mfrow=c(5, 1), mar=c(1, 1, 3, 1))
col.table(red)
col.table(green)
col.table(blue)
col.table(mix1)
col.table(mix2)


x = c("#33221188","#13001588","#AA445588")
x11()
col.table(x)

r = seq(50,200,length=10)
g = 255
b = c(10,20)
hr = as.character.hexmode(r)
hr
toupper(hr)
x = paste0("#",toupper(hr),toupper(as.character.hexmode(g)),
           toupper(as.character.hexmode(b))[1],"1B")
x
x11()
col.table(x)



rainbow(20) # 무지개 색상

# heat.colors(): 따뜻한 색감의 색상 팔레트
# terrain.colors(): 지형을 나타내는 색감의 색상 팔레트
# topo.colors(): 지형을 나타내는 색감의 색상 팔레트
# cm.colors(): cyan에서 magenta로 진행되는 색상 팔레트
# gray(): 회색 계열로 구성된 색상 팔레트

x11()
par(mfrow = c(6, 1), mar = c(0, 0, 2, 0))
col.table(rainbow(20))
col.table(heat.colors(20))
col.table(terrain.colors(20))
col.table(topo.colors(20))
col.table(cm.colors(20))
col.table(gray(seq(0,255,length=20)/255))


par(mfrow = c(2, 2), mar = c(0, 0, 2, 0))
col.map(rainbow(400, start = 0, end = 0.8))
col.map(heat.colors(400))
col.map(cm.colors(400))
col.map(topo.colors(400))

x11()
seqs <- seq(0, 255, length = 20)
alpha <- toupper(as.character.hexmode(seqs))
par(mfrow = c(5, 1), mar = c(0, 0, 2, 0))
col.table(paste("#FF0000", alpha, sep = ""), fg = 1) # 마지막이 00 : 투명
col.table(paste("#00FF00", alpha, sep = ""), fg = 1) # 마지막이 FF : 불투명
col.table(paste("#0000FF", alpha, sep = ""), fg = 1)
col.table(rainbow(20), main = "Alpha Channel 사용안함")
col.table(rainbow(20, alpha = seq(0, 1, length = 20)),
          main = "Alpha Channel 사용", fg=1)


x <- c(1, 1.3, 1.6)
y <- c(1, 2, 1)
x11()
#quartz()
par(mar = c(4, 2, 3, 1), mfrow = c(1, 2))
plot(x, y, pch = 16, cex = 20, col = c("red", "green", "blue"),
     xlim = c(0,3), ylim = c(-2, 5))
title(main = "col=c('red','green','blue')")
plot(x, y, pch = 16, cex = 20, col = c("#FF000033", "#00FF0033", "#0000FF33"),
     xlim = c(0, 3), ylim = c(-2, 5))
title(main = "alpha channle by \"77\"")

x11()
# quartz()
par(mfrow=c(2,2))
par(mar=c(0.1,0.1,1,0.1))
hsv(0.5, 0.5, 0.5) # 채도, 색상, 명도를 사용해 색상을 지정
hsv1 <- c(hsv(0.5, 0.5, 0.5), hsv(0.6, 0.5, 0.5),
          hsv(0.7, 0.5, 0.5), hsv(0.8, 0.5, 0.5))
hsv2 <- c(hsv(0.5, 0.5, 0.5), hsv(0.5, 0.6, 0.5),
          hsv(0.5, 0.7, 0.5), hsv(0.5, 0.8, 0.5))
hsv3 <- c(hsv(0.5, 0.5, 0.5), hsv(0.5, 0.5, 0.6),
          hsv(0.5, 0.5, 0.7), hsv(0.5, 0.5, 0.8))
hsv4 <- c(hsv(0.5, 0.5, 0.5), hsv(0.6, 0.6, 0.6),
          hsv(0.7, 0.7, 0.7), hsv(0.8, 0.8, 0.8))
col.map(hsv1)
title("hsv1")
col.map(hsv2)
title("hsv2")
col.map(hsv3)
title("hsv3")
col.map(hsv4)
title("hsv4")
hsv1
hsv2
hsv3
hsv4


reds1 <- rgb((0:15)/15, g = 0, b = 0)
reds2 <- rgb((0:15)/15, g = 0, b = 0, alpha = 0.5)
gray1 <- gray(0:8/8)
gray2 <- gray(0:8/8, alpha = 0.5)
reds1
reds2
gray1
gray2

x11()
#quartz()
par(mfrow = c(2, 2), mar = c(1, 3, 1, 1))
col.map(reds1)
title("rgb((0:15)/15, g=0, b=0)")
col.map(reds2)
title("rgb((0:15)/15, g=0, b=0, alpha=0.5)")
col.map(gray1)
title("gray(0:8/8)")
col.map(gray2)
title("gray(0:8/8, alpha=0.5)")


rm(list=ls())
setwd("D:/example")
ls()

# png device

png(filename='d:/test.png')
a = 1:10
b = 2*a + rnorm(10)
plot(a,b)
dev.off()

# jpeg
x11()
plot(a,b)
dev.copy(jpeg,filename='d:/test2.jpg')
dev.off()
?jpeg
graphics.off()

# dev
x11()
plot(1:3)
x11()
plot(6:4)
dev.cur()
dev.prev()
dev.set(2)
dev.set(3)
dev.off(2)
dev.off(3)



