# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(leaflet)
require(DT)

shinyServer(function(input, output) {
  # Generate the data frame from the server
  df1 <- eventReactive(input$clicks1, {df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select country, sum(ttl_g_country_overall)/sum(ttl_medals_country_overall) AS GP, sum(ttl_s_country_overall)/sum(ttl_medals_country_overall) AS SP, sum(ttl_b_country_overall)/sum(ttl_medals_country_overall) AS BP
                                                                                       from OLYMPICS
                                                                                       group by country;"
                                                                                       ')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ryl96', PASS='orcl_ryl96', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  })
  
  # Code for the check box
  checkBoxes <- eventReactive({input$button}, {
    if (input$button == "ALL" || is.null(input$button))
    {
      checkBoxes = c("ALL","France","Germany", "Italy", "Japan", "United Kingdom", "United States", "Australia", "Hungary", "Sweden")
    }
    else
    {
      checkBoxes = input$button
    }
  }, ignoreNULL = FALSE)
  
  
  
  # First ggplot------------------------------------------------------
  output$distPlot1 <- renderPlot(height=600, width=900, {
    scatterplot <- df1() %>% select(COUNTRY, GP, SP, BP) %>% group_by(COUNTRY) %>% subset(COUNTRY %in% checkBoxes())
    plot1 <- ggplot() + 
      geom_point() +
      labs(title='Medal Percentages for Each Country') +
      labs(x=paste("Country"), y=paste("Value"), color = paste("Percentage")) +
      layer(data=scatterplot, 
            mapping=aes(x=as.character(COUNTRY), y=GP, color = "Gold Percentage"), 
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list(), 
            position=position_identity()
      ) +
      layer(data=scatterplot, 
            mapping=aes(x=as.character(COUNTRY), y=SP, color = "Silver Percentage"), 
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list(), 
            position=position_identity()
      ) +
      layer(data=scatterplot, 
            mapping=aes(x=as.character(COUNTRY), y=BP, color = "Bronze Percentage"), 
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list(), 
            position=position_identity()
      ) 
      
    plot1
  })


# Begin code for Third Tab:

df3 <- eventReactive(input$clicks3, {df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
                                                 "select * from olympics
                                                 ;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ryl96', PASS='orcl_ryl96', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

})



output$distPlot2 <- renderPlot(height=600, width=900, {
  s <- df3() %>% select(COUNTRY, YR) %>% filter(COUNTRY %in% c("Germany", "East Germany", "West Germany", "Russia", "Soviet Union"))
  plot3 <- ggplot() + 
    geom_boxplot(fill=NA) +
    labs(title='BoxPlot of Country Participation') +
    labs(x=paste("Country"), y=paste("Year")) +
    layer(data=s, 
          mapping=aes(x=COUNTRY, y=YR), 
          stat="identity", 
          stat_params=list(), 
          geom="point",
          geom_params=list(), 
          position=position_identity()
    )+
    layer(data=s, 
          mapping=aes(x=COUNTRY, y=YR), 
          stat="boxplot", 
          stat_params=list(), 
          geom="boxplot",
          geom_params=list(), 
          position=position_identity()
    ) 
  plot3
})

})
