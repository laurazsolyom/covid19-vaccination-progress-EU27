-- =========================================
-- Author: Laura Zsolyom
-- CreateDate: 22/09/2021
-- Description: Calculates average vaccination rate per continent per month
-- Tableau dataset: 1 vaccination rate per continent 
-- Tableau visualization: https://public.tableau.com/app/profile/laura.zsolyom/viz/Explanationofcovid-19vaccinationprogress/Explanationofcovid-19vaccinationprogress
-- =========================================

WITH tVaccination AS (
  SELECT
    date,
    iso_3166_1_alpha_3,
    country_code,
    country_name,
    cumulative_persons_fully_vaccinated, 
    gdp_per_capita_usd,
    human_development_index
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
  WHERE 1=1
   AND aggregation_level = 0 
  ORDER BY 3,1

 )
,

tPopulation AS (
  SELECT
    country_code AS iso_3166_1_alpha_3,
    year_2018 AS population_2018
  FROM
    `bigquery-public-data.world_bank_global_population.population_by_country`

)



,tContinent AS (
  SELECT 
  *
  FROM `projects.Countries.Countries`
)

, tJoined AS (
  SELECT 
    EXTRACT(MONTH FROM tV.date) AS month,
    tC.continent,
    tV.country_name,
    ROUND(AVG(cumulative_persons_fully_vaccinated)) AS avg_cumulative_persons_fully_vaccinated,
    AVG(tP.population_2018) AS population_2018,
    AVG( tV.gdp_per_capita_usd) as gdp_per_capita_usd,
    AVG(tV.human_development_index) AS human_development_index
  FROM tVaccination  AS tV

  LEFT JOIN tContinent AS tC  ON iso_3166_1_alpha_3 = Code

  LEFT JOIN tPopulation AS tP USING(iso_3166_1_alpha_3)

  GROUP BY 1, 2, 3
  ORDER BY 1, 2

)

SELECT
  month,
  continent,
  SUM(avg_cumulative_persons_fully_vaccinated) as vacc,
  COUNT(avg_cumulative_persons_fully_vaccinated) as vacc_count,
  SUM(population_2018) as pop
FROM tJoined 
GROUP BY 1, 2
ORDER BY 1, 2









