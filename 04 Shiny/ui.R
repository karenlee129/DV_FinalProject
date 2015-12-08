#ui.R

require(shiny)
require(shinydashboard)
require(leaflet)
require(shinyBS)
dashboardPage(skin = "blue",
              dashboardHeader(title = "Shiny Final Project: RONLY LEUNG AND KAREN LEE",
                              titleWidth = 500
              ),
              dashboardSidebar(
                sidebarMenu(
                  menuItem("ScatterPlot", tabName = "scatterplot", icon = icon("th")),
                  menuItem("Boxplot", tabName = "boxplot", icon = icon("th"))
                  
                )
              ),
              dashboardBody(
                tabItems(
                  # First tab content
                  tabItem(tabName = "scatterplot",
                          checkboxGroupInput(inputId = "button",
                                             label = "Countries",
                                             choices = c("ALL","France","Germany", "Italy", "Japan", "United Kingdom", "United States", "Australia", "Hungary", "Sweden"), selected = "ALL", inline = TRUE),
                          #actionButton("tabBut2", "Click Here To View The Table"),
                          textInput(inputId = "title", 
                                    label = "ScatterPlot Title",
                                    value = "Medal Percentage for Specific Countries"),
                          actionButton(inputId = "clicks1",  label = "Click Here"),
                          plotOutput("distPlot1"),
                          bsModal("modalExample2", "Data Table", "tabBut2", size = "extra large",
                          dataTableOutput("scatterplottable"))
                  ),
                  
                  # Third tab content
                  tabItem(tabName = "boxplot",
                          actionButton(inputId = "clicks3",  label = "Click me"),
                          plotOutput("distPlot2")
                  )
                  
                  )
                )
              )

