# 22.04.07

setwd("D:/example")
dir()

# save : 변수를 파일로 저장
dat <- data.frame(a=rnorm(10)); dat
dat2 <- data.frame(a = rnorm(10)); dat2
save(list = c("dat"), file = "ex_dat1.Rdata")
save.image(file = "ex_dat2.Rdata")
rm(list = ls())
load(file = "ex_dat1.Rdata"); ls()
load(file = "ex_dat2.Rdata"); ls()
getwd()

# dim : 크기 리턴
# lapply : 벡터 또는 리스트의 각 원소마다 지정한 함수를 적용하여 최종 결과를 리스트 형태로 반환
v <- c("a,b,c,d,e", "a,b", "d,e,f"); v
lapply(v, nchar) # 문자 개수 출력
sp <- strsplit(v,","); sp
lapply(sp,length) # sp의 리스트 별 길이 출력
lapply(sp, paste0, "a") # 원소에 "a"이어 붙임
v <- c("a,b,c,d,e", "a,b", "d,e,f"); v

# sapply : lapply의 반환값인 리스트를 벡터로 반환
sapply(v, nchar)
lapply(sp, "[[", 2) # 리스트 별 2번째 원소 반환 [=lapply(sp, function(x) x[2])]

# tapply : lapply를 테이블 형식으로 요약, 인덱스 별로 모아서 요약
n <- 10; n
fac <- factor(rep_len(1:3, n), levels = 1:5); fac # rep_len(1:3, n) : 길이가 n이 될때 까지
length(fac) 
x <- 1:n; x
table(fac) # 레벨에 해당되는 원소의 개수 반환 ( == table(rep_len(1:3, 10)))
cbind(x, fac)
tapply(1:n, fac, sum) #(== sum(x[fac==1]))

# dplyr
# filter() : 조건식에 맞는 데이터 추출
# select() : 선택한 변수 추출
# mutata() : 새로운 변수 정의, 추가
# arrange() : 변수에 따라 오름차순 정렬
# summarize() : 데이터 셋에 mean(), sd(), var() 등 함수를 지정하여 수행
# group_by() : 그룹별 집계를 위한 데이터 셋의 그룹화
# grup_by() 사용후 summarize()사용 -> 두개를 대부분 같이 사용
install.packages("dplyr")
library(dplyr); search()
ls(2)
?mtcars
filter(mtcars, cyl == 4, am == 1) # mtcars[mtcars$cyl == 4, mtcars$am == 1] -> 강의 영상버기
filter(mtcars, wt>2, cyl==8)
names(mtcars)
select(mtcars, mpg, cyl, wt) # = select(mtcars, 1, 2, 3)
select(mtcars, -hp, -gear)
mtf = select(mtcars, mpg, am, cyl, hp, wt); mtf
mutate(mtf, hw_rat=hp/wt)
mutate(mtf, hw_rat=hp/wt, cw_rat = cyl/wt)

arrange(mtf, mpg, desc(cyl)) # 정렬(첫 번째 변수를 기준으로 오름차순)
arrange(mtf, am, cyl, wt)
mt_gr <- group_by(mtcars, cyl); mt_gr
summarize(mt_gr, m_mpg = mean(mpg), m_wt = mean(wt))
