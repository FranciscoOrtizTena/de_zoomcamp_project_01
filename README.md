# Project Description

## Title: Analyzing Formula 1 Lap Times: A Data Engineering Perspective

### Introduction
The world of Formula 1 (F1) is not just a spectacle of speed, precision, and competitive spirit; it is also a treasure trove of data waiting to be explored and understood. With decades of history, the sport offers an extensive dataset that encapsulates the essence of racing, including the minutiae of lap times, the profiles of drivers, and the specifics of races across different eras and circuits worldwide. This project aims to dive into the rich dataset from Formula 1 races, focusing specifically on lap times, drivers, and races. By leveraging data engineering techniques, we seek to uncover patterns, trends, and insights that lie hidden within the raw data, providing a deeper understanding of the dynamics of F1 racing.

### Objective
The primary objective of this project is to perform a comprehensive analysis of the Formula 1 dataset, with a particular focus on lap times, drivers, and races. Through this analysis, we aim to identify patterns and insights that could offer a deeper understanding of performance trends, driver efficiency, and race strategies over the years. Additionally, this project seeks to demonstrate the application of data engineering and analysis techniques in handling large-scale, complex datasets, thereby showcasing the potential of data science in the realm of sports analytics.

### Data Description
The dataset for this project is derived from a comprehensive collection of Formula 1 data available on [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020/data?select=races.csv), which includes detailed records spanning from the inception of the FIA Formula One World Championship in 1950 through to the latest season in 2023. For the purpose of this project, the analysis will concentrate on the following tables:
- `lap_times.csv`: This table contains detailed lap-by-lap data for every driver in each race, including lap times.
- `drivers.csv`: This table provides information on F1 drivers, including their names, nationalities, and other personal details.
- `races.csv`: This table lists all the races, including details about the circuit, the date, and the specific round of the championship.

These tables collectively offer a multifaceted view of the sport, allowing for a nuanced analysis of driver performance, race characteristics, and temporal trends in lap times.

### Expected Outcomes
The project aims to produce a series of outcomes that will contribute to the understanding of Formula 1 racing dynamics. These include:
- A comprehensive analysis report detailing findings on lap times, driver performance, and race characteristics.
- Visualizations that highlight trends, patterns, and outliers in the data.
- A demonstration of the application of data engineering and analytics techniques in sports data analysis.

By dissecting the intricacies of lap times in relation to drivers and races, this project aims to offer new insights into the sport of Formula 1, providing a deeper understanding for fans, teams, and stakeholders alike. Through the lens of data engineering, we explore the past to understand the present and anticipate the future of Formula 1 racing.

## Data Pipeline Design and Orchestration Using Mage for Formula 1 Dataset

### Overview
In the quest to analyze the intricate details of Formula 1 races, drivers, and lap times, efficient management and processing of data are paramount. To achieve this, we have designed a robust data pipeline architecture utilizing Mage, a leading workflow orchestration tool. Our pipeline is structured to ensure seamless data loading, transformation, and exportation, facilitating a continuous flow of updated information for analysis. This architecture is crucial for handling the dataset encompassing lap times, driver profiles, and race details.

### Pipeline Structure
Each table within our dataset - namely `lap_times.csv`, `drivers.csv`, and `races.csv` - is processed through a dedicated pipeline composed of three main blocks:

1. **Data Loader**: This initial block is responsible for loading the data from its source. Given the vast amount of historical and current Formula 1 data, it's essential to have a reliable and efficient loading process to ensure all relevant data is captured accurately for analysis.

2. **Transformer**: Post data loading, the transformer block plays a pivotal role. Here, data undergoes various transformations to refine and structure it for analysis. A key focus is on schema creation and ensuring that date-related columns are appropriately handled. This step is vital for maintaining the integrity and usability of the data, especially considering the historical depth of the dataset which requires accurate time-series analysis.

3. **Data Exporter**: The final block in our pipeline deals with exporting the transformed data. In this case, the data is securely sent to a Google Cloud Storage bucket as a parquet file. This step ensures that the data is not only stored in a centralized location but is also readily available for analysis and further processing.

### Code Repository
For transparency and collaboration, the code for each data pipeline is here:
- [lap_times](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/workflow_orchestration/project_laptimes_to_gcs.md)
- [drivers](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/workflow_orchestration/pipeline_drivers_id.md)
- [races](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/workflow_orchestration/pipeline_race_ids.md)

This repository provides detailed instructions and scripts needed to replicate or extend the pipelines, ensuring that the project remains open for future enhancements and contributions.

#### Automation and Updates
Recognizing the dynamic nature of Formula 1, where races occur frequently, it's imperative to keep the dataset current. To address this, we have implemented a trigger mechanism within Mage that automatically runs the pipelines on a weekly basis. This automation ensures that new race data, driver updates, and lap times are promptly reflected in our dataset following each Grand Prix, keeping our analysis relevant and timely.

![Trigger after the race is over](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/images/trigger_lap_races.png)

#### Conclusion
Through careful planning and the application of modern data engineering practices, we have established a data pipeline framework that stands at the core of our Formula 1 data analysis project. This framework not only ensures the efficient handling of data through its lifecycle but also supports continuous updates, thereby laying a solid foundation for uncovering insights into the world of Formula 1 racing.
