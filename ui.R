library(shiny)
library(data.table)
library(ggplot2)

# ui.R

procedures <- fread("data/procedures.csv")

shinyUI(
        
        fluidPage(
                h1("Medicare Provider Utilization & Payment Data"),
                h2("Visualizations for the Triangle Region of North Carolina"),
        
                sidebarLayout(
                        sidebarPanel(
                                p("Show the distribution of Medicare charges according to 2014 Medicare Provider Payment Data."),
                                br(),
                                selectInput("proctype",
                                            "Choose the type of procedure:",
                                            choices = list("Cardiac stress test", "Colonoscopy with biopsy", "Colonoscopy with lesion removal", "CT abdomen/pelvis with contrast", "CT abdomen/pelvis without contrast", "Outpatient visit for new patient", "Screening mammogram", "Diagnostic mammogram"),
                                            selected = "Outpatient visit for new patient"),
                                br(),
                                radioButtons("setting",
                                        "Choose the provider setting:",
                                        choices = list("Facility", "Non-facility"),
                                        selected = "Facility"),
                                helpText("Facility generally includes inpatient/hospital services and non-facility generally captures outpatient/clinic services"),
                                br()
                        ),
                        
                        mainPanel(
                                plotOutput("dotplot"),
                                p("The average Medicare charge (in dollars) for Durham is:", textOutput("Durham")),
                                p("The average Medicare charge (in dollars) for Chapel Hill is:", textOutput("Chappel_Hill")),
                                p("The average Medicare charge (in dollars) for Raleigh is:", textOutput("Raleigh")),
                                br(),
                                h3("Welcome"),
                                p("This web app is a window into the Medicare Fee-for-Service Provider Utilization & Payment Data Physician and Other Supplier Public Use File, which can be found here:", a("http://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier.html")),
                                p("Medicare is public insurance for the elderly and disabled. In 2010, Medicare covered ~50 million Americans. The full data set includes 9 million rows, organized such that each row is a specific service/procedure performed by a specific provider/organization. Thus, each healthcare provider has separate entries for each service provided to Medicare recipients."),
                                p("This app drills down to look closely at the Triangle region of North Carolina. Three major health systems compete for services in this region; Duke in Durham, UNC in Chappel Hill, and WakeMed in Raleigh. This app enables a high-level comparison of Medicare charges for a small subset of common procedures."),
                                br(),
                                h3("Data Processing"),
                                p("This web app uses data for the subset of providers who practice in the cities of Durham, Chapel Hill, and Raleigh. Only individual providers are included in the data set, excluding healthcare providers that bill as organizations."),
                                br(),
                                h3("About the author"),
                                p("This page was built by Mark Dakkak, an MD/MPP student at Duke University who is a data science enthusiast.")
                                )
                )
        )
)