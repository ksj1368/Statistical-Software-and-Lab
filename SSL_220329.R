# 22.03.29
# 1차원 인덱스 사용 -> 해당 위치 알려줌
# as. -> 형변환이지만 as.matrix()는 열벡터로 형변환
# 데이터 프레임이 문자형 자료를 포함한 경우, 행렬 변환시 행렬의 원소는 모두 문자형 자료로 변환 (문자형 행렬로 변환)
# 데이터 프레임이 수치형, 논리형 자료만을 포함한 경우, 행렬 변환시 행렬의 원소는 모두 수치형 자료로 변환 (수치형 행렬)
x<- 1:100; x
sum1 <- sum(x[13:100]); sum1
x <- c(1:5, 10:20, 30:45, 2:5, 11:30); x
x>12
sum2 <- sum(x[x>12]); sum2
sum3 <- sum(x[x>10 & x<20]); sum3
A = matrix(1:10, 5, 2); A
A[1, 2] = NA
A[4, 1] = NA; A
is.na(A) # NA를 TRUE로 반환
mean(A)
A[is.na(A)] = 0; A
mean(A)
# apply(mat, 1(row) or 2(col), func_name)
# 반복문의 사용을 줄이고 프로그램의 효율을 높임(속도차이 별로 없음)
# 코드 단축(for vs apply)
# r(andom)norm : 난수 생성
x_mat <- matrix(rnorm(100),20,5); x_mat
# Calculate mean values of each columns
apply(x_mat,2,mean)   # col별로 평균 계산
apply(x_mat, 1, mean) # row별로 평균 계산
apply(x_mat, 2, var)
apply(x_mat, 1, var)
apply(x_mat, 2, quantile, c(0.5, 0.7))
x_q <- quantile(x_mat[,1], c(0.5, 0.7)); x_q
for(i in 2:ncol(x_mat)){
  x_q <- cbind(x_q, quantile(x_mat[,i], c(0.5, 0.7)))
}; x_q
## 함수 이름을 Console에 입력하면 함수 내부 볼수있음
rnorm(10)

# R input and output
# collapse : 문자열 벡터를 나눔
# paste(string1, string2, …., sep="", collapse = NULL) : 하나의 문자열로 반환(시험 잘나옴)
myname <- "Jang SeongJun"; myname
paste("My name is ", myname, sep="")
file_id <- 1553; file_id
paste("Dataset_", file_id, sep = "")
paste(LETTERS[1:5], 1:5)
paste("A", "B", collapse = '/') # 
paste(c("A", "B"), collapse = '/') # vec라서 sep이 작동안함
paste(c("A", "B"),1:2, collapse = '/')
paste(c("A", "B"),1:2, sep = "?", collapse = '/')
paste0(c("A", "B"), 1:2, collapse = '/')
paste0(LETTERS[1:5], letters[1:5])

# nchar : number of character
test <- c("asdfg", "AFFY1245820"); test
nchar(test)

# substr : sting의 일부분 추출 (파일에서 규칙을 추출 할때 사용, 패턴화)
f_name <- "AFFY1245820"; f_name
substr(f_name, 5, nchar(f_name))

f_name2 <- "AFFY1245820.txt"; f_name2
substr(f_name2, 5, nchar(f_name2)-4)

# strtrim : 문자열 자름
strtrim("ABCDEF", 3)
strtrim(rep("asffg", 3), c(1, 4, 10))

# strsplit : 문자열을 주어진 값으로 구분하여 자름
# 다음 시간에 한다고 함 + 시험 나옴
# 확장 정규 표현식 외우기

