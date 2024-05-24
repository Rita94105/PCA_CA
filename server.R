library(shiny)
library(ggbiplot)
library(factoextra)
library(FactoMineR)
library(bslib)

shinyServer(
  function(input,output){
    observe({
      showModal(modalDialog(
        title = "Welcome to my Shiny Apps!",
        HTML("Hi everyone,<br> 
             My name is Rita<br> 
             Hope you have a great day and enojoy my analysis!"),
        easyClose = TRUE,
        footer = NULL
      ))
    })
    
    iris_data <- iris
    
    # Reactive function to perform PCA
    perform_pca <- reactive({
      log.ir <- log(iris[, 1:4])
      ir.species <- iris[, 5]
      ir.pca <- prcomp(log.ir, center = TRUE, scale. = TRUE)
      return(ir.pca)
    })
    
    output$pca_plot <- renderPlot({
      pca_result <- perform_pca()
      x_col <- switch(input$x_axis,
                      "PC1" = pca_result$x[,1],
                      "PC2" = pca_result$x[,2],
                      "PC3" = pca_result$x[,3],
                      "PC4" = pca_result$x[,4])
      y_col <- switch(input$y_axis,
                      "PC1" = pca_result$x[,1],
                      "PC2" = pca_result$x[,2],
                      "PC3" = pca_result$x[,3],
                      "PC4" = pca_result$x[,4])
      
      ggbiplot(pca_result, obs.scale = 1, var.scale = 1, groups = iris$Species, ellipse = TRUE) +
        scale_color_discrete(name = '') +
        theme(legend.direction = 'horizontal', legend.position = 'top') +
        geom_point(aes_string(x = x_col, y = y_col)) +
        stat_ellipse(aes_string(x = x_col, y = y_col, color = iris$Species), 
                     type = "norm", level = 0.95, geom = "polygon", alpha = 0.2)
    })
    
    output$pca_result <- renderDataTable({
      log.ir <- log(iris[, 1:4])
      ir.species <- iris[, 5]
      ir.pca <- prcomp(log.ir, center = TRUE, scale. = TRUE)
      
      # Create a data frame with PC1-4 values
      pca_data <- as.data.frame(ir.pca$x[, 1:4])
      colnames(pca_data) <- paste0("PC", 1:4)
      
      # Return the data frame
      pca_data
    })
    
    output$log_data <- renderDataTable({
      # Log transform the data
      log_iris <- log(iris[, 1:4])
      
      # Return the log-transformed data
      log_iris
    })
    
    output$extended_result_plot <- renderPlot({
      #Perform PCA calculation
      log.ir <- log(iris[, 1:4])
      ir.species <- iris[, 5]
      ir.pca <- prcomp(log.ir, center = TRUE, scale. = TRUE)
      
      # Plot inertia
      fviz_eig(ir.pca, addlabels = TRUE, ylim = c(0, 50))
    })
    
    output$ca_plot <- renderPlot({
      iris_data <- iris[, -5]
      
      # K-means clustering
      set.seed(123)
      kmeans_result <- kmeans(iris_data, centers = input$k, nstart = 25)
      
      # Adding cluster result to the data
      iris_data$cluster <- as.factor(kmeans_result$cluster)
      
      # Creating a contingency table for CA
      contingency_table <- table(iris_data$cluster, iris$Species)
      
      # Correspondence Analysis (CA)
      ca_result <- CA(contingency_table, graph = FALSE)
      
      # Plotting
      fviz_ca_biplot(ca_result, 
                     repel = TRUE, # Avoid text overlap
                     col.row = iris_data$cluster[match(rownames(contingency_table), iris_data$cluster)],
                     palette = "jco",
                     geom = "arrow",
                     ellipse.type = "confidence",
                     legend.title = "Cluster") +
        labs(title = "K-means Clustering with Correspondence Analysis")
    })
    
    output$ca_result <- renderDataTable({
      iris_data <- iris[, -5]
      
      # K-me    ans clustering
      set.seed(123)
      kmeans_result <- kmeans(iris_data, centers = input$k, nstart = 25)
      
      # Adding cluster result to the data
      iris_data$cluster <- as.factor(kmeans_result$cluster)
      
      # Return the data frame with cluster information
      iris_data
    })
    
    output$ui_code <- renderPrint({
      cat(readLines("ui.R"), sep = "\n")
    })
    
    output$server_code <- renderPrint({
      cat(readLines("server.R"), sep = "\n")
    })
    
    output$iris_plot <- renderPlot({
      x_var <- input$x
      y_var <- input$y
      
      if (input$plot_type == "Histogram") {
        ggplot(iris_data, aes_string(x = x_var)) +
          geom_histogram(fill = "skyblue", color = "black", bins = 30) +
          labs(x = x_var, y = "Frequency", title = paste("Histogram of", x_var))
      } else {
        ggplot(iris_data, aes_string(x = x_var, y = y_var, color = "Species")) +
          geom_point() +
          labs(x = x_var, y = y_var, color = "Species", title = "Scatterplot of Iris Dataset")
      }
    })
    
    output$iris_data <- renderDataTable({
      iris
    })
  }
)
