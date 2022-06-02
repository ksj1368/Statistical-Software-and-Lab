# 22. 05. 26

# http://ggplot2.org
# http://docs.ggplot2.org

# ggplot2
install.packages("ggplot2")
library(ggplot2)

head(mtcars)

p <- ggplot(mtcars, aes(wt, mpg, color=cyl)) # x축 = wt, y축 = mpg, clr = cyl의ㅣ 범위로 그라데이ㅕㄴ

x11()
p
p2 = p + geom_point()
print(p2) # = p2
names(p2) # p2 객체 정의 확인

p2$data
mtcars[1,1] = 23
head(mtcars)
head(p2$data) # mtcars[1,1]이 23으로 수정이 안됨(data를 복제 함, 메모리 낭비 발생)

x11()
print(p) # print(p)

p = p2
names(p)
head(p$data)
p$layers
p$scales
p$mapping
p$theme
p$coordinates
p$facet
p$plot_env
p$labels
p$labels$x = 'Weight'
p$labels$y = 'MPG'
p$labels$colour = "Cylinder"
x11()
p
attributes(p)


summary(p)


p <- ggplot(mtcars, aes(factor(cyl), fill=factor(cyl))) # fill = color
x11()
p
p <- p + geom_bar(width=.5) # barplot
x11()
p

p2 <- p + facet_grid(. ~ gear) # facet_grid : 기여도에 따라 분리
x11()
p2

p3 = p + facet_grid(rows=vars(gear)) # row형식으로 출력
#x11()
p3

p4 = p + facet_grid(cols=vars(gear)) # col형식 출력 
#x11()
p4

p5 = p + facet_grid(rows=vars(am),cols=vars(gear))
#x11()
p5



x11()
png(file='C:/Users/INHA/Desktop/ggplot')
print(p)
dev.off()

graphics.off()

# aes
p <- ggplot(data=iris,aes(x=Sepal.Length, y=Sepal.Width))
x11()
p
p <- p + geom_point(aes(color=Species)) # color추가(local mapping)
p
p2 <- p + geom_point(mapping=
                       aes(x=Petal.Length, y=Petal.Width,color=Species),
                     pch=17)
x11()
p2

p <- ggplot(data=iris) 
p <- p + xlab("Length") + ylab("Width")
x11()
p

p2 <- p+ geom_point(mapping=
                      aes(x=Sepal.Length, y=Sepal.Width), colour="blue", pch=19)
p2

p3 <- p + geom_point(mapping=
                       aes(x=Petal.Length, y=Petal.Width), colour="red", pch=17)
x11()
p3
x11()
p4 = p2 + geom_point(mapping=
                       aes(x=Petal.Length, y=Petal.Width), colour="red", pch=17)
p4

summary(p)

p <- ggplot(data=mtcars, aes(x=wt, y=mpg))
p = p + geom_point(colour="orange", size=6)
x11()
p + xlab("Weight") + ylab("MPG(miles/gallon)") +
  xlim(c(3,5)) + ylim(c(10,15)) # x/ylim에 포함되는 값만 시각화(나머지는 missing value 처리)


graphics.off()

p <- ggplot(data=mtcars, aes(x=wt, y=mpg))
p = p + geom_point(aes(color=cyl, size=gear))
x11()
p


#geom_line
x11()
p <- ggplot(data=mtcars, aes(x=wt, y=mpg))
p + geom_line()

p2 <- ggplot(data=mtcars, aes(x=wt, y=mpg))
x11()
p2 + geom_line(linetype=2,size=2,color=2)#"#FF00FFAA")


# geom_abline
mw_coef = coef(lm(mpg~wt,mtcars))
p <- ggplot(data=mtcars, aes(x=wt, y=mpg))
p <- p + geom_point()
x11()
p
p <- p +
  coord_cartesian(xlim=c(1,5), ylim=c(10,35))
x11()
p


p <- p + xlim(1, 5) + ylim(10, 35)
x11()
p

p + geom_abline(intercept = mw_coef[1],
                slope = mw_coef[2],color="blue")
p + geom_vline(xintercept = 3,color="red") +
  geom_hline(yintercept = 20,color="red")

graphics.off()

# 22.05.31 ######################################
# geom_smooth 
# 국소 다항 회귀(local polynomial regression)기반으로 smooth함수를 추정해 그래프에 표시
# local : 범위내에서 3차식 추정
# 회색 범위 : 95% 신뢰구간
# 패턴 확인할 때 사용
p <- ggplot(data=mtcars, aes(x=wt, y=mpg))
p = p + geom_point()

# 파란선 : 중심선
x11()
p + geom_smooth() # p = point
x11()
p + geom_smooth(aes(linetype=factor(cyl)))

# geom_bar
# 주어진 데이터(명목형)로 부터 막대그래프 추가
# fill(상자 내부 색상), color(테두리 색상) 조절 가능

p <- ggplot(data=mtcars, aes(factor(cyl)))
x11()
p + geom_bar(fill="steelblue",color='red')
x11()
p + geom_bar(aes(fill=factor(gear)),color='black')

# geom_area
# ggplot에서 mapping으로 주어진 x, y의 값을 기준으로 
# y값의 하위부분을 주어진 색상으로 채움
huron <- data.frame(year = 1875:1972, level = as.vector(LakeHuron))
head(huron)
graphics.off()
p = ggplot(data=huron, aes(x=year,y=level))
x11()
p + geom_area() # 0부터 표현해 차이가 안보임
range(huron$level)

x11()
p + geom_area(fill='steelblue') +
  coord_cartesian(ylim=c(min(huron$level)-2,max(huron$level)+2)) # y축 범위 조절

x11()
p + geom_area(fill='steelblue') +
  ylim(-10,578)


# geom_ribbon()
# ggplot에서 mapping으로 주어진 x, ymin, ymax의 값을 기준으로
# ymin에서 ymax값의 사이를 주어진 색상으로 채움
# 주어진 시점에서의 변화를 표현할 때 사용
x11()
p + geom_line()

p = ggplot(data=huron, aes(x=year,y=level, ymin=huron$level-2,ymax=huron$level+2))
p + geom_ribbon(fill='steelblue') + geom_point() + geom_line()

setwd('d:/example')
kospi = read.table(file='kospi_data.txt',header=T,sep='\t')
head(kospi)
kospi[,1][1:5]
kospi[,1] = as.Date(kospi[,1]) # 날짜 형식으로 변환
kospi[,1][1:5]

attributes(as.Date(kospi[,1]))

p = ggplot(data=kospi, aes(x=Date,y=CurrentIndex,ymin=Lowest,ymax=Highest))
x11()
p = p + geom_ribbon(fill='lightblue') 
p + geom_point() + geom_line()

## 날짜 처리
install.packages("lubridate")
library(lubridate)
search()
ls(2)
k = as.Date(kospi[,1]); k
x = ymd(k); x
attributes(x)
year(x)  # 년도
month(x) # 월
day(x)   # 일
date(x)  # 날짜
wday(x)  # 요일(1~7 : 월 ~ 일)
week(x)  # 몇 번째 주

# geom_boxplot
# 주어진 데이터로부터 boxplot을 추가
p <- ggplot(mtcars, aes(factor(cyl), mpg))
x11()
p + geom_boxplot()
p + geom_boxplot(aes(fill=factor(carb)))

# geom_histogram()
# 주어진 데이터로부터 histogram을 추가
# binwidth의 값을 지정하지 않을 경우 range/30으로 적용(warning)
movies = read.csv(file='movies.csv',header=T)
head(movies)
dim(movies)
x11()
p <- ggplot(data=movies, aes(x=rating))
p + geom_histogram() # bin = 30개로 고정
p + geom_histogram(binwidth=1)

# ..변환.. : ggplot2에서 지원하는 표기법, 데이터의 변환 기능 적용
# ..density.. : density로 변환
p + geom_histogram(binwidth=1,aes(y=..density..)) + geom_density(color='red')
  
#  ..count.. : count로 변환
p + geom_histogram(binwidth=1, aes(y=..density.., fill=..count..)) + 
  geom_density(color='red') + scale_fill_gradient(low='white',high='#496ff5')

grep("scale",ls(2),value=T)

# geom_density
# 주어진 데이터로부터 분포에 대한 확률 밀도 함수를 표현하기 위한 함수 
# fill(색상 채움), alpha (투명도)를 이용해 여러 밀도 함수를 동시에 표현 가능
p <- ggplot(movies, aes(x = rating))
p + geom_density()
p + geom_density(aes(fill=factor(mpaa)), alpha=0.25)

# geom_text
# 주어진 위치에 텍스트를 표현하기 위한 함수
# x, y의 위치를 지정하거나 기존에 지정된 x,y에 텍스트 출력
p <- ggplot(mtcars, 
            aes(x=wt, y=mpg, 
                label=rownames(mtcars)))
p <- p + geom_point()
p + geom_text(aes(x=wt+0.05, 
                  color=factor(cyl)),size=5)

######################################################
library(reshape2)
install.packages(c("mapproj","maps"))
library(mapproj)
library(maps)
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
head(crimes)

states_map <- map_data("state")
head(states_map)

p <- ggplot(crimes, aes(map_id=state))
p <- p + geom_map(aes(fill=Murder), map=states_map)
p <- p + expand_limits(x=states_map$long, y=states_map$lat)
p + coord_map()

#ECDF 
df <- data.frame(x = c(rnorm(100, 0, 2),rnorm(100, 1, 4)), g = gl(2, 100))
p <- ggplot(df, aes(x, color = g))
p + stat_ecdf()
p + stat_ecdf(geom="line", size=1)

# stat_function

dat <- data.frame(x = rnorm(100))
p <- ggplot(dat, aes(x = x))
p <- p + geom_density(fill = "green",
                      alpha = 0.15)
p + stat_function(fun = dnorm, 
                  color = "red", fill="red", 
                  alpha=0.15, geom="area")

# coord_cartesian
library(ggplot2)
p <- ggplot(data=mtcars, aes(x=disp, y=wt))
p <- p + geom_smooth()
x11()
p
p + coord_cartesian(xlim=c(325, 500), ylim=c(3,6))
p + xlim(c(325,500))

#coord_flip
p <- ggplot(mtcars, 
            aes(factor(cyl), mpg))
p + geom_boxplot() +
  coord_flip()

p <- ggplot(mtcars, 
            aes(factor(cyl)))
p + geom_bar(fill="steelblue",
             color='black') +
  coord_flip()

# coord_fixed()

x <- c(500, 350, 700, 600, 400)
y <- c(10, 20, 30, 30, 20)
dat <- data.frame(x, y)
p <- ggplot(data=dat, aes(x=x, y=y))
p <- p + geom_point(size=5)
p
p + coord_fixed(ratio=1)

# coord_map

library(maps)
world <- map_data("world")
head(world)
korea <- world[grep("Korea$", world$region),]
head(korea)
p <- ggplot(korea, aes(x=long, y=lat, group=group))
p <- p + geom_polygon(fill="white", colour="black")
x11()
p
p + coord_map()


#coord_trans
p <- ggplot(data=diamonds, 
            aes(x=carat, y=price, colour=factor(cut)))
p <- p + geom_point()
p
p + coord_trans(x = "log10", y = "log10")

# gg map
install.packages("ggmap")
library(ggmap)

register_google(key = "AIzaSyCCM57JzoJLPLNd4SCWVIlk9GkjiXMTS6A")
has_google_key()
google_key()
lon = 126.653
lat = 37.45
map = get_googlemap("Incheon",zoom=12,maptype="roadmap",
                    markers=data.frame(lon,lat))
x11()
ggmap(map)

# get_map
food = read.csv(file='food.csv',header=T)
head(food)
loc = geocode("Incheon")
loc = as.numeric(loc)
loc = c(lon,lat)
map = get_map(loc,zoom=13,maptype='roadmap')
p = ggmap(map, extent='device') + 
  geom_point(
    aes(x=Lon,y=Lat,size=Rating,fill=Rating),
    alpha=0.6,pch=21,data=food) +
  scale_size(range=c(0,10)) +
  geom_text(aes(x=Lon+0.001,y=Lat+0.001,
                label=Name),color="white",size=5,data=food)
x11()
p


# Wordcloud in R

#install.packages(c('tm', 'SnowballC', 'wordcloud'))
library(tm)
library(SnowballC)
library(wordcloud)

jeopQ <- read.csv('JEOPARDY_CSV.csv', stringsAsFactors = FALSE) 

### Data Cleaning
jeopCorpus <- Corpus(VectorSource(jeopQ$Question))
jeopCorpus <- tm_map(jeopCorpus, removePunctuation) ## . , ? ! ()
jeopCorpus <- tm_map(jeopCorpus, removeWords, 
                     c("the", "this", "The", "This", stopwords('english')))
## stopwords("en")
jeopCorpus <- tm_map(jeopCorpus, stemDocument)  ## went -> go

wordcloud(jeopCorpus, max.words = 100, random.order = FALSE) 

# additional
dir.create('test_fig')
f_name = 'test_fig/test_'
for(i in 1:10)
{
  png(file=paste0(f_name,i,'.png'))
  plot(1:10,rnorm(10),type='l')
  dev.off()
}
