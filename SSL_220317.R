## sort() : default : 오름차순, 
## sort(x, decreasing = T) : 내림차순 정렬
## order() : 정렬하기전 원래 위치 출력
x <- c(1, 5, 3, 2, 4); x
y <- c(-1, 2, 4, 3, 2); y
sort(x)
sort(x, T)
order(x)
sort(x, F)
y[order(x)]
x[order(x)] # sort()를 했을 때와 같아짐
## 함수에 들어가는 인수 : argument
## 허수부가 0이라는 것을 저장 해야함
## complex로 정의를 할 경우 허수부분에 0을 입력하면 에러
## 따라서 복소수를 표현하려면 0i를 사용해야함
## ?func_name : 함수에 대한 도움말 출력
## conj() : 복소수의 부호를 바꿈
## arg() :편각, 복소평면을 좌표평면으로 나타낼 경우 쎄타에 해당

## paste0() : 공백없이 문자 생성
complex(real = -17, imaginary = 0)
complex(3, 1) #length = 3, real = 1, imag = 0(default)
complex(3, 10, -2)
sqrt(-17)
sqer(-17+0i)
z <- 0 + 1i; z
Re(z)
Im(z)
Mod(z)
Conj(z)
z*Conj(z)
Arg(z) # == pi/2
pi/2
as.complex(paste0(3,"+", 2, "i"))
## a:b -> 시작 숫자 : 끝나는 숫자
## rep() : 같은 수 반복
## each :원소별로 반복
## times : 벡터 구간 반복
x <-1:10; x
y <- 3.3:8; y
rep(c(1,2), times = 3)
rep(c(1, 2), each = 3)
## seq(from, to, by, length(길이), along.with) 
## along.with = 특정 벡터의 길이 -> 길이와 일치시킴
## from : 시작 , to : 끝, by : 간격(default = 1)
## length가 없을 경우 seq가 끝나는 지점에서 끝남
seq(from = 1, to = 10)
seq(length = 10, from =-5, by = 3)
seq(length = 6, to = 10, by = 2)
########################################
## 벡터는 하나의 타입만 가능(중요함) -> 숫자, 문자, 논리
## 자동으로 형변환됨 -> 문자형이 있으면 문자형으로 변환
## 자동 형변환으로 인한 오류가 발생할 수도 있다.
## 벡터에 이름을 할당하면 문자로 인덱싱이 가능
## 비어있는 객체에 인덱스 추가 가능
## 비어있는 인덱스(결측값)는 "NA"로 처리(default)
vec <- vector(); vec
vec <- 1:10; vec
vec2 <- c("abc", "def"); vec2
vec3 <- c(T, F, F, T); vec3
vec98 <- c(1, "def"); vec98
vec99 <- c("acv", 1); vec99
names(vec2) <- c("first", "second"); vec2
vec4 <- vector(); vec4
vec4[1] <- 1; vec4
vec4[2] < 5; vec4
## matrix(value, nrow(행), byrow(열))
## 세로를 우선으로 채움(default)
## byrow = T -> 열을 우선으로 채움
## cbind -> 행 기준으로 열 추가
## rbind -> 열 기준으로 행 추가
x1 <- matrix(1:10, nrow = 5, ncol = 2, byrow = T); x1
x2 <- matrix(1:10, 5, 2, byrow = F); x2
# 행렬의 크기가 작을 경우
x3 <- matrix(1:10, 3, 2, byrow = F); x3
# 행렬의 크기가 클 경우
x4 <- matrix(1:10, 6, 2, byrow = F); x4
cbind(x1, x2)
rbind(x1, x2)

## 행렬에 이름부여 -> 실무에서 많이 쓰임
## 데이터 누락을 파악할 때 이름으로 검색 가능
A <- matrix(1:12, 4, 3); A
rownames(A) <- c(paste0("n", 1:4)); A
colnames(A) <- c(paste0("x", 1:3)); A

## 위의 방식보다는 아래의 방식을 선호
rname <- c(paste0("n", 1:4)); rname
cname <- c(paste0("x", 1:3)); cname
B <- matrix(1:12, 4, 3, dimnames = list(rname, cname)); B
A[1,2] <- "3"; A # 인덱스들이 문자형으로 형변환
as.numeric(A) # 벡터로 변경됨(행렬을 유지해주지 않음)
# 행렬로 변경되며 숫자형으로 형변환도 가능
matrix(as.numeric(A), nrow(A), ncol(A)) 
