library(shiny)
library(shinydashboard)
library(shinythemes)
library(bslib)
library(bsicons)


pca_info_ui <- function(){
  fluidPage(
    fluidRow(
      column(width = 12,
             h3("About PCA:"),
             br(),
             p("Principal Component Analysis (PCA) is a statistical method used for data dimensionality reduction and feature extraction."),
             p("It transforms the original data through linear transformations into a set of linearly uncorrelated variables called principal components, aiming to reduce the dimensionality of the data while retaining the maximum variability."),
             p("The goal of PCA is to find a new coordinate system in which the variance of the data is maximized."),
             p("The principal components are typically arranged in descending order of variance, so selecting the most important principal components allows for dimensionality reduction while preserving as much information from the original data as possible."),
             p("PCA finds applications in various fields including data compression, data visualization, feature selection, and pattern recognition."),
             br(),
             h4("Data Normalization"),
             p("In PCA, we first normalize the original data for subsequent analysis. Normalization involves subtracting the mean from the data and then dividing by the standard deviation."),
             withMathJax(helpText('$$\\mathscr{z} = \\frac {(\\mathscr{x} - \\mu)} {\\sigma}$$')),
             p("The normalized data will have the property of having a mean of 0 and a standard deviation of 1."),
             br(),
             h4("Covariance"),
             p("It describes the degree of joint variation between two variables, and its calculation formula is:"),
             withMathJax(helpText('$$\\mathscr{Cov(f1,f2)} = \\frac {1}{N-1} \\sum_{i=1}^N (f_{i1} - \\widetilde{f_1}) (f_{i2} - \\widetilde{f_2})$$')),
             withMathJax(helpText('f1,f2 are variables, and others are means')),
             br(),
             h4("PCA Process"),
             p("The PCA process involves the following steps:"),
             tags$ul(
               tags$li("Normalize the data by subtracting the mean and dividing by the standard deviation."),
               tags$li("Calculate the covariance matrix of the normalized data."),
               tags$li("Compute the eigenvectors and eigenvalues of the covariance matrix."),
               tags$li("Sort the eigenvectors by decreasing eigenvalues to obtain the principal components."),
               tags$li("Project the original data onto the principal components to obtain the transformed data.")
             )
      )
    )  
  )
}

pca_ui <- function(){
  fluidPage(
    titlePanel("PCA of Iris Dataset"),
    sidebarLayout(
      sidebarPanel(
        helpText("Visualizing PCA Results"),
        selectInput("x_axis", "X-axis:", choices = c("PC1", "PC2", "PC3", "PC4")),
        selectInput("y_axis", "Y-axis:", choices = c("PC1", "PC2", "PC3", "PC4"))
      ),
      mainPanel(
        plotOutput("pca_plot")
      )
    )
  )
}

ca_info_ui <- function(){
  fluidPage(
    fluidRow(
      column(width = 12,
             h3("About Correspondence Analysis (CA):"),
             br(),
             p("Correspondence Analysis (CA) is a multivariate statistical technique used to analyze the association between two categorical variables."),
             p("It is an extension of Principal Component Analysis (PCA) for categorical data."),
             p("CA is used to explore relationships between categorical variables and visualize the patterns of association in a contingency table."),
             p("The goal of CA is to represent the rows and columns of the contingency table as points in a low-dimensional space, where the distances between points reflect the strength of association between categories."),
             p("CA is widely used in fields such as market research, social sciences, and bioinformatics for analyzing categorical data and identifying patterns of association."),
             br(),
             h4("Contingency Table"),
             p("A contingency table is a table that displays the frequency distribution of two or more categorical variables."),
             p("The rows and columns of the table represent the categories of the variables, and the cells contain the frequencies or counts of observations that fall into each category."),
             br(),
             h4("CA Process"),
             p("The CA process involves the following steps:"),
             tags$ul(
               tags$li("Construct a contingency table from the categorical data."),
               tags$li("Calculate the expected frequencies of the contingency table under the assumption of independence."),
               tags$li("Calculate the residuals between the observed and expected frequencies."),
               tags$li("Perform singular value decomposition (SVD) on the residuals to obtain the principal components."),
               tags$li("Plot the rows and columns of the contingency table in the space defined by the principal components.")
             )
      )
    )  
  )
}

ca_ui <- function(){
  fluidPage(
    titlePanel("Correspondence Analysis of Iris Dataset"),
    sidebarLayout(
      sidebarPanel(
        helpText("Visualizing Correspondence Analysis Results"),
        sliderInput("k", "Number of Clusters:", value = 3, min = 3, max = 10),
      ),
      mainPanel(
        plotOutput("ca_plot")
      )
    )
  )
}

ca_result <- function(){
  fluidPage(
    titlePanel("Correspondence Analysis Result"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("k", "Number of Clusters:", value = 3, min = 3, max = 10),
      ),
      mainPanel(
        dataTableOutput("ca_result")
      )
    )
  )
}

code_viewer <- function(){
  fluidPage(
    fluidRow(
      column(width = 12,
             h3("Code Viewer:"),
             h4("UI Code:"),
             verbatimTextOutput("ui_code"),
             br(),
             h4("Server Code:"),
             verbatimTextOutput("server_code"),
             br(),
             column(width = 12, align = "center",
                    actionButton(inputId = "git",label="Github", 
                                 icon = icon("github"), 
                                 onclick ="window.open('https://github.com/Rita94105', '_blank')")
             ),
             br()
             
      )
    )
  )
}

iris_info_ui <- function() {
  fluidPage(
    fluidRow(
      column(width = 12,
             h3("About Iris Flower:"),
             br(),
             p("The Iris flower is a genus of 260–300 species of flowering plants with showy flowers."),
             p("The flowers are typically large, showy, and brightly colored, with flowers in shades of purple, white, yellow, pink, and blue."),
             p("Iris is a popular garden flower and has many cultivars developed for horticultural use."),
             p("The three most common species in the iris dataset are setosa, versicolor, and virginica."),
             br(),
             img(src = "https://media.licdn.com/dms/image/D4D12AQF5vivFTAdZjQ/article-cover_image-shrink_600_2000/0/1700911428185?e=2147483647&v=beta&t=RaJufpE5-ZMvIMZFVTy4dNtvnKHVgmThtTORx-_qu6Q",
                 height = 300, width = 600)
      )
    )
  )
}

iris_dataset_ui <- function() {
  fluidPage(
    fluidRow(
      column(width = 12,
             h3("About Iris Dataset:"),
             br(),
             p("The Iris dataset is a well-known dataset in the field of statistics and machine learning."),
             p("It contains 150 observations of iris flowers, with measurements for sepal length, sepal width, petal length, and petal width."),
             p("The dataset is often used for classification tasks, such as predicting the species of an iris flower based on its measurements."),
             p("It is also frequently used for data visualization and exploration purposes."),
             hr()
      )
    ),
    fluidRow(
      column(width = 12,
             sidebarLayout(
               sidebarPanel(
                 selectInput("x", "X-Axis Variable:", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
                 selectInput("y", "Y-Axis Variable:", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
                 radioButtons("plot_type", "Plot Type:", choices = c("Histogram", "Scatterplot"))
               ),
               mainPanel(
                 plotOutput("iris_plot")
               )
             )
      )
    )
  )
}

ui <- navbarPage(
  "Shiny",
  theme = bs_theme(version = 4, bootswatch = "simplex"),
  navbarMenu("Data",
             tabPanel("Iris Flower Information", iris_info_ui()),
             tabPanel("Iris Dataset Usage", iris_dataset_ui()),
             tabPanel("Iris Raw Data", mainPanel(
               dataTableOutput("iris_data")))
  ),
  navbarMenu("PCA",
             tabPanel("PCA Introduction", pca_info_ui()),
             tabPanel("PCA plot",pca_ui()),
             tabPanel("PCA Result",mainPanel(
               dataTableOutput("pca_result"))),
             tabPanel("Log Transformed Data",mainPanel(
               dataTableOutput("log_data"))),
             tabPanel("extended result",mainPanel(
               plotOutput("extended_result_plot")))
  ),
  navbarMenu("CA",
             tabPanel("CA Introduction", ca_info_ui()),
             tabPanel("CA plot", ca_ui()),
             tabPanel("CA Result", ca_result())
  ),
  tabPanel("Code", code_viewer())
)
