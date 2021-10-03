-- =========================================
-- Author: Laura Zsolyom
-- CreateDate: 22/09/2021
-- Description: Calculates progress of death toll per EU27 countries
-- Tableau dataset: 4 confirmed death toll EU27
-- Tableau vizualization: https://public.tableau.com/app/profile/laura.zsolyom/viz/Explanationofcovid-19vaccinationprogress/Explanationofcovid-19vaccinationprogress
-- =========================================


WITH EU_Countries AS (
  SELECT
    date,
    country_code,
    country_name,
   -- aggregation_level,
    subregion1_code,
    subregion1_name,
    new_confirmed,
    new_deceased,
    population
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
   WHERE  country_name IN ('Austria',  'Italy', 'Belgium',  'Latvia', 'Bulgaria', 'Lithuania', 'Croatia', 'Luxembourg', 'Cyprus', 'Malta', 'Czech Republic', 'Netherlands', 'Denmark',  'Poland', 'Estonia', 'Portugal', 'Finland', 'Romania', 'France', 'Slovakia', 'Germany', 'Slovenia', 'Greece', 'Spain', 'Hungary', 'Sweden', 'Ireland')
      AND aggregation_level = 0 
  ORDER BY 3,1,5
 
 )


SELECT
  date,
  country_code,
  country_name,
  SUM(new_confirmed) AS new_confirmed,
  SUM(new_deceased) AS  new_deceased,
  MIN(population) AS population
FROM EU_Countries 
GROUP BY 1,2,3
ORDER BY 2,1
 

