# 22.05.17
# 회귀분석

# lm() : linear model
# 단순회귀, 중회귀 모형 등 일반적인 회귀모형 적합 시 사용
# lm(formula, options)
# 적용하고자 하는 모형에 맞게 옵션 조정
# 가중회귀 모형: weights 옵션 조정
# 기본적인 회귀모형(단순회귀, 중회귀)의 경우 옵션들을 크게 조정하지 않아도 된다.

rm(list = ls())
getwd()
setwd("D:/Dataset")
getwd()
load(file = "expr_dat.Rdata")
uq_names = colnames(expr_dat); uq_names
##  1을 제외한 후 coef가 가장 큰 값
cmat = cor(expr_dat)
diag(cmat) = 0
max(abs(cmat[upper.tri(cmat)]))
## ## ## ## 제외한 그래프가 선형에 가까움
indy = 262 #8
indx = 263  #200
x = expr_dat[,indx]; x
y = expr_dat[,indy]; y
fit = lm(y~x); fit
summary(fit) # 통계량 출력
x11()
plot(x,y,pch =16)
abline(fit, col=2, lwd=3)

# summary()추출
names(fit)
fit$coefficients
coef(fit)

sfit = summary(fit)
sfit[[4]] # intercept
sfit$r.squared

# predict() : 새로운 값 추정
pred1 = predict(fit, newdata = data.frame(x=2.3)); pred1
# or fit$coefficients (coef(fit)) 이용 계산
est = coef(fit); est
x1 = 2.3
y1 = est[1] +est[2] *x1; y1
pred2 = predict(fit, newdata = data.frame(x=c(1,2.2,6.7))); pred2
x2 = c(1, 2.2, 6.7)
y = est[1] +est[2]*x2; y

# 회귀 모형 비교 -> anova() 사용해 전체 모형 중 축소 모형에서 제외 된 변수들의
# 회귀 계수가 모두 0인지에 대한 가설 검정 수행
indy = 8
indx = c(10, 30, 200)
indxr = c(10, 200) # reduced
xf = expr_dat[, indx]; xf
xr = expr_dat[,indxr]; xr
y = expr_dat[,indy]; y
fit1 = lm(y~xf); fit1
fit2 = lm(y~xr); fit2
anova(fit2, fit1) # fail to reject H0, 30을 제외하고 모델을 생성하는 것이 좋다.

ftxt = paste0(uq_names[indy], '~', paste0(uq_names[indx], collapse = "+")); ftxt
ftxtr = paste0(uq_names[indy], '~', paste0(uq_names[indxr], collapse = "+")); ftxtr

colnames(expr_dat) = gsub("[ .]", "", uq_names) # 공백 또는 .이 들어갈 경우 제거
lm_dat = data.frame(expr_dat); lm_dat
fit1 = lm(as.formula(ftxt), data = lm_dat); fit1
fit2 = lm(as.formula(ftxtr), data = lm_dat); fit2
anova(fit2, fit1)

# 모형 진단
# model diagnostics
rsd = resid(fit2); rsd
ft = fitted(fit2); ft
x11()
plot(ft, rsd, type = 'p', pch = 16) # 
hist(rsd, breaks = 20) # 그래프가 정규 분포 형태를 따른다

x11()
qqnorm(rsd)
qqline(rsd, col=2, lwd = 2) # 꼬리부분을 제외하면 정규성을 만족한다고 볼수 있다.
graphics.off()
