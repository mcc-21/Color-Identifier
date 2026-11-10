# Color Identifier

Convolutional neural networked backed color identifier API
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

### Performance

<img width="500" height="800" alt="performance-plot" src="https://github.com/user-attachments/assets/65fb7e67-3f91-4ae6-98da-30846288d2fa" />

### mlflow

<img width="941" height="508" alt="mlflow_ui" src="https://github.com/user-attachments/assets/2569f75b-c3c0-4603-ac24-67a51f4c6f23" />

### Initial RShiny App

<img width="960" height="404" alt="first-app-run" src="https://github.com/user-attachments/assets/f93c31a4-0e50-416c-aa45-bc2b0ab94922" />

#### Image Used

<img width="554" height="554" alt="shirt-download" src="https://github.com/user-attachments/assets/339ab29b-9bdc-499a-ab7d-f3bdfa45763c" />

## Areas of Improvement

1. Improve target color distribution by stricter group labeling, and more even distribution of photos for classes.
   <img width="2100" height="2100" alt="target-color-distribution" src="https://github.com/user-attachments/assets/e0f742d1-a4e0-47a7-a1a3-4e89bc5c9400" />
2. Check consistent color labeling among data splits.
3. Improve hyperparameter tuning and add more epochs.
4. Add more data augmentation strategies to processing or improve those metrics.

## Overall Project Workflow
1. Data ingestion
2. Data exploration/augmentation
3. Model training
4. Model evaluation
5. mlflow tracking
6. R Shiny App deployment


