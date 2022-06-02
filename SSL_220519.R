# 22.05.19
# R Markdown
# https://rmarkdown.rstudio.com/
# Rstudio에서 File > New File > R markdown
# File > Knit Document : 문서로 출력(ctrl + Shift + k)
#http://www.ptep-online.com/ctan/lshort_korean.pdf

# output: word_document / html_document / pdf_document
# install.packages("tinytex") -> pdf로 output 설정할 때 파일 크기 줄이기 위해 설치
# 장점 : R이 없어도 웹브라우저에서 확인 가능
# pdf_document -> 한글 유니코드 오류 발생
library(tinytex)
tinytex::install_tinytex()

install.packages("reticulate") # 파이썬 사용
library(reticulate)
reticulate::install_miniconda()
