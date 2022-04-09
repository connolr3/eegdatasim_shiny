require(devtools)
require(dashboardthemes)
#devtools::install_github("connolr3/eegdatasim")
#library(eegdatasim)
source("man.R")
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

 #The Data Sim Panel----------------------------------------------
noise_panel <- tabPanel(
  title = "1.1 Data Simulation",
  titlePanel("EEG Data Simulation"),
  h4("Change the parameters in the sidebar. If you require greater
       flexibility in parameter choice, please use EEGdatasim.R directly."),
 # noise_selection,
plotOutput("noiseplot"),
hr(),

titlePanel("1.2 Signal Averaging"),
plotOutput("testplot")
)


#The ERP Identification Panel ----------------------------------------------
erp_id_panel <- tabPanel(

  "2.1 ERP Identification",
 # noise_selection,
 # noise_selection,
  titlePanel("ERP Identification"),
 h4("Change the parameters in the sidebar. If you require greater
       flexibility in parameter choice, please use EEGdatasim.R directly."),
  strong("Data Standardisation"),
 sliderInput("pc", "Buffer Percentage",
             min = 0, max = 30, value = 4
 ),
 radioButtons("pos_choice","Peak Position Estimation",choices=c("Use actual Peak Position"="actual","Estimate Peak Position based on Max"="default"),selected ="Use actual Peak Position" ),
#  plotOutput("stanplot"),
tableOutput("hats"),
plotOutput("stanplot"),
  strong("Estimate ERP"),
  plotOutput("erpplot")
)


#The Estimating Parameters Panel----------------------------------------------
 estimating_params_panel <- tabPanel(
   "3.1 Estimating Parameters",
   titlePanel("Estimating Parameters"),
   h4("Change the parameters in the sidebar. If you require greater
       flexibility in parameter choice, please use EEGdatasim.R directly."),
   tableOutput("optim"),
   plotOutput("optimplot")
 )


#The Power Panel---------------------------------------------
 power_panel <- tabPanel(
   "4.2 Background: Power Determination",
   titlePanel("Power"),
   # sliderInput("averagingn", "No. Estimations to Average Over",
   #             min = 10, max =200 , value = 100
   # ),
   # sliderInput("acc", "Acurracy Window (%)",
   #             min = 4, max =40 , value = 10
   # ),
   # sliderInput("maxn", "Max No. Of Trials",
   #             min = 0, max = 120, value = 50
   # ),
   # plotOutput("powerplot"),

   strong(p("What are we doing?")),
   p("For a certain set of experiment conditions (i.e a specific number of trials and sampling frequency) and expected outcome (i.e. we suspect the frequency of the ERP will be about 7Hz.) - we can simulate expected data from a prosepctive experiment.
   Using the methods from the previous 3 steps, we can average this data, identify the ERP range and estimate the frequency and amplitude of the ERP.
   ",br(),"As we simulated the data ourselves, we can compare the actual versus estimated parameters, and see how accurate we were. "),
   p("Using the methods from the previous 3 steps, we can average this data, identify the ERP range and estimate the frequency and amplitude of the ERP.
   As we simulated the data ourselves, we can compare the actual versus estimated parameters, and see how accurate we were. "),
   p("Let’s say an experimenter is going to conduct an EEG experiment with 30 trials, and expects the ERP to have a frequency of 7Hz.
   We can simulate noise and peaks for a 30 trial EEG with an ERP of frequency 7.
   Then we can see if we could predict the frequency (give or take 5%)."),
   p("We can do this 100 times, and we might be able to accurately predict the frequency of the ERP, say, 78 times (0.78). ",br(),"
   However, the experimenter might decide they want to run a more accurate experiment. If they did the above for 50 trials, now they accurately predict the ERP 93 times out of 100 (p=93). They are happy with this, so with their specific set of experimental conditions, they decide to run 50 trials instead of 30."),

   br(),
   strong(p("Monte Carlo Simulation for Power Analysis")),
    p("Monte Carlo simulation provides us with a flexible way to run power analysis.
    It is often used to investigate the performance of statistical estimators (in this case, estimators of the ERP frequency and amplitude) under various conditions. It can also be used to decide on the sample size needed for a study and to determine power (Muthén & Muthén, 2002)."),

   br(),strong(p("How accurate is accurate?")),
   p("The Power Determination Function in eegdatasim calculates the number of times the frequency is accurately identified. If the frequency was 7 however, it is very unlikely we can predict the frequency as 7 exactly. Therefore, the user specifies the ",strong("accuracy window.")," A window of 5%, classifies estimates from 6.65 to  7.35 as a correct estimate."),
   br(),
   strong(p("Functionality")),
   img(src="power1.PNG"),br(),
 
  br(),br(),br(),br(),br(), em(p("Muthén, L.K. and Muthén, B.O., 2002. How to use a Monte Carlo study to decide on sample size and determine power. Structural equation modeling, 9(4), pp.599-620."))
 )

power_interactive_panel <- tabPanel(
   title = "4.1 Power Determination",
   titlePanel("Power Determination"),
   # noise_selection,
   p("As power.determination has a long run-time, some pre-run output is visualised below."),
   p("If you require, use EEGdatasim.R directly."),
   hr(),
   
   p("As this function has a large time complexity, some output is already visualised below.
  The plotted increase mimics the cdf of a Bernoulli Distribution."),
   p("The Plot shows the proportion of times the frequency was accurately estimates (+/- 10%), when the true frequency was 7, and amplitude was 5"),
   p("For each number of trials (1 to 120), data was generated 100 times, and frequency estimated."),
   img(src="power_determination_plot.png"),br(),
   p("if you wanted to obtain accuracy of 0.8, you would have to conduct 21 trials... based on this Monte Carlo Simulation."),
   img(src="21trials.png"),br(),
   p("User Input functionality is not provided here as the time complexity is too large. However if you require greater flexibility, please use EEGdatasim.R directly "),
   em(p("In general, the following holds:")),
   p("As we would expect, the predictions are more accurate the more trials are conducted. "),
   p("A higher frequency causes the ERP to narrow and makes OPTIM less accurate. So if you are measuring a brain response that is known to have a higher frequency, more trials may be required. "),
   p("A higher peak amplitude differentiates the ERP and makes it easier to identify the ERP."),
   
   
 )
 
 
#  The Nav Bar-----------------------------------------------------
mynav<- navbarPage(
  theme = shinytheme("cosmo"),#other theme choices - https://rstudio.github.io/shinythemes/
  "",
  intro_panel,
  background_panel,
  navbarMenu("1. Data Sim",noise_panel,background1.2_panel,background1.3_panel),
  navbarMenu("2. ERP Identification",erp_id_panel,background2.1_panel),
  navbarMenu("3. Parameter Estimation",estimating_params_panel,background3.1_panel),
  navbarMenu("4. Power Determination",power_interactive_panel,power_panel),

)


#  The Dashboard Page-----------------------------------------------------
dashboardPage(
  dashboardHeader(title="EEGDataSim.R"),
  dashboardSidebar(sidebarMenu(
    menuItem("Change Parameters below;", tabName = "dashboard"),
    p("__________________________"),
    downloadButton("downloadData", "Download Simulated Data"),
    p("__________________________"),
    sliderInput("srate", "Sampling Frequnecy (Hz)",
                min = 0, max = 500, value = 250
    ),
    sliderInput("n", "No. Of Trials",
                min = 0, max = 250, value = 50
    ),
    sliderInput("frames", "Length (frames) of single trial",
                min = 0, max = 400, value = 200
    ),h4("______________________"),
    sliderInput("pos", "Position of Peak",
                min = 0, max = 400, value = 100
    ),
    sliderInput("peakfreq", "Peak Frequency",
                min = 0, max = 30, value = 7
    ),
    h4("_____________________"),
    numericInput("noiseamp", "Noise Amplitude:", 2, min = 1, max = 10),
    numericInput("peakamp", "peak (ERP) Amplitude:", 7, min = 1, max = 15)
  ) ),
  dashboardBody(
    # shinyDashboardThemes(
    #      theme = "poor_mans_flatly"
    #    ),
    mynav)
)




