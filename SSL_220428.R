# 22.04.28
setwd("C:\Users\JSJ\Desktop\학교\4-1\SSL\Dataset")
dir()
getwd()

# 단일 변수 데이터 탐색 : 막대그래프, 원 그래프, 히스토그램, 상자그림
# 두 변수의 데이터 탐색 : X-Y 평면의 선그림, 산점도
# 다중 변수의 데이터 탐색 : 산점도 행렬

# 막대그래프
# 이산형 변수의 모든 데이터 값에 대한 빈도수(frequency)를 동일한 폭의 막대 크기로 나타낸 그래프
# 이산형 변수의 분포 표현
# barplot() : 빈도표 
# plot(factor(), main = "그래프 제목", xlab = "xlabel", ylab = "ylabel", ylim = y축범위)
dat <- read.table("Ex211_tab.txt", header = T, sep = "\t"); head(dat)
dat[,6]
dat$Job
attach(dat) # dataframe에 있는 colname을 변수처럼 사용할수 있게 함
Job
x11() # = windows() : 새로운 창 출력 graphics.off() : 창 종료
plot(factor(Job), main = "직업의 막대그림", xlab = "직업", 
     ylab = "인원수(명)", ylim = c(0,15), col = c(1, "royalblue4", 4, "royalblue"))
grep("blue", colors(), value = T)
box() # plot에 네모 박스 추가
detach(dat) # attach를 종료
factor(Job)

freq = table(Job);  freq # dat[,6]
# png(file = 'bar.jpg')
pdf(file = 'bar2.pdf') 
for(i in 1:40){
barplot(freq, main = "직업의 막대그림", xlab = "Job", ylab = "인원수(명)",
        ylim = c(0,15), xlim = c(0, 5))
box()}
dev.off() # device창을 꺼야 파일로 저장됨

# gplots 패키지의 barplot2 
# 평균값에 대한 신뢰 구간을 그래프에 쉽게 표현 가능
# 열별로 행의 값을 막대그래프에 구분하여 표현
# 형식: barplot2( dataset, beside = T or F,legend = names, plot.ci = T or F, ci.l = lower bound, ci.u = upper.bound)
install.packages("gplots")
data(VADeaths); VADeaths
?VADeaths
seq(0, 1, length = 11)
gray(seq(0,1,length = 11))
x11()
barplot(rep(1, 11), col = gray(seq(0, 1, length = 11)))

library(gplots)
x11()
# 도시, 시골, 성별로 구분

barplot2(VADeaths, beside = TRUE, col = gray(seq(0.4, 0.9, length = 5)),
         legend = rownames(VADeaths), ylim = c(0,100))
title(main = "Death Rates in Virginia", font.main = 4)
box()
x11()
# 연령으로 구분
barplot2(t(VADeaths), beside = TRUE, col = gray(seq(0.4, 0.9, length = 5)),
         legend = colnames(VADeaths), ylim = c(0,100))
title(main = "Death Rates in Virginia", font.main = 4)
box()

hh <- t(VADeaths)[, 5:1]; hh
mybarcol <- "gray20"; mybarcol
# 신뢰구간 설정
cil <- hh* 0.85; cil
ciu <- hh *1.15; ciu
x11()
mp <- barplot2(hh, beside = TRUE, col = gray(seq(0.4, 0.9, length = 4)),
               legend = colnames(VADeaths), ylim = c(0, 100),
               main = "Death Rates in Virginia", font.main = 4,
               sub = "Faked 95 percent error bars", cex.names = 1.5,
               plot.ci = TRUE, ci.l = cil, ci.u = ciu, plot.grid = TRUE)
box()
# font.main : 글씨체
# cex.names : 글자 크기
# plot.ci : TRUE일 경우
# plot.grid : 배경 참조선

# 원 그래프(파이 차트)
# 하나의 원을 각 변수의 도수에 비례하게 조각으로 나누어 그린 그래프로 상대적인 크기를 비교하기에 용이한 그래프
# R에서의 사용 형식: 도수 또는 비율로 이루어진 벡터를 입력
# 점유율 표현할때 좋음
x11()
pie(freq, main = "직업의 원그림")
pie(rep(1, 24), col = rainbow(24), radius = 0.9)
pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
lbl = c("Blueberry", "Cherry", "Apple", "Boston Cream", "Other", "Vanilla Cream")
names(pie.sales) = paste0(lbl," (", pie.sales*100, "%)")
pie(pie.sales, col = rainbow(length(pie.sales)))
pie.sales
