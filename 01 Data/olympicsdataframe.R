require("jsonlite")
require("RCurl")
require(extrafont)
require(ggplot2)

olympics <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select * 
from OLYMPICS;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ryl96', PASS='orcl_ryl96', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 

head(olympics)
summary(olympics)
