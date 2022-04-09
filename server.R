require(devtools)
require(dashboardthemes)
#devtools::install_github("connolr3/eegdatasim")
#library(eegdatasim)
#require(eegdatasim)
require(gridExtra)
require(knitr)
require(R.methodsS3)
require(R.matlab)
require(ggplot2)
require(shiny)
require(shinydashboard)
require(shinythemes)
library('eegkit')
source("man.R")



server <- function(input, output) {
    output$noiseplot<-renderPlot({
    set.seed(123)
    usernoise<-noise(input$frames,input$n,input$srate)
    userpeak<-peak(frames=input$frames,epochs=input$n,srate=input$srate,peakfr=input$peakfreq,position=input$pos)
    usersignal<<-input$noiseamp*usernoise+input$peakamp*userpeak
    user_averaged_signal<<-signal.averaging(usersignal,frames=input$frames,epochs=input$n)

    userdata<-data.frame(c(1:input$frames),usernoise[1:input$frames],userpeak[1:input$frames],usersignal[1:input$frames],user_averaged_signal)
    names(userdata)<-c("x","noise","peak","sig","asig")
    p1<-ggplot(data=userdata, aes(x=x, y=noise)) +
      geom_line()+theme_classic() + xlab("")+ylab("")+ggtitle("Noise (first trial)")

    p1 <- p1 +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
                                                                                                      colour = "#ECF0F5",
                                                                                                      size = 0.5, linetype = "solid"),)
    p2<- ggplot(data=userdata, aes(x=x, y=peak)) +
       geom_line()+theme_classic() + xlab("")+ylab("")+ggtitle("Peak (first trial)")

    p2 <- p2 +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
                                                                                                     colour = "#ECF0F5",
                                                                                                     size = 0.5, linetype = "solid"),)
    p3<- ggplot(data=userdata, aes(x=x, y=sig)) +
       geom_line()+theme_classic() + xlab("")+ylab("")+ggtitle("Signal (first trial)")
    p3 <- p3 +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
                                                                                                     colour = "#ECF0F5",
                                                                                                     size = 0.5, linetype = "solid"),)

    grid.arrange(p1, p2,p3, ncol=3)
    })

    output$testplot<-renderPlot({
      set.seed(123)
      usernoise<-noise(input$frames,input$n,input$srate)
      userpeak<-peak(frames=input$frames,epochs=input$n,srate=input$srate,peakfr=input$peakfreq,position=input$pos)
      usersignal<<-input$noiseamp*usernoise+input$peakamp*userpeak
      user_averaged_signal<<-signal.averaging(usersignal,frames=input$frames,epochs=input$n)


      userdata<-data.frame(c(1:input$frames),user_averaged_signal)
      names(userdata)<-c("x","asig")


      p3<- ggplot(data=userdata, aes(x=x, y=asig)) +
        geom_line()+theme_classic() + xlab("")+ylab("")+ggtitle(paste("Averaged Signal (over",input$n," trials)"))
      p3 <- p3 +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
                                                                                                       colour = "#ECF0F5",
                                                                                                      size = 0.5, linetype = "solid"),)
      p3
    })


    observeEvent(input$frames, {
      x <- input$frames
      updateNumericInput(inputId = "pos",max=x)

    })




    output$hats<-renderTable({
      set.seed(123)
      usernoise<-noise(input$frames,input$n,input$srate)
      userpeak<-peak(frames=input$frames,epochs=input$n,srate=input$srate,peakfr=input$peakfreq,position=input$pos)
      usersignal<<-input$noiseamp*usernoise+input$peakamp*userpeak
      user_averaged_signal<<-signal.averaging(usersignal,frames=input$frames,epochs=input$n)

      user_hats<-est.sig.hat(user_averaged_signal,100,buffer_pc = input$pc/100)
      Parameter<-c("Mean", "SD","Variance")
      Estimates<-c(user_hats[1],user_hats[2],user_hats[2]^2)
      user_stan_data<<-(user_averaged_signal-user_hats[1])/user_hats[1]
      data.frame(Parameter,Estimates)
   })

     output$stanplot<-renderPlot({
       set.seed(123)
       usernoise<-noise(input$frames,input$n,input$srate)
       userpeak<-peak(frames=input$frames,epochs=input$n,srate=input$srate,peakfr=input$peakfreq,position=input$pos)
       usersignal<<-input$noiseamp*usernoise+input$peakamp*userpeak
       user_averaged_signal<<-signal.averaging(usersignal,frames=input$frames,epochs=input$n)
       user_hats<-est.sig.hat(user_averaged_signal,100,buffer_pc = input$pc/100)
       user_stan_data<<-(user_averaged_signal-user_hats[2])/user_hats[1]
       userdata<-data.frame(c(1:input$frames),user_stan_data)
       names(userdata)<-c("x","ssig")



       p<- ggplot(data=userdata, aes(x=x, y=ssig)) +
         geom_line()+theme_classic() + xlab("")+ylab("")+ggtitle("Standardised Signal ")
       p <- p +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
                                                                                                        colour = "#ECF0F5",
                                                                                                    size = 0.5, linetype = "solid"),)
       p


        })

     output$erpplot<-renderPlot({
        set.seed(123)
        usernoise<-noise(input$frames,input$n,input$srate)
        userpeak<-peak(frames=input$frames,epochs=input$n,srate=input$srate,peakfr=input$peakfreq,position=input$pos)
        usersignal<<-input$noiseamp*usernoise+input$peakamp*userpeak
        user_averaged_signal<<-signal.averaging(usersignal,frames=input$frames,epochs=input$n)
        user_hats<-est.sig.hat(user_averaged_signal,100,buffer_pc = input$pc/100)
        user_stan_data<<-(user_averaged_signal-user_hats[2])/user_hats[1]
        mypeak_range<<-find.ERP.range(user_stan_data,1.7)
        userdata<-data.frame(c(1:input$frames),user_averaged_signal,col="black")
        names(userdata)<-c("x","y","col")
        userdata[mypeak_range,3]<-"red"
        p<- ggplot(data=userdata, aes(x=x, y=y)) +
          geom_line(col=userdata$col)+theme_classic() + xlab("")+ylab("")+ggtitle("Av. Signal with ERP Identified")
        p <- p +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
                                                                                                       colour = "#ECF0F5",
                                                                                                       size = 0.5, linetype = "solid"),)
        p
       })



    output$optim<-renderTable({
      set.seed(123)
      usernoise<-noise(input$frames,input$n,input$srate)
      userpeak<-peak(frames=input$frames,epochs=input$n,srate=input$srate,peakfr=input$peakfreq,position=input$pos)
      usersignal<<-input$noiseamp*usernoise+input$peakamp*userpeak
      user_averaged_signal<<-signal.averaging(usersignal,frames=input$frames,epochs=input$n)
      user_hats<-est.sig.hat(user_averaged_signal,100,buffer_pc = input$pc/100)
      user_stan_data<<-(user_averaged_signal-user_hats[2])/user_hats[1]
      mypeak_range<<-find.ERP.range(user_stan_data,1.7)

      xis<<-mypeak_range
      yis<<-user_averaged_signal[mypeak_range]
      peak_center_estimate=which(user_averaged_signal==max(user_averaged_signal))
      pars<<-optimise.ERP(xis,yis,mysr=input$srate,pkcntr=peak_center_estimate[[1]])
      Parameter<-c("Frequency", "Amplitude")
      Actual<-c(input$peakfreq,input$peakamp)
      Estimate<-c(pars$par[1],pars$par[2])
      data.frame(Parameter,Actual,Estimate)
     })

     output$optimplot<-renderPlot({
       set.seed(123)
       set.seed(123)
       usernoise<-noise(input$frames,input$n,input$srate)
       userpeak<-peak(frames=input$frames,epochs=input$n,srate=input$srate,peakfr=input$peakfreq,position=input$pos)
       usersignal<<-input$noiseamp*usernoise+input$peakamp*userpeak
       user_averaged_signal<<-signal.averaging(usersignal,frames=input$frames,epochs=input$n)
       user_hats<-est.sig.hat(user_averaged_signal,100,buffer_pc = input$pc/100)
       user_stan_data<<-(user_averaged_signal-user_hats[2])/user_hats[1]
       mypeak_range<<-find.ERP.range(user_stan_data,2.1)
       
       xis<<-mypeak_range
       yis<<-user_averaged_signal[mypeak_range]
       peak_center_estimate=which(user_averaged_signal==max(user_averaged_signal))
       pars<<-optimise.ERP(xis,yis,mysr=input$srate,pkcntr=peak_center_estimate[[1]])
       
       pred<-pars$par[2]*cos(((xis-peak_center_estimate[[1]])*2*pi*pars$par[1])/input$srate)

       userdata<-data.frame(xis,yis,pred)
       p<- ggplot(data=userdata, aes(x=xis, y=yis)) +
         geom_point()+theme_classic()+geom_line(data = userdata,aes(x=xis,y=pred),col="red") + ylab("")+xlab(paste("Freq estimate: ",round(pars$par[1],2),". Amp Estimate:",round(pars$par[2],2),"."))+ggtitle("ERP with Prediction Overlay")
       p <- p +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
                                                                                                      colour = "#ECF0F5",
                                                                                                      size = 0.5, linetype = "solid"),)
       p
     })
      # output$powerplot<-renderPlot({
      #   my_ps<- power.determination(
      #     input$acc/100,
      #     freq = input$peakfreq,
      #     amp = input$peakamp,
      #     frames = input$frames,
      #     srate = input$srate,
      #     maxtrial = 20,
      #     averagingN = 50
      #   )
      #   userdata<-data.frame(c(1:20),my_ps$my_frequency_ps)
      #   names(userdata)<-c("xis","yis")
      #   p<- ggplot(data=userdata, aes(x=xis, y=yis)) +
      #     geom_point()+theme_classic()+ xlab("No. Trials")+ylab("Power")+ggtitle("Bernoulli P Estimation... within 10% of True Frequency")
      #   p <- p +theme(plot.background = element_rect(fill = "#ECF0F5"),panel.background = element_rect(fill = "#ECF0F5",
      #                                                                                                  colour = "#ECF0F5",
      #                                                                                                  size = 0.5, linetype = "solid"),)
      #   p
      # })




     # Downloadable csv of selected dataset ----
     output$downloadData <- downloadHandler(
       filename = function() {
         filename<-paste(substring(Sys.Date(),6,11),"my_eegdatasim",substring(Sys.time(),12,13),"-",substring(Sys.time(),15,16),".csv",sep="")
         paste(filename, sep = "")
       },
       content = function(file) {
         myinfo<-c("frames",input$frames, "srate",input$srate, "n",input$n)
         write.csv(c(myinfo,usersignal), file, row.names = FALSE)
       }
     )

}
