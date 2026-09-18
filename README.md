# Color Identifier

Convolutional neural network backed color identifier API

## Overview

This project aims to evaluate transfer learning as a framework for image 
classification. Leveraging pre-trained models has the potential to shorten the deployment lifecycle, enabling 
faster transition from development to production. Additionally, using pre-trained models may improve accuracy, 
as they are often trained on larger and more diverse datasets than those available to individual research teams. 
Image classification is an ideal domain for this evaluation due to its computational intensity. Working with multi
class image data can use a lot of computing power and resources, so making the process more efficient is very 
important. Establishing a reliable framework in this area could significantly improve both the accuracy and 
timeliness of projects. Furthermore, computer vision applications are rapidly expanding, with impactful use 
cases such as assisting colorblind individuals, supporting medical diagnoses, and enhancing object detection in 
transportation systems. By identifying the most effective approach, whether through transfer learning or 
training from scratch, this project seeks to inform the development of a deployment-ready model suited for 
colorblind individuals.

## Dataset

The dataset chosen is a publicly, available collection of clothing images available at 
https://www.kaggle.com/datasets/paramaggarwal/fashion-product-images-dataset (Aggarwal). This dataset 
contains multiple types of clothing in various colors. Metadata attributes like price, base color, discounts, brand 
names, and more are recorded in detail. Base color will be the target. There are over 44,400 images in jpeg 
format. This data is owned by Param Aggarwal and hosted on Kaggle. 

## Model

CNN based on ResNet50 v2 sources from Keras/Tensorflow.

## Results

Show your performance screenshots here.

### Performance

<img width="500" height="800" alt="performance-plot" src="https://github.com/user-attachments/assets/65fb7e67-3f91-4ae6-98da-30846288d2fa" />




