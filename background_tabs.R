intro_panel <- tabPanel(
  "Home",
  titlePanel("EEGdatasim"),
  p("This is a Shiny App for EEG data that was developed in 2022. It is designed to aid understanding of the EEGdatasim.R and serves as a tutorial to it.
  Functionality is as following; "),
  p("   - Simulates and displays EEG data"),
  p("   - Performs Signal Averaging on Sample Data"),
  p("   - Estimates the frequency and amplitude of ERP from Sample EEG Data"),
  p("   - Calculates the Power of an sample EEG trial based on Monte Carlo Estimation "),
  strong(p("Project Background")),
  p("This project involves building a synthetic data generator and statistical power calculation engine
  for a prospective study on depression. Statistical power is used by researchers as an approximate measure
  of the reliability of a study. Studies which are under-powered can lead to false conclusions from trial data.
  Modern studies typically use data from multiple data sources, and getting a reliable estimate of the power
  involves considering the design of the study as well
  as authentic  representation of all the sources of uncertainty arising during the study.
  Synthetic data generation enables modelling of uncertainty at all levels of the study. "),
  strong(p("About the Project")),

  p("This Shiny App was created as part of a final year project for Management Science and
  Information Systems Studies (MSISS).
  This project was completed by Rose Connolly, under the supervision of Dr. Jason Wyse.
  The client is the Whelan Lab, Trinity College Institute of Neuroscience."),
  p("The project title is \"Simulation model for psychology studies with EEG markers\"."),
  strong(p("How it works",style = "font-size:18px")),
  em(p("It is important to read the backgrounds for each section prior to using simulation to understand the functionality.")),
  p("Functionality of EEGDataSim can be divided into 4 components.
  This Shiny App allows individual exploration of each of these components.
  "),#
  p("   - Data Simulation and Signal Averaging"),
  p("   - Identifying ERPs"),
  p("   - Parameter Estimation"),
  p("   - Power Estimation"),
  p("This Shiny app should be explored in number order given. Change the parameters on the left to explore different types of signals. Any additional parameters needed for a section can be changed on the main part of the page. "),

  p("Included for each section is a written background page. These pages descrive the functionality involved in EEGdatasim, and gives examples of the package in use. It is reccomended users read these pages before exploring simulation in order to understand what the simulation involves.",style = "font-size:17px"),
  br(),br(),br(),br(),
  strong(p("Additional Links/References")),
  h4(a(href = "https://data.mrc.ox.ac.uk/data-set/simulated-eeg-data-generator", "Original Matlab Data Simulation ")),
  h4(a(href = "http://www.whelanlabtcd.org/", "The Whelan Lab")),
  h4(a(href = "https://github.com/connolr3/eegdatasim", "EEGdatasim Package hosted on Github")),
  h4(a(href = "https://github.com/connolr3/eegdatasim_shiny", "This Shiny App Code on Github")),
  br(),
  h4( "Email - connolr3@tcd.ie")

)




background_panel<-   tabPanel("Introduction",tags$style("p, div {font-size:17px}"),

  strong(p("About the Project")),
  p("This page gives a ",em(span("brief"))," background to EEGs and ERPs for a non-professional user."),
  strong(p("EEGs",style = "font-size:17px")),

  p("An electroencephalogram (EEG) is a test used to find problems related to electrical activity of the brain. An EEG tracks and records brain wave patterns. Small metal discs with thin wires (electrodes) are placed on the scalp, and then send signals to a computer to record the results.
  The following image shows the international 10:20 system, a recognized standard measure of electrode placement in an EEG. As we can see, the odd numbers are on the left, even on right.",br(),"(Other systems include the international 10:10, where distances between electrodes is 10% only... hence there are a lot more electrodes placed on scalp.)
  "),img(src="eegcap.jpg",height="400",width="400"),
  br(),
  p("The letters stand for brain areas such as Central, Frontal, Parietal. The 10:20 relates to the way the area of the head is split into 10% or 20% between electrodes."),
  p("There are four types of EEG patterns including alpha waves, beta waves, theta waves and delta waves. Each of these patterns can be said to have two  properties: amplitude and frequency."),
  img(src="waves_table.png"),br(),br(),
br(),
  strong(p(" Event-Related Potentials (ERP)  ")),
  p("An event-related potential  is the measured brain response that is the direct result of a specific sensory, cognitive, or motor event.  The study of the brain through ERPs provides a non-invasive means of evaluating brain functioning. ",br(),"For example, an EEG would be conducted to see how the brain responds to a bright light. The response to the light can be seen within the signal as an ERP. ",br(),"ERPs use similar equipment to EEG, i.e. electrodes attached to the scalp. However, the key difference is that a stimulus is presented to a
  participant (for example a picture/sound) and the researcher looks for activity related to that stimulus."),
  p("An EEG not measuring ERPs would present no stimulus.   "),
  p(" Yet, when we conduct an EEG, there are thousands of ongoing processes... it's near impossible to pick out the response to one single stimulus (i.e. the ERP). But what we can do is repeat the trial many times and average out all the 'noise'... we are left with the relevant waveform... the ERP! "),
  br(),br(),strong(p("2 ERP Theories")),

  p("Researchers have proposed different theories of how ERP works or its mechanism of action.",strong(span("Classical")),"and ",strong(span("Phase Reset")),"."),

  p("Basically as Makinen et al., (2005) say 'the generation mechanism of event-related responses remains unclear...
    Event-related responses are assumed to be generated either",br(),"(1) separately of ongoing, oscillatory brain activity (**Classical**)",br(),"or",br(),"(2) through stimulus-induced reorganization of ongoing activity (**Phase Reset**).'"),
  br(),br(),br(),
  p("(1) The ",strong(span("Classical"))," theory implies that evoked and ongoing activities are separate and distinct neuronal phenomena. The stimulus 'evokes' an additive, phase-locked response in each trial.",br(),"(2) According to the ",strong(span("phase-resetting"))," view, upon the onset of a stimulus, the phases of the ongoing background oscillations become aligned (phase-reset or partial phase-reset) to the stimulus. By averaging the stimulus-locked trials, the phase-locked oscillatory activity emerges as an evoked component.  "),
  br(),br(),br(),
  p("Note that EEGdataSim.R is built for Classically Simulated data. Functionality is provided for both simulation theories but the rest of the functionality (ERP, identification,estimating power etc.) is built and designed for Classically Simulated data.",br(),"This is due to Client preferences, as the classical theory is the more popular in studies."),

  br(),br(),br(),
  strong(p("Additional Links ")),
  p("See examples below of debates of the two theories;"),
  a("<https://pubmed.ncbi.nlm.nih.gov/17459593/#:~:text=On%20the%20other%20hand%20the,on%20cognitive%20neuroscience%20is%20discussed.>"),br(),
  a("<https://www.sciencedirect.com/science/article/pii/S1053811904006275>"),
  a("<https://www.sciencedirect.com/science/article/pii/S1053811905006609>"),br(),br(),br(),
  a(href = "https://www.researchgate.net/figure/The-additive-and-phase-resetting-theory-of-evoked-response-generation-A-The-additive_fig2_47718739", "Click here for a good visual of the difference in the two theories... (classical theory is also called additive)")


  )


background1.2_panel<-   tabPanel("1.2 Background: Data Simulation",
                                 strong(p("Simulated EEG data generator for R")),
  a(href="https://data.mrc.ox.ac.uk/data-set/simulated-eeg-data-generator","Adapted for R from matlab version"),
  p("All functions adapted from Rafal Bogacz and Nick Yeung, Princeton Univesity, December 2002 versions in Matlab.",br(),"Data is generted using two theories: Classical and Phase Reset.  "),
  br(),
  strong(p("Classical Theory (AKA Evoked Model, Additive Model)")),
  p("ERP signal (peak function) is assumed buried in EEG noise (noise function)  "),
  p("According to the classical view, peaks in ERP waveforms reflect phasic bursts of activity in one or more brain regions that are triggered by experimental events of interest. Specifically, it is assumed that an ERP-like waveform is evoked by each event, but that on any given trial this ERP 'signal' is buried in ongoing EEG 'noise'."),

  br(),
  strong(p("Noise")),
  p("'Noise is generated such that its power spectrum matches the power spectrum of human EEG.'",br(),"
  The matlab folder contained a 'meanpower.mat' file, a 1X125 data file containing data. This data is based off mean power of actual human EEG data, and used to compute the power of simulated data.
  I read this into R using 'R.matlab' library. The noise function returns a vector containing EEG sample signals."),
  p("In essence this function has 3 parameters: ",br(),"1st describing the length of a single trial of the signal by the number of samples,",br()," 2nd describing the number of trials, and ",br(),"3rd describing sampling frequency. ",br(),"Hence to generate one trial of 0.8s of noise with sampling frequency 250Hz;"),
  code("mynoise = noise (200, 1, 250)  "),
  br(),
  p("The value of the first parameters describing the number of samples was computed by multiplying the duration of the noise by the sampling frequency, i.e. 0.8 * 250 = 200.
  250Hz means that there are 250 small electrical charges measured every second, so 0.8 seconds has 200 occurrences of these small electrical charges.
  The sampling frequency/rate is the number of samples per second taken from the continuous signal, giving us discrete data.",br(),"   For example: if the sampling frequency is 44100 hertz, a recording with a duration of 60 seconds will contain 2,646,000 samples."),
  img(src="noise1.2.png"),br(),
   img(src="noise1.png"),br(),
  p("Note: This noise function was adapted for efficiency from the Matlab version. The Matlab version used loops which was too slow in R. The function was adapted to use matrices and apply functions to reduce the time complexity. However, the statistical process is identical."),
  p("And so one Trial of Classical Theory Noise looks like;" ),br(),
  img(src="noise3.PNG"),br(),
  img(src="noise2.PNG"),br(),
  p("This 'noise' is representative of thousands of ongoing brain processes that appear in the EEG."),


  br(),
  strong(p("Peak")),
  em(p("Parameters 1-3 same as Noise")),
  p("To generate a peak with frequency 5Hz and center in 115th sample;  "),
  code("mypeak = peak (200, 1, 250, 5, 115)"),br(),
  img(src="peak1.PNG"),br(),
  p("And so one Trial with just the Classical Theory Peak looks like;" ),br(),
  img(src="peak2.PNG"),br(),
  img(src="peak3.PNG"),br(),br(),br(),


  strong(p("Signal: Combining Peak and Noise")),
  p("We can combine the noise and peak.  If we want to make the peak negative, we can multiply mypeak by -1 before addition.
  Amplitude can be scaled up/down by multiplying the vector before addition."),
  img(src="signal1.PNG"),br(),
  img(src="signal2.PNG"),br(),
  img(src="signal3.PNG"),br(),
  img(src="signal4.PNG"),br(),
  br(),br(),


  p("Basically, what we have above by combining the peak and noise is what we would get when we conduct an EEG to measure an ERP. A response to stimulus - the ERP as a peak and ongoing activity as the noise - both combined with each other.",br(),"It is NB to note that we have multiplied the peak by 12 for ease of visualisation. In reality, the ERP is very hard to distinguish from background noise.",br(),"To see the actual brain's response to a stimulus, you must conduct many trials and average the results together, causing random brain activity ('noise') to be averaged out and the relevant waveform to remain -  the ERP ('peak')."),
  em(p("The next Step is to Average the signal")),br(),br(),br(),br(),br(),br(),
  p("EEGdatasim provides functionality for Phase Reset Theory Data Simulation, however, the rest of the package functionality is built for Classicaly Simulated Data only.")



)
#----------------------------------------------
background1.3_panel<-   tabPanel("1.3 Background: Signal Averaging",
                                 strong(p("Averaging the signal to drown out the Noise")),
  p("We cannot identify the ERP in one of these trials.",br(),"However, say we conduct 30 trials... we can average out the noise to be left with the ERP"),
  img(src="sa1.PNG"),br(),
  img(src="sa2.PNG"),br(),br(),
  p("If we conducted less trials, say 10, we cannot identify the ERP well as some noise remains."),
  img(src="sa3.PNG"),br(),br(),br(),
  p("If we conducted lots of trials, say 100, the noise is nearly completely averaged out and the ERP is readily identifiable. "),
  img(src="sa4.PNG"),br(),br(),br(),
  p("Once we have averaged the signal, the ERP is identifiable by eye."),
  em(p("The next stage, however, is to be able to identify the ERP analytically."))

  )




#----------------------------------------------
background2.1_panel<-   tabPanel("2.2 Background: ERP Identification",
                                 strong(p("ERP Identification")),
  p("So far, we have simulated data and used signal averaging to drown out the noise. ",br(),"Visualising the Signal we are left with:")    ,
  img(src="erp1.PNG"),br(),
  p("Once we have averaged the signal, the ERP is identifiable by eye. Yet we need an analytical method of identifying the ERP. This is what this step is concerned with."),
  br(),p("This step involves;"),
  p(" -> Standardizing the data based on the SD and mean of the Noise."),
  p(" -> This means all/most of the noise is re-scaled to fall between [-2,2]"),
  p(" -> If there is a large segment outside this range, it is likely the ERP."),
  p(" -> Taking the center of the peak, or if not known - Identifiying the maximum part of the averaged signal (top of the ERP)"),
  p(" -> With this max point, going left and right either side of the ERP until we fall back into the noise data again… (fall under 1.7)."),
  br(),p("We will look at this in more detail below."),br(),br(),br(),

  strong(p("Standardising the data")),
  p("'Data standardization is about making sure that data is internally consistent; that is, each data type has the same content and format. Standardized values are useful for tracking data that isn’t easy to compare otherwise.'"),
  p("Standardising the data means that no matter the amplitude/ size of the EEG signal… we have a consistent method of identifying the ERP. No matter how large or small… we can scale the data to fall within the same range each time so our analytical methods are consistently used each time."),
  p("Typically, to standardize variables, you calculate the mean and standard deviation for a variable. Then, for each observed value of the variable, you subtract the mean and divide by the standard deviation."),
  p("We need a standard deviation and a mean based ONLY on the noise part of the data…. This is so that when we scale the data… the ERP won’t shrink down too much and we can identify it as not typical of the noise data."),
  p("The following function calculates the SD and mean of the noise part of the signal. The position of the peak center is a parameter to be specified, but defaults to the absolute max of the signal (allowing for negative ERP). Buffer_pc is the percentage of data either side of this position you want to omit from the SD/mean calculation…. The default is 0.25 which is very conservative…. as it omits 25% either side of the ERP from the calculation… 50% of the data in total…"),
  img(src="erp2.PNG"),br(),
  img(src="erp3.PNG"),br(),br(),
  p("Now, Standardise the data "),br(),
  img(src="erp4.PNG"),br(),
  img(src="erp5.PNG"),br(),br(),br(),br(),


  strong(p("Identify the ERP based on standardisation")),
  p("The following function identifies the ERP, The 'data' input is the standardised, averaged signal. The function finds the ERP, first by identifying the max of the data.
  ",br(),"As the signal has been standardised, the max of the signal will contain the max of the ERP. Then the function takes ERP values as those left and right of this max point that are above a certain cutoff. As we can see, the ERP continues below the default cutoff of 2, so a value of 1.7 woud be appropriate."),
  img(src="erp6.PNG"),br(),
  img(src="erp7.PNG"),br(),br(),br(),br(),
  p("So we have identified the ERP by; - Estimating what the mean and standard deviation of the noise is. Using this mean and sd to standardise the entire signal. - Standardised data should fall within [-2,2]… so anything outside the range is atypical of the data."),
  p("We identify data outside this range as the ERP."),
  em(p("We have the ERP, the next step we take is in a different direction. Now that we have the ERP location, we will work backwards and attempt to identify what freqeuncy and amplitude caused this peak.")),
  br(),p("As we simulated the data, we know the true value and can compare the estimate."),br(),br(),br(),
  )





background3.1_panel<-   tabPanel("3.2 Background: Parameter Estimation",
                                 strong(p("Estimating Parameters")),

   p("So far, we have simulated data, and used signal averaging to drown out the noise. ",br(),"Then we estimated the mean and sd of the noise part of the signal, and used these to standardise the data.",br()," Based on standardising, we identified the ERP part of signal as that which was outside a certain range.
",br(),"We have the ERP, the step we are now going to take is in a different direction. Now that we have the ERP location, we will work backwards and attempt to identify what freqeuncy and amplitude caused this peak.
",br(),"As we simulated the data, we know the true value and can compare the estimate.
So we start with ",br(),"1) standardised signal",br()," 2) The estimated ERP range."),
   img(src="pe1.PNG"),br(),br(),br(),
   img(src="pe2.PNG"),br(),
   p("So now we have estimated the peak range, we split the signal and take just the region where the ERP is estimated to be."),



   strong(p("Estimate Peak Parameters (Amplitude/Frequency)")), em(strong(p("By Optimisation"))),
   p("Using 'Optim' library to estimate parameters, a loss function is minimised. The loss function is the SSE",br()," (observed minus predicted value)^2"),
   p("Before we estimate the parameters, we will look at the functions and what they do...",br(),"
We want to estimate the frequency of the ERP (this is the frequency of a best fit cos). This also helps us figure out the width of the ERP, which is useful for some studies. We also want to see how high the ERP is (the amplitude)."),
   p("So we are estimating;"), p(" -> Amplitude"), p(" -> Frequency (can be used for width)"),
   br(),br(),p("The Cos function we will be manipulating will look like;"),
   em(p("The parameters in bold are the ones we are estimating.")),
   code("",strong("amp")," x cos((x-offset) x 2pi x ",strong("frequency")," / srate)"),br(),br(),
   p("srate is just our sampling frequency, which is always known in the trials...",em(p("In this example it is 250Hz.")),),
  p("Offset allows us to shift the cos left or right to fit the peak... For these signals we have simulated... this happens to be the Peak center position"),
  br(),br(),br(),
  p("We will use Optim in R, with the BFGS method. The gradient is supplied (derivative of SSE) to speed BFGS up. As BFGS requires a one-dimensional problem (estimaing one parameter only) - the cos is rewritten slightly from above to express ampltidue in other terms so that just frequency is estimated. "),
  strong(p("'The function optim provides algorithms for general-purpose optimisation. Optim minimises a function by varying its parameters.'")),
  p("With this function, we can get a prediction for a value of X. We can compare with with what the actual observation was. If we sum this difference for every predicted value, it will give us an idea of how good a fit the function was. Before we sum them however, they are squared so that any negative values don’t cancel out positive ones.",br(),"
This sum is known as the SSE (Sum Square Errors) and the parameters that give us the lowest SSE are optimal...",br(),"
This is what the functionality fo the below two functions cover."),
  img(src="pe3.PNG"),br(),
  p("As OPTIM has to iterate over a large number of values... it can sometimes miss the correct one. So if you have any idea of the true value, it can be passsed into OPTIM as a starting value for iteration. Therefore we will start the estimate for amplitude as the maximum value of the ERP."),
  img(src="pe4.PNG"),br(),
  img(src="pe5.PNG"),br(),
  img(src="pe6.PNG"),br(),
  img(src="pe7.PNG"),br(),
  img(src="pe8.PNG"),br(),
  img(src="pe9.PNG"),br(),
  img(src="pe10.PNG"),br(),
  img(src="pe11.PNG"),br(),br(),br(),

  p("We can see how the fitted cos shape overlaid on the actual ERP data;"),
  img(src="pe12.PNG"),br(),
  p("We can also overlay the entire Cos wave for sake of visualisation."),br(),
  img(src="pe13.PNG"),br(),
  p("So, we have functionality to estimate parameters of the ERP. The final step is concerned with Power. We want to know how reliable our estimates are."),
  em(p("In the next and final step we look at Monte Carlo Methods for estimating the Power of EEGdatasim.R.")),br(),br(),br(),br(),br(),br()


)

