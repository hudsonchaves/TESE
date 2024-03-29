install.packages("XML")
library(XML)

########
### O QUE É UM PARSER?
########
url = "http://www.r-datacollection.com/materials/html/fortunes.html"
fortunes = readLines(con=url)
fortunes

parsed_fortunes = htmlParse(file=url)
print(parsed_fortunes)
str(parsed_fortunes)

#########
### DESCARTANDO NÓS
#########

h1 = list("body" = function(x){NULL})
parsed_fortunes = htmlTreeParse(url, handlers=h1, asTree=TRUE)
parsed_fortunes$children

h2 = list(
  startElement = function(node, ...){
    name = xmlName(node)
    if(name %in% c("div", "title")){NULL}
    else{node}
  },
  comment = function(node){NULL}
)
parsed_fortunes = htmlTreeParse(file=url,handlers=h2,asTree=TRUE)


#########
### EXTRAINDO INFORMAÇÕES
#########

getItalics = function(){
  i_container =  character()
  list(i=function(node,...){
    i_container <<- c(i_container, xmlValue(node))
  }, returnI = function() i_container)
}

h3 = getItalics()
invisible(htmlTreeParse(url, handlers=h3))
h3$returnI()
