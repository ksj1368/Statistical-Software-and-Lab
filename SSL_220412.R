# 220412
setwd("D:/example")
dir()

# pipe(%>%)
# func1 %>% func2 : func1의 인수를 func2로 옮겨줌
data(mtcars)
library(dplyr)
dat2 <- mtcars %>%
    group_by(cyl) %>%
    select(mpg, wt, cyl) %>%
    summarize(m_mpg = mean(mpg)) %>%
    filter(m_mpg > 16); dat2
library(magrittr)  
1:10 %>% sum() # %>%는 dplyr 패키지에서 사용가능하지만 magritter를 설치하면 다른 곳에서 사용 가능

# is.na() : 결측값 확인, NA일 경우 TRUE, 아닐경우 FALSE 리턴
# sum() : 수치 연산이라 논리형을 수치형으로 변환(TRUE = 1, FALSE = 0)
# which() : TRUE인 인덱스 반환
x <- matrix(c(NA, 1, 3, NA, NA, 2), 3, 2); x
is.na(x)
sum(is.na(x))
which(is.na(x)) # 1차원 배열에서 NA 위치
which(is.na(x), arr.ind = T) # 2차원 배열에서 NA 위치
which(is.na(x), T)
x[which(is.na(x), T)]
which(x>1)
mean(x) 
mean(x, na.rm = T) # NA 제외 평균

cm <- apply(x, 2, mean, na.rm = T); cm
x[which(is.na(x), T)] <- cm[which(is.na(x), T)[,2]]; x # 결측치를 평균으로 변경, 메모리 측면에서 안좋음
# 2회 이상 사용하는 값은 변수로 저장하는게 메모리 측면에서 효율적
indx <- which(is.na(x), T); indx # 변수로 저장해서 사용하는게 좋음
x[indx] <- cm[indx[,2]]; x

# R condition statements
# 목요일 수업 내용까지 시험범위
# if()
if(pi>3) cat("\n expr(T)") else cat("\n expr(F)")
x <- 1:5; x
if(length(x) == 5) 
{
  if(sum(x) == 15){
    cat("\n length =", length(x),", sum = ", sum(x))
} 
  else
{
    cat("\n length 5! =", length(x))
  }
}

# ifelse(논리벡터, 참일 때 표현식, 거짓일 때 표현식)
x <- c(10, 3, 6, 9); x
y <- c(1, 5, 4, 12); y
ifelse(x>y, x, y)
score <- c(80, 75, 40, 98); score
grade <- ifelse(score >= 50, "pass", "fail"); grade
data.frame(score, grade)
y <- -2:2; y
ifelse(y >=0, y, -y) # = abs(y)

# switch(변수, 1에 해당 표현식, 2에 해당 표현식, ...)
x <- c(1, 3, 2, 5, 2); x
i <- 5; i
x <- switch(i, mean(x), median(x), sd(x), var(x)); x # 해당하는 값이 없으면 출력 안함 or NULL
is.null(x)
sd(x)
type <- "mean"; type
switch(type, mean= mean(x), sd = sd(x), var = var(x))
mean(x)

# for()
s <- 0; s
for(i in 1:100)
{
  s = s + i
}
s
