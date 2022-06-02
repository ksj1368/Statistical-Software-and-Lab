# 22.03.22
# (AB)^T = B^T*A^T
# AI = IA = A
# AB != BA -> 예외적으로 성립하는 경우도 있음
A <- matrix(1:12,4,3); A
A[1, 2]
A[2, 3]
A[1, ]
A[, 1]
A[c(1, 3),]
A[, 1:2]
A[, -3] # 3열 제외하고 선택
A[-3, ]
A[, -(1:2)]
dim(A) # 행렬인지 판단(NULL : 행렬이 아님)
C<- matrix(A[1,], 1, 3); C # 1, 3없으면 열벡터

A <- matrix(1:12, 4, 3); A
B <- matrix(1, 4, 3); B
A+B
A-B

# 행렬곱 : %*% -> 차원을 맞춰줘야 함
A<- matrix(1:6, 2, 3); A
B <- matrix(1, 3, 2); B
A%*%B
A[1,] * B[,1]   # 1 3 5
A[1,] %*% B[,1] # 9, 내적처럼 계산(1*1 + 3*1 + 5*1), 1 by 1 행렬로 리턴
matrix(A[1,], 3, 1)%*%matrix(B[, 1], 1, 3)
A[1,]%o%B[,1]

# solve() : 역행렬 계산
A <- matrix(1:4, 2, 2); A
solve(A)

# t() : 전치 행렬
A <- matrix(1:12, 4, 3); A
B <- matrix(1, 4, 3); B
t(A)
t(B)

# 대각합
A <- matrix(1:9, 3, 3); A
sum(diag(A))
diag(A) # 행렬의 대각성분 추출
diag(A) = rep(1, 3); A # A라는 행렬의 대각 성분을 1로 바꿈
diag(c(1, 3, -2))
diag(5) #5차 단위 행렬 생성

# 내적
x <- c(1, 2, 3); x
y <- c(1, 2, 3); y
sum(x*y) # (1*1) + (2*2) + (3*3) = 14

# det
A <- matrix(1:4, 2, 2); A
det(A)

# 고유값, 고유벡터
eigen(A) # eigen(A)$values, eigen(A)$vectors로 성분 추출 가능

