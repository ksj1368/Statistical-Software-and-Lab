## 22.05.06
getwd()
setwd("C:/Users/JSJ/Desktop/학교/4-1/SSL")
getwd()
# 왜도(skewness): 비대칭 (asymmetry) 정도
# 왜도가 0일 경우 -> 대칭
# 왜도 < 0 : left or negative skewed (negative value), 왼쪽으로 치우침(꼬리가 길어진 부분으로 치우침)
# 왜도 > 0 : right or postive skewed (positive value), 오른쪽으로 치우침(꼬리가 길어진 부분으로 치우침) 

# 첨도(excess kurtosis): 뾰족한 (peakedness) 정도
# <3 : flat (left distribution)
# =3 : Normal distribution
# >3 : steep (right distribution) : 뾰족해짐
# install.packages("moments")
library(moments)
load("Dataset/expr_dat.Rdata")
skewness(expr_dat[,1])
kurtosis(expr_dat[,1])
x11()
hist(expr_dat[,1],freq = F)
x = seq(5.5, 8.5, length = 100); x
lines(x, dnorm(x, mean = mean(expr_dat[,1]), sd(expr_dat[,1])))
# lines() : 점을 이어주는 선 추가
# dnorm() : 정규분포 pdf
# 정규분포의 곡선과 분포가 유사하므로 왜도가 0에 가깝고 첨도도 3에 가깝다.

# summary() : 데이터 요약
# 수치형 자료 : 기초통계량 계산
# 문자형 자료 :길이 및 class return(요인으로 정의시 빈도), 굳이 사용할 필요는 없음
# 참고 : Class 형식 마다 summary 형태가 달라짐
x <- rnorm(100)
summary(x)
y <- c('red', 'blue', 'red', 'white')
f.y <- factor(y); f.y
summary(f.y)

# 교차표(cross table) or 분할표(contingency table)
# table(row, col)
# 1차원 도수분포표
table(mtcars$cyl)
table(mtcars$am)

# 2차원 도수분포표
table(mtcars$cyl, mtcars$am)

# 3차원 도수분포표
table(mtcars$cyl, mtcars$am, mtcars$gear)

# 공분산(covariance) : 두 변수 간 연관성 파악할수 있으나 크기 비교는 어려움
# cov(X, Y) = E[(X-E(X))(Y-E(Y))] 
cov(expr_dat[,1], expr_dat[,5]) # 0.06593261
cov(expr_dat[,c(1,5,8)]) # 대각 성분 -> 분산, 나머지 -> 공분산(대칭)
var(expr_dat[,1]) # 0.1774125

# 상관계수(correlation) : 공분산을 각각의 표준편차로 나눔, 크기 비교 가능 
# -1 <= p <= 1
cor(expr_dat[,1], expr_dat[,5]) # 0.186082
cor(expr_dat[,c(1,5,8)])

#######################################
# Web scraping with rvest
# rvest : 크롬의 SelectorGadget과 함께 사용하여 쉽게 웹 스크래핑을 진행하는 R의 패키지
# raed_html("web page url") : url을 읽고 Tag로 구조화하여 객체 생성
# html_nodes(url, "css selector location") : SelectorGadget 기반 CSS location 값을 이용해 웹페이지 내 Tag 선택
# url = raed_html()의 return 값
# html_text(html) : 선택된 Tag의 Text들만 선택하여 반환
# html = html_nodes()의 return 값

# 크롬에서 SelectorGadget 설치 후 진행
# 빨간색 box : 제외
# 초록색 box : 선택
# 노란색 box : 같이 가져옴
# install.packages("rvest")
library(rvest)
library(xml2)

# IMDB eg)
url <- 'https://www.imdb.com/search/title?cont=100&release_date=2019,2019&title_type=feature'

# Reading thr HTML code from the website
webpage <- read_html(url); webpage
temp <- html_nodes(webpage, '.lister-item-header a'); temp # 영화 제목
html_text(temp)

temp2 <- html_nodes(webpage, '.ratings-imdb-rating strong'); temp2 # 별점
html_text(temp2) # 문자형으로 출력

temp3 <- html_nodes(webpage, '.text-primary'); temp3 # 순서
x_temp3 = html_text(temp3); x_temp3
x_temp3 = as.numeric(gsub("[.]","",x_temp3)); x_temp3

temp4 <- html_nodes(webpage, '.text-muted.unbold'); temp4 # 개봉 연도
x_temp4 = html_text(temp4); x_temp4
x_temp4 = as.numeric(gsub("[()]|([I]+)", "", x_temp4)); x_temp4

dat = data.frame(title = html_text(temp), rating = html_text(temp2), years= x_temp4); dat

temp5 <- html_nodes(webpage, '.sort-num_votes-visible span:nth-child(2)'); temp5 # 투표횟수
x_temp5 = html_text(temp5); x_temp5
x_temp5 = as.numeric(gsub("[,]",'',x_temp5)); x_temp5

dat$vote = x_temp5; head(dat)

str_date = "2019-01-01"
end_date = '2019-12-31'
cnt = 100
str_num = 1
url = paste0('https://www.imdb.com/search/title/?title_type=feature&release_date=',
             str_date,",",end_date,'&start=',str_num,'&ref_=adv_nxt');url
page = read_html(url)
temp = html_node(page, ".desc span:nth-child(1)") # 1-50 of 12,195 titles. 
html_text(temp)

# 타이틀 개수만 추출
num_tt = as.numeric(gsub(',','',strsplit(html_text(temp), "[ ]")[[1]][3])); num_tt 
num_page = ceiling(num_tt/cnt); num_page
mv_list = list()
for(i in 1:5){
  url = paste0('https://www.imdb.com/search/title/?title_type=feature&release_date=',
               str_date,",",end_date,'&start=',str_num,'&ref_=adv_nxt')
  page = read_html(url); page
  temp <-html_nodes(page, '.lister-item-header a')
  temp = html_text(temp)
  temp2 <-html_nodes(page, '.ratings-imdb-rating strong')
  temp2 = html_text(temp2)
  mv_list[[i]] = list(temp, temp2) # data.frame(title=temp, rate = temp2)
  Sys.sleep(runif(1,0.5,2)) # runif(1,0.5,2)만큼 휴식, runif(1,0.5,2) = 0.5 ~ 2초 사이에 난수만큼 휴식
  str_num = str_num +cnt
  cat('\n page : ', i, ' / Total : ', num_page)
}

# Ex2 naver
# 네이버 영화 url
# https://movie.naver.com/movie/bi/mi/basic.nhn?code=136900
# 리뷰 url
# https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=136900&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false
url = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=136900&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false"
i = 1
url_temp = paste0(url, "&page=", i); url_temp

mv_webpage = read_html(url_temp); mv_webpage
tt_cnt_temp = html_nodes(mv_webpage, ".score_reple p")
html_text(tt_cnt_temp)

mv_webpage = read_html(url_temp)
html_text(mv_webpage)
tt_cnt_temp = html_nodes(mv_webpage, '.total em') # 관람객 평점 건수
v_count = html_text(tt_cnt_temp); v_count
v_count = gsub("[,]", "",v_count)
tt_cnt = as.numeric(v_count); tt_cnt

page_indx = 1:ceiling(tt_cnt/10)
length(page_indx)

rating = numeric()
user_name = character()

for(i in 1:3){
  w_temp = read_html(paste0(url, "&page=", i))
  r_temp = html_nodes(w_temp, ".score_result .star_score em")
  rating = c(rating, as.numeric(html_text(r_temp)))
  u_temp = html_nodes(w_temp, ".score_reple a span")
  u_txt = html_text(u_temp)
  u_txt = u_txt[u_txt != "BEST"]
  user_name = c(user_name,u_txt)
  Sys.sleep(runif(1,1,3))
  cat('\n', i, 'page')
}

rating
user_name
data.frame(rating, user_name)
temp = gsub(")","", user_name)
temp_list = strsplit(temp, "[(]")
res = sapply(temp_list, function(x) x[length(x)])
head(res)

x11()
plot(table(rating), type = "h")
