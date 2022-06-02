# 22.05.10
# 분포의 이름과 아래의 키워드를 조합 -> 분포에 대한 함수 사용 가능
# 키워드 + R에서의분포 이름
# d : probability Density function
# q : Quantile function
# p : Cumulative distribution function
# r : generate random numbers from sucg distribution

# 균일 분포
a = 3
b = 5
dunif(4.25, min=a, max=b)
punif(3.5, a, b, lower.tail=F) # 1-F(x) 계산, F(x) = CDF
qunif(0.75, min=a, max=b, lower.tail = T) # 
x = runif(1000,a,b); head(x) # 
x11()
m = hist(x,breaks = 15, freq = F); m
lines(m$mids, m$density, col=2,lwd=3)# 선 추가
text(m$mids, m$density+0.05, as.character(m$counts)) # 텍스트 추가
points(m$mids, m$density, col='steelblue', pch=16, cex=2) # 포인트 추가
graphics.off()

# 초기하 분포
# X ~HG(N,M,n) -> in R : X ~ HG(m+n,m,k)
# E(X) = n*(N/M), VAR(X) = n*(N/M)*(N-M)/M

# 이항분포
n=10
pr = 0.5
dbinom(2,n,pr,log=F) # B(n, pr)
pbinom(5, n, pr, log = F)
qbinom(0.5, n, pr, log= F)
x = rbinom(10000, n, pr); head(x)
tb_x = table(x); tb_x
x11()
plot(tb_x)
graphics.off()

# 정규분포
 
# 카이제곱 분포
# ncp = 0 일때 일반적인 chisq

# t 분포
# ncp = 0 일때 일반적인 t분포

# QQPlot
dat = rnorm(200, mean=2, sd=2); dat
dat = rt(200, df=2); dat # 주석처리하면 정규분포, 포함할 경우 outlier발생
x11()
qqnorm(dat) # 산점도
qqline(dat,col=2, lwd=2)

# F-분포
# 두 정규모집단의 분산을 비교하거나 분산분석 등에 사용
# ncp -> 분자에만 영향을 줌
x=seq(0.01, 20, by = 0.01);x
y =df(x, df1=4, df2=5); y
x11()
plot(x,y,type='l') # l = lines
pf(0.5,df1=4,df2=5)
qf(c(0.95,0.975, 0.995),df1=4, df2=5)
1/qf(c(0.95,0.025, 0.005), df1=5, df2=4)
z = rf(1000, 4, 5);z
x11()
hist(z, breaks=15)
graphics.off()

# 중심극한 정리
df = 4
niter = 1000
xm = rep(0,niter); xm
for(i in 1:niter) {
  X <-rchisq(100, df=df)
  xm[i] = (mean(X)-df)/(sqrt(2*df)/sqrt(100))
}
x11()
hist(X, breaks = 20, main = expression(chi^2~(4)),
     col = 'lightblue')
x11()
hist(X, breaks = 20, main = expression(over(bar(X) -mu, sigma/sqrt(n))),
     col = 'gray', xlab='normalized saple mean')
demo(plotmath) # 왼쪽 : input to hist(expression()), 오른쪽 : output