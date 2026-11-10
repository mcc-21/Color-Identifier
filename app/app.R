library(shiny)
library(bslib)
library(bsicons)
library(reticulate)
library(keras3)
library(tensorflow)

model <- load_model("image-class-model.keras")
color_classes <- read.csv("color-categories.csv")


#user interface
ui <- page_navbar(
  title= "Color Identifier",
  theme=bs_theme(version = 5) |>
    bs_add_variables(
      #"navbar-nav-margin-x" = "auto", #center main tabs
      "navbar-bg" = "#2B2B2B",#banner background
      "navbar-light-color" = "dodgerblue",
      "navbar-light-brand-color" = "dodgerblue",
      "navbar-light-active-color" = "dodgerblue",
      "navbar-light-hover-color" = "darkblue",),
  nav_panel(title= "Identify",
            p("Upload an image to identify the base color of the object shown."),
            layout_column_wrap(
              width=1/3,
              fixed_width = T,
              div(fileInput(inputId = "uploaded_image",
                            label = "Upload image here", #FOR NULL
                            placeholder = "Upload image here",
                            multiple = F,
                            accept = c("image/jpeg",
                                       "image/png",
                                       "image/jpg",
                                       ".jpeg",
                                       ".jpg",
                                       ".png"
                            )
              ),
              div(style= "height: 15px;"),
              value_box(                     #for output value
                title= "Colors Identified",
                value = uiOutput("model_results"), #changes based on user input
                showcase = bsicons::bs_icon("palette"),
                theme="primary"
              )
              )
            ) ),
  nav_panel(title= "About",
            p("The purpose of this app is to assist color identification for color-blind individuals using computer vision.\nThe user will upload a picture. The picture will be processed through our computer vision model powered by ResNetv50 through transfer learning.\nOur color detection model is initially trained on clothing articles.\nAs we develop, we aim to assist in color detection in other ways.")),
  nav_spacer(),
  nav_menu(title="Links",
           align = "right",
           nav_item(tags$a("GitHub", href="https:http://www.github.com/mcc-21"))
           )
)


#server logic
server <- function(input, output, session){
  output$model_results <- renderUI({
    req(input$uploaded_image) #requires upload
    message("Processing image....")
    image_name <- input$uploaded_image$name
    message("Image name is ", image_name)
    image_path <- input$uploaded_image$datapath
    message("Image path is ", image_path)
    message("Preparing image for analysis....")
    image <- image_load(image_path,
                        target_size = c(60,80))
    image_array <- (image_to_array(image)) / 255
    image_tensor <- array_reshape(image_array,
                                  c(1,
                                    dim(image_array)))
    
    predictions <- as.vector(model |> predict(image_tensor))
    print(paste0("Overall predictions: ", predictions))
    top_classes <- order(predictions, decreasing = T)[1:2] #Highest 2 predictions
    print(paste0("The top 2 predicted colors are: ", top_classes))
    color_1 <- color_classes$x[top_classes[1]]
    probability_1 <- round(predictions[top_classes[1]] * 100, 1)
    color_2 <- color_classes$x[top_classes[2]]
    probability_2 <- round(predictions[top_classes[2]] * 100, 1)
    
    HTML(paste0(
      "<div style='font-size: 15px; line-height: 1.5;'>",
      "<strong>Image:</strong> ", image_name, "<br><br>",
      "<strong>Top Colors Detected:</strong><br>",
      color_1, "(",probability_1, "%)<br>",
      color_2, "(", probability_2, "%)",
      "</div>"
    ))
    
    })
}


shinyApp(ui = ui, server = server)


