library(shiny)
library(data.table)
library(ggplot2)

procedures <- fread("data/procedures.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

        output$dotplot <- renderPlot({
                
                ggplot(procedures[hcpcs_description == input$proctype & place_of_service == input$setting], aes(x = nppes_provider_city, y = average_submitted_chrg_amt, size = line_srvc_cnt)) + geom_point(alpha = 3/4) + theme_bw() + labs(title = paste("Distribution of charges for:", input$proctype, sep =" "), x = "", y = "Average Submitted Charge by Provider (in dollars, $)") + scale_size_continuous(name = "Total Number of \nServices Provided") + ylim(0,round(max(procedures[hcpcs_description == input$proctype, average_submitted_chrg_amt], digits = -1)))
        })
        
        Durham <- reactive({mean(procedures[hcpcs_description == input$proctype & place_of_service == input$setting & nppes_provider_city == "DURHAM", average_submitted_chrg_amt])})
        output$Durham <- renderText({Durham()})
        
        Chappel_Hill <- reactive({mean(procedures[hcpcs_description == input$proctype & place_of_service == input$setting & nppes_provider_city == "CHAPEL HILL", average_submitted_chrg_amt])})
        output$Chappel_Hill <- renderText({Chappel_Hill()})
        
        Raleigh <- reactive({mean(procedures[hcpcs_description == input$proctype & place_of_service == input$setting & nppes_provider_city == "RALEIGH", average_submitted_chrg_amt])})
        output$Raleigh <- renderText({Raleigh()})
})