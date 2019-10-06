library(shiny)
shinyServer(function(input, output) {
    values <- reactiveValues()
    # Calculate the interest and amount    
    observe({
        input$Calculate
        values$Compound_Interest <- isolate({
            round(input$Principal*(1+input$Interest/100/recode(input$Compound_Interval,"365=365; 52=52; 12=12; 4=4; 2=2; 1=1"))^
            (input$Time_Periods*recode(input$Compound_Interval,"365=365; 52=52; 12=12; 4=4; 2=2; 1=1")) - input$Principal,2)
        })
        values$Amount <- round(isolate(input$Principal) + values$Compound_Interest,2)
    })
    
    # Display values entered
    output$Principal <- renderText({
        input$Calculate
        paste("Principal Amount:", isolate(formatC(input$Principal,digits = 2, format = "f",big.mark = ",")))
    })
    
    output$Interest <- renderText({
        input$Calculate
        paste("Interest Rate:", isolate(input$Interest), 
              "% per year")
    })
    
    output$Time_Periods <- renderText({
        input$Calculate
        paste("Time Period: ", isolate(input$Time_Periods), "Years, compounding ",
              recode(isolate(input$Compound_Interval),
                     "1='annually';2='half-yearly';4='quarterly';12='monthly';52='weekly';365='daily'"))
    })
    
    output$Compound_Interest <- renderText({
        if(input$Calculate == 0) ""
        else
            paste("Compound Interest:", formatC(values$Compound_Interest, digits = 2, format = "f",big.mark = ","))
    })
    
    output$Amount <- renderText({
        if(input$Calculate == 0) ""
        else 
            paste("Total Amount (Principal + Compound Interest):", formatC(values$Amount, digits = 2,format = "f", big.mark = ","))
    })
    
    CompoundingTable <- reactive({
        Compound_balance <- input$Principal
        df <- 0
        for (i in 1:input$Time_Periods) {
            Compound_balance <- Compound_balance * (1+input$Interest/100)
            df <- rbind(df, Compound_balance - input$Principal)
        }
        print(df[,1])
    })
    
    output$plot1 <- renderPlot({
        formatC(plot(0:input$Time_Periods, CompoundingTable(), xlab="Year", ylab="Compound Interest Earned"), format = "d")
        points(input$Time_Periods, values$Amount-input$Principal, col = "green", type = "n")
        text(input$Time_Periods, values$Amount-input$Principal,labels = values$Amount-input$Principal, cex=0.6, pos=1, col="dark green")
    })
    
})



