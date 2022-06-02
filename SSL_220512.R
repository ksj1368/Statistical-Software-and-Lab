# 22.05.12
# 모평균 가설 검정
setwd("D:/Dataset")
getwd()
load(file ="/expr_dat.rdata")
head(expr_dat)
gr_ind = gl(2,221); gr_ind
uq_names = colnames(expr_dat);uq_names
# t.test
# h0 = mu < mu0
t1 = t.test(expr_dat[,1], mu = 6.5, conf.level = 0.95,
            alternative = "two.sided"); t1
t2 = t.test(expr_dat[,1], mu = 6.5, conf.level = 0.95,
            alternative = "less"); t2 # fail to reject h0
t3 = t.test(expr_dat[,1], mu = 6.9, conf.level = 0.95,
            alternative = "greater"); t3
names(t1) # t1에 들어있는 객체 반환 = attributes(t1)
t1$statistic
t1[[1]]
t1[[2]]
t1$p.value
t1$null.value
summary(t1)

# t.test(two sample, indep)
x = expr_dat[gr_ind==1,1];x
y= expr_dat[gr_ind == 2, 1]; y
# var.equal = T -> 검정통계량 계산해주지만 F로 해도 상관없음(default = F)
# t1 : alternative hypothesis: true difference in means is not equal to 0
t1 = t.test(x,y, mu = 0, conf.level = 0.95, paired = F,
            alternative = "two.sided"); t1 
# t2 : alternative hypothesis: true difference in means is less than 0
t2 = t.test(x,y, mu = 0, conf.level = 0.95, paired = F,
            alternative = "less"); t2
# t3 : alternative hypothesis: true difference in means is greater than 0
t3 = t.test(x,y, mu = 0, conf.level = 0.95, paired = F,
            alternative = "greater"); t3

# paired t-test
n=25
x = rnorm(n, mean=1, sd=1); x
y = x +rnorm(n, mean=0.5, sd=1); y # mean이 클수록 기각역 증가
# t1 : alternative hypothesis: true difference in means is not equal to 0
t1 = t.test(x,y,alternative = 'two.sided', paired=T, var.equal = F); t1
# t2 : alternative hypothesis: true difference in means is less than 0
t2 = t.test(x,y,alternative = 'less', paired = T, var.equal = F); t2
# t3 : alternative hypothesis: true difference in means is greater than 0
t3 = t.test(x,y,alternative = 'greater', paired = T, var.equal = F); t3


# mean이 클수록 기각역 증가

n_exp = 1000
rej = rep(0, n_exp); rej
for(i in 1:n_exp){
  # 평균 차이가 커질수록 검정역이 커진다.
    x = rnorm(n, mean=1, sd=1); x # x ~ N(1, 1^2)
    y = x +rnorm(n, mean=0.1, sd=1); y # y ~ N(1, sqrt(2)^2) 
    t1 = t.test(x,y,alternative = 'two.sided', paired=T, var.equal = F)
    rej[i] = t1$p.value < 0.05 # T일 경우 기각
} 
# 차이가 클수록 제대로 검출, 0.05비슷하게 나오면 type1 error 
mean(rej) # h1을 주장할 비율= power, power가 높을수록 검정을 잘함
sum(rej)


