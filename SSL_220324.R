#22.03.24
# 이름 생략하면 번호로 이름 부여
# []와 [[]]의 차이
lst1 <- list(a = 1:10, b = matrix(1:4, 2, 2)); lst1
lst2 <- list(); lst2
lst2[[1]] <- matrix(1:10, 5, 2); lst2
lst2[[2]] <- lst1; lst2
lst1[2]   # $b -> list
lst1[[2]] # matrix
lst1$a
lst1$b
lst1[1]
lst1[[1]]
lst2[[1]]
lst2[[1]][3] 
lst2[[2]][[1]]

# lst1[1:2], lst[[1:2]]의 차이 
lst1[1:2]   # lst1의 a, b를 list로 출력
lst1[[1:2]] # lst1[[1]][[2]]와 동일, 
lst1[[1]][[2]]

# Error : recursive indexing failed at level 2
lst1[[c(1, 2, 4)]] # lst1[[1]][[2]][[4]]와 동일(범위를 벗어남)
lst1[[1]][[2]][[4]] # a의 2번째 원소는 1개이기 때문에 오류 발생
lst1[[1]][[2]][4] # NA

# factor -> 기말
# 숫자형으로 처리하지만 문자형으로 표현
# 따옴표가 없음 : factor 타입 / level이 없으면 알파벳 순서대로 레벨 표현
# levels = 문자형 벡터로 생성할 때 level 및 순서 명시
# order = T: 순서형, order=F: 명목형(default : )
grade <- c("A", "A", "B", "C", "B", "B"); grade
f2_grade <- factor(grade, order = T); f2_grade
f_grade <- factor(grade); f_grade
as.numeric(grade) # Error : 강제형변환에 의해 생성된 NA 입니다
as.numeric(f_grade)

lev <- c("C", "B", "A"); lev
f3_grade <- factor(grade, levels = lev, order = T); f3_grade
levels(f2_grade)
levels(f3_grade) # 순서에 대한 정보x

grade2 <- c("1.23", "4", "5", "A", "3.23", "2.2"); grade2
f_grade2 <- factor(grade2); f_grade2
as.numeric(grade2) # 정수형으로 형 변환
as.numeric(f_grade2) # A가 6으로 숫자형으로 변환
mean(as.numeric(f_grade2)) 

# dataframe : 다른 유형의 자료형으로 구성 가능(행렬 + list 형태)
# 변수별로 정의할 때 행의 길이가 같아야 함
# default : 열 우선 할당
x1 <- 1:4; x1
x2 <- c("Kim",  "Lee", "Jung", "Park"); x2
dat <- data.frame(x1, x2); dat
dat2 <- data.frame(num = x1, name = x2); dat2

# $ : 변수명접근
dat2$num 
dat2$name

# stringsAsFactors의 default : True(4.0.0 부터는 F) 
dat3 <- data.frame(x1, x2, stringsAsFactors = T); dat3
dat3[,2] # factor 변환 됨, stringsAsFactors = F면 levels
dat[,1]
dat[,2]
dat[1,]
dat[2,]
dat[2, 1]
dat[3, 2]
dat3[3, 2]

# 리스트의 인덱스 형태도 가능
dat
dat[1]
dat[2]
dat[[1]]
dat[[2]]

# 여러 변수 선택 및 자료 선택 가능(행렬과 동일)
dat[, 1:2]
dat[, -1]
dat[-1, -2]
dat[-1, c(2, 4)] # Error : undefined columns selected

# 배열
x1 <- array(1:24, dim = c(4, 3, 2)); x1 # 4*3*2 3차원 배열 생성
x2 <- array(1:32, dim = c(2, 2, 4, 2)); x2 # 2*2*4 3차원 배열이 2개 생성
x1[,,1]
x2[,,3,1]
