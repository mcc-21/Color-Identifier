
library(plumber)
library(reticulate)
library(keras3)
library(base64enc)


color_identifier <- load_model("image-class-model.keras")
color_classes <- read.csv("color-categories.csv")

#register_parser("multi", parser_multipart, fixed = "multipart/form-data")

#* Image classification webpage
#* @get /
function() {
  '
<!DOCTYPE html>
<html>
<head>
<title>Image Classifier</title>
</head>
<body style="font-family:Arial;text-align:center;padding:50px">

<h2>Image Classification</h2>

<input type="file" id="image" accept="image/*">

<br><br>

<button onclick="predict()">Predict</button>

<h3 id="result"></h3>

<script>
async function predict() {

  const file = document.getElementById("image").files[0];

  if (!file) {
    alert("Please select an image");
    return;
  }

  const formData = new FormData();
  formData.append("image", file);

  document.getElementById("result").innerHTML = "Predicting...";

  const response = await fetch("/predict", {
    method: "POST",
    body: formData
  });

  const data = await response.json();

  document.getElementById("result").innerHTML =
    data.predictions.map(p =>
      p.class + " : " + (p.probability * 100).toFixed(2) + "%"
    ).join("<br>");
}
</script>

</body>
</html>
'
}

#* Predict image class
#* @param image:file
#* @post /predict
#* @serializer json
function(image) {
  
  img <- image_read(image[[1]])
  
  img <- image_resize(img, "60x80!")
  
  img <- image_convert(img, colorspace = "sRGB")
  
  x <- image_data(img, channels = "rgb")
  
  x <- as.integer(x) / 255
  
  x <- aperm(x, c(3, 2, 1))
  
  x <- array(x, dim = c(1, 60, 80, 3))
  
  # Model prediction
  probabilities <- as.numeric(predict(color_identifier, x))
  
  # Top 2
  top2 <- order(probabilities, decreasing = TRUE)[1:2]
  
  list(
    predictions = lapply(top2, function(i) {
      list(
        class = color_classes[i],
        probability = probabilities[i]
      )
    })
  )
}

