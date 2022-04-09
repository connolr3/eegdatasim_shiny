require(devtools)
require(dashboardthemes)
#devtools::install_github("connolr3/eegdatasim")
#library(eegdatasim)
#install.packages("R.matlab")
#require(eegdatasim)
require(gridExtra)
require(knitr)
require(R.methodsS3)
require(R.matlab)
require(ggplot2)
require(shiny)
require(shinydashboard)
require(shinythemes)
source("background_tabs.R")


#source the UI and server files
source("ui.R")#define the app presentation
source("server.R")#define the app logic

#4 Create shiny application ------------------------------------------
shinyApp(ui = ui, server = server)


