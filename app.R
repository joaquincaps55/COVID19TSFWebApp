# Load necessary libraries
library(shiny)
library(shinythemes)
library(COVID19)
library(lubridate)
library(ggplot2)
library(dplyr)
library(prophet)
library(bit64)
library(DT)

# Data preparation -----------------
coviddata <- covid19("United Kingdom")  # Get data for the UK

# Convert to appropriate types
coviddata$date <- as.Date(coviddata$date)
coviddata$confirmed <- as.numeric(coviddata$confirmed)
coviddata$deaths <- as.numeric(coviddata$deaths)

# Filter the data to include only 2020-2021
coviddata <- coviddata[coviddata$date >= as.Date("2020-01-01") & coviddata$date <= as.Date("2021-12-31"), ]

# Initialize new columns for daily increases
coviddata$new.c <- numeric(nrow(coviddata))
coviddata$new.d <- numeric(nrow(coviddata))

# Calculate daily increases
coviddata$new.c[2:nrow(coviddata)] <- diff(coviddata$confirmed)
coviddata$new.d[2:nrow(coviddata)] <- diff(coviddata$deaths)

# Print the structure to check
print(head(coviddata))
print(str(coviddata))

# Events (lockdowns) -----------------
l1 <- data_frame(
  holiday = "lockdown1",
  ds = as.Date(c('2020-03-26')),
  lower_window = 0,
  upper_window = 100
)
l2 <- data_frame(
  holiday = "lockdown2",
  ds = as.Date(c('2020-11-05')),
  lower_window = 0,
  upper_window = 27
)
l3 <- data_frame(
  holiday = "lockdown3",
  ds = as.Date(c('2021-01-05')),
  lower_window = 0,
  upper_window = 62
)
holidays <- bind_rows(l1, l2, l3)

# UI ----------------
ui <- fluidPage(theme = shinytheme("sandstone"),
                navbarPage(
                  "COVID-19 UK Time Series Forecasting",
                  # Infections Tab
                  tabPanel("Infections",
                           sidebarPanel(
                             h2("Control Panel "),
                             sliderInput("daysI",
                                         "Days forecasted:",
                                         min = 7,
                                         max = 56,
                                         value = 7,
                                         step = 7),
                             radioButtons("radioI", "Lockdown effect",
                                          c("On" = 1,
                                            "Off" = 2)
                             ),
                             submitButton("See Graph")
                           ),
                           mainPanel(
                             h1("Forecasting UK COVID-19 infections"),
                             helpText("Source: 'covid19datahub.io'"),
                             helpText("Black = actual, Blue = predicted"),
                             plotOutput(outputId = "infectionPlot"),
                             h2("Actual Data"),
                             DT::dataTableOutput("tableI")
                           )
                  ),
                  # Deaths Tab
                  tabPanel("Deaths",
                           sidebarPanel(
                             h2("Control Panel "),
                             sliderInput("daysD",
                                         "Days forecasted:",
                                         min = 7,
                                         max = 56,
                                         value = 7,
                                         step = 7),
                             radioButtons("radioD", "Lockdown effect",
                                          c("On" = 1,
                                            "Off" = 2)
                             ),
                             submitButton("See Graph")
                           ),
                           mainPanel(
                             h1("Forecasting UK COVID-19 deaths"),
                             helpText("Source: 'covid19datahub.io'"),
                             helpText("Black = actual, Blue = predicted"),
                             plotOutput(outputId = "deathPlot"),  # Ensure this matches the server code
                             h2("Actual Data"),
                             DT::dataTableOutput("tableD")
                           )
                  ),
                  tabPanel("Help/More Information",
                           h1("Help"),
                           p("The graphs created are a forecast of COVID-19 infections/deaths in the UK. Please note that the data used is not cumulative but instead is a daily increase of infections/deaths."),
                           h1("Lockdown dates used"),
                           p("Lockdown 1: 26 March 2020 - 4 July 2020"),
                           p("Lockdown 2: 5 November 2020 - 2 December 2020"),
                           p("Lockdown 3: 5 January 2021 - 8 March 2021 (estimate)"),
                           h1("Data Source"),
                           p("The data was retrieved from 'covid19datahub' (Guidotti and Ardia, 2020). "),
                           a("https://covid19datahub.io/")
                  )
                )
)

# Server ----------------
server <- function(input, output) {
  # Infection forecasted graph
  output$infectionPlot <- renderPlot({
    ds <- coviddata$date
    y <- coviddata$new.c
    forecast_df <- data.frame(ds = ds, y = y)
    
    forecast_df <- forecast_df[complete.cases(forecast_df), ]
    
    if (input$radioI == 1) {
      m <- prophet(forecast_df, holidays = holidays)
    } else {
      m <- prophet(forecast_df)
    }
    
    future <- make_future_dataframe(m, periods = input$daysI)
    forecast <- predict(m, future)
    
    plot(m, forecast, xlabel = "Date", ylabel = "Daily increase of infections")
  })
  
  # Deaths forecasted graph
  output$deathPlot <- renderPlot({
    ds <- coviddata$date
    y <- coviddata$new.d
    forecast_df <- data.frame(ds = ds, y = y)
    
    forecast_df <- forecast_df[complete.cases(forecast_df), ]
    
    if (input$radioD == 1) {
      m <- prophet(forecast_df, holidays = holidays)
    } else {
      m <- prophet(forecast_df)
    }
    
    future <- make_future_dataframe(m, periods = input$daysD)
    forecast <- predict(m, future)
    
    plot(m, forecast, xlabel = "Date", ylabel = "Daily increase of deaths")
  })
  
  # Show actual data - Infections
  output$tableI <- DT::renderDataTable(DT::datatable({
    data <- coviddata[, c("date", "confirmed", "new.c")]
    data
  }))
  
  # Show actual data - Deaths
  output$tableD <- DT::renderDataTable(DT::datatable({
    data <- coviddata[, c("date", "deaths", "new.d")]
    data
  }))
}

# Run the application 
shinyApp(ui = ui, server = server)