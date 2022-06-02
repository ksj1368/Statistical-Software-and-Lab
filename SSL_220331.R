# 22.03.31
#확장 정규 표현식(시험)
x <- c(as = "asfef", qu = "qwerty", "yuoip[", "b", "stuff.blah.yech"); x
strsplit(x, "e") # e를 기준으로 문자열 분리 + e 제거
strsplit(x,"[a-f]") # = [abcdef] 를 제거한뒤 제거위치에 ""표시, 마지막 문자열이 제거됐을 경우 ""가 추가 안됨
strsplit(x, "[aleu][ab]") # aa, ab, la, ea, eb, ua, ub가 포함될 경우 자름

# unlist : 리스트를 벡터화
unlist(strsplit("a.b.c", ".")) # 따옴표가 연속으로 있을 경우 하나로 표현
unlist(strsplit("a.b.c", "[.]")) # 아래와 동일한 출력
unlist(strsplit("a.b.c", ".", fixed = TRUE))

y <- c("ab/cd/ef~z!yk?c", "a/x!b,y,z.t/s"); y
strsplit(y, "[/~!?]")
strsplit(y, "[[:punct:]]")
unlist(strsplit(y, "[[:punct:]]")) # 하나의 리스트로 합침(벡터화)
x <- list(1:10, matrix(c("3", -3, 1, 2), 2, 2)); x
unlist(x) # 벡터화, 문자형으로 형변환
# unlink : 폴더 삭제 함수

getwd()
setwd("d:/")
dir()
dir.create("eaxmple2")
setwd("example2")
getwd()
dir('../')
dir.create('./test')
dir('c:/windows')
unlink("test", recursive = T)
dir()
?unlink

test <- dir("C:/Windows"); test
t1 <- grep("^[A-Ca-c][a-z]", test); t1# ABCabc로 시작 뒤에는 소문자 아무거나
t2 <- grep("[.]exe$", test, value = T); t2 # .exe로 끝나는 파일
t3 <- grep("^[BbCc].+exe$", test, value = T); t3  # BbCc로 시작하고 exe로 끝나는 파일

length(colors())
colors()[1:5]
cn <- grep("white", colors(), value = T); cn # colors()에서화이트 계열 추출
x11()
barplot(rep(3, length(cn)), col = cn); cn # 높이 3인 막대그래프, cn개수만큼 반복

# grep() : 탐색 대상 내에서 정규표현식에 매치되는 값들의 위치를 반환
# value = T 이면 실제 값을 반환
x <- c("010-3123-2134", "032-860-7642", "02-111-1234", "010-123-5656"); x
grep("010-[0-9]{3,4}-[0-9]{4}", x, value = T)
grep("0[2-9][0-9]?-[1-9][0-9]{2,3}-[0-9]{4}", x, value = T)

# 대상 내에 정규표현식에 해당하는 문자열들을 바꿀 문자열로 치환
gsub('[.]exe', '.csv', t2) # exe를 csv로 변환(단, .exe만 변환 )
gsub('.exe', '.csv', t2)

setwd('d:/eaxmple2') # 저장위치 설정
for(i in 1:20){ # 파일 생성(20개)
  write.table(1:10, file = paste0('data_', i, '.txt'))
}
fname <- dir(); fname
fname2 <- grep('data_[0-9][.]txt', fname, value = T); fname2
fname3 <- paste0(substr(fname2, 1, 5), "0", substr(fname2, 6, nchar(fname2))); fname3
file.rename(fname2, fname3)
cbind(fname2, fname3)
