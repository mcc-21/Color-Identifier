
library(plumber)
library(reticulate)
library(keras3)
library(base64enc)


color_identifier <- load_model("image-class-model.keras")
color_classes <- read.csv("color-categories.csv")

#register_parser("multi", parser_multipart, fixed = "multipart/form-data")


#* @apiTitle Color Identifier
#* @predict
function(){
  list(status = paste0("The purpose of this API is to assist individuals with color blindness."))
}


#* Log incoming requests for debugging
#* @filter logger
function(req) {
  cat(as.character(Sys.time()), "-", req$REQUEST_METHOD, req$PATH_INFO, "\n")
  plumber::forward()
}

#* Predict the top 2 highest classes from a JPEG/PNG file upload
#* @serializer json
#* @param image:file 
#* @post /predict
function(req, res) {
  
  # Get uploaded image
  image <- req$files$image
  
  # Check image upload
  if (is.null(image)) {
    res$status <- 400
    return(list(
      error = "Please upload an image"
    ))
  }
  
  # Get uploaded image path
  image_path <- as.character(image$datapath)
  
  # Check file existence
  if (!file.exists(image_path)) {
    res$status <- 400
    return(list(
      error = "Uploaded image not found"
    ))
  }
  
  # Open image
  img <- tryCatch({
    
    Image$open(image_path)
    
  }, error = function(e) {
    
    message("Image error: ", conditionMessage(e))
    NULL
    
  })
  
  if (is.null(img)) {
    res$status <- 400
    return(list(
      error = "Invalid image file"
    ))
  }
  
  # Load image into memory
  img$load()
  
  # Validate image format
  image_format <- as.character(img$format)
  
  if (!image_format %in% c("JPEG", "PNG")) {
    res$status <- 400
    return(list(
      error = "Only JPG, JPEG and PNG images are allowed"
    ))
  }
  
  # Convert image to RGB
  img <- img$convert("RGB")
  
  # Resize image
  # Model input: (60, 80, 3)
  # PIL expects (width, height)
  img <- img$resize(tuple(60L, 80L))
  
  # Convert image to array
  img_array <- tf$keras$utils$img_to_array(img)
  
  # Add batch dimension
  img_array <- np$expand_dims(
    img_array,
    axis = 0L
  )
  
  # Normalize image
  # Use only if normalization was applied during training
  img_array <- img_array / 255.0
  
  # Predict image
  predictions <- color_identifier$predict(img_array)
  
  # Convert predictions to R vector
  probs <- as.numeric(
    predictions$numpy()[1L, ]
  )
  
  # Validate predictions
  if (length(probs) != 37 ||
      length(color_classes) != 37) {
    
    res$status <- 500
    
    return(list(
      error = "Model must return 37 class predictions"
    ))
  }
  
  # Get top 2 predicted classes
  top2 <- order(
    probs,
    decreasing = TRUE
  )[1:2]
  
  # Extract only class labels
  output <- unname(color_classes[top2])
  
  # Return results
  return(list(
    status = "success",
    predictions = output
  ))
}
