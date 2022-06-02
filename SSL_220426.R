# 22.04.26
# .Platform : os정보 보여줌
.Platform
setwd("C:/Users/JSJ/Desktop/학교/4-1/SSL/Dataset")
dir()
getwd()
raw_dat <- read.csv("Ex_data.csv", header = T, stringsAsFactors = F)
nrow(raw_dat)
ncol(raw_dat)
gr_ind <- gl(2, 221); gr_ind # gl(그룹의 수, 그룹의 크기)
dat_mat <- t(as.matrix(raw_dat[,-1])); dat_mat
dim(dat_mat)
rownames(dat_mat) <- paste0("S", 1 :nrow(dat_mat))
colnames(dat_mat) <- raw_dat[,1]
head(dat_mat[,1:10])

# 표본을 삭제하는 것은 정보 손실을 야기
# 결측값을 다루는 다양한 통계적인 방법이 개발되어 있으나 본 강의에서는 자세히 다루지 않음
# • 예제: 결측값을 갖는 표본을 해당하는 열의 평균으로 대체
indx <- which(is.na(dat_mat), T); indx
nrow(indx)
col_ind <- indx[,2]; col_ind
col_m <- apply(dat_mat[,col_ind], 2, mean, na.rm = T); col_m # 중복된 col이 남아 있음
dat_mat[indx] <- col_m 
sum(is.na(dat_mat))
dim(dat_mat)

# 동일한 유전자에 대해 측정된 자료를 평균값으로 대체
# 1. 유일한 열의 이름 찾기 -> unique()를 사용해 중복된 열 제거
# 2. 결과 저장용 행렬 만들기
# 3. 행렬의 평균 계산

uq_names <- unique(colnames(dat_mat)); uq_names
p <- length(uq_names); p
n <- dim(dat_mat)[1]; n
expr_dat <- matrix(0, n, p); expr_dat
for(i in 1:p){
  expr_dat[,i] <- apply(as.matrix(dat_mat[,colnames(dat_mat)==uq_names[i]]), 1, mean)
  cat("|n", i, "-th step")
}
# 실행 시간계산
# toc <- Sys.time()
# as.numeric(toc, units = "secs")
colnames(expr_dat) <- uq_names
rownames(eapr_dat) <- rownames(dat_mat)
head(expr_dat[,1:20])
dim(expr_dat)
sum(is.na(expr_dat))

# 데이터의 통합
# merge(x, y, by, by.x, by.y, sort=TRUE) : 2개의 dataframe의 안에 있는 정보를 결합할 때 사용
# x : 데이터 결합의 기본 대상
# y : 결합하고자 하는 추가 데이터
# by : 결합 기준이 되는 열 (열이름, 숫자 가능)
# by.x, by.y : x와 y에서 열이름이 다르거나 위치가 다를 경우 적용
dat1 <- data.frame(id = 1:5, name = c("Kim", "Lee", "Jung", "Park", "Choi"),
                   dept = c(1, 3, 2, 2, 1)); dat1
dat2 <- data.frame(dept_id = c(1, 2, 3), 
                   dept_name = c("Computer Science", "Statistic","Economics")); dat2
merge(dat1, dat2, by.x="dept", by.y = "dept_id", sort = F)

# 탐색적 데이터 분석 (exploratory data analysis, EDA)
# • 데이터의 결측값, 특이값의 탐색 및 데이터의 구조, 특징 등을 조사하여
# 데이터의 변환이나 축소가 필요한지 등의 관측 데이터 자체를 탐색하는 분석 기법

# 탐색적 데이터 분석의 분류
# • 그래프를 이용한 탐색
#  다양한 그래프를 통하여 데이터의 요약 및 특징 정리
# • 통계표 및 통계량을 통한 탐색
#  평균, 분산, 분위수 등의 분포 파악을 위한 모수 추정값 요약

# 데이터(data)의 정의
# • 현상을 설명하기 위하여 수치적 특성 또는 사실적 특성을 나타낸
# 것으로 일반적으로 자료의 각 항목을 변수(variable)로 나타냄

