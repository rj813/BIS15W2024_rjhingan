library("tidyverse")
library("shiny")

homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")

ui <- fluidPage(titlePanel("Homerange Locomotion"),
  radioButtons("x", "Select Fill Variable", choices = c("thermoregulation", "trophic.guild"), 
               selected="trophic.guild"),
  
  plotOutput("plot")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    
    ggplot(data=homerange, aes_string(x="locomotion", fill=input$x)) +
      geom_bar(position = "dodge", alpha=0.8, color="black")+
      labs(x=NULL, fill="Fill Variable") +
      theme_light(base_size = 18)
  })
}

shinyApp(ui, server)
