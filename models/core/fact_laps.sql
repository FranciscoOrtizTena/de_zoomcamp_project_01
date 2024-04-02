{{
    config(
        materialized='table'
    )
}}

WITH lap_times AS (
    SELECT *
    FROM {{ ref('stg_lap_times') }}
),
drivers_id AS (
    SELECT *
    FROM {{ ref('stg_drivers_id') }}
),
race_ids AS (
    SELECT *
    FROM {{ ref('stg_race_ids') }}
)

SELECT 
    r.year, -- Select the year of the race
    r.date, -- Select the date of the race
    r.round, -- Select the round of the race
    r.name AS gran_prix, -- Select the name of the race
    d.forename || ' ' || d.surname AS driver_name, -- Select the driver's name
    d.nationality, -- Select the driver's nationality
    lt.lap, -- Select the lap number
    lt.position, -- Select the position of the driver in this lap
    lt.time, -- Select the lap time
    lt.milliseconds -- Select the lap time in milliseconds
FROM 
    lap_times AS lt -- From the lap times table
INNER JOIN 
    race_ids AS r ON lt.raceId = r.raceId -- Join with the race IDs table on matching raceId
INNER JOIN 
    drivers_id AS d ON lt.driverId = d.driverId -- Join with the drivers ID table on matching driverId
