library(shiny)

ui <- shinyUI(fluidPage(
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



server <- shinyServer(function(input, output){
  
  #PLOT THE PRIOR
  output$prior <- renderPlot({
    priorAlpha <- input$alpha
    priorBeta <- input$beta
    dum <- seq(0,1, length=10^3)
    
    prior<- function(x)
      ifelse(x>0 & x<1, dbeta(x, shape1 = priorAlpha, shape2 = priorBeta),0)
    
    
    plot(dum, prior(dum), type='n', 
         main = 'Prior', 
         xlab = expression( theta ), ylab=expression(pi*'(' * theta *')'))
    lines(dum, prior(dum), col=input$color)
  })
  
  #Adjust Number of Heads Input
  output$HeadsOptions <- renderUI({
    nT <- input$nTrials
    sliderInput("nHeads", "Select number of Successes", min=0, max=nT, value = 0, step=1)
    
  })
  
  #Plot the posterior  
  output$posterior <- renderPlot({
    a <- input$alpha
    b <- input$beta
    nT <- input$nTrials
    nH <- input$nHeads
    
    postAlpha <- a + nH
    postBeta <- b+ nT - nH
    dum <- seq(0,1, length=10^3)
    posterior <- function(x)
      ifelse(x>0 & x<1, dbeta(x, shape1 = postAlpha, shape2 = postBeta),0)
    
    
    plot(dum, posterior(dum), type='n', 
         main = 'Posterior', 
         xlab=expression(theta), ylab=expression(pi*'(' * theta *' |D)'))
    lines(dum, posterior(dum), col=input$color)
  })
  
})


# Run the application 
shinyApp(ui = ui, server = server)