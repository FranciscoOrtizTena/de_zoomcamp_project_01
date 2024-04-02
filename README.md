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

### Automation and Updates
Recognizing the dynamic nature of Formula 1, where races occur frequently, it's imperative to keep the dataset current. To address this, we have implemented a trigger mechanism within Mage that automatically runs the pipelines on a weekly basis. This automation ensures that new race data, driver updates, and lap times are promptly reflected in our dataset following each Grand Prix, keeping our analysis relevant and timely.

![Trigger after the race is over](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/images/trigger_lap_races.png)

Here is a screenshot of the parquet files in GCS buckets

![Parquet files in GCS buckets](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/images/parquet_files.png)

## Data Loading and Optimization in BigQuery

#### Data Loading into BigQuery
Following the initial data preparation and storage in Google Cloud Storage, the next step involved loading the data into BigQuery for advanced analysis and query performance. Our project specifically focused on three critical tables: `lap_times`, `drivers`, and `races`. These tables were loaded into BigQuery, setting the stage for sophisticated data analysis and insight generation related to Formula 1 races, drivers' performance, and detailed lap times.

### Optimization of the Lap Times Table
Given the extensive amount of lap time data accumulated over the years of Formula 1 races, optimizing query performance was a key consideration. For the `lap_times` table, which contains detailed timing information for each lap in every race, we applied a clustering strategy based on the `race_id` column. Clustering is a technique used in BigQuery to organize data based on the contents of one or more columns. This approach significantly improves query performance by reducing the amount of data scanned during a query, thereby also lowering the cost of operations.

The decision to use clustering over partitioning was dictated by the nature of the `lap_times` table. Ideally, partitioning is a preferred method for organizing data in BigQuery, especially when dealing with time-series data, as it divides the table into segments, each holding data for a specific interval of time. However, partitioning requires a date or timestamp column, which the `lap_times` table lacks. This absence of a date-specific column in the `lap_times` data model made partitioning infeasible, leading to the choice of clustering by `race_id` as the most effective optimization technique.

### Clustering Implementation
To implement clustering on the `lap_times` table by `raceid`, the following SQL code was used in BigQuery:

```sql
-- Cluster by `raceID`
CREATE OR REPLACE TABLE `eminent-torch-412600.project_01.lap_times_optimized`
CLUSTER BY raceId AS
SELECT *
FROM `eminent-torch-412600.project_01.lap_times`;
```

This code snippet illustrates how we altered the table structure to include clustering, optimizing the storage and query performance based on the `raceId`. By doing so, queries that filter on this column can benefit from improved efficiency, as BigQuery can quickly locate the relevant data without scanning the entire dataset.

## Data Transformation with dbt

### Introduction to Transformation Phase
After successfully loading and optimizing the data within BigQuery, the next crucial step in our data engineering project involved transforming the data to facilitate deeper analysis. For this purpose, we employed dbt (data build tool), a powerful tool that enables data analysts and engineers to transform data in their warehouse more effectively. dbt allows for the definition of transformations as code, which can then be version-controlled, tested, and deployed in a manner similar to software development practices.

### Defining the Schema
The first step in our dbt transformation process was to define the schema for our data models. This involved specifying the structure of our final transformed tables, ensuring they were optimized for analysis purposes. The schema was carefully designed to accommodate the data from our three primary sources: `lap_times`, `drivers`, and `races`.

- Schema Definition Documentation: [Link to Schema Definition](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/models/staging/schema.yml)

### Loading Tables from BigQuery
With our schema defined, the next task was to load the three critical tables from BigQuery into dbt. This step was vital to make the raw data available for transformation. Each table was imported into dbt, setting the groundwork for the subsequent data transformation steps.

- `lap_times` Table Import: [Link to Lap Times Import](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/models/staging/stg_lap_times.sql)
- `drivers` Table Import: [Link to Drivers Import](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/models/staging/stg_drivers_id.sql)
- `races` Table Import: [Link to Races Import](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/models/staging/stg_race_ids.sql)

### Data Transformation and Table Union
Upon loading the tables into dbt, we proceeded with the transformation process. The goal was to create a unified view that combined elements from the `lap_times`, `drivers`, and `races` tables. This unified dataset was designed to enhance our analysis, providing a comprehensive view of the drivers' lap times across different races and seasons.

The [resulting_table](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/models/core/fact_laps.sql) included the following columns, designed to offer a rich dataset for our analysis:
- `year`: The year of the race season.
- `date`: The date of the race.
- `round`: The round number of the race within the season.
- `gran_prix`: The name of the Grand Prix.
- `driver_name`: The name of the driver.
- `nationality`: The nationality of the driver.
- `lap`: The lap number.
- `position`: The position of the driver at the end of the lap.
- `time`: The time taken to complete the lap.
- `milliseconds`: The lap time in milliseconds for more precise analysis.

### Data Lineage with dbt
An additional advantage of using dbt in our project is its ability to generate a data lineage graph. This graph visually represents the flow of data from the source tables through the various transformations, culminating in the final unified table. The lineage graph is an invaluable tool for understanding the dependencies and relationships between data models within our project.

- Data Lineage Visualization: ![Link to Data Lineage Graph](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/images/Linage.png)

By leveraging dbt for our data transformations, we've streamlined the process of preparing our Formula 1 dataset for in-depth analysis. The unified dataset not only simplifies the analytical process but also ensures that our insights are based on comprehensive and accurately transformed data.

## Optimization with Partitioning and Clustering in BigQuery

#### New Optimization Strategy
With the newly transformed table in BigQuery, combining data from `lap_times`, `drivers`, and `races`, we can further optimize query performance and cost efficiency through partitioning and clustering. Partitioning the table by the `date` column and clustering by `driver_name` provides a dual benefit: it organizes the data such that queries filtering by date or driver are significantly faster and more cost-effective, due to the reduced amount of data scanned.

### Implementing Partitioning by Date
Partitioning the table by the `date` column ensures that the data is divided into segments, each containing data for a specific day. This is particularly useful for time-series data like ours, as it aligns with the chronological nature of race events and analysis requirements.

### Implementing Clustering by Driver Name
Clustering by `driver_name` further refines the organization of the data within each partition. Since queries often involve filtering or aggregating data by driver, clustering on this column ensures that such operations are optimized, leading to quicker and cheaper queries.

### SQL Code for Partitioning and Clustering
To implement both partitioning by `date` and clustering by `driver_name` in BigQuery, the following SQL code snippet outlines the necessary commands:

```sql
CREATE OR REPLACE TABLE `eminent-torch-412600.dbt_fortiztena.fact_laps_optimized`
PARTITION BY DATE(date)
CLUSTER BY driver_name AS
SELECT
  *
FROM
  `eminent-torch-412600.dbt_fortiztena.fact_laps`;
```

This SQL command creates (or replaces if it already exists) a table in your specified dataset. It defines the table to be partitioned by the `date` column and clustered by `driver_name`. The `SELECT` statement at the end specifies the data that will populate this table, which should be modified according to the actual structure and name of your source table.

## Development of a Dashboard in Looker Studio

### Introduction to Dashboarding
The culmination of our data engineering and analysis project for Formula 1 datasets involves the creation of an interactive dashboard in Google Looker Studio. This dashboard is designed to visualize the insights derived from the data transformed through dbt and optimized in BigQuery, providing an intuitive and dynamic platform for exploring Formula 1 lap times and driver performances.

### Data Connection in Looker Studio
The first critical step in building our dashboard was establishing a connection to the transformed and optimized data in BigQuery. Looker Studio's ability to directly connect to BigQuery datasets allows for real-time data visualization and analysis, ensuring that our dashboard reflects the most up-to-date information.

### Dashboard Components
Once the data connection was established, we designed the dashboard to include two primary visualization tiles, enhancing the user's ability to interact with and explore the Formula 1 data:

1. **Lap Time Distribution Chart**: The first tile is a chart that visualizes the distribution of lap times for selected drivers. This visualization helps in understanding the consistency and performance of drivers across different laps and races. By examining the spread and central tendency of lap times, users can gauge a driver's efficiency and reliability on the track.

2. **Position Distribution Chart**: The second tile is a categorical chart that illustrates the percentage of laps a driver spent in each race position. This provides insights into a driver's competitiveness and their ability to maintain or improve their position throughout a race. Understanding position distribution is crucial for analyzing race strategy and driver skill in overtaking and defending positions.

### Interactive Filters
To enhance the dashboard's interactivity and user engagement, we incorporated three filters, allowing users to customize the data displayed according to their interests:

1. **Year Filter**: Enables users to select and view data from a specific year, focusing the analysis on a particular season.
2. **Grand Prix Filter**: Allows users to choose a specific Grand Prix to analyze, providing insights into driver performances on different circuits.
3. **Driver Filter**: Offers the ability to select one or more drivers, enabling detailed comparisons of driver performances and lap times.

### Dashboard Accessibility
The dashboard is hosted on Looker Studio, making it accessible to users with the link provided. Through this dashboard, users can interact with the data, explore various analytical dimensions, and derive their insights based on the comprehensive Formula 1 dataset.

- Dashboard Screenshot: ![Insert Screenshot Here](https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/blob/main/images/Dashboard.png)
- View the Dashboard: [Access the Dashboard Here](https://lookerstudio.google.com/s/ht2ytAG0_Ao)

### Leveraging Looker Studio for Insights
By utilizing Google Looker Studio, this project offers a powerful, interactive platform for Formula 1 fans, analysts, and enthusiasts to explore and analyze data in a user-friendly manner. The dashboard not only provides valuable insights into the intricacies of Formula 1 racing but also demonstrates the potential of data visualization in enhancing the understanding and appreciation of sports analytics. Through dynamic visualizations and interactive filters, users are equipped to uncover deep insights into the performance and strategies of Formula 1 drivers and teams.

## Conclusion

This project embarked on a comprehensive journey through the fascinating realm of Formula 1 data, harnessing the power of data engineering and analytics to unlock a deeper understanding of the sport's intricacies. By meticulously processing, transforming, and optimizing a rich dataset spanning decades of F1 history, we've laid a solid foundation for advanced analysis. The use of modern data engineering tools like dbt for transformation, BigQuery for data management and optimization, and finally, Google Looker Studio for visualization, highlights the project's innovative approach to sports analytics.

Our journey from raw data to insightful dashboards illustrates the potential of data-driven analysis in transforming how we understand sports performance and strategies. The dashboard, with its interactive filters and detailed visualizations, offers users a unique lens through which to explore the nuances of Formula 1 racing. It not only serves as a testament to the power of data visualization but also as a valuable resource for fans, analysts, and teams alike, providing new perspectives on driver performance, race strategies, and the evolution of the sport over time.

In conclusion, this project stands as a vivid example of how data engineering and analytics can bridge the gap between raw data and actionable insights. It underscores the importance of thoughtful data preparation, the power of cloud computing for data analysis, and the unparalleled insights offered by interactive data visualizations. As Formula 1 continues to evolve, the methodologies and technologies employed in this project will remain relevant, offering fresh insights and fostering a deeper appreciation for the sport's complex dynamics.
