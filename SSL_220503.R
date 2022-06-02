# 21.05.03
setwd('C:/Users/INHA/Desktop/Dataset')
getwd()
dir()

# histogram
# hist(vector, breaks = number of breaks(바의 개수))
# Sturges = log2(n) +1 
set.seed(7) # 난수 생성 초기값 지정, 난수 생성 수열
# rnorm(2)을 실행하면 동일한 난수 발생
hist.data <- rnorm(100, 3, 2);
hist_info = hist(hist.data, breaks = "Sturges", plot = F)
hist_info
nbins = length(hist_info$mids); nbins
col_vec = rep("white", nbins)
col_vec[hist_info$density>0.15] = "lightblue"
col_vec[hist_info$density<=0.15] = "red"
col_vec[7:10] = "blue"
x11()
hist(hist.data, breaks = "sturges", col=col_vec)
hist(hist.data, breaks = 20, col=col_vec)

# boxplot
# 히스토그램보다 변수가 많을 때 사용하면 좋음
# boxplot(vector/matrix/list, other options)

# alpha = 0.6 : 0.6만큼 채도 조정
load("C:/Users/INHA/Desktop/Dataset/expr_dat.Rdata")
mat = expr_dat[,c(3,4,7,8)]
x11()
boxplot(mat,col = rainbow(4,alpha = 0.1))
res = boxplot(mat,plot=F); res
res$out[res$group == 1]

x11()
# dot 표현 바꿀수 있음 (pch = 1:20)
plot(1:20, rep(5,20), type = "p", pch = 1:20, cex =1:5)

x11()
boxplot(mat,col = rainbow(4,alpha = 0.1), pch = 7)

# XY평면의 선그림
pop_dat = read.csv(file = "table_2_2.csv")
x11()
plot(pop_dat[,1], pop_dat[,2], type = "l", xlab = "연도", ylab = "인구수")
x11()
plot(pop_dat[,1], pop_dat[,2], type = "b", xlab = "연도", ylab = "인구수")
x11()
plot(pop_dat[,1], pop_dat[,2], type = "o", xlab = "연도", ylab = "인구수")
x11()
plot(pop_dat[,1], pop_dat[,2], type = "p", xlab = "연도", ylab = "인구수")

# multi figure
x11(); par(mfrow = c(2,2))  
plot(pop_dat[,1], pop_dat[,2], type = "l", xlab = "연도", ylab = "인구수")
plot(pop_dat[,1], pop_dat[,2], type = "b", xlab = "연도", ylab = "인구수")
plot(pop_dat[,1], pop_dat[,2], type = "o", xlab = "연도", ylab = "인구수")
plot(pop_dat[,1], pop_dat[,2], type = "p", xlab = "연도", ylab = "인구수")

# 연도 섞기
x11()
n = nrow(pop_dat)
indx = sample(1:n)
plot(pop_dat[indx,1], pop_dat[indx,2], type = "l", xlab = "연도", ylab = "인구수")

# scatter plot
# pair들의 순서는 상관없음
# 각자해보기

# scatter plot matrix
# 여러 변수에 대한 상관 관계를 한 눈에 파악하기 위하여 
# 각 변수 쌍에 대한 산점도를 행렬의 형태로 나타낸 그래프
# pairs(matrix or data.frame)
# pairs(formula type)
head(iris)
# 선형이어야 유효한 변수
pairs(iris[1:4], pch = 21, bg = c("red", "green", "blue")[as.numeric(iris$Species)])

# 최빈값
# 전체 주어진 관측치들 중에서 가장 빈도가 높은 값
# 명목척도로 측정된 자료에 대한 대표값으로 주로 사용됨
# R함수가 정의되어 있지 않음 (mode는 객체의 type 반환)
x = c(1,2,3,1,2,3,5,5,5,3,2)
tb_x = table(x); tb_x
which.max(tb_x)
as.numeric(names(tb_x)[which.max(tb_x)])
Mode = function(vec){
  tb = table(vec)
  return(as.numeric(names(tb)[which(tb == max(tb))]))
}
Mode(x)

