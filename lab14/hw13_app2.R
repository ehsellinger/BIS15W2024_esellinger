library(tidyverse)
library(shiny)
library(shinydashboard)

options(scipen=999)

UC_admit <- read_csv("data/UC_admit.csv")

UC_admit$Academic_Yr <- as.factor(UC_admit$Academic_Yr)

ui <- dashboardPage(
  dashboardHeader(title = "UC Schools Admissions Data 1994-2023"),
  dashboardSidebar(disable=T),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 2,
          
          selectInput("x", "Select Ethnicity", choices = unique(UC_admit$Ethnicity), hr()), 
          selectInput("y", "Select Campus", choices = unique(UC_admit$Campus), hr()),
          selectInput("z", "Select Admit Category", choices = unique(UC_admit$Category), hr()),
      ),  
      
      box(width = 7,
          plotOutput("plot", width = "800px", height = "600px")
      ) # close the second box
    ) # close the row
  ) # close the dashboard body
) # close the ui

server <- function(input, output, session) {
  
  session$onSessionEnded(stopApp) #automatically stop the app when we close it
  
  output$plot <- renderPlot({
    UC_admit %>% 
      filter(Ethnicity == input$x) %>% 
      filter(Category == input$z) %>% 
      filter(Campus == input$y) %>% 
      ggplot(aes(x = Academic_Yr, y = FilteredCountFR, fill = Academic_Yr)) +
      guides(fill = FALSE) +
      geom_col(position = "dodge") +
      theme(axis.text.x = element_text(angle = 45, hjust=1)) +
      labs(x = NULL,
           y = "Student Count")
  })
}

shinyApp(ui, server)