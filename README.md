# [Interactive web service for PCA and CA analysis](https://rita94105.shinyapps.io/hw4-Rita94105/)

## Objective
- Create an interactive web service using ShinyApp to perform Principal Component Analysis (PCA) and Correspondence Analysis (CA).

<p align="center">
 <img src="/images/PCA.png" width="48%" height="48%" >
 <img src="/images/CA.png" width="48%" height="48%" >
<p/>

## Getting Started
1. **Integrate Example Script**: Integrating the folllowing script into a Shiny application. While `ggbiplot` is recommended for creating biplots in PCA, feel free to explore and use other packages suitable for PCA and CA if necessary.

```R
data(iris)
# log transform 
log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]

# apply PCA - scale. = TRUE is highly advisable, but the default is FALSE. 
ir.pca <- prcomp(log.ir,center = TRUE, scale. = TRUE)

library(ggbiplot)
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, groups = ir.species)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', legend.position = 'top')
print(g)
```

2.  **Installation of ggbiplot**: The `ggbiplot` package is not available on CRAN and must be installed from GitHub using the following command in RStudio:
```
devtools::install_github("vqv/ggbiplot")
```

3. **Connect Shinyapps.io with RStudio**:
   - In RStudio, manage your ShinyApps.io accounts by navigating to `Tools → Global Options → Publishing`. This setup is crucial for publishing your application.
     <p align="center">
     <img src="/images/shinyapp_on_rstudio.png" width="70%" height="70%" >
     <p/>   
4. **Preview Application**: After completing your Shiny application, preview it in the RStudio console using the appropriate command to initiate your app locally.
```
library(shiny)
shinyApp(ui = ui, server = server)
```

5. **Publish**:
   - On the preview screen, locate the `Publish` button in the upper right corner. Click it to deploy your application to [ShinyApps.io](https://www.shinyapps.io/).

<p align="center">
 <img src="/images/shinyapp_on_rstudio_2.png" width="60%" height="60%" >
<p/>
  
## Important Notes
- **R Version**: Ensure you are using R version 4 for this assignment.

## Reference
### Shiny
* [shinythemes](https://github.com/rstudio/shinythemes)
* [Mastering Shiny](https://mastering-shiny.org/action-layout.html#bootstrap)
* [Shiny基本介紹](https://suyenting.github.io/post/shiny-introduction/)
* [Shiny Dashboard與Shiny史上最全](https://ask.hellobi.com/blog/R_shequ/33916)
* [Shiny](https://shiny.posit.co/r/articles/build/layout-guide/)
* [Display code in Shiny](https://stackoverflow.com/questions/56842812/r-shiny-display-text-as-code-on-several-lines)
* [modalDialog](https://shiny.posit.co/r/reference/shiny/1.4.0/modaldialog)

### Bootstrap
* [Bootstrap Icons](https://icons.getbootstrap.com/)


### PCA
* [主成分分析](https://hackmd.io/@CILS110/rkK504C0)
* [主成分分析](https://r-stat.neocities.org/pca)
* [ggbiplot](https://github.com/friendly/ggbiplot)
* [ggbiplot-最好看的PCA作圖：樣品PCA散點+分組橢圓+主成分丰度和相關](https://www.796t.com/content/1548617075.html)
