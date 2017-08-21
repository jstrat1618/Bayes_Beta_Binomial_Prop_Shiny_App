library(shiny)

shinyUI(fluidPage(
  #App Title
  titlePanel('Bayes Binomial Proportion with Beta Prior'),
  
  sidebarLayout(
    sidebarPanel(
      
      #HYPER-PARAMETERS
      #Alpha
      sliderInput("alpha","Select alpha for the prior distribution", 
                  min=0.1, max=100, value=1, step=0.1),
      #Beta
      sliderInput("beta", "Select beta for the prior distribution" , 
                  min=0.1, max=100, value=1, step=0.1),
      
      #DATA
      #Number of Trials
      sliderInput("nTrials", "Select number of Trials", min=2, max=500, value = 100),
      #Number of heads
      uiOutput("HeadsOptions"),
      
      #GRAPHICAL PARAMETERS
      radioButtons("color", "Select the color of the plots", 
                   choices = c("Black","Green", "Blue", "Orange"), selected = "Black")
      
    ),
    
    
    
    
    mainPanel(
      plotOutput("prior"),
      plotOutput("posterior")
    )
    
  )
  
))