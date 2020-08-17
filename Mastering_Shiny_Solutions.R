
# Mastering Shiny Chapter 2 Exercise Solutions --------------------------------------------

# install.packages("shiny")

library(shiny)

# Ex: 1 -------------------------------------------------------------------

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
  
)

server <- function(input, output, session) {
  output$greeting<- renderText({
    paste0("Hello ", input$name)
  })
}

shinyApp(ui, server)

# Ex: 2 -------------------------------------------------------------------

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  "then x times 5 is",
  textOutput("product")
)


server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * 5
  })
}

shinyApp(ui, server)

# Ex: 3 -------------------------------------------------------------------

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "and y is", min = 1, max = 50, value = 30),
  "then x times y is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * input$y
  })
}

shinyApp(ui, server)



# Ex: 4 -------------------------------------------------------------------

ui <- fluidPage(
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)


server <- function(input, output, session) {
  output1<- reactive({
    input$x * input$y
  })
  
  output$product <- renderText({ 
    output1()
  })
  output$product_plus5 <- renderText({ 
    output1() + 5
  })
  output$product_plus10 <- renderText({ 
   output1() + 10
  })
}

shinyApp(ui, server)


# Ex: 5 -------------------------------------------------------------------

library(ggplot2)
datasets <- data(package = "ggplot2")$results[c(2, 4, 10), "Item"]

ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot")
)


server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summmary <- renderPrint({
    summary(dataset())
  })
  output$plot <- renderPlot({
    plot(dataset())
  }, res = 96)
}

shinyApp(ui, server)

