# 22.04.05
# 아래 코드 시ㅓㅎㅁ?
text <- c("axxx?xx", "axx?xx??bbb"); text
strsplit(text, split = '(?<![?])[?](?![?])', perl = T) # 양쪽이 ?가 아닐경우 split
text2 <- c("azzzzze, axxxdxe, asfxfe"); text2
strsplit(text2, "(?<=a).*(?=e)", perl = T) # 임의의 문자(a, e)가 없을 경우 split
strsplit(text2, "(?<=a)[zx]+(?=e)|", perl=T) # z 또는 x가 나오고 a 또는 e가 앞뒤에 있을 경우 split

setwd("D:/example")
getwd()
dir()
# p3(중간)?
# readline : 사용자로부터 문자열을 입력받을 때 사용( = input())
a <- readline("Input any intger : ")
b <- readline("Input two integers with comma : ")
as.numeric(unlist(strsplit(b, "[,]")))
sample(1:45, 6)

# scan
x1 <- scan(file = "input_noh.txt", what = numeric()); x1
x2 <- scan(file = "input_noh.txt", what = character()); x2
x3 <- scan(file = "input_noh.txt"); x3
x4 <- scan(file = "input_h.txt", what = character()); x4
x <- matrix(as.numeric(x4[-(1:2)]), ncol = 2, byrow = T); x

# read.table : 데이터를 불러와 데이터프레임으로 리턴 
# header = T : 파일에 변수명이 존재(defualt = F) 
# nrows = 행의 개수(-1 : all, 10 : 상위 행 10개만 가져옴)
# skip = 건너 뛸  데이터 개수(0 : defualt, 5 : 5개 건너뜀)
# encoding = 텍스트가 깨질 경우에 사용(한글 : UTF-8사용)
# stringsAsFactors = (default = T)
dat <- read.table(file ="input_noh.txt", nrows = 3); dat
dat2 <- read.table(file = "input_noh.txt", header = T,nrows = 3); dat2
dat3 <- read.table(file = "input_h.txt", header = F,nrows = 3); dat3
dat4 <- read.table(file = "input_h.txt", header = T, nrows = 3); dat4
dat5 <- read.table(file = "input_h.txt", header = F, nrows = 3, stringsAsFactors = F); dat5

# 출력(cat, write)
# cat = scanf, 벡터 형식의 자료출력에 적합 + 반복문
# append = T :  기존에 파일에 출력 결과를 이어서 추가
i = 0
while(1){
  i = i+1
  # cat("\n", i)
  if(i%%100 == 0)
    cat("\n", i, "st iteration")
}
x <- 1:10; x
cat(x, file = "x.txt", sep = "\t", append = T) # setwd()에 x.txt 추가
cat('\t', file = "x.txt", sep ="", append = T)
cat(x, sep = "\t", append =T)
cat(x, sep = "\n", append = T)
cat("\n", 1,"st element of x = ", x[1])
# write.table : mat형태로 출력
# file = "파일 이름":저장하고자 하는 파일 이름 및 위치
# row.names = T or F # 행이름의 출력 여부
# col.names = T of F # 열이름의 출력 여부
# quote = T or F # 문자열에 따옴표 표기 여부
# sep = "\n", "\t", " " # 개행문자, 변수의 구분
# csv = 컴마로 구ㅜㅂㄴ
x1 <- 1:20; x1
x2 <- rep(c("A", "B", "B", "A"), 5); x2
x3 <- rep(c(T, F), each = 10); x3
dat <- cbind(x1, x2, x3); dat
write.table(dat, file = "test1.txt", row.names = F, col.names = F, quote = T, sep = "\t")
write.table(dat, file = "test2.txt", row.names = F, col.names = F, quote = F, sep = "\n")
write.table(dat, file = "test3.txt", row.names = F, sep = ",")
write.table(dat, file = "test4.txt", row.names = T, col.names = T, quote = T, sep = " ")
write.table(dat, file = "test5.txt", row.names = F, col.names = F, quote = T, sep = " ")
