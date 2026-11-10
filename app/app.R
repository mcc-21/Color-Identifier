library(shiny)
library(bslib)
library(bsicons)

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
            p("Upload an image to identify the base color of the object shown.")),
  nav_panel(title= "About",
            p("The purpose of this app is to assist color identification for color-blind individuals using computer vision.\nThe user will upload a picture. The picture will be processed through our computer vision model powered by ResNetv50 through transfer learning.\nOur color detection model is initially trained on clothing articles.\nAs we develop, we aim to assist in color detection in other ways.")),
  nav_spacer(),
  nav_menu(title="Links",
           align = "right",
           nav_item(tags$a("GitHub", href="https:http://www.github.com/mcc-21"))
           ),
  nav_panel(
    "Color Identification",
    layout_column_wrap(
      width=1/3,
      fixed_width = T,
      div(fileInput(inputId = "image_loaded",
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
            showcase = bs_icons::bs_icon("palette"),
            theme="primary"
          )
      )
  ) 
))


#server logic
server <- function(input, output){
  
}


shinyApp(ui = ui, server = server)


