# Company Bankruptcy Prediction

This project aims to predict company bankruptcy using machine learning techniques, specifically Random Forest models. The analysis includes data exploration, visualization, and model training using R.

## Table of Contents
- [Dependencies](#dependencies)
- [Data](#data)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Model Training](#model-training)
- [Results](#results)

## Dependencies

The project uses the following R packages:
- pacman
- tidyr
- ggthemes
- ggplot2
- plotly
- GGally
- rio
- stringr
- shiny
- rmarkdown
- lubridate
- psych
- ipred
- caret
- ROCR
- pROC
- DT
- rpart
- rpart.plot
- httr
- randomForest
- readr

You can install these packages using the `pacman::p_load()` function as shown in the script.

## Data

The dataset is loaded from a CSV file named "data.csv". It contains information about various companies, including a binary indicator of bankruptcy (1 for bankrupt, 0 for not bankrupt).

## Exploratory Data Analysis

The script performs several exploratory data analysis steps:
1. Checking for missing values
2. Visualizing the frequency of bankruptcy
3. Plotting histograms for all 95 independent variables
4. Creating a correlation matrix heatmap
5. Generating density plots for independent variables by bankruptcy status

## Model Training

Two Random Forest models are trained using different cross-validation settings:
1. Model 1a: 3-fold cross-validation with 2 repeats
2. Model 1b: 5-fold cross-validation with 3 repeats

The models are trained on 70% of the data, with the remaining 30% used for testing.

## Results

The script generates confusion matrices and variable importance plots for both models. The results can be used to evaluate model performance and identify the most important predictors of company bankruptcy.

To run the analysis, simply execute the R script in your preferred R environment.
