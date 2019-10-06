library(shiny)
library(car)

shinyUI(fluidPage(
    titlePanel("Compound Interest Calculator"),
    sidebarLayout(
        sidebarPanel(
            helpText("This Shiny app calculates compound interest based on your selections."),            
            numericInput("Principal", label = h6("Enter the investment (principal) amount"), value = 100),
            numericInput("Interest", label = h6("Enter the annual interest rate (in % - decimal values will work. E.g, 2.5)"), value = 5, step = .5, max = 25),
            sliderInput("Time_Periods", label = h6("Choose the number of time periods"), min = 0, max = 50, value = 2),
            selectInput("Compound_Interval", label = h6("Select compounding intervals from Daily, Weekly, Monthly, Quarterly, Half-Yearly & Annually"), choices = list("Daily"=365,"Weekly"=52,"Monthly"=12,"Quarterly"=4,"Half-Yearly"=2,"Annually"=1), selected = 1),
            actionButton("Calculate", label = "Calculate Amount")
        ),
        
        mainPanel(
            tabsetPanel(
                tabPanel("Output",
                         p(h5("Investment values entered by you:")), textOutput("Principal"),
                         textOutput("Interest"), textOutput("Time_Periods"),
                         textOutput("Compound_Interval"), p(h5("Calculated investment values post compounding:")),
                         textOutput("Compound_Interest"), textOutput("Amount"),
                         plotOutput("plot1")
                ),
                
                tabPanel("Definitions",
                         p(h4("Compound Interest Calculator:")),
                         helpText("This application calculates compound interest and total amount based on initial investment, interest rate, time periods and compounding intervals entered by user."),
                         HTML("<u><b>Methodology for calculating compound interest: </b></u>
                                              <br> <br>
                                              <b> Formula: </b> <br>
                                              Principal * (1 + Interest Rate / Compounding Interval) ^ (Number of Time Periods * Compounding Interval) </b>
                                              <br> <br>
                                              <b> Definitions:</b> <br>
                                              <u> Principal </u> = Investment Amount <br>
                                              <u> Interest Rate </u> = Rate of interest per year <br>
                                              <u> Number of Time Periods </u> = Number of total terms for initial investment <br>
                                              <u> Compounding Interval </u> = Intervals at which investment will get compounded (Daily, Weekly, Monthly, Quarterly, Half-Yearly and Annually) <br>
                                              <u> Compound Interest </u> = Compound Interest Amount after given period <br>
                                              <u> Amount </u> = Total Amount (Principal + Compound Interest)")
                )
            )
        )
    )
))