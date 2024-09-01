# COVID-19 UK Forecasting Web Application

## Overview

This project is an interactive web application designed to forecast the daily increase in COVID-19 infections and deaths in the United Kingdom. The app utilizes historical data from 2020 to 2021, a period when COVID-19 cases were highly prevalent, to generate predictions using the 'prophet' forecasting model. This application was developed as part of my final year dissertation at Brunel University London in 2021, during a time when much about the virus and its long-term impact was still unknown. The goal was to provide a tool for visualizing the potential future impact of the pandemic, considering significant factors such as lockdowns.

## Background and Motivation

The COVID-19 pandemic has profoundly affected the United Kingdom, placing it among the top fifteen most impacted countries globally. In 2021, as the pandemic unfolded, there was significant uncertainty regarding the future trajectory of infections and deaths. This uncertainty created a pressing need for reliable forecasting tools to predict potential outcomes and help in planning and decision-making. As part of my final year dissertation, I aimed to develop an interactive web application capable of forecasting COVID-19 infections and deaths within the UK. The motivation for this project arose from the critical need for data-driven insights during a global health crisis, especially when little was known about the virus's behavior over time.

## Problem Statement

The COVID-19 pandemic introduced a high level of uncertainty regarding the future trajectory of infections and deaths, particularly in a country as heavily impacted as the United Kingdom. In 2021, the limited availability of data and the rapidly changing nature of the pandemic made it difficult to predict the daily increase in COVID-19 cases and deaths accurately. Traditional forecasting methods were often insufficient, as they could not adequately account for the dynamic factors, such as government lockdowns, which played a crucial role in controlling the spread of the virus. The core problem addressed by this project was the need for a flexible and interactive tool that could incorporate these social factors and provide meaningful forecasts to assist policymakers, health professionals, and the public in making informed decisions.

## Solution

To address the problem, I developed an interactive web application using R and the 'Shiny' package, which integrates the 'prophet' forecasting model. The application forecasts the daily increase in COVID-19 infections and deaths in the UK over a period of 7 to 56 days. Key features of the solution include:

- **Incorporation of Lockdown Data:** The application integrates specific UK lockdown dates into the forecasting model, enabling the tool to reflect the potential impact of these social interventions on the spread of the virus.
- **User Interactivity:** Users can adjust the forecast period, toggle the inclusion of lockdown effects, and switch between viewing infection and death forecasts. This interactivity allows users to explore different scenarios and better understand the potential outcomes of the pandemic.
- **Data Cleaning and Anomaly Handling:** The application processes and cleans the data to minimize 'noise' and correct anomalies, such as those arising from government reporting errors, ensuring the accuracy and reliability of the forecasts.
- **Dynamic Visualization:** The web app dynamically displays forecasted data alongside actual historical data, providing a clear visual representation of potential future trends and allowing for real-time updates as new data becomes available.

## Features

- **Forecasting:** Predict COVID-19 infections and deaths for the next 7 to 56 days, with customizable options for users.
- **Lockdown Impact:** Analyze how UK lockdowns influenced COVID-19 trends. The application incorporates UK lockdown dates into the model to reflect their impact on infection and death rates.
- **Interactive Visualization:** View dynamic graphs and data tables showing both forecasted and actual data. The design process included multiple iterations from low-fidelity prototypes to a fully functional web app.
- **User-Friendly Interface:** Includes a help section with detailed information on using the app, understanding the data, and toggling features like lockdown effects.

## Data Source

The data used in this project is sourced from [COVID-19 Data Hub](https://covid19datahub.io/) (Guidotti and Ardia, 2020). The dataset was chosen for its accuracy, reliability, and timeliness, which were essential for producing meaningful forecasts during the uncertain times of 2021. Significant effort was placed on ensuring the data was clean, with minimal 'noise' and anomalies, such as correcting UK government data inconsistencies.

## Installation

### Prerequisites

- **R version 4.0 or above**
- The following R packages:
  - `shiny`
  - `shinythemes`
  - `COVID19`
  - `lubridate`
  - `ggplot2`
  - `dplyr`
  - `prophet`
  - `bit64` (for handling integer64 columns)

### Steps to Install

1. Install the required R packages by running:
   ```R
   install.packages(c("shiny", "shinythemes", "COVID19", "lubridate", "ggplot2", "dplyr", "prophet", "bit64"))
   ```

2. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/joaquincaps55/COVID19TSFWebApp.git
   ```

3. Set your working directory to the location of the cloned repository in RStudio.

4. Run the `app.R` script to start the application.

## Usage

Once the application is running, it will open in your default web browser. You can:

- Adjust the forecast period using the slider (7 to 56 days).
- Toggle the impact of lockdowns on the forecast to see how government interventions may affect future trends.
- View both the forecasted data and actual historical data in the provided tables.

### File Structure

- **`app.R`**: The main script containing the Shiny UI and server logic.
- **`README.md`**: This file, providing an overview and instructions for the project.

## Project Background

This web application was created as part of my final year dissertation at Brunel University London. The project followed a rigorous development process, starting with extensive background research, followed by iterative design and implementation stages. Key decisions included focusing on daily increase data rather than cumulative figures to avoid overwhelming users with large numbers, and integrating UK lockdown dates to enhance forecast accuracy. Testing phases were crucial to ensure the app's functionality, including handling edge cases like data anomalies.

## Acknowledgments

I would like to thank my supervisor, Martin Shepperd, for his invaluable insights and guidance throughout this project. Special thanks also go to my mentor, Jon Regan, for his assistance in structuring the methodology and for providing weekly motivation during the challenging times of the pandemic. Additionally, I am deeply grateful to my family for their unwavering support.

---

**Note:** Due to the reduced number of COVID-19 cases in recent months, the date range has been manually adjusted to focus on data from 2020 to 2021, when COVID-19 data was more prevalent and relevant for forecasting. This project was developed in 2021, during a time when the future trajectory of the pandemic was still largely unknown, and the tool was designed to help navigate this uncertainty.

---

## Contact

For any questions or suggestions, feel free to reach out via email at [joaquincapinpuyan@yahoo.co.uk](mailto:joaquincapinpuyan@yahoo.co.uk) or connect with me on [LinkedIn](https://www.linkedin.com/in/joaquin-capinpuyan-863235175). Also if you would like to view a copy of my full thesis report, please send me an email and I will be more than happy to send it!
